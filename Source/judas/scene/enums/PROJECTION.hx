package judas.scene.enums;

/**
 * ...
 * @author Damilare Akinlaja
 */
@:enum
abstract PROJECTION(Int) 
{
	/**
	 * A perspective camera projection where the frustum shape is essentially pyramidal.
	 */
	var PERSPECTIVE	= 	0;
	
	/**
	 * An orthographic camera projection where the frustum shape is essentially a cuboid.
	 */
	var	ORTHOGRAPHIC = 	1;
}