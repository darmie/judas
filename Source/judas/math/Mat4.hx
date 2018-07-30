package judas.math;

import haxe.io.*;
import haxe.ds.*;
import haxe.ds.Vector;

class Mat4
{

	public var data:Vector<Float>;

	/**
	 * Creates a new Mat4 object
	 * @param	v0
	 * @param	v1
	 * @param	v2
	 * @param	v3
	 * @param	v4
	 * @param	v5
	 * @param	v6
	 * @param	v7
	 * @param	v8
	 * @param	v9
	 * @param	v10
	 * @param	v11
	 * @param	v12
	 * @param	v13
	 * @param	v14
	 * @param	v15
	 */
	public function new(
		v0:Float = 1, v1:Float = 0, v2:Float = 0, v3:Float = 0,
		v4:Float = 0, v5:Float = 1, v6:Float = 0, v7:Float = 0,
		v8:Float = 0, v9:Float = 0, v10:Float = 1, v11:Float = 0,
		v12:Float = 0, v13:Float = 0, v14:Float = 0, v15:Float =1
	)
	{
		this.data = new Vector(16);
		this.data[0] = v0;
		this.data[1] = v1;
		this.data[2] = v2;
		this.data[3] = v3;
		this.data[4] = v4;
		this.data[5] = v5;
		this.data[6] = v6;
		this.data[7] = v7;
		this.data[8] = v8;
		this.data[9] = v9;
		this.data[10] = v10;
		this.data[11] = v11;
		this.data[12] = v12;
		this.data[13] = v13;
		this.data[14] = v14;
		this.data[15] = v15;
	}

	/**
	 * Adds the specified 4x4 matrices together and stores the result in
	 * the current instance.
	 * @param	lhs
	 * @param	rhs
	 * @return	Mat4
	 */

	public function add2(lhs:Mat4, rhs:Mat4):Mat4
	{
		var a = lhs.data,
		b = rhs.data,
		r = this.data;

		r[0] = a[0] + b[0];
		r[1] = a[1] + b[1];
		r[2] = a[2] + b[2];
		r[3] = a[3] + b[3];
		r[4] = a[4] + b[4];
		r[5] = a[5] + b[5];
		r[6] = a[6] + b[6];
		r[7] = a[7] + b[7];
		r[8] = a[8] + b[8];
		r[9] = a[9] + b[9];
		r[10] = a[10] + b[10];
		r[11] = a[11] + b[11];
		r[12] = a[12] + b[12];
		r[13] = a[13] + b[13];
		r[14] = a[14] + b[14];
		r[15] = a[15] + b[15];

		return this;
	}

	/**
	 * Adds the specified 4x4 matrix to the current instance.
	 * @param	rhs
	 * @return Mat4
	 */
	public function add(rhs:Mat4):Mat4
	{
		return this.add2(this, rhs);
	}

	/**
	 * Creates a duplicate of the specified matrix.
	 * @return Mat4
	 */
	public function clone():Mat4
	{
		return new Mat4().copy(this);
	}

	/**
	 * Copies the contents of a source 4x4 matrix to a destination 4x4 matrix.
	 * @param	rhs
	 * @return	Mat4
	 */
	public function copy(rhs:Mat4):Mat4
	{

		this.data = rhs.data.copy();

		return this;
	}

	/**
	 * Reports whether two matrices are equal.
	 * @param	rhs
	 * @return  Mat4
	 */
	public function equals(rhs:Mat4):Bool
	{
		var l = this.data,
		r = rhs.data;

		return ((l[0] == r[0]) &&
		(l[1] == r[1]) &&
		(l[2] == r[2]) &&
		(l[3] == r[3]) &&
		(l[4] == r[4]) &&
		(l[5] == r[5]) &&
		(l[6] == r[6]) &&
		(l[7] == r[7]) &&
		(l[8] == r[8]) &&
		(l[9] == r[9]) &&
		(l[10] == r[10]) &&
		(l[11] == r[11]) &&
		(l[12] == r[12]) &&
		(l[13] == r[13]) &&
		(l[14] == r[14]) &&
		(l[15] == r[15]));
	}

