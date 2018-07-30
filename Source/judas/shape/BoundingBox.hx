package judas.shape;
import haxe.ds.Vector;
import judas.math.Mat4;
import judas.math.Vec3;

/**
 * ...
 * @author Damilare Akinlaja
 */
class BoundingBox
{

	private var tmpVecA:Vec3  = new Vec3();
	private var tmpVecB:Vec3  = new Vec3();
	private var tmpVecC:Vec3  = new Vec3();
	private var tmpVecD:Vec3  = new Vec3();
	private var tmpVecE:Vec3  = new Vec3();

	public var center:Vec3;
	public var halfExtents:Vec3;

	private var min:Vec3;
	private var max:Vec3;

	public var type:Dynamic;
	/**
	 * Axis-Aligned Bounding Box.
	 * Create a new axis-aligned bounding box.
	 * @param	center	Center of box. The constructor takes a reference of this parameter.
	 * @param	halfExtents	Half the distance across the box in each axis. The constructor takes a reference of this parameter.
	 */
	public function new(center:Vec3 = new Vec3(0, 0, 0), halfExtents:Vec3 = new Vec3(0.5, 0.5, 0.5))
	{
		this.center = center;
		this.halfExtents = halfExtents;

		this.min = new Vec3();
		this.max = new Vec3();
	}

	/**
	 * Combines two bounding boxes into one, enclosing both.
	 * @param	other	- Bounding box to add.
	 */
	public function add(other:BoundingBox):Void
	{
		var tc:Vector<Float> = this.center.data;
		var tcx:Float = tc[0];
		var tcy:Float = tc[1];
		var tcz:Float = tc[2];
		var th:Vector<Float> = this.halfExtents.data;
		var thx:Float = th[0];
		var thy:Float = th[1];
		var thz:Float = th[2];
		var tminx:Float = tcx - thx;
		var tmaxx:Float = tcx + thx;
		var tminy:Float = tcy - thy;
		var tmaxy:Float = tcy + thy;
		var tminz:Float = tcz - thz;
		var tmaxz:Float = tcz + thz;

		var oc:Vector<Float> = other.center.data;
		var ocx:Float = oc[0];
		var ocy:Float = oc[1];
		var ocz:Float = oc[2];
		var oh:Vector<Float> = other.halfExtents.data;
		var ohx:Float = oh[0];
		var ohy:Float = oh[1];
		var ohz:Float = oh[2];
		var ominx:Float = ocx - ohx;
		var omaxx:Float = ocx + ohx;
		var ominy:Float = ocy - ohy;
		var omaxy:Float = ocy + ohy;
		var ominz:Float = ocz - ohz;
		var omaxz:Float = ocz + ohz;

		if (ominx < tminx) tminx = ominx;
		if (omaxx > tmaxx) tmaxx = omaxx;
		if (ominy < tminy) tminy = ominy;
		if (omaxy > tmaxy) tmaxy = omaxy;
		if (ominz < tminz) tminz = ominz;
		if (omaxz > tmaxz) tmaxz = omaxz;

		tc[0] = (tminx + tmaxx) * 0.5;
		tc[1] = (tminy + tmaxy) * 0.5;
		tc[2] = (tminz + tmaxz) * 0.5;
		th[0] = (tmaxx - tminx) * 0.5;
		th[1] = (tmaxy - tminy) * 0.5;
		th[2] = (tmaxz - tminz) * 0.5;
	}

	/**
	 * Copy the bounding box
	 * @param	src
	 */
	public function copy(src:BoundingBox):Void
	{
		this.center.copy(src.center);
		this.halfExtents.copy(src.halfExtents);
		this.type = src.type;
	}

	/**
	 * Clone the bounding box
	 */
	public function clone()
	{
		return new BoundingBox(this.center.clone(), this.halfExtents.clone());
	}

