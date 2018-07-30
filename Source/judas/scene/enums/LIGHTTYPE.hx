package judas.scene.enums;

/**
 * ...
 * @author Damilare Akinlaja
 */
@:enum
abstract LIGHTTYPE(Int) 
{
	/**
	 * Directional (global) light source.
	 */
	var DIRECTIONAL = 0;
	/**
	 * Point (local) light source.
	 */
	var POINT	=	1;
	
	/**
	 * Spot (local) light source.
	 */
	var SPOT	=	2;
}