	/**
	 * Reports whether the specified matrix is the identity matrix.
	 * @return Bool
	 */
	public function isIdentity():Bool
	{
		var m = this.data;

		return ((m[0] == 1) &&
		(m[1] == 0) &&
		(m[2] == 0) &&
		(m[3] == 0) &&
		(m[4] == 0) &&
		(m[5] == 1) &&
		(m[6] == 0) &&
		(m[7] == 0) &&
		(m[8] == 0) &&
		(m[9] == 0) &&
		(m[10] == 1) &&
		(m[11] == 0) &&
		(m[12] == 0) &&
		(m[13] == 0) &&
		(m[14] == 0) &&
		(m[15] == 1));
	}

	public function mul2(lhs:Mat4, rhs:Mat4):Mat4
	{
		var a00, a01, a02, a03,
		a10, a11, a12, a13,
		a20, a21, a22, a23,
		a30, a31, a32, a33,
		b0, b1, b2, b3,
		a = lhs.data,
		b = rhs.data,
		r = this.data;

		a00 = a[0];
		a01 = a[1];
		a02 = a[2];
		a03 = a[3];
		a10 = a[4];
		a11 = a[5];
		a12 = a[6];
		a13 = a[7];
		a20 = a[8];
		a21 = a[9];
		a22 = a[10];
		a23 = a[11];
		a30 = a[12];
		a31 = a[13];
		a32 = a[14];
		a33 = a[15];

		b0 = b[0];
		b1 = b[1];
		b2 = b[2];
		b3 = b[3];
		r[0]  = a00 * b0 + a10 * b1 + a20 * b2 + a30 * b3;
		r[1]  = a01 * b0 + a11 * b1 + a21 * b2 + a31 * b3;
		r[2]  = a02 * b0 + a12 * b1 + a22 * b2 + a32 * b3;
		r[3]  = a03 * b0 + a13 * b1 + a23 * b2 + a33 * b3;

		b0 = b[4];
		b1 = b[5];
		b2 = b[6];
		b3 = b[7];
		r[4]  = a00 * b0 + a10 * b1 + a20 * b2 + a30 * b3;
		r[5]  = a01 * b0 + a11 * b1 + a21 * b2 + a31 * b3;
		r[6]  = a02 * b0 + a12 * b1 + a22 * b2 + a32 * b3;
		r[7]  = a03 * b0 + a13 * b1 + a23 * b2 + a33 * b3;

		b0 = b[8];
		b1 = b[9];
		b2 = b[10];
		b3 = b[11];
		r[8]  = a00 * b0 + a10 * b1 + a20 * b2 + a30 * b3;
		r[9]  = a01 * b0 + a11 * b1 + a21 * b2 + a31 * b3;
		r[10] = a02 * b0 + a12 * b1 + a22 * b2 + a32 * b3;
		r[11] = a03 * b0 + a13 * b1 + a23 * b2 + a33 * b3;

		b0 = b[12];
		b1 = b[13];
		b2 = b[14];
		b3 = b[15];
		r[12] = a00 * b0 + a10 * b1 + a20 * b2 + a30 * b3;
		r[13] = a01 * b0 + a11 * b1 + a21 * b2 + a31 * b3;
		r[14] = a02 * b0 + a12 * b1 + a22 * b2 + a32 * b3;
		r[15] = a03 * b0 + a13 * b1 + a23 * b2 + a33 * b3;

		return this;
	}

	/**
	 * Multiplies the current instance by the specified 4x4 matrix.
	 * @param rhs
	 * @return Mat4
	 */
	public function mul(rhs:Mat4):Mat4
	{
		return this.mul2(this, rhs);
	}

	/**
	 * Transforms a 3-dimensional point by a 4x4 matrix.
	 * @return Vec3
	 */
	public function transformPoint(?vec:Vec3, res?:Vec3):Vec3
	{
		var x:Float, y:Float, z:Float,
		m:Vector<Float> = this.data,
		v:Vector<Float> = vec.data;

		res = (res == null) ? new Vec3() : res;

		x = v[0] * m[0] + v[1] * m[4] + v[2] * m[8] + m[12];
		y = v[0] * m[1] + v[1] * m[5] + v[2] * m[9] + m[13];
		z = v[0] * m[2] + v[1] * m[6] + v[2] * m[10] + m[14];

		return res.set(x, y, z);
	}

