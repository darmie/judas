package judas.math;
import haxe.ds.Vector;

/**
 * ...
 * @author Damilare Akinlaja
 */
class Vec4
{
	/**
	 * The first element of the vector.
	 */
	@:isVar public var x(get, set):Float;

	/**
	 * The second element of the vector.
	 */
	@:isVar public var y(get, set):Float;

	/**
	 * The third element of the vector
	 */
	@:isVar public var z(get, set):Float;

	/**
	 * The fourth element of the vector
	 */
	@:isVar public var w(get, set):Float;

	public var data:Vector<Float>;

	/**
	 * Creates a new Vec4 object
	 * @param	x
	 * @param	y
	 * @param	z
	 * @param	w
	 */
	public function new(?x:Float, ?y:Float, ?z:Float, ?w:Float)
	{
		this.data = new Vector(4);

		this.data[0] = x != null ? x : 0;
		this.data[1] = y != null ? y : 0;
		this.data[2] = z != null ? z : 0;
		this.data[3] = w != null ? w : 0;
	}

	/**
	 * Adds a 4-dimensional vector to another in place.
	 * @param	rhs - The vector to add to the specified vector.
	 * @return	Vec4
	 */
	public function add(rhs:Vec4):Vec4
	{
		var a:Vector<Float> = this.data,
		b:Vector<Float> = rhs.data;

		a[0] += b[0];
		a[1] += b[1];
		a[2] += b[2];
		a[3] += b[3];

		return this;
	}

	/**
	 * Adds two 4-dimensional vectors together and returns the result.
	 * @param	lhs	- The first vector operand for the addition.
	 * @param	rhs - The second vector operand for the addition.
	 * @return	Vec4
	 */
	public function add2(lhs:Vec4, rhs:Vec2):Vec4
	{
		var a:Vector<Float> = lhs.data,
		b:Vector<Float> = rhs.data,
		r:Vector<Float> = this.data;

		r[0] = a[0] + b[0];
		r[1] = a[1] + b[1];
		r[2] = a[2] + b[2];
		r[3] = a[3] + b[3];

		return this;
	}

	/**
	 * Returns an identical copy of the specified 4-dimensional vector.
	 * @return	Vec4 - A 4-dimensional vector containing the result of the cloning.
	 */
	public function clone():Vec4
	{
		return new Vec4().copy(this);
	}

	/**
	 * Copied the contents of a source 4-dimensional vector to a destination 4-dimensional vector.
	 * @param	rhs	- A vector to copy to the specified vector.
	 * @return	Vec4
	 */
	public function copy(rhs:Vec4):Vec4
	{
		this.data = rhs.data.copy();

		return this;
	}

	/**
	 * Returns the result of a dot product operation performed on the two specified 4-dimensional vectors.
	 * @param	rhs	- The second 4-dimensional vector operand of the dot product.
	 * @return	Float
	 */
	public function dot(rhs:Vec4):Float
	{
		var a:Vector<Float> = this.data,
		b:Vector<Float> = rhs.data;

		return a[0] * b[0] + a[1] * b[1] + a[2] * b[2] + a[3] * b[3];
	}

	/**
	 * Reports whether two vectors are equal.
	 * @param	rhs	- The vector to compare to the specified vector.
	 * @return	Bool - true if the vectors are equal and false otherwise.
	 */
	public function equals(rhs:Vec4):Bool
	{
		var a:Vector<Float> = this.data,
		b:Vector<Float> = rhs.data;

		return a[0] == b[0] && a[1] == b[1] && a[2] == b[2] && a[3] == b[3];
	}

	/**
	 * Returns the magnitude of the specified 4-dimensional vector.
	 * @return Float - The magnitude of the specified 4-dimensional vector.
	 */
	public function length():Float
	{
		var v:Vector<Float> = this.data;
		return Math.sqrt(v[0] * v[0] + v[1] * v[1] + v[2] * v[2] + v[3] * v[3]);
	}

	/**
	 * Returns the magnitude squared of the specified 4-dimensional vector.
	 * @return	Float - The magnitude of the specified 4-dimensional vector.
	 */
	public function lengthSq():Float
	{
		var v:Vector<Float> = this.data;
		return v[0] * v[0] + v[1] * v[1] + v[2] * v[2] + v[3] * v[3];
	}

	/**
	 * Returns the result of a linear interpolation between two specified 4-dimensional vectors.
	 * @param	lhs	- The 4-dimensional to interpolate from.
	 * @param	rhs	- The 4-dimensional to interpolate to.
	 * @param	alpha	- The value controlling the point of interpolation. Between 0 and 1, the linear interpolant
	 * will occur on a straight line between lhs and rhs. Outside of this range, the linear interpolant will occur on
	 * a ray extrapolated from this line.
	 * @return	Vec4
	 */
	public function lerp(lhs:Vec4, rhs:Vec4, alpha:Float):Vec4
	{
		var a:Vector<Float> = lhs.data,
		b:Vector<Float> = rhs.data,
		r:Vector<Float> = this.data;

		r[0] = a[0] + alpha * (b[0] - a[0]);
		r[1] = a[1] + alpha * (b[1] - a[1]);
		r[2] = a[2] + alpha * (b[2] - a[2]);
		r[3] = a[3] + alpha * (b[3] - a[3]);

		return this;
	}

