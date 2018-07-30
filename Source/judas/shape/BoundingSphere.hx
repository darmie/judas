package judas.shape;
import haxe.ds.Vector;
import judas.math.Vec3;

/**
 * ...
 * @author Damilare Akinlaja
 */
class BoundingSphere
{
	private var tmpVecA:Vec3  = new Vec3();
	private var tmpVecB:Vec3  = new Vec3();
	private var tmpVecC:Vec3  = new Vec3();
	private var tmpVecD:Vec3  = new Vec3();

	public var center:Vec3;
	public var radius:Float;

	/**
	 * Creates a new bounding sphere.
	 * A bounding sphere is a volume for facilitating fast intersection testing.
	 * @param	center	The world space coordinate marking the center of the sphere. The constructor takes a reference of this parameter.
	 * @param	radius	The radius of the bounding sphere. Defaults to 0.5.
	 */

	public function new(?center:Vec3, ?radius:Float)
	{
		this.center = center == null ? new Vec3(0, 0, 0) : center;
		this.radius = radius == null ? 0.5 : radius;
	}

	public function containsPoint(point:Vec3):Bool
	{
		var lenSq = tmpVecA.sub2(point, this.center).lengthSq();
		var r = this.radius;
		return lenSq < r * r;
	}

	public function compute(vertices:Vector<Float>):Void
	{
		var numVerts:Float = vertices.length / 3;

		var vertex = tmpVecA;
		var avgVertex = tmpVecB;
		var sum = tmpVecC;

		// FIRST PASS:
		// Find the "average vertex", which is the sphere's center...

		for (i in 0...numVerts)
		{
			vertex.set(vertices[ i * 3 ], vertices[ i * 3 + 1 ], vertices[ i * 3 + 2 ]);
			sum.add(vertex);

			// apply a part-result to avoid float-overflows
			if (i % 100 == 0)
			{
				sum.scale(1 / numVerts);
				avgVertex.add(sum);
				sum.set(0, 0, 0);
			}
		}

		sum.scale(1 / numVerts);
		avgVertex.add(sum);

		this.center.copy(avgVertex);

		// SECOND PASS:
		// Find the maximum (squared) distance of all vertices to the center...
		var maxDistSq:Float = 0;
		var centerToVert = tmpVecD;

		for (i in 0...numVerts)
		{
			vertex.set(vertices[ i * 3 ], vertices[ i * 3 + 1 ], vertices[ i * 3 + 2 ]);

			centerToVert.sub2(vertex, this.center);
			maxDistSq = Math.max(centerToVert.lengthSq(), maxDistSq);
		}

		this.radius = Math.sqrt(maxDistSq);
	}

	/**
	 * Test if a ray intersects with the sphere.
	 * @param	ray	Ray to test against (direction must be normalized).
	 * @param	point	If there is an intersection, the intersection point will be copied into here.
	 * @return	Bool
	 */
	public function intersectsRay(ray:Ray, point?:Vec3):Bool
	{
		var m = tmpVecA.copy(ray.origin).sub(this.center);
		var b:Float = m.dot(tmpVecB.copy(ray.direction).normalize());
		var c:Float = m.dot(m) - this.radius * this.radius;

		// exit if ray's origin outside of sphere (c > 0) and ray pointing away from s (b > 0)
		if (c > 0 && b > 0)
			return null;

		var discr:Float = b * b - c;
		// a negative discriminant corresponds to ray missing sphere
		if (discr < 0)
			return false;

		// ray intersects sphere, compute smallest t value of intersection
		var t = Math.abs(-b - Math.sqrt(discr));

		// if t is negative, ray started inside sphere so clamp t to zero
		if (point != null)
			point.copy(ray.direction).scale(t).add(ray.origin);

		return true;
	}

	/**
	 * Test if a Bounding Sphere is overlapping, enveloping, or inside this Bounding Sphere.
	 * @param	sphere	Bounding Sphere to test.
	 * @return	Bool
	 */
	public function intersectsBoundingSphere(sphere:BoundingSphere):Bool
	{
		tmpVecA.sub2(sphere.center, this.center);
		var totalRadius:Float = sphere.radius + this.radius;
		if (tmpVecA.lengthSq() <= totalRadius * totalRadius)
		{
			return true;
		}

		return false;
	}

}