	/**
	 * Transforms a 3-dimensional vector by a 4x4 matrix.
	 * @param	vec
	 * @param	res
	 * @return  Vec3
	 */
	public function transformVector(vec:Vec3, res?:Vec3):Vec3
	{
		var _x:Float, _y:Float, _z:Float,
		m = data,
		v = vec.data;

		res = (res == null) ? new Vec3() : res;

		_x = v[0] * m[0] + v[1] * m[4] + v[2] * m[8];
		_y = v[0] * m[1] + v[1] * m[5] + v[2] * m[9];
		_z = v[0] * m[2] + v[1] * m[6] + v[2] * m[10];

		return res.set(_x, _y, _z);
	}

	/**
	 * Transforms a 4-dimensional vector by a 4x4 matrix.
	 * @param	vec
	 * @param	res
	 * @return  Vec4
	 */

	public function transformVec4(vec:Vec4, res:Vec4):Vec4
	{
		var x:Float, y:Float, z:Float, w:Float,
		m = this.data,
		v = vec.data;

		res = (res == null) ? new Vec4() : res;

		x = v[0] * m[0] + v[1] * m[4] + v[2] * m[8] + v[3] * m[12];
		y = v[0] * m[1] + v[1] * m[5] + v[2] * m[9] + v[3] * m[13];
		z = v[0] * m[2] + v[1] * m[6] + v[2] * m[10] + v[3] * m[14];

		w = v[0] * m[3] + v[1] * m[7] + v[2] * m[11] + v[3] * m[15];

		return res.set(x, y, z, w);
	}

	/**
	 * Sets the specified matrix to a viewing matrix derived from an eye point, a target point
	 * and an up vector. The matrix maps the target point to the negative z-axis and the eye point to the
	 * origin, so that when you use a typical projection matrix, the center of the scene maps to the center
	 * of the viewport. Similarly, the direction described by the up vector projected onto the viewing plane
	 * is mapped to the positive y-axis so that it points upward in the viewport. The up vector must not be
	 * parallel to the line of sight from the eye to the reference point.
	 * @param	position
	 * @param	target
	 * @param	up
	 * @return  Mat4
	 */
	public function setLookAt(position:Vec3, target:Vec3, up:Vec3):Mat4
	{
		

		var x = new Vec3();
		var y = new Vec3();
		var z = new Vec3();

		z.sub2(position, target).normalize();
		y.copy(up).normalize();
		x.cross(y, z).normalize();
		y.cross(z, x);

		var r = this.data;

		r[0]  = x.x;
		r[1]  = x.y;
		r[2]  = x.z;
		r[3]  = 0;
		r[4]  = y.x;
		r[5]  = y.y;
		r[6]  = y.z;
		r[7]  = 0;
		r[8]  = z.x;
		r[9]  = z.y;
		r[10] = z.z;
		r[11] = 0;
		r[12] = position.x;
		r[13] = position.y;
		r[14] = position.z;
		r[15] = 1;

		return this;
	}

	/**
	 * Sets the specified matrix to a perspective projection matrix. The function's parameters define
	 * the shape of a frustum.
	 * @param	left
	 * @param	right
	 * @param	bottom
	 * @param	top
	 * @param	znear
	 * @param	zfar
	 * @return  Mat4
	 */
	public function setFrustum(left:Float, right:Float, bottom:Float, top:Float, znear:Float, zfar:Float):Mat4
	{
		var temp1 = 2 * znear;
		var temp2 = right - left;
		var temp3 = top - bottom;
		var temp4 = zfar - znear;

		var r = this.data;
		r[0] = temp1 / temp2;
		r[1] = 0;
		r[2] = 0;
		r[3] = 0;
		r[4] = 0;
		r[5] = temp1 / temp3;
		r[6] = 0;
		r[7] = 0;
		r[8] = (right + left) / temp2;
		r[9] = (top + bottom) / temp3;
		r[10] = (-zfar - znear) / temp4;
		r[11] = -1;
		r[12] = 0;
		r[13] = 0;
		r[14] = (-temp1 * zfar) / temp4;
		r[15] = 0;

		return this;
	}