	/**
	 * Multiplies a 4-dimensional vector to another in place.
	 * @param	rhs	- The 4-dimensional vector used as the second multiplicand of the operation.
	 * @return	Vec4
	 */
	public function mul(rhs:Vec4):Vec4
	{
		var a:Vector<Float> = this.data,
		b:Vector<Float> = rhs.data;

		a[0] *= b[0];
		a[1] *= b[1];
		a[2] *= b[2];
		a[3] *= b[3];

		return this;
	}

	/**
	 * Returns the result of multiplying the specified 4-dimensional vectors together.
	 * @param	lhs	- The 4-dimensional vector used as the first multiplicand of the operation.
	 * @param	rhs	- The 4-dimensional vector used as the second multiplicand of the operation.
	 * @return	Vec4
	 */
	public function mul2(lhs:Vec4, rhs:Vec4):Vec4
	{
		var a:Vector<Float> = lhs.data,
		b:Vector<Float> = rhs.data,
		r:Vector<Float> = this.data;

		r[0] = a[0] * b[0];
		r[1] = a[1] * b[1];
		r[2] = a[2] * b[2];
		r[3] = a[3] * b[3];

		return this;
	}

	/**
	 * Returns the specified 4-dimensional vector copied and converted to a unit vector.
	 * @return	Vec4
	 */
	public function normalize():Vec4
	{
		var v:Vector<Float> = this.data;

		var lengthSq:Float = v[0] * v[0] + v[1] * v[1] + v[2] * v[2] + v[3] * v[3];
		if (lengthSq > 0)
		{
			var invLength:Float = 1 / Math.sqrt(lengthSq);
			v[0] *= invLength;
			v[1] *= invLength;
			v[2] *= invLength;
			v[3] *= invLength;
		}

		return this;
	}

	/**
	 * Scales each dimension of the specified 4-dimensional vector by the supplied scalar value.
	 * @param	scalar
	 * @return	Vec4
	 */
	public function scale(scalar:Float):Vec4
	{
		var v:Vector<Float> = this.data;

		v[0] *= scalar;
		v[1] *= scalar;
		v[2] *= scalar;
		v[3] *= scalar;

		return this;
	}

	/**
	 * Sets the specified 4-dimensional vector to the supplied numerical values.
	 * @param	x	The value to set on the first component of the vector.
	 * @param	y	The value to set on the second component of the vector.
	 * @param	z	The value to set on the third component of the vector.
	 * @param	w	The value to set on the fourth component of the vector.
	 */
	public function set(x:Float, y:Float, z:Float, w:Float)
	{
		var v:Vector<Float> = this.data;

		v[0] = x;
		v[1] = y;
		v[2] = z;
		v[3] = w;

		return this;
	}

	/**
	 * Subtracts a 4-dimensional vector from another in place.
	 * @param	rhs	- 	The vector to add to the specified vector.
	 * @return	Vec4
	 */
	public function sub(rhs:Vec4):Vec4
	{
		var a:Vector<Float> = this.data,
		b:Vector<Float> = rhs.data;

		a[0] -= b[0];
		a[1] -= b[1];
		a[2] -= b[2];
		a[3] -= b[3];

		return this;
	}

	/**
	 * Subtracts two 4-dimensional vectors from one another and returns the result.
	 * @param	rhs	The first vector operand for the subtraction.
	 * @param	lhs	The second vector operand for the subtraction.
	 * @return
	 */
	public function sub2(rhs:Vec4, lhs:Vec4):Vec4
	{
		var a:Vector<Float> = lhs.data,
		b:Vector<Float> = rhs.data,
		r:Vector<Float> = this.data;

		r[0] = a[0] - b[0];
		r[1] = a[1] - b[1];
		r[2] = a[2] - b[2];
		r[3] = a[3] - b[3];

		return this;
	}
	
	/**
	 * Converts the vector to string form.
	 * @return String The vector in string form.
	 */
	public function toString():String {
		return "[" + this.data[0] + ", " + this.data[1] + ", " + this.data[2] + ", " + this.data[3] + "]";
	}
	
	public function get_x():Float 
	{
		return this.data[0];
	}
	
	public function set_x(x:Float):Float 
	{
		this.data[0] = x;
	}
	
	public function get_y():Float 
	{
		return this.data[1];
	}
	
	public function set_y(y:Float):Float 
	{
		this.data[1] = y;
	}	
	
	public function get_z():Float 
	{
		return this.data[2];
	}
	
	public function set_z(z:Float):Float 
	{
		this.data[2] = z;
	}
	
	public function get_w():Float 
	{
		return this.data[3];
	}
	
	public function set_w(w:Float):Float 
	{
		this.data[3] = w;
	}
	
	
	@:readOnly public static var ONE:Vec4 = new Vec4(1, 1, 1, 1);
	@:readOnly public static var ZERO:Vec4 = new Vec4(0, 0, 0, 0);	
	
}