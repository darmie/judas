package judas.graphics.enum;

/**
 * ...
 * @author Damilare Akinlaja
 */
@:enum
abstract CULLFACE(Int)
{
	/**
	 * No triangles are culled.
	 */

	var NONE = 0;

	/**
	 * Triangles facing away from the view direction are culled.
	 */

	var BACK = 1;

	/**
	 * Triangles facing the view direction are culled.
	 */
	var FRONT = 2;

	/**
	 * Triangles are culled regardless of their orientation with respect to the view
	 * direction. Note that point or line primitives are unaffected by this render state.
	 */

	var FRONTANDBACK = 3;
}