	/**
	 * Sets the specified matrix to a perspective projection matrix. The function's
	 * parameters define the shape of a frustum.
	 * @param	fovy - The field of view in the frustum in the Y-axis of eye space (or X axis if fovIsHorizontal is true)
	 * @param	aspect - The aspect ratio of the frustum's projection plane (width / height).
	 * @param	znear - The near clip plane in eye coordinates.
	 * @param	zfar  - The far clip plane in eye coordinates.
	 * @param	fovIsHorizontal
	 * @return  Mat4
	 */
	public function setPerspective(fovy:Float, aspect:Float, znear:Float, zfar:Float, fovIsHorizontal?:Bool):Mat4
	{
		var xmax:Float, ymax:Float;

		if (!fovIsHorizontal)
		{
			ymax = znear * Math.tan(fovy * Math.PI / 360);
			xmax = ymax * aspect;
		}
		else {
			xmax = znear * Math.tan(fovy * Math.PI / 360);
			ymax = xmax / aspect;
		}

		return this.setFrustum(-xmax, xmax, -ymax, ymax, znear, zfar);
	}

	/**
	 * Sets the specified matrix to an orthographic projection matrix. The function's parameters
	 * define the shape of a cuboid-shaped frustum.
	 * @param	left - The x-coordinate for the left edge of the camera's projection plane in eye space.
	 * @param	right - The x-coordinate for the right edge of the camera's projection plane in eye space.
	 * @param	bottom - The y-coordinate for the bottom edge of the camera's projection plane in eye space.
	 * @param	top - The y-coordinate for the top edge of the camera's projection plane in eye space.
	 * @param	near - The near clip plane in eye coordinates.
	 * @param	far - The far clip plane in eye coordinates.
	 * @return	Mat4
	 */

	public function setOrtho(left:Float, right:Float, bottom:Float, top:Float, near:Float, far:Float):Mat4
	{
		var r = this.data;

		r[0] = 2 / (right - left);
		r[1] = 0;
		r[2] = 0;
		r[3] = 0;
		r[4] = 0;
		r[5] = 2 / (top - bottom);
		r[6] = 0;
		r[7] = 0;
		r[8] = 0;
		r[9] = 0;
		r[10] = -2 / (far - near);
		r[11] = 0;
		r[12] = -(right + left) / (right - left);
		r[13] = -(top + bottom) / (top - bottom);
		r[14] = -(far + near) / (far - near);
		r[15] = 1;

		return this;
	}

	/**
	 * Sets the specified matrix to a rotation matrix equivalent to a rotation around
	 * an axis. The axis must be normalized (unit length) and the angle must be specified in degrees.
	 * @param	axis - The normalized axis vector around which to rotate.
	 * @param	angle - The angle of rotation in degrees.
	 * @return	Mat4
	 */
	public function setFromAxisAngle(axis:Vec3, angle:Float):Mat4
	{
		

		angle *= Constants.DEG_TO_RAD;

		var _x = axis.x;
		var _y = axis.y;
		var _z = axis.z;
		var c = Math.cos(angle);
		var s = Math.sin(angle);
		var t = 1 - c;
		var tx = t * _x;
		var ty = t * _y;
		var m = this.data;

		m[0] = tx * _x + c;
		m[1] = tx * _y + s * _z;
		m[2] = tx * _z - s * _y;
		m[3] = 0;
		m[4] = tx * _y - s * _z;
		m[5] = ty * _y + c;
		m[6] = ty * _z + s * x;
		m[7] = 0;
		m[8] = tx * _z + s * _y;
		m[9] = ty * _z - _x * s;
		m[10] = t * _z * _z + c;
		m[11] = 0;
		m[12] = 0;
		m[13] = 0;
		m[14] = 0;
		m[15] = 1;

		return this;
	}

