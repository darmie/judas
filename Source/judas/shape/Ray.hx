package judas.shape;
import judas.math.Vec3;

/**
 * ...
 * @author Damilare Akinlaja
 */
class Ray 
{

	public var origin:Vec3;
	public var direction:Vec3;
	
	/**
	 * An infinite ray
	 * Creates a new infinite ray starting at a given origin and pointing in a given direction.
	 * @param	origin
	 * @param	direction
	 */	
	public function new(?origin:Vec3, ?direction:Vec3) 
	{
        this.origin = origin != null ? origin : new Vec3(0, 0, 0);
        this.direction = direction != null ? direction : new Vec3(0, 0, -1);		
	}
	
}