	/**
	 * Test whether two axis-aligned bounding boxes intersect.
	 * @param	other	Boundingbox to test against
	 * @return	Bool
	 */
	public function intersects(other:BoundingBox):Bool
	{
		var aMax:Vec3 = this.getMax();
		var aMin:Vec3 = this.getMin();
		var bMax:Vec3 = other.getMax();
		var bMin:Vec3 = other.getMin();

		return (aMin.x <= bMax.x) && (aMax.x >= bMin.x) &&
		(aMin.y <= bMax.y) && (aMax.y >= bMin.y) &&
		(aMin.z <= bMax.z) && (aMax.z >= bMin.z);
	}

	public function _intersectsRay(ray:Ray, point:Vec3):Bool
	{
		var tMin = tmpVecA.copy(this.getMin()).sub(ray.origin).data;
		var tMax = tmpVecB.copy(this.getMax()).sub(ray.origin).data;
		var dir = ray.direction.data;

		// Ensure that we are not dividing it by zero
		for (i in 0...3)
		{
			if (dir[i] == 0)
			{
				tMin[i] = tMin[i] < 0 ? -Math.POSITIVE_INFINITY : Math.POSITIVE_INFINITY;
				tMax[i] = tMax[i] < 0 ? -Math.POSITIVE_INFINITY : Math.POSITIVE_INFINITY;
			}
			else
			{
				tMin[i] /= dir[i];
				tMax[i] /= dir[i];
			}
		}

		var realMin = tmpVecC.set(Math.min(tMin[0], tMax[0]), Math.min(tMin[1], tMax[1]), Math.min(tMin[2], tMax[2])).data;
		var realMax = tmpVecD.set(Math.max(tMin[0], tMax[0]), Math.max(tMin[1], tMax[1]), Math.max(tMin[2], tMax[2])).data;

		var minMax = Math.min(Math.min(realMax[0], realMax[1]), realMax[2]);
		var maxMin = Math.max(Math.max(realMin[0], realMin[1]), realMin[2]);

		var _intersects:Bool = minMax >= maxMin && maxMin >= 0;

		if (_intersects)
			point.copy(ray.direction).scale(maxMin).add(ray.origin);

		return _intersects;
	}

	public function _fastIntersectsRay(ray:Ray):Bool
	{
		var diff = tmpVecA;
		var cross = tmpVecB;
		var prod = tmpVecC;
		var absDiff = tmpVecD;
		var absDir = tmpVecE;
		var rayDir = ray.direction;

		diff.sub2(ray.origin, this.center);
		absDiff.set(Math.abs(diff.x), Math.abs(diff.y), Math.abs(diff.z));

		prod.mul2(diff, rayDir);

		if (absDiff.x > this.halfExtents.x && prod.x >= 0)
			return false;

		if (absDiff.y > this.halfExtents.y && prod.y >= 0)
			return false;

		if (absDiff.z > this.halfExtents.z && prod.z >= 0)
			return false;

		absDir.set(Math.abs(rayDir.x), Math.abs(rayDir.y), Math.abs(rayDir.z));
		cross.cross(rayDir, diff);
		cross.set(Math.abs(cross.x), Math.abs(cross.y), Math.abs(cross.z));

		if (cross.x > this.halfExtents.y * absDir.z + this.halfExtents.z * absDir.y)
			return false;

		if (cross.y > this.halfExtents.x * absDir.z + this.halfExtents.z * absDir.x)
			return false;

		if (cross.z > this.halfExtents.x * absDir.y + this.halfExtents.y * absDir.x)
			return false;

		return true;
	}

	/**
	 * Test if a ray intersects with the AABB.
	 * @param	ray	Ray to test against (direction must be normalized).
	 * @param	point	If there is an intersection, the intersection point will be copied into here.
	 * @return	Bool
	 */
	public function intersectsRay(ray:Ray, point?:Vec3):Bool
	{
		if (point != null)
		{
			return this._intersectsRay(ray, point);
		}
		else {
			return this._fastIntersectsRay(ray);
		}
	}

	public function setMinMax(min:Vec3, max:Vec3):Void
	{
		this.center.add2(max, min).scale(0.5);
		this.halfExtents.sub2(max, min).scale(0.5);
	}

	/**
	 * Return the minimum corner of the AABB.
	 * @return Vec3
	 */
	public function getMin():Vec3
	{
		return this.min.copy(this.center).sub(this.halfExtents);
	}

