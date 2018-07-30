package judas.graphics.enum;

/**
 * ...
 * @author Damilare Akinlaja
 */
@:enum
abstract BLENDMODE(Int)
{
	/**
	 * Multiply all fragment components by zero.
	 */
	var ZERO = 0;

	/**
	 * Multiply all fragment components by one.
	 */
	var ONE = 1;

	/**
	 * Multiply all fragment components by the components of the source fragment.
	 */
	var SRC_COLOR = 2;

	/**
	 * Multiply all fragment components by one minus the components of the source fragment.
	 */
	var ONE_MINUS_SRC_COLOR = 3;

	/**
	 * Multiply all fragment components by the components of the destination fragment.
	 */
	var DST_COLOR = 4;

	/**
	 * Multiply all fragment components by one minus the components of the destination fragment.
	 */
	var ONE_MINUS_DST_COLOR = 5;

	/**
	 * Multiply all fragment components by the alpha value of the source fragment.
	 */
	var SRC_ALPHA = 6;

	/**
	 * Multiply all fragment components by the alpha value of the source fragment.
	 */
	var SRC_ALPHA_SATURATE = 7;

	/**
	 * Multiply all fragment components by one minus the alpha value of the source fragment.
	 */
	var ONE_MINUS_SRC_ALPHA = 8;

	/**
	 * Multiply all fragment components by the alpha value of the destination fragment.
	 */
	var DST_ALPHA = 9;

	/**
	 * Multiply all fragment components by one minus the alpha value of the destination fragment.
	 */
	var ONE_MINUS_DST_ALPHA = 10;
}