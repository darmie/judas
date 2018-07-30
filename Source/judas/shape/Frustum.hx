package judas.shape;
import haxe.ds.Vector;
import judas.math.Mat4;
import judas.math.Vec3;
import judas.shape.BoundingSphere;

/**
 * ...
 * @author Damilare Akinlaja
 */
class Frustum
{

	public var planes:Vector<Vector<Float>>;

	private var viewProj:Mat4 = new Mat4();
	/**
	 * A frustum is a shape that defines the viewing space of a camera.
	 * Creates a new frustum shape.
	 * @param	projectionMatrix	The projection matrix describing the shape of the frustum.
	 * @param	viewMatrix	The inverse of the world transformation matrix for the frustum.
	 */
	public function new(?projectionMatrix:Mat4, ?viewMatrix:Mat4)
	{
		projectionMatrix = projectionMatrix != null ? projectionMatrix : new Mat4().setPerspective(90, 16 / 9, 0.1, 1000);
		viewMatrix = viewMatrix != null ? viewMatrix : new Mat4();

		this.planes = [];
		for (i in 0...6)
			this.planes[i] = [ ];

		this.update(projectionMatrix, viewMatrix);
	}

	public function update(projectionMatrix:Mat4, viewMatrix:Mat4):Void
	{
		viewProj.mul2(projectionMatrix, viewMatrix);
		var vpm:Vector<Float> = viewProj.data;

		// Extract the numbers for the RIGHT plane
		this.planes[0][0] = vpm[ 3] - vpm[ 0];
		this.planes[0][1] = vpm[ 7] - vpm[ 4];
		this.planes[0][2] = vpm[11] - vpm[ 8];
		this.planes[0][3] = vpm[15] - vpm[12];
		// Normalize the result
		var t:Float = Math.sqrt(this.planes[0][0] * this.planes[0][0] + this.planes[0][1] * this.planes[0][1] + this.planes[0][2] * this.planes[0][2]);
		this.planes[0][0] /= t;
		this.planes[0][1] /= t;
		this.planes[0][2] /= t;
		this.planes[0][3] /= t;

		// Extract the numbers for the LEFT plane
		this.planes[1][0] = vpm[ 3] + vpm[ 0];
		this.planes[1][1] = vpm[ 7] + vpm[ 4];
		this.planes[1][2] = vpm[11] + vpm[ 8];
		this.planes[1][3] = vpm[15] + vpm[12];
		// Normalize the result
		t = Math.sqrt(this.planes[1][0] * this.planes[1][0] + this.planes[1][1] * this.planes[1][1] + this.planes[1][2] * this.planes[1][2]);
		this.planes[1][0] /= t;
		this.planes[1][1] /= t;
		this.planes[1][2] /= t;
		this.planes[1][3] /= t;

		// Extract the BOTTOM plane
		this.planes[2][0] = vpm[ 3] + vpm[ 1];
		this.planes[2][1] = vpm[ 7] + vpm[ 5];
		this.planes[2][2] = vpm[11] + vpm[ 9];
		this.planes[2][3] = vpm[15] + vpm[13];
		// Normalize the result
		t = Math.sqrt(this.planes[2][0] * this.planes[2][0] + this.planes[2][1] * this.planes[2][1] + this.planes[2][2] * this.planes[2][2] );
		this.planes[2][0] /= t;
		this.planes[2][1] /= t;
		this.planes[2][2] /= t;
		this.planes[2][3] /= t;

		// Extract the TOP plane
		this.planes[3][0] = vpm[ 3] - vpm[ 1];
		this.planes[3][1] = vpm[ 7] - vpm[ 5];
		this.planes[3][2] = vpm[11] - vpm[ 9];
		this.planes[3][3] = vpm[15] - vpm[13];
		// Normalize the result
		t = Math.sqrt(this.planes[3][0] * this.planes[3][0] + this.planes[3][1] * this.planes[3][1] + this.planes[3][2] * this.planes[3][2]);
		this.planes[3][0] /= t;
		this.planes[3][1] /= t;
		this.planes[3][2] /= t;
		this.planes[3][3] /= t;

		// Extract the FAR plane
		this.planes[4][0] = vpm[ 3] - vpm[ 2];
		this.planes[4][1] = vpm[ 7] - vpm[ 6];
		this.planes[4][2] = vpm[11] - vpm[10];
		this.planes[4][3] = vpm[15] - vpm[14];
		// Normalize the result
		t = Math.sqrt(this.planes[4][0] * this.planes[4][0] + this.planes[4][1] * this.planes[4][1] + this.planes[4][2] * this.planes[4][2]);
		this.planes[4][0] /= t;
		this.planes[4][1] /= t;
		this.planes[4][2] /= t;
		this.planes[4][3] /= t;

		// Extract the NEAR plane
		this.planes[5][0] = vpm[ 3] + vpm[ 2];
		this.planes[5][1] = vpm[ 7] + vpm[ 6];
		this.planes[5][2] = vpm[11] + vpm[10];
		this.planes[5][3] = vpm[15] + vpm[14];
		// Normalize the result
		t = Math.sqrt(this.planes[5][0] * this.planes[5][0] + this.planes[5][1] * this.planes[5][1] + this.planes[5][2] * this.planes[5][2]);
		this.planes[5][0] /= t;
		this.planes[5][1] /= t;
		this.planes[5][2] /= t;
		this.planes[5][3] /= t;
	}

	/**
	 * Tests whether a point is inside the frustum. Note that points lying in a frustum plane are
	 * considered to be outside the frustum.
	 * @param	point	 The point to test
	 * @return	Bool
	 */
	public function containsPoint(point:Vec3):Bool
	{
		for (p in 0...6)
			if (this.planes[p][0] * point.x +
			this.planes[p][1] * point.y +
			this.planes[p][2] * point.z +
			this.planes[p][3] <= 0)
				return false;
		return true;
	}

	/**
	 * Tests whether a bounding sphere intersects the frustum. If the sphere is outside the frustum,
     * zero is returned. If the sphere intersects the frustum, 1 is returned. If the sphere is completely inside
     * the frustum, 2 is returned. Note that a sphere touching a frustum plane from the outside is considered to
     * be outside the frustum.
	 * @param	sphere	The sphere to test
	 * @return	Float 	0 if the bounding sphere is outside the frustum, 1 if it intersects the frustum and 2 if
     * it is contained by the frustum
	 */
	public function containsSphere(sphere:BoundingSphere):Float
	{
		var c:Int = 0;
		var d:Float;

		var sr = sphere.radius;
		var sc = sphere.center.data;
		var scx:Float = sc[0];
		var scy:Float = sc[1];
		var scz:Float = sc[2];
		var planes = this.planes;
		var plane:Vector<Float>;

		for (p in 0...6)
		{
			plane = planes[p];
			d = plane[0] * scx + plane[1] * scy + plane[2] * scz + plane[3];
			if (d <= -sr)
				return 0;
			if (d > sr)
				c++;
		}

		return (c == 6) ? 2 : 1;
	}

}