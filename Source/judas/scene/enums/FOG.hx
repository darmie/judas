package judas.scene.enums;

/**
 * ...
 * @author Damilare Akinlaja
 */
@:enum
abstract FOG(String) 
{
	/**
	 * No fog is applied to the scene.
	 */
	var NONE = "none";
	
	/**
	 * Fog rises linearly from zero to 1 between a start and end depth.
	 */
	var LINEAR = "linear";
	
	/**
	 * Fog rises according to an exponential curve controlled by a density value.
	 */
	var EXP	=	"exp";
	
	/**
	 * Fog rises according to an exponential curve controlled by a density value.
	 */
	var EXP2	= "exp2";
}