	/**
	 * Sets the specified matrix to a translation matrix.
	 * @param	tx The x-component of the translation.
	 * @param	ty The Y-component of the translation.
	 * @param	tz The z-component of the translation.
	 * @return
	 */
	public function setTranslate(tx:Float, ty:Float, tz:Float):Mat4
	{
		var m:Vector<Float> = this.data;

		m[0] = 1;
		m[1] = 0;
		m[2] = 0;
		m[3] = 0;
		m[4] = 0;
		m[5] = 1;
		m[6] = 0;
		m[7] = 0;
		m[8] = 0;
		m[9] = 0;
		m[10] = 1;
		m[11] = 0;
		m[12] = tx;
		m[13] = ty;
		m[14] = tz;
		m[15] = 1;

		return this;
	}

	/**
	 * Sets the specified matrix to a scale matrix.
	 * @param	sx The x-component of the scale.
	 * @param	sy The y-component of the scale.
	 * @param	sz The z-component of the scale.
	 * @return
	 */
	public function setScale(sx:Float, sy:Float, sz:Float):Mat4
	{
		var m:Vector<Float> = this.data;

		m[0] = sx;
		m[1] = 0;
		m[2] = 0;
		m[3] = 0;
		m[4] = 0;
		m[5] = sy;
		m[6] = 0;
		m[7] = 0;
		m[8] = 0;
		m[9] = 0;
		m[10] = sz;
		m[11] = 0;
		m[12] = 0;
		m[13] = 0;
		m[14] = 0;
		m[15] = 1;

		return this;
	}

	/**
	 * Sets the specified matrix to its inverse.
	 * @return Mat4
	 */
	public function invert():Mat4
	{
		var a00:Float, a01:Float, a02:Float, a03:Float,
		a10:Float, a11:Float, a12:Float, a13:Float,
		a20:Float, a21:Float, a22:Float, a23:Float,
		a30:Float, a31:Float, a32:Float, a33:Float,
		b00:Float, b01:Float, b02:Float, b03:Float,
		b04:Float, b05:Float, b06:Float, b07:Float,
		b08:Float, b09:Float, b10:Float, b11:Float,
		det:Float, invDet:Float, m:Vector<Float>;

		m = this.data;
		a00 = m[0];
		a01 = m[1];
		a02 = m[2];
		a03 = m[3];
		a10 = m[4];
		a11 = m[5];
		a12 = m[6];
		a13 = m[7];
		a20 = m[8];
		a21 = m[9];
		a22 = m[10];
		a23 = m[11];
		a30 = m[12];
		a31 = m[13];
		a32 = m[14];
		a33 = m[15];

		b00 = a00 * a11 - a01 * a10;
		b01 = a00 * a12 - a02 * a10;
		b02 = a00 * a13 - a03 * a10;
		b03 = a01 * a12 - a02 * a11;
		b04 = a01 * a13 - a03 * a11;
		b05 = a02 * a13 - a03 * a12;
		b06 = a20 * a31 - a21 * a30;
		b07 = a20 * a32 - a22 * a30;
		b08 = a20 * a33 - a23 * a30;
		b09 = a21 * a32 - a22 * a31;
		b10 = a21 * a33 - a23 * a31;
		b11 = a22 * a33 - a23 * a32;

		det = (b00 * b11 - b01 * b10 + b02 * b09 + b03 * b08 - b04 * b07 + b05 * b06);
		if (det == 0)
		{
			// #ifdef DEBUG
			trace("Can't invert matrix, determinant is 0");
			// #endif
			this.setIdentity();
		}
		else {
			invDet = 1 / det;

			m[0] = (a11 * b11 - a12 * b10 + a13 * b09) * invDet;
			m[1] = (-a01 * b11 + a02 * b10 - a03 * b09) * invDet;
			m[2] = (a31 * b05 - a32 * b04 + a33 * b03) * invDet;
			m[3] = (-a21 * b05 + a22 * b04 - a23 * b03) * invDet;
			m[4] = (-a10 * b11 + a12 * b08 - a13 * b07) * invDet;
			m[5] = (a00 * b11 - a02 * b08 + a03 * b07) * invDet;
			m[6] = (-a30 * b05 + a32 * b02 - a33 * b01) * invDet;
			m[7] = (a20 * b05 - a22 * b02 + a23 * b01) * invDet;
			m[8] = (a10 * b10 - a11 * b08 + a13 * b06) * invDet;
			m[9] = (-a00 * b10 + a01 * b08 - a03 * b06) * invDet;
			m[10] = (a30 * b04 - a31 * b02 + a33 * b00) * invDet;
			m[11] = (-a20 * b04 + a21 * b02 - a23 * b00) * invDet;
			m[12] = (-a10 * b09 + a11 * b07 - a12 * b06) * invDet;
			m[13] = (a00 * b09 - a01 * b07 + a02 * b06) * invDet;
			m[14] = (-a30 * b03 + a31 * b01 - a32 * b00) * invDet;
			m[15] = (a20 * b03 - a21 * b01 + a22 * b00) * invDet;
		}

		return this;
	}

