package judas.graphics.enum;

/**
 * ...
 * @author Damilare Akinlaja
 */
@:enum
abstract CLEARFLAG(Int)
{

	/**
	 * Clear the color buffer.
	 */

	var COLOR = 1;

	/**
	 * Clear the depth buffer
	 */
	var DEPTH = 2;

	/**
	 * Clear the stencil buffer.
	 */
	var STENCIL = 4;
}