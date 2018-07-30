package judas.shape;
import judas.math.Vec3;

/**
 * ...
 * @author Damilare Akinlaja
 */
class Plane
{
	public var normal:Vec3;
	public var point:Vec3;

	private var tmpVecA:Vec3 = new Vec3();

	/**
	 * An infinite plane.
	 * Create an infinite plane.
	 * @param	point	Point position on the plane. The constructor takes a reference of this parameter.
	 * @param	normal	Normal of the plane. The constructor takes a reference of this parameter.
	 */
	public function new(?point:Vec3, ?normal:Vec3)
	{
		this.normal = normal == null ? new Vec3(0, 0, 1) : normal;
		this.point = point == null ? new Vec3(0, 0, 0) : point;
	}

	/**
	 * Test if the plane intersects between two points.
	 * @param	start	Start position of line.
	 * @param	end		End position of line.
	 * @param	point	If there is an intersection, the intersection point will be copied into here.
	 * @return
	 */
	public function intersectsLine(start:Vec3, end:Vec3, ?point:Vec3):Bool
	{
		var d:Float = -this.normal.dot(this.point);
		var d0:Float = this.normal.dot(start) + d;
		var d1:Float = this.normal.dot(end) + d;

		var t:Float = d0 / (d0 - d1);
		var intersects = t >= 0 && t <= 1;
		if (intersects && point != null)
			point.lerp(start, end, t);

		return intersects;
	}

	/**
	 * Test if a ray intersects with the infinite plane
	 * @param	ray		Ray to test against (direction must be normalized)
	 * @param	point	If there is an intersection, the intersection point will be copied into here
	 * @return	Bool
	 */
	public function intersectsRay(ray:Ray, ?point:Vec3):Bool
	{
		var pointToOrigin = tmpVecA.sub2(this.point, ray.origin);
		var t = this.normal.dot(pointToOrigin) / this.normal.dot(ray.direction);
		var intersects:Bool = t >= 0;

		if (intersects && point != null)
			point.copy(ray.direction).scale(t).add(ray.origin);

		return intersects;
	}

}