	/**
	 * Sets matrix data from an array.
	 * @param	src
	 * @return  Mat4
	 */
	public function set(src:Vector<Float>):Mat4
	{
		var dst:Vector<Float> = this.data;
		dst[0] = src[0];
		dst[1] = src[1];
		dst[2] = src[2];
		dst[3] = src[3];
		dst[4] = src[4];
		dst[5] = src[5];
		dst[6] = src[6];
		dst[7] = src[7];
		dst[8] = src[8];
		dst[9] = src[9];
		dst[10] = src[10];
		dst[11] = src[11];
		dst[12] = src[12];
		dst[13] = src[13];
		dst[14] = src[14];
		dst[15] = src[15];

		return this;
	}

	/**
	 * Sets the specified matrix to the identity matrix.
	 * @return Mat4
	 */
	public function setIdentity():Mat4
	{
		var m:Vector<Float> = this.data;
		m[0] = 1;
		m[1] = 0;
		m[2] = 0;
		m[3] = 0;
		m[4] = 0;
		m[5] = 1;
		m[6] = 0;
		m[7] = 0;
		m[8] = 0;
		m[9] = 0;
		m[10] = 1;
		m[11] = 0;
		m[12] = 0;
		m[13] = 0;
		m[14] = 0;
		m[15] = 1;

		return this;
	}

	/**
	 * Sets the specified matrix to the concatenation of a translation, a
	 * quaternion rotation and a scale.
	 * @param	t A 3-d vector translation.
	 * @param	r A quaternion rotation.
	 * @param	s A 3-d vector scale.
	 * @return  Mat4
	 */
	public function setTRS(t:Vec3, r:Quat, s:Vec3):Mat4
	{
		var tx:Float, ty:Float, tz:Float, qx:Float, qy:Float, qz:Float, qw:Float, sx:Float, sy:Float, sz:Float,
		x2:Float, y2:Float, z2:Float, xx:Float, xy:Float, xz:Float, yy:Float, yz:Float, zz:Float, wx:Float, wy:Float, wz:Float, m:Vector<Float>;

		tx = t.x;
		ty = t.y;
		tz = t.z;

		qx = r.x;
		qy = r.y;
		qz = r.z;
		qw = r.w;

		sx = s.x;
		sy = s.y;
		sz = s.z;

		x2 = qx + qx;
		y2 = qy + qy;
		z2 = qz + qz;
		xx = qx * x2;
		xy = qx * y2;
		xz = qx * z2;
		yy = qy * y2;
		yz = qy * z2;
		zz = qz * z2;
		wx = qw * x2;
		wy = qw * y2;
		wz = qw * z2;

		m = this.data;

		m[0] = (1 - (yy + zz)) * sx;
		m[1] = (xy + wz) * sx;
		m[2] = (xz - wy) * sx;
		m[3] = 0;

		m[4] = (xy - wz) * sy;
		m[5] = (1 - (xx + zz)) * sy;
		m[6] = (yz + wx) * sy;
		m[7] = 0;

		m[8] = (xz + wy) * sz;
		m[9] = (yz - wx) * sz;
		m[10] = (1 - (xx + yy)) * sz;
		m[11] = 0;

		m[12] = tx;
		m[13] = ty;
		m[14] = tz;
		m[15] = 1;

		return this;
	}

