package judas.graphics.enum;

/**
 * ...
 * @author Damilare Akinlaja
 */
@:enum
abstract CUBEFACE(Int)
{
	/**
	 * The positive X face of a cubemap.
	 */
	var POSX = 0;

	/**
	 * The negative X face of a cubemap.
	 */
	var NEGX = 1;

	/**
	 * The positive Y face of a cubemap.
	 */
	var POSY = 2;

	/**
	 * The negative Y face of a cubemap
	 */
	var NEGY = 3;

	/**
	 * The positive Z face of a cubemap.
	 */
	var POSZ = 4;

	/**
	 * The negative Z face of a cubemap.
	 */
	var NEGZ = 5;
}