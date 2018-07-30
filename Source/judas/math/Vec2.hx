package judas.math;
import haxe.ds.Vector;

/**
 * ...
 * @author Damilare Akinlaja
 */
class Vec2
{

	public var data:Vector<Float>;
	
	/**
	 * The first element of the vector.
	 */
	@:isVar public var x(get, set):Float;
	
	/**
	 * The second element of the vector.
	 */
	@:isVar public var y(get, set):Float;

	/**
	* Creates a new Vec2 object
	* @param x The x value.
	* @param y The y value
	*/
	public function new(?x:Float, ?y:Float)
	{
		this.data = new Vector(2);

		this.data[0] = x ? x : 0;
		this.data[1] = y ? y : 0;
	}

	/**
	 * Adds a 2-dimensional vector to another in place.
	 * @param	rhs
	 * @return	Vec2
	 */
	public function add(rhs:Vec2):Vec2
	{
		var a:Vector<Float> = this.data,
		b:Vector<Float> = rhs.data;

		a[0] += b[0];
		a[1] += b[1];

		return this;
	}

	/**
	 * Adds two 2-dimensional vectors together and returns the result.
	 * @param	lhs The first vector operand for the addition.
	 * @param	rhs The second vector operand for the addition.
	 * @return	Vec2
	 */
	public function add2(lhs:Vec2, rhs:Vec2):Vec2
	{
		var a:Vector<Float> = lhs.data,
		b:Vector<Float> = rhs.data,
		r:Vector<Float> = this.data;

		r[0] = a[0] + b[0];
		r[1] = a[1] + b[1];

		return this;
	}

	/**
	 * Returns an identical copy of the specified 2-dimensional vector.
	 * @return Vec2
	 */
	public function clone():Vec2
	{
		return new Vec2().copy(this);
	}

	/**
	 * Copied the contents of a source 2-dimensional vector to a destination 2-dimensional vector.
	 * @param	rhs
	 * @return  Vec2
	 */
	public function copy(rhs:Vec2):Vec2
	{
		var a:Vector<Float> = this.data,
		b:Vector<Float> = rhs.data;

		a[0] = b[0];
		a[1] = b[1];

		return this;
	}

	/**
	 * Returns the result of a dot product operation performed on the two specified 2-dimensional vectors.
	 * @param	rhs The second 2-dimensional vector operand of the dot product.
	 * @return	Vec2
	 */
	public function dot(rhs:Vec2):Vec2
	{
		var a:Vector<Float> = this.data,
		b:Vector<Float> = rhs.data;

		return a[0] * b[0] + a[1] * b[1];
	}

	/**
	 * Reports whether two vectors are equal.
	 * @param	rhs
	 * @return	Bool
	 */

	public function equals(rhs:Vec2):Bool
	{
		var a:Vector<Float> = this.data,
		b:Vector<Float> = rhs.data;

		return a[0] == b[0] && a[1] == b[1];
	}

	/**
	 * Returns the magnitude squared of the specified 2-dimensional vector.
	 * @return Float
	 */

	public function length():Float
	{
		var v:Vector<Float> = this.data;

		return Math.sqrt(v[0] * v[0] + v[1] * v[1]);
	}

	/**
	 * Returns the result of a linear interpolation between two specified 2-dimensional vectors.
	 * @param	lhs The 2-dimensional to interpolate from.
	 * @param	rhs The 2-dimensional to interpolate to.
	 * @param	alpha The value controlling the point of interpolation. Between 0 and 1, the linear interpolant
	 * will occur on a straight line between lhs and rhs. Outside of this range, the linear interpolant will occur on
	 * a ray extrapolated from this line.
	 * @return	Vec2
	 */
	public function lerp(lhs:Vec2, rhs:Vec2, alpha:Float):Vec2
	{
		var a:Vector<Float> = lhs.data,
		b:Vector<Float> = rhs.data,
		r:Vector<Float> = this.data;

		r[0] = a[0] + alpha * (b[0] - a[0]);
		r[1] = a[1] + alpha * (b[1] - a[1]);

		return this;
	}

