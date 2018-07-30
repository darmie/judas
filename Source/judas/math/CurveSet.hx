package judas.math;

import haxe.io.*;

/**
 * @name CurveSet
 * @class A curve set is a collection of curves.
 * @description Creates a new curve set.
 * @param {Array} [curveKeys] An array of arrays of keys (pairs of numbers with
 * the time first and value second).
 */

class CurveSet
{

	public var curves:Array<Curve>;

	/**
	 *  The interpolation scheme applied to all curves in the curve set. Can be:
	 * <ul>
	 *     <li>Curve.LINEAR</li>
	 *     <li>Curve.SMOOTHSTEP</li>
	 *     <li>Curve.CATMULL</li>
	 *     <li>Curve.CARDINAL</li>
	 * </ul>
	 *  @return Int
	 */
	@:isVar public var type(get, set):Int;
	@:isVar public var length(get, null):Int;

	public function new(curveKeys?:Array<Dynamic>)
	{

		this.curves = [];
		this.type = Curve.SMOOTHSTEP;

		if (curveKeys.length > 1)
		{
			for (i in 0...curveKeys.length)
			{
				this.curves.push(new Curve(curveKeys[i]));
			}
		}
		else
		{
			if (curveKeys.length === 0)
			{
				this.curves.push(new Curve());
			}
			else
			{
				var arg = curveKeys[0];
				if (Std.is(arg, Int))
				{
					for (i in 0...arg)
					{
						this.curves.push(new Curve());
					}
				}
				else
				{
					for (i in 0...arg.length)
					{
						this.curves.push(new Curve(arg[i]));
					}
				}
			}
		}
	}

	/**
	 *  Return a specific curve in the curve set.
	 *  @param index - The index of the curve to return
	 *  @return Curve
	 */
	public function get(index:Int):Curve
	{
		return this.curves[index];
	}

	/**
	 *  Returns the interpolated value of all curves in the curve
	 *  set at the specified time.
	 *  @param time - The time at which to calculate the value
	 *  @param result - The interpolated curve values at the specified time
	 *  If this parameter is not supplied, the function allocates a new array internally
	 *  to return the result.
	 *  @return Array<Float>
	 */
	public function value(time:Float, result:Array<Dynamic>):Array<Float>
	{
		var length = this.curves.length;
		result = result || [];
		result.length = length;

		for (i in 0...length)
		{
			result[i] = this.curves[i].value(time);
		}

		return result;
	}

	/**
	 *  Returns a clone of the specified curve set object.
	 *  @return Curveset
	 */
	public function clone():CurveSet
	{
		var result:CurveSet = new CurveSet();

		result.curves = [];
		for (i in 0...this.curves.length)
		{
			result.curves.push(this.curves[i].clone());
		}

		result.type = this.type;

		return result;
	}

	public function quantize(precision:Int):Float32Array
	{
		precision = Math.max(precision, 2);

		var numCurves = this.curves.length;
		var values = new Float32Array(precision * numCurves);
		var step = 1.0 / (precision - 1);
		var temp = [];

		for (i in 0...precision)   // quantize graph to table of interpolated values
		{
			var value = this.value(step * i, temp);
			if (numCurves == 1)
			{
				values[i] = value[0];
			}
			else
			{
				for (j in 0...numCurves)
				{
					values[i * numCurves + j] = value[j];
				}
			}
		}

		return values;
	}

	/**
	 *  The number of curves in the curve set.
	 *  @return Int
	 */
	public function get_length():Int
	{
		return this.curves.length;
	}

	public function get_type():Int
	{
		return this.type;
	}

	public function set_type(value:Int):Int
	{
		this.type = value;
		for (i in 0...this.curves.length)
		{
			this.curves[i].type = value;
		}

		return this.type;
	}

}