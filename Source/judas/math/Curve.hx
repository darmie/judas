package judas.math;

import haxe.io.*;
import haxe.ds.Vector;

class Curve
{
	/**
	 * A linear interpolation scheme.
	 */
	public static var LINEAR:Int = 0;
	/**
	 * A smooth step interpolation scheme.
	 */
	public static var SMOOTHSTEP:Int = 1;
	/**
	 * A Catmull-Rom spline interpolation scheme.
	 */
	public static var CATMULL:Int = 2;
	/**
	 * A cardinal spline interpolation scheme.
	 */
	public static var CARDINAL:Int = 3;

	public var keys:Array<Array<Float>>;
	public var type:Int;
	@:isVar public var length(get, null):Int;
	public var tension:Float;

	/**
	 *  A curve is a collection of keys (time/value pairs). The shape of the
	 *  curve is defined by its type that specifies an interpolation scheme for the keys.
	 *  @param data - An array of keys (pairs of numbers with the time first and value second)
	 */
	public function new(?data:Array<Array<Float>>)
	{
		this.keys = [];
		this.type = Curve.SMOOTHSTEP;

		this.tension = 0.5; // used for Curve.CARDINAL

		if (data != null)
		{
			var i = 0;
			while (i < data.length - 1)
			{
				this.keys.push([data[i], data[i+1]]);
				i += 2;
			}
		}

		this.sort();
	}

	/**
	 *  Add a new key to the curve.
	 *  @param time - Time to add new key
	 *  @param value - Value of new key
	 *  @return Array<Array<Float>> [time, value] pair
	 */
	public function add(time:Float, value:Float):Array<Array<Float>>
	{
		var keys = this.keys;
		var len = keys.length;
		var i = 0;

		while (i < len)
		{
			if (keys[i][0] > time)
			{
				break;
			}

			i++;
		}

		var key = [time, value];
		this.keys.splice(i, 0, key);
		return key;
	}

	/**
	 *  Return a specific key.
	 *  @param index - The index of the key to return
	 *  @return Array<Float> - The key at the specified index
	 */
	public function get(index:Int):Array<Float>
	{
		return this.keys[index];
	}

	/**
	 *  Sort keys by time.
	 */
	public function sort()
	{
		this.keys.sort(function (a, b)
		{
			return a[0] - b[0];
		});
	}

	public function value(time:Float):Float
	{
		var keys = this.keys;

		// no keys
		if (keys.length == 0)
		{
			return 0;
		}

		// Clamp values before first and after last key
		if (time < keys[0][0])
		{
			return keys[0][1];
		}
		else if (time > keys[keys.length-1][0])
		{
			return keys[keys.length-1][1];
		}

		var leftTime = 0;
		var leftValue = keys.length ? keys[0][1] : 0;

		var rightTime = 1;
		var rightValue = 0;

		for (i in 0...keys.length)
		{
			// early exit check
			if (keys[i][0] == time)
			{
				return keys[i][1];
			}

			rightValue = keys[i][1];

			if (time < keys[i][0])
			{
				rightTime = keys[i][0];
				break;
			}

			leftTime = keys[i][0];
			leftValue = keys[i][1];
		}

		var div = rightTime - leftTime;
		var interpolation = (div == 0 ? 0 : (time - leftTime) / div);

		if (this.type == Curve.SMOOTHSTEP)
		{
			interpolation *= interpolation * (3 - 2 * interpolation);
		}
		else if (this.type == Curve.CATMULL || this.type == Curve.CARDINAL)
		{
			var p1 = leftValue;
			var p2 = rightValue;
			var p0 = p1+(p1-p2); // default control points are extended back/forward from existing points
			var p3 = p2+(p2-p1);

			var dt1 = rightTime - leftTime;
			var dt0 = dt1;
			var dt2 = dt1;

			// back up index to left key
			if (i > 0)
			{
				i = i - 1;
			}

			if (i > 0)
			{
				p0 = keys[i-1][1];
				dt0 = keys[i][0] - keys[i-1][0];
			}

			if (keys.length > i+1)
			{
				dt1 = keys[i+1][0] - keys[i][0];
			}

			if (keys.length > i+2)
			{
				dt2 = keys[i+2][0] - keys[i+1][0];
				p3 = keys[i+2][1];
			}

			// normalize p0 and p3 to be equal time with p1->p2
			p0 = p1 + (p0-p1)*dt1/dt0;
			p3 = p2 + (p3-p2)*dt1/dt2;

			if (this.type == Curve.CATMULL)
			{
				return this.interpolateCatmullRom(p0, p1, p2, p3, interpolation);
			}
			else
			{
				return this.interpolateCardinal(p0, p1, p2, p3, interpolation, this.tension);
			}
		}

		return Constants.lerp(leftValue, rightValue, interpolation);
	}

	private function  interpolateHermite(p0:Float, p1:Float, t0:Float, t1:Float, s:Float):Float
	{
		var s2 = s*s;
		var s3 = s*s*s;
		var h0 = 2*s3 - 3*s2 + 1;
		var h1 = -2*s3 + 3*s2;
		var h2 = s3 - 2*s2 + s;
		var h3 = s3 - s2;

		return p0 * h0 + p1 * h1 + t0 * h2 + t1 * h3;
	}

	private function  interpolateCardinal(p0:Float, p1:Float, p2:Float, p3:Float, s:Float, t:Float):Float
	{
		var t0 = t*(p2 - p0);
		var t1 = t*(p3 - p1);

		return this.interpolateHermite(p1, p2, t0, t1, s);
	}

	private function interpolateCatmullRom(p0:Float, p1:Float, p2:Float, p3:Float, s:Float):Float
	{
		return this.interpolateCardinal(p0, p1, p2, p3, s, 0.5);
	}

	public function  closest(time:Float):Array<Float>
	{
		var keys = this.keys;
		var length = keys.length;
		var min = 2;
		var result = null;

		for (i in 0...length)
		{
			var diff = Math.abs(time - keys[i][0]);
			if (min >= diff)
			{
				min = diff;
				result = keys[i];
			}
			else
			{
				break;
			}
		}

		return result;
	}

	/**
	 *  Returns a clone of the specified curve object.
	 *  @return Curve
	 */
	public function clone():Curve
	{
		var result = new Curve();
		result.keys = this.keys.copy();
		result.type = this.type;
		return result;
	}

	public function quantize(precision:Int):Vector<Float>
	{
		precision = Math.max(precision, 2);

		var values:Vector<Float> = new Vector(precision);
		var step = 1.0 / (precision - 1);

		// quantize graph to table of interpolated values
		for (i in 0...precision)
		{
			var value = this.value(step * i);
			values[i] = value;
		}

		return values;
	}

	public function get_length():Int
	{
		return this.keys.length;
	}

}