	/**
	 * Multiplies a 2-dimensional vector to another in place.
	 * @param	rhs The 2-dimensional vector used as the second multiplicand of the operation.
	 * @return Vec2
	 */
	public function mul(rhs:Vec2):Vec2
	{
		var a:Vector<Float> = this.data,
		b:Vector<Float> = rhs.data;

		a[0] *= b[0];
		a[1] *= b[1];

		return this;
	}

	/**
	 * Returns the result of multiplying the specified 2-dimensional vectors together.
	 * @param	rhs The 2-dimensional vector used as the first multiplicand of the operation.
	 * @param	lhs The 2-dimensional vector used as the second multiplicand of the operation.
	 * @return  Vec2
	 */
	public function mul2(lhs:Vec2, rhs:Vec2):Vec2
	{
		var a:Vector<Float> = lhs.data,
		b:Vector<Float> = rhs.data,
		r:Vector<Float> = this.data;

		r[0] = a[0] * b[0];
		r[1] = a[1] * b[1];

		return this;
	}

	/**
	 * Returns the specified 2-dimensional vector copied and converted to a unit vector.
	 * If the vector has a length of zero, the vector's elements will be set to zero.
	 * @return Vec2
	 */
	public function normalize():Vec2
	{
		var v:Vector<Float> = this.data;

		var lengthSq:Float = v[0] * v[0] + v[1] * v[1];
		if (lengthSq > 0)
		{
			var invLength = 1 / Math.sqrt(lengthSq);
			v[0] *= invLength;
			v[1] *= invLength;
		}

		return this;
	}

	/**
	 * Scales each component of the specified 2-dimensional vector by the supplied
	 * scalar value.
	 * @param scalar
	 * @return Vec2
	 */
	public function scale(scalar):Vec2
	{
		var v:Vector<Float> = this.data;

		v[0] *= scalar;
		v[1] *= scalar;

		return this;
	}

	/**
	 * Sets the specified 2-dimensional vector to the supplied numerical values.
	 * @param	x
	 * @param	y
	 * @return Vec2
	 */

	public function set(x:Float, y:Float):Vec2
	{
		var v:Vector<Float> = this.data;

		v[0] = x;
		v[1] = y;

		return this;
	}

	/**
	 * Subtracts a 2-dimensional vector from another in place.
	 * @param	rhs
	 * @return  Vec2
	 */
	public function sub(rhs:Vec2):Vec2
	{
		var a:Vector<Float> = this.data,
		b:Vector<Float> = rhs.data;

		a[0] -= b[0];
		a[1] -= b[1];

		return this;
	}

	/**
	 * Subtracts two 2-dimensional vectors from one another and returns the result.
	 * @param	lhs
	 * @param	rhs
	 * @return	Vec2
	 */
	public function sub2(lhs:Vec2, rhs:Vec2):Vec2
	{
		var a:Vector<Float> = lhs.data,
		b:Vector<Float> = rhs.data,
		r:Vector<Float> = this.data;

		r[0] = a[0] - b[0];
		r[1] = a[1] - b[1];

		return this;
	}
	
	/**
	 * Converts the vector to string form.
	 * @return String
	 */
	public function toString():String
	{
		return "[" + this.data[0] + ", " + this.data[1] + "]";
	}
	
	
	
	public function get_x():Float{
		return this.data[0];
	}
	
	public function set_x(value:Float):Float
	{
		this.data[0] = value;
		return this.data[0];
	}
	

	public function get_y():Float{
		return this.data[1];
	}
	
	public function set_y(value:Float):Float
	{
		this.data[1] = value;
		return this.data[1];
	}
	
	
	/**
	 * A constant vector set to [1, 1].
	 */
	@:readOnly public static var ONE:Vec2 = new Vec2(1, 1);
	
	/**
	 * A constant vector set to [1, 0].
	 */
	@:readOnly public static var RIGHT:Vec2 = new Vec2(1, 0);
	
	/**
	 * A constant vector set to [0, 1].
	 */
	@:readOnly public static var UP:Vec2 = new Vec2(0, 1);
	
	/**
	 * A constant vector set to [0, 0].
	 */
	@:readOnly public static var ZERO:Vec2 = new Vec2(0, 0);
	

}