	/**
	 * Sets the specified matrix to its transpose.
	 * @return Mat4
	 */
	public function transpose():Mat4
	{
		var tmp:Float, m:Vector<Float> = this.data;

		tmp = m[1];
		m[1] = m[4];
		m[4] = tmp;

		tmp = m[2];
		m[2] = m[8];
		m[8] = tmp;

		tmp = m[3];
		m[3] = m[12];
		m[12] = tmp;

		tmp = m[6];
		m[6] = m[9];
		m[9] = tmp;

		tmp = m[7];
		m[7] = m[13];
		m[13] = tmp;

		tmp = m[11];
		m[11] = m[14];
		m[14] = tmp;

		return this;
	}

	public function invertTo3x3(res:Vec3):Mat4
	{
		var a11:Float, a21:Float, a31:Float, a12:Float, a22:Float, a32:Float, a13:Float, a23:Float, a33:Float,
		m:Vector<Float>, r:Vector<Float>, det:Float, idet:Float;

		m = this.data;
		r = res.data;

		var m0:Float = m[0];
		var m1:Float = m[1];
		var m2:Float = m[2];

		var m4:Float = m[4];
		var m5:Float = m[5];
		var m6:Float = m[6];

		var m8:Float = m[8];
		var m9:Float = m[9];
		var m10:Float = m[10];

		a11 =  m10 * m5 - m6 * m9;
		a21 = -m10 * m1 + m2 * m9;
		a31 =  m6  * m1 - m2 * m5;
		a12 = -m10 * m4 + m6 * m8;
		a22 =  m10 * m0 - m2 * m8;
		a32 = -m6  * m0 + m2 * m4;
		a13 =  m9  * m4 - m5 * m8;
		a23 = -m9  * m0 + m1 * m8;
		a33 =  m5  * m0 - m1 * m4;

		det =  m0 * a11 + m1 * a12 + m2 * a13;
		if (det == 0)   // no inverse
		{
			trace("pc.Mat4#invertTo3x3: Matrix not invertible");
			return this;
		}

		idet = 1 / det;

		r[0] = idet * a11;
		r[1] = idet * a21;
		r[2] = idet * a31;
		r[3] = idet * a12;
		r[4] = idet * a22;
		r[5] = idet * a32;
		r[6] = idet * a13;
		r[7] = idet * a23;
		r[8] = idet * a33;

		return this;
	}

	/**
	 * Extracts the translational component from the specified 4x4 matrix.
	 * @param	t
	 * @return	Vec3
	 */
	public function getTranslation(t:Vec3):Vec3
	{
		t = (t == null) ? new Vec3() : t;

		return t.set(this.data[12], this.data[13], this.data[14]);
	}

	/**
	 * Extracts the x-axis from the specified 4x4 matrix.
	 * @param	x
	 * @return  Vec3
	 */
	public function getX(x:Vec3):Vec3
	{
		x = (x == null) ? new Vec3() : x;

		return x.set(this.data[0], this.data[1], this.data[2]);
	}

	/**
	 * Extracts the y-axis from the specified 4x4 matrix.
	 * @param	y
	 * @return  Vec3
	 */
	public function getY(y:Vec3):Vec3
	{
		y = (y == null) ? new Vec3() : y;

		return y.set(this.data[4], this.data[5], this.data[6]);
	}

	/**
	 * Extracts the y-axis from the specified 4x4 matrix.
	 * @param	y
	 * @return  Vec3
	 */
	public function getZ(z:Vec3):Vec3
	{
		z = (z == null) ? new Vec3() : z;

		return z.set(this.data[8], this.data[9], this.data[10]);
	}

