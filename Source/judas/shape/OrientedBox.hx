package judas.shape;
import haxe.ds.Vector;
import judas.math.Mat4;
import judas.math.Vec3;

/**
 * ...
 * @author Damilare Akinlaja
 */
class OrientedBox
{
	private var modelTransform:Mat4;

	private var aabb:BoundingBox;

	public var halfExtents:Mat4;

	private var tmpRay:Ray = new Ray();
	private var tmpVec3:Vec3 = new Vec3();
	private var tmpSphere:BoundingSphere = new BoundingSphere();
	private var tmpMat4:Mat4 = new Mat4();
	
	public var worldTransform(null, set):Mat4;

	
	/**
	 * Oriented Box
	 * Create a new oriented box.
	 * @param	worldTransform	The world transform of the OBB
	 * @param	halfExtents	Transform that has the orientation and position of the box. Scale is assumed to be one.
	 */
	public function new(?worldTransform:Mat4, ?halfExtents:Mat4)
	{
		this.halfExtents = halfExtents == null ? new new Vec3(0.5, 0.5, 0.5) : halfExtents;

		this.worldTransform = worldTransform == null ? tmpMat4.setIdentity() : worldTransform;
		this.modelTransform = worldTransform.clone().invert();
		this.aabb = new BoundingBox(new Vec3(), this.halfExtents);
	}

	/**
	 * Test if a ray intersects with the OBB.
	 * @param	ray	Ray to test against (direction must be normalized).
	 * @param	point	If there is an intersection, the intersection point will be copied into here.
	 * @return
	 */
	public function intersectsRay(ray:Ray, point?:Vec3):Bool
	{
		this.modelTransform.transformPoint(ray.origin, tmpRay.origin);
		this.modelTransform.transformVector(ray.direction, tmpRay.direction);

		if (point != null)
		{
			var result = this.aabb._intersectsRay(tmpRay, point);
			tmpMat4.copy(this.modelTransform).invert().transformPoint(point, point);
			return result;
		}
		else {
			return this.aabb._fastIntersectsRay(tmpRay);
		}
	}

	/**
	 * Test if a point is inside a OBB.
	 * @param	point	Point to test.
	 * @return	Bool
	 */
	public function containsPoint(point:Vec3):Bool
	{
		this.modelTransform.transformPoint(point, tmpVec3);
		return this.aabb.containsPoint(tmpVec3);
	}

	/**
	 * Test if a Bounding Sphere is overlapping, enveloping, or inside this OBB.
	 * @param	sphere	Bounding Sphere to test.
	 * @return	Bool
	 */
	public function intersectsBoundingSphere(sphere:BoundingSphere):Bool
	{
		this.modelTransform.transformPoint(sphere.center, tmpSphere.center);
		tmpSphere.radius = sphere.radius;

		if (this.aabb.intersectsBoundingSphere(tmpSphere))
		{
			return true;
		}

		return false;
	}
	
	
	public function set_worldTransform(value:Mat4):Mat4{
		this.modelTransform.copy(value).invert();
	}

}