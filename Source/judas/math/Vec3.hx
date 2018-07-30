package judas.math;
import haxe.ds.Vector;

/**
 * ...
 * @author Damilare Akinlaja
 */
class Vec3
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

	public var data:Vector<Float>;

	/**
	 * A 3-dimensional vector.
	 * @param	x
	 * @param	y
	 * @param	z
	 */

	public function new(?x:Float, ?y:Float, ?z:Float)
	{
		this.data = new Vector(3);
		this.data[0] = x != null ? x : 0;
		this.data[1] = y != null ? y : 0;
		this.data[2] = z != null ? z : 0;
	}

	/**
	 * Adds a 3-dimensional vector to another in place.
	 * @param	rhs The vector to add to the specified vector.
	 * @return	Vec3
	 */
	public function add(rhs:Vec3):Vec3
	{
		var a:Vector<Float> = this.data,
		b:Vector<Float> = rhs.data;

		a[0] += b[0];
		a[1] += b[1];
		a[2] += b[2];

		return this;
	}

	/**
	 * Adds two 3-dimensional vectors together and returns the result.
	 * @param	lhs The first vector operand for the addition.
	 * @param	rhs The second vector operand for the addition.
	 * @return Vec3
	 */
	public function add2(lhs:Vec3, rhs:Vec3):Vec3
	{
		var a:Vector<Float> = lhs.data,
		b:Vector<Float> = rhs.data,
		r:Vector<Float> = this.data;

		r[0] = a[0] + b[0];
		r[1] = a[1] + b[1];
		r[2] = a[2] + b[2];

		return this;
	}

	/**
	 * Returns an identical copy of the specified 3-dimensional vector.
	 * @return Vec3
	 */
	public function clone():Vec3
	{
		return new Vec3().copy(this);
	}

	/**
	 * Copied the contents of a source 3-dimensional vector to a destination 3-dimensional vector.
	 * @param	rhs
	 * @return Vec3
	 */
	public function copy(rhs:Vec3):Vec3
	{
		var a:Vector<Float> = this.data,
		b:Vector<Float> = rhs.data;

		a[0] = b[0];
		a[1] = b[1];
		a[2] = b[2];

		return this;
	}

	/**
	 * Returns the result of a cross product operation performed on the two specified 3-dimensional vectors.
	 * @param	lhs
	 * @param	rhs
	 * @return	Vec3
	 */
	public function cross(lhs:Vec3, rhs:Vec3):Vec3
	{

		var a:Vector<Float> = lhs.data;
		var b:Vector<Float> = rhs.data;
		var r:Vector<Float> = this.data;

		var ax:Float = a[0];
		var ay:Float = a[1];
		var az:Float = a[2];
		var bx:Float = b[0];
		var by:Float = b[1];
		var bz:Float = b[2];

		r[0] = ay * bz - by * az;
		r[1] = az * bx - bz * ax;
		r[2] = ax * by - bx * ay;

		return this;
	}

	/**
	 * Returns the result of a dot product operation performed on the two specified 3-dimensional vectors
	 * @param	rhs
	 * @return  Float
	 */
	public function dot(rhs:Vec3):Float
	{
		var a:Vector<Float> = this.data,
		b:Vector<Float> = rhs.data;

		return a[0] * b[0] + a[1] * b[1] + a[2] * b[2];
	}

	/**
	 * Reports whether two vectors are equal.
	 * @param	rhs
	 * @return Bool
	 */
	public function equals(rhs:Vec3):Bool
	{
		var a:Vector<Float> = this.data,
		b:Vector<Float> = rhs.data;

		return a[0] == b[0] && a[1] == b[1] && a[2] == b[2];
	}

	/**
	 * Returns the magnitude of the specified 3-dimensional vector
	 * @return Float
	 */
	public function length():Float
	{
		var v:Vector<Float> = this.data;

		return Math.sqrt(v[0] * v[0] + v[1] * v[1] + v[2] * v[2]);
	}

	/**
	 * Returns the magnitude squared of the specified 3-dimensional vector.
	 * @return Float The magnitude of the specified 3-dimensional vector.
	 */
	public function lengthSq():Float 
	{
		var v:Vector<Float> = this.data;

        return v[0] * v[0] + v[1] * v[1] + v[2] * v[2];
	}
	/**
	 * Returns the result of a linear interpolation between two specified 3-dimensional vectors.
	 * @param	lhs
	 * @param	rhs
	 * @param	alpha
	 * @return 	Vec3
	 */
	public function lerp(lhs:Vec3, rhs:Vec3, alpha:Float):Vec3
	{
		var a:Vector<Float> = lhs.data,
		b:Vector<Float> = rhs.data,
		r:Vector<Float> = this.data;

		r[0] = a[0] + alpha * (b[0] - a[0]);
		r[1] = a[1] + alpha * (b[1] - a[1]);
		r[2] = a[2] + alpha * (b[2] - a[2]);

		return this;
	}

	/**
	 * Multiplies a 3-dimensional vector to another in place.
	 * @param	rhs
	 * @return	Vec3
	 */
	public function mul(rhs:Vec3):Vec3
	{
		var a:Vector<Float> = this.data,
		b:Vector<Float> = rhs.data;

		a[0] *= b[0];
		a[1] *= b[1];
		a[2] *= b[2];

		return this;
	}

	/**
	 * Returns the result of multiplying the specified 3-dimensional vectors together.
	 * @param	lhs
	 * @param	rhs
	 * @return	Vec3
	 */
	public function mul2(lhs:Vec3, rhs:Vec3):Vec3
	{
		var a:Vector<Float> = lhs.data,
		b:Vector<Float> = rhs.data,
		r:Vector<Float> = this.data;

		r[0] = a[0] * b[0];
		r[1] = a[1] * b[1];
		r[2] = a[2] * b[2];

		return this;
	}

	/**
	 * Returns the specified 3-dimensional vector copied and converted to a unit vector.
	 * @return Vec3
	 */
	public function normalize():Vec3
	{
		var v:Vector<Float> = this.data;

		var lengthSq:Float = v[0] * v[0] + v[1] * v[1] + v[2] * v[2];
		if (lengthSq > 0)
		{
			var invLength = 1 / Math.sqrt(lengthSq);
			v[0] *= invLength;
			v[1] *= invLength;
			v[2] *= invLength;
		}

		return this;
	}

	/**
	 * Projects this 3-dimensional vector onto the specified vector.
	 * @param	rhs
	 * @return	Vec3
	 */
	public function project(rhs:Vec3):Vec3
	{
		var a:Vector<Float> = this.data;
		var b:Vector<Float> = rhs.data;
		var a_dot_b:Float = a[0] * b[0] + a[1] * b[1] + a[2] * b[2];
		var b_dot_b:Float = b[0] * b[0] + b[1] * b[1] + b[2] * b[2];
		var s:Float = a_dot_b / b_dot_b;
		a[0] = b[0] * s;
		a[1] = b[1] * s;
		a[2] = b[2] * s;
		return this;
	}

	/**
	 * Scales each dimension of the specified 3-dimensional vector by the supplied
	 * scalar value.
	 * @param	scalar The value by which each vector component is multiplied.
	 * @return
	 */
	public function scale(scalar:Float):Vec3
	{
		var v:Vector<Float> = this.data;

		v[0] *= scalar;
		v[1] *= scalar;
		v[2] *= scalar;

		return this;
	}

	/**
	 * Sets the specified 3-dimensional vector to the supplied numerical values.
	 * @param	x The value to set on the first component of the vector.
	 * @param	y The value to set on the second component of the vector.
	 * @param	z The value to set on the third component of the vector.
	 * @return	Vec3
	 */
	public function set(x:Float, y:Float, z:Float):Vec3
	{
		var v:Vector<Float> = this.data;

		v[0] = x;
		v[1] = y;
		v[2] = z;

		return this;
	}

	/**
	 * Subtracts a 3-dimensional vector from another in place.
	 * @param	rhs
	 * @return	Vec3
	 */
	public function sub(rhs:Vec3):Vec3
	{
		var a:Vector<Float> = this.data,
		b:Vector<Float> = rhs.data;

		a[0] -= b[0];
		a[1] -= b[1];
		a[2] -= b[2];

		return this;
	}

	/**
	 * Subtracts two 3-dimensional vectors from one another and returns the result.
	 * @param	lhs	The first vector operand for the addition.
	 * @param	rhs	The second vector operand for the addition.
	 * @return
	 */
	public function sub2(lhs:Vec3, rhs:Vec3):Vec3
	{
		var a:Vector<Float> = lhs.data,
		b:Vector<Float> = rhs.data,
		r:Vector<Float> = this.data;

		r[0] = a[0] - b[0];
		r[1] = a[1] - b[1];
		r[2] = a[2] - b[2];

		return this;
	}
	
	/**
	 * Converts the vector to string form.
	 * @return String
	 */
	public function toString():String
	{
		return "[" + this.data[0] + ", " + this.data[1] + ", " + this.data[2] + "]";
	}
	
	
	public function get_x():Float 
	{
		return this.data[0];
	}
	
	public function set_x(x:Float):Float 
	{
		this.data[0] = x;
		return this.data[0];
	}
	

	public function get_y():Float 
	{
		return this.data[1];
	}
	
	public function set_y(y:Float):Float 
	{
		this.data[1] = y;
		return this.data[1];
	}
	
	public function get_z():Float 
	{
		return this.data[2];
	}
	
	public function set_z(z:Float):Float 
	{
		this.data[2] = z;
		return this.data[2];
	}
	
	/**
	 * A constant vector set to [0, 0, 1].
	 */
	@:readOnly public static var BACK = new Vec3(0, 0, 1);
	
	@:readOnly public static var DOWN = new Vec3(0, -1, 0);
	
	@:readOnly public static var FORWARD = new Vec3(0, 0, -1);
	
	@:readOnly public static var LEFT = new Vec3( -1, 0, 0);
	
	@:readOnly public static var ONE = new Vec3(1, 1, 1);
	
	@:readOnly public static var RIGHT = new Vec3(1, 0, 0);
	
	@:readOnly public static var UP = new Vec3(0, 1, 0);
	
	@:readOnly public static var ZERO = new Vec3(0, 0, 0);
	
	
	
	
}
