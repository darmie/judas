package judas.math;
import haxe.ds.Vector;

/**
 * ...
 * @author Damilare Akinlaja
 */
class Quat
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
	
	/**
	 * Create a new Quat object
	 * @param	x
	 * @param	y
	 * @param	z
	 * @param	w
	 */

	public function new(?x:Float, ?y:Float, ?z:Float, ?w:Float)
	{
		this.x = (x == null) ? 0 : x;
		this.y = (y == null) ? 0 : y;
		this.z = (z == null) ? 0 : z;
		this.w = (w == null) ? 1 : w;
	}

	/**
	 * Returns an identical copy of the specified quaternion.
	 * @return	A quaternion containing the result of the cloning.
	 */
	public function clone():Quat
	{
		return new Quat(this.x, this.y, this.z, this.w);
	}

	public function conjugate():Quat
	{
		this.x *= -1;
		this.y *= -1;
		this.z *= -1;

		return this;
	}

	/**
	 * Copies the contents of a source quaternion to a destination quaternion.
	 * @param	rhs	he quaternion to be copied.
	 * @return	Quat
	 */
	public function copy(rhs:Quat):Quat
	{
		this.x = rhs.x;
		this.y = rhs.y;
		this.z = rhs.z;
		this.w = rhs.w;

		return this;
	}

	/**
	 * Reports whether two quaternions are equal.
	 * @param	that
	 * @return	Bool true if the quaternions are equal and false otherwise.
	 */
	public function equals(that:Quat):Bool
	{
		return ((this.x == that.x) && (this.y == that.y) && (this.z == that.z) && (this.w == that.w));
	}

	/**
	 * Gets the rotation axis and angle for a given
	 *  quaternion. If a quaternion is created with
	 *  setFromAxisAngle, this method will return the same
	 *  values as provided in the original parameter list
	 *  OR functionally equivalent values.
	 * @param	axis
	 * @return	Float
	 */
	public function getAxisAngle(axis:Vec3):Float
	{
		var rad:Float = Math.acos(this.w) * 2;
		var s:Float = Math.sin(rad / 2);
		if (s != 0)
		{
			axis.x = this.x / s;
			axis.y = this.y / s;
			axis.z = this.z / s;
			if (axis.x < 0 || axis.y < 0 || axis.z < 0)
			{
				// Flip the sign
				axis.x *= -1;
				axis.y *= -1;
				axis.z *= -1;
				rad *= -1;
			}
		}
		else {
			// If s is zero, return any axis (no rotation - axis does not matter)
			axis.x = 1;
			axis.y = 0;
			axis.z = 0;
		}
		return rad * Constants.RAD_TO_DEG;
	}

	/**
	 * Converts the supplied quaternion to Euler angles.
	 * @param	eulers	- The 3-dimensional vector to receive the Euler angles.
	 * @return  Vec3 The 3-dimensional vector holding the Euler angles that
	 * correspond to the supplied quaternion.
	 */
	public function getEulerAngles(eulers:Vec3):Vec3
	{
		eulers = (eulers == nukk) ? new Vec3() : eulers;

		var qx:Float = this.x;
		var qy:Float = this.y;
		var qz:Float = this.z;
		var qw:Float = this.w;

		var x:Float, y:Float, z:Float;

		var a2:Float = 2 * (qw * qy - qx * qz);
		if (a2 <= -0.99999)
		{
			x = 2 * Math.atan2(qx, qw);
			y = -Math.PI / 2;
			z = 0;
		}
		else if (a2 >= 0.99999)
		{
			x = 2 * Math.atan2(qx, qw);
			y = Math.PI / 2;
			z = 0;
		}
		else
		{
			x = Math.atan2(2 * (qw * qx + qy * qz), 1 - 2 * (qx * qx + qy * qy));
			y = Math.asin(a2);
			z = Math.atan2(2 * (qw * qz + qx * qy), 1 - 2 * (qy * qy + qz * qz));
		}

		return eulers.set(x, y, z).scale(Constants.RAD_TO_DEG);
	}

	/**
	 * Generates the inverse of the specified quaternion.
	 * @return	Quat
	 */
	public function invert():Quat
	{
		return this.conjugate().normalize();
	}

	/**
	 * Returns the magnitude of the specified quaternion.
	 * @return	Float
	 */
	public function length():Float
	{
		var x:Float = this.x;
		var y:Float = this.y;
		var z:Float = this.z;
		var w:Float = this.w;
		return Math.sqrt(x * x + y * y + z * z + w * w);
	}

	/**
	 * Returns the magnitude squared of the specified quaternion.
	 * @return	Float - The magnitude of the specified quaternion.
	 */
	public function lengthSq():Float
	{
		var x:Float = this.x;
		var y:Float = this.y;
		var z:Float = this.z;
		var w:Float = this.w;

		return x * x + y * y + z * z + w * w;
	}

	/**
	 * Returns the result of multiplying the specified quaternions together.
	 * @param	rhs The quaternion used as the second multiplicand of the operation.
	 * @return	Quat
	 */
	public function mul(rhs:Quat):Quat
	{
		var q1x:Float = this.x;
		var q1y:Float = this.y;
		var q1z:Float = this.z;
		var q1w:Float = this.w;

		var q2x:Float = rhs.x;
		var q2y:Float = rhs.y;
		var q2z:Float = rhs.z;
		var q2w:Float = rhs.w;

		this.x = q1w * q2x + q1x * q2w + q1y * q2z - q1z * q2y;
		this.y = q1w * q2y + q1y * q2w + q1z * q2x - q1x * q2z;
		this.z = q1w * q2z + q1z * q2w + q1x * q2y - q1y * q2x;
		this.w = q1w * q2w - q1x * q2x - q1y * q2y - q1z * q2z;

		return this;
	}

	/**
	 * Returns the result of multiplying the specified quaternions together.
	 * @param	rhs	- The quaternion used as the first multiplicand of the operation.
	 * @param	lhs	- The quaternion used as the second multiplicand of the operation.
	 * @return	Quat
	 */
	public function mul2(rhs:Quat, lhs:Quat):Quat
	{
		var q1x:Float = lhs.x;
		var q1y:Float = lhs.y;
		var q1z:Float = lhs.z;
		var q1w:Float = lhs.w;

		var q2x:Float = rhs.x;
		var q2y:Float = rhs.y;
		var q2z:Float = rhs.z;
		var q2w:Float = rhs.w;

		this.x = q1w * q2x + q1x * q2w + q1y * q2z - q1z * q2y;
		this.y = q1w * q2y + q1y * q2w + q1z * q2x - q1x * q2z;
		this.z = q1w * q2z + q1z * q2w + q1x * q2y - q1y * q2x;
		this.w = q1w * q2w - q1x * q2x - q1y * q2y - q1z * q2z;

		return this;
	}

	/**
	 * Returns the specified quaternion converted in place to a unit quaternion.
	 * @return	Quat The result of the normalization.
	 */
	public function normalize():Quat
	{
		var len:Float = this.length();
		if (len == 0)
		{
			this.x = this.y = this.z = 0;
			this.w = 1;
		}
		else {
			len = 1 / len;
			this.x *= len;
			this.y *= len;
			this.z *= len;
			this.w *= len;
		}

		return this;
	}

	/**
	 * Sets the specified quaternion to the supplied numerical values.
	 * @param	x	The x component of the quaternion.
	 * @param	y	The y component of the quaternion.
	 * @param	z	The z component of the quaternion.
	 * @param	w	The w component of the quaternion.
	 * @return	Quat
	 */
	public function set(x:Float, y:Float, z:Float, w:Float):Quat
	{
		this.x = x;
		this.y = y;
		this.z = z;
		this.w = w;

		return this;
	}

	/**
	 * Sets a quaternion from Euler angles specified in XYZ order.
	 * @param	axis	World space axis around which to rotate.
	 * @param	angle	Angle to rotate around the given axis in degrees.
	 * @return	Quat
	 */
	public function setFromAxisAngle(axis:Vec3, angle:Float):Quat
	{
		angle *= 0.5 * Constants.DEG_TO_RAD;

		var sa:Float = Math.sin(angle);
		var ca:Float = Math.cos(angle);

		this.x = sa * axis.x;
		this.y = sa * axis.y;
		this.z = sa * axis.z;
		this.w = ca;

		return this;
	}

	/**
	 * Sets a quaternion from Euler angles specified in XYZ order.
	 * @param	ex	Angle to rotate around X axis in degrees.
	 * @param	ey	Angle to rotate around Y axis in degrees.
	 * @param	ez	Angle to rotate around Z axis in degrees.
	 * @return	Quat
	 */
	public function setFromEulerAngles(ex:Float, ey:Float, ez:Float):Quat
	{
		var halfToRad:Float = 0.5 * Constants.DEG_TO_RAD;
		ex *= halfToRad;
		ey *= halfToRad;
		ez *= halfToRad;

		var sx:Float = Math.sin(ex);
		var cx:Float = Math.cos(ex);
		var sy:Float = Math.sin(ey);
		var cy:Float = Math.cos(ey);
		var sz:Float = Math.sin(ez);
		var cz:Float = Math.cos(ez);

		this.x = sx * cy * cz - cx * sy * sz;
		this.y = cx * sy * cz + sx * cy * sz;
		this.z = cx * cy * sz - sx * sy * cz;
		this.w = cx * cy * cz + sx * sy * sz;

		return this;
	}

	/**
	 * Converts the specified 4x4 matrix to a quaternion. Note that since
	 * a quaternion is purely a representation for orientation, only the translational part
	 * of the matrix is lost.
	 * @param	mat	- The 4x4 matrix to convert.
	 * @return	Quat
	 */
	public function setFromMat4(mat:Mat4):Quat
	{

		var m:Vector<Float> = mat.data;

		// Cache matrix values for super-speed
		var m00:Float = m[0];
		var m01:Float = m[1];
		var m02:Float = m[2];
		var m10:Float = m[4];
		var m11:Float = m[5];
		var m12:Float = m[6];
		var m20:Float = m[8];
		var m21:Float = m[9];
		var m22:Float = m[10];

		// Remove the scale from the matrix
		var lx:Float = 1 / Math.sqrt(m00 * m00 + m01 * m01 + m02 * m02);
		var ly:Float = 1 / Math.sqrt(m10 * m10 + m11 * m11 + m12 * m12);
		var lz:Float = 1 / Math.sqrt(m20 * m20 + m21 * m21 + m22 * m22);

		m00 *= lx;
		m01 *= lx;
		m02 *= lx;
		m10 *= ly;
		m11 *= ly;
		m12 *= ly;
		m20 *= lz;
		m21 *= lz;
		m22 *= lz;

		// http://www.cs.ucr.edu/~vbz/resources/quatut.pdf

		var tr:Float = m00 + m11 + m22;
		if (tr >= 0)
		{
			s = Math.sqrt(tr + 1);
			this.w = s * 0.5;
			s = 0.5 / s;
			this.x = (m12 - m21) * s;
			this.y = (m20 - m02) * s;
			this.z = (m01 - m10) * s;
		}
		else {
			if (m00 > m11)
			{
				if (m00 > m22)
				{
					// XDiagDomMatrix
					rs = (m00 - (m11 + m22)) + 1;
					rs = Math.sqrt(rs);

					this.x = rs * 0.5;
					rs = 0.5 / rs;
					this.w = (m12 - m21) * rs;
					this.y = (m01 + m10) * rs;
					this.z = (m02 + m20) * rs;
				}
				else
				{
					// ZDiagDomMatrix
					rs = (m22 - (m00 + m11)) + 1;
					rs = Math.sqrt(rs);

					this.z = rs * 0.5;
					rs = 0.5 / rs;
					this.w = (m01 - m10) * rs;
					this.x = (m20 + m02) * rs;
					this.y = (m21 + m12) * rs;
				}
			}
			else if (m11 > m22)
			{
				// YDiagDomMatrix
				rs = (m11 - (m22 + m00)) + 1;
				rs = Math.sqrt(rs);

				this.y = rs * 0.5;
				rs = 0.5 / rs;
				this.w = (m20 - m02) * rs;
				this.z = (m12 + m21) * rs;
				this.x = (m10 + m01) * rs;
			}
			else {
				// ZDiagDomMatrix
				rs = (m22 - (m00 + m11)) + 1;
				rs = Math.sqrt(rs);

				this.z = rs * 0.5;
				rs = 0.5 / rs;
				this.w = (m01 - m10) * rs;
				this.x = (m20 + m02) * rs;
				this.y = (m21 + m12) * rs;
			}
		}

		return this;
	}

	/**
	 * Performs a spherical interpolation between two quaternions. The result of
	 * the interpolation is written to the quaternion calling the function.
	 * @param	lhs	The quaternion to interpolate from.
	 * @param	rhs	The quaternion to interpolate to.
	 * @param	alpha	The value controlling the interpolation in relation to the two input
	 * quaternions. The value is in the range 0 to 1, 0 generating q1, 1 generating q2 and anything
	 * in between generating a spherical interpolation between the two.
	 * @return	Quat
	 */
	public function slerp(lhs:Quat, rhs:Quat, alpha:Float):Quat
	{
		// Algorithm sourced from:
		// http://www.euclideanspace.com/maths/algebra/realNormedAlgebra/quaternions/slerp/
		//var lx, ly, lz, lw, rx, ry, rz, rw;
		var lx:Float = lhs.x;
		var ly:Float = lhs.y;
		var lz:Float = lhs.z;
		var lw:Float = lhs.w;
		var rx:Float = rhs.x;
		var ry:Float = rhs.y;
		var rz:Float = rhs.z;
		var rw:Float = rhs.w;

		// Calculate angle between them.
		var cosHalfTheta:Float = lw * rw + lx * rx + ly * ry + lz * rz;

		if (cosHalfTheta < 0)
		{
			rw = -rw;
			rx = -rx;
			ry = -ry;
			rz = -rz;
			cosHalfTheta = -cosHalfTheta;
		}

		// If lhs == rhs or lhs == -rhs then theta == 0 and we can return lhs
		if (Math.abs(cosHalfTheta) >= 1)
		{
			this.w = lw;
			this.x = lx;
			this.y = ly;
			this.z = lz;
			return this;
		}

		// Calculate temporary values.
		var halfTheta = Math.acos(cosHalfTheta);
		var sinHalfTheta = Math.sqrt(1 - cosHalfTheta * cosHalfTheta);

		// If theta = 180 degrees then result is not fully defined
		// we could rotate around any axis normal to qa or qb
		if (Math.abs(sinHalfTheta) < 0.001)
		{
			this.w = (lw * 0.5 + rw * 0.5);
			this.x = (lx * 0.5 + rx * 0.5);
			this.y = (ly * 0.5 + ry * 0.5);
			this.z = (lz * 0.5 + rz * 0.5);
			return this;
		}

		var ratioA = Math.sin((1 - alpha) * halfTheta) / sinHalfTheta;
		var ratioB = Math.sin(alpha * halfTheta) / sinHalfTheta;

		// Calculate Quaternion.
		this.w = (lw * ratioA + rw * ratioB);
		this.x = (lx * ratioA + rx * ratioB);
		this.y = (ly * ratioA + ry * ratioB);
		this.z = (lz * ratioA + rz * ratioB);
		return this;
	}

	public function transformVector(vec:Vec3, ?res:Vec3):Vec3
	{
		if (res == null)
		{
			res = new Vec3();
		}

		var x:Float = vec.x;
		var y:Float = vec.y;
		var z:Float = vec.z;
		var qx:Float = this.x;
		var qy:Float = this.y;
		var qz:Float = this.z;
		var qw:Float = this.w;

		// calculate quat * vec
		var ix:Float = qw * x + qy * z - qz * y;
		var iy:Float = qw * y + qz * x - qx * z;
		var iz:Float = qw * z + qx * y - qy * x;
		var iw:Float = -qx * x - qy * y - qz * z;

		// calculate result * inverse quat
		res.x = ix * qw + iw * -qx + iy * -qz - iz * -qy;
		res.y = iy * qw + iw * -qy + iz * -qx - ix * -qz;
		res.z = iz * qw + iw * -qz + ix * -qy - iy * -qx;

		return res;
	}
	
	/**
	 * Converts the quaternion to string form.
	 * @return	Quat
	 */
	public function toString():String
	{
		return "[" + this.x + ", " + this.y + ", " + this.z + ", " + this.w + "]";
	}
	
	/**
	 * A constant quaternion set to [0, 0, 0, 1].
	 */
	@:readOnly public static var IDENTITY = new Quat();
	
	/**
	 * A constant quaternion set to [0, 0, 0, 0].
	 */
	@:readOnly public static var ZERO = new Quat(0, 0, 0, 0);

}