	/**
	 * Return the maximum corner of the AABB.
	 * @return	maximum corner.
	 */
	public function getMax():Vec3
	{
		return this.max.copy(this.center).add(this.halfExtents);
	}

	/**
	 * Test if a point is inside a AABB.
	 * @param	point	Point to test.
	 * @return	Bool
	 */
	public function containsPoint(point:Vec3):Bool
	{
		var min = this.getMin();
		var max = this.getMax();

		for (i in 0...3)
		{
			if (point.data[i] < min.data[i] || point.data[i] > max.data[i])
				return false;
		}

		return true;
	}

	/**
	 * Set an AABB to enclose the specified AABB if it were to be transformed by the specified 4x4 matrix.
	 * @param	aabb	Box to transform and enclose
	 * @param	m	Transformation matrix to apply to source AABB.
	 */
	public function setFromTransformedAabb(aabb:BoundingBox, m:Mat4):Void
	{
		var bc = this.center;
		var br = this.halfExtents;
		var ac = aabb.center.data;
		var ar = aabb.halfExtents.data;

		m = m.data;
		var mx0 = m[0];
		var mx1 = m[4];
		var mx2 = m[8];
		var my0 = m[1];
		var my1 = m[5];
		var my2 = m[9];
		var mz0 = m[2];
		var mz1 = m[6];
		var mz2 = m[10];

		var mx0a = Math.abs(mx0);
		var mx1a = Math.abs(mx1);
		var mx2a = Math.abs(mx2);
		var my0a = Math.abs(my0);
		var my1a = Math.abs(my1);
		var my2a = Math.abs(my2);
		var mz0a = Math.abs(mz0);
		var mz1a = Math.abs(mz1);
		var mz2a = Math.abs(mz2);

		bc.set(
			m[12] + mx0 * ac[0] + mx1 * ac[1] + mx2 * ac[2],
			m[13] + my0 * ac[0] + my1 * ac[1] + my2 * ac[2],
			m[14] + mz0 * ac[0] + mz1 * ac[1] + mz2 * ac[2]
		);

		br.set(
			mx0a * ar[0] + mx1a * ar[1] + mx2a * ar[2],
			my0a * ar[0] + my1a * ar[1] + my2a * ar[2],
			mz0a * ar[0] + mz1a * ar[1] + mz2a * ar[2]
		);
	}

	public function compute(vertices:Vector<Float>):Void
	{
		var min = tmpVecA.set(vertices[0], vertices[1], vertices[2]);
		var max = tmpVecB.set(vertices[0], vertices[1], vertices[2]);
		var numVerts:Float = vertices.length / 3;

		for (i in 1...numVerts)
		{
			var x = vertices[i * 3 + 0];
			var y = vertices[i * 3 + 1];
			var z = vertices[i * 3 + 2];
			if (x < min.x) min.x = x;
			if (y < min.y) min.y = y;
			if (z < min.z) min.z = z;
			if (x > max.x) max.x = x;
			if (y > max.y) max.y = y;
			if (z > max.z) max.z = z;
		}

		this.setMinMax(min, max);
	}

	public function intersectsBoundingSphere(sphere:BoundingSphere):Bool
	{
		var sq:Float = this.distanceToBoundingSphereSq(sphere);
		if (sq <= sphere.radius * sphere.radius)
		{
			return true;
		}

		return false;
	}

	private function distanceToBoundingSphereSq(sphere:BoundingSphere):Float
	{
		var boxMin = this.getMin();
		var boxMax = this.getMax();

		var sq:Float = 0;

		for (i in 0...3) {
		var out:Float = 0;
		var pn:Float = sphere.center.data[i];
			var bMin:Float = boxMin.data[i];
			var bMax:Float = boxMax.data[i];
			var val:Float = 0;

			if (pn < bMin)
			{
				val = (bMin - pn);
				out += val * val;
			}

			if (pn > bMax)
			{
				val = (pn - bMax);
				out += val * val;
			}

			sq += out;
		}

		return sq;
	}

}