	/**
	 * Extracts the scale component from the specified 4x4 matrix.
	 * @param	scale
	 * @return Vec3
	 */
	public function getScale(?scale:Vec3):Vec3{

		var _x:Vec3 = new Vec3();
		var _y:Vec3 = new Vec3();
		var _z:Vec3 = new Vec3();

		scale = (scale == null) ? new Vec3() : scale;

		this.getX(_x);
		this.getY(_y);
		this.getZ(_z);
		scale.set(_x.length(), _y.length(), _z.length());

		return scale;
	}

	/**
	 * Sets the specified matrix to a rotation matrix defined by
	 * Euler angles. The Euler angles are specified in XYZ order and in degrees.
	 * @param	ex Angle to rotate around X axis in degrees.
	 * @param	ey Angle to rotate around Y axis in degrees.
	 * @param	ez Angle to rotate around Z axis in degrees.
	 * @return Mat4
	 */

	public function setFromEulerAngles(ex:Float, ey:Float, ez:Float):Mat4
	{
		ex *= Constants.DEG_TO_RAD;
		ey *= Constants.DEG_TO_RAD;
		ez *= Constants.DEG_TO_RAD;

		// Solution taken from http://en.wikipedia.org/wiki/Euler_angles#Matrix_orientation
		var s1:Float = Math.sin(-ex);
		var c1:Float = Math.cos(-ex);
		var s2:Float = Math.sin(-ey);
		var c2:Float = Math.cos(-ey);
		var s3:Float = Math.sin(-ez);
		var c3:Float = Math.cos(-ez);

		var m:Vector<Float> = this.data;

		// Set rotation elements
		m[0] = c2 * c3;
		m[1] = -c2 * s3;
		m[2] = s2;
		m[3] = 0;

		m[4] = c1 * s3 + c3 * s1 * s2;
		m[5] = c1 * c3 - s1 * s2 * s3;
		m[6] = -c2 * s1;
		m[7] = 0;

		m[8] = s1 * s3 - c1 * c3 * s2;
		m[9] = c3 * s1 + c1 * s2 * s3;
		m[10] = c1 * c2;
		m[11] = 0;

		m[12] = 0;
		m[13] = 0;
		m[14] = 0;
		m[15] = 1;

		return this;
	}

	/**
	 * Extracts the Euler angles equivalent to the rotational portion
	 * of the specified matrix. The returned Euler angles are in XYZ order an in degrees.
	 * @param	eulers A 3-d vector to receive the Euler angles
	 * @return	Vec3
	 */
	public function getEulerAngles(?eulers:Vec3):Vec3
	{
		var scale:Vec3 = new Vec3();
		eulers = (eulers == null) ? new Vec3() : eulers;
		this.getScale(scale);
		var sx:Float = scale.x;
		var sy:Float = scale.y;
		var sz:Float = scale.z;

		var m:Vector<Float> = this.data;

		var _y:Float = Math.asin( -m[2] / sx);
		var _x:Float = 0.0;
		var _z:Float = 0.0;
		var halfPi:Float = Math.PI * 0.5;

		if (_y < halfPi)
		{
			if (_y > -halfPi)
			{
				_x = Math.atan2(m[6] / sy, m[10] / sz);
				_z = Math.atan2(m[1] / sx, m[0] / sx);
			}
			else
			{
				// Not a unique solution
				_z = 0;
				_x = -Math.atan2(m[4] / sy, m[5] / sy);
			}
		}
		else {
			// Not a unique solution
			_z = 0;
			_x = Math.atan2(m[4] / sy, m[5] / sy);
		}

		return eulers.set(_x, _y, _z).scale(Constants.RAD_TO_DEG);

	}

	/**
	 *  Converts the specified matrix to string form.
	 * @return String
	 */
	public function toString():String
	{
		var i, t;

		t = '[';
		i = 0;
		while (i < 16)
		{
			t += this.data[i];
			t += (i != 15) ? ', ' : '';
			
			i += 1;
		}
		t += ']';
		return t;
	}
	
	
	@:readOnly public static var IDENTITY:Mat4 = new Mat4();
	
	
	@:readOnly public static var ZERO:Mat4  = new Mat4(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	

}