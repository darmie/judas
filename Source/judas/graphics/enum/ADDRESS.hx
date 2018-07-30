package judas.graphics.enum;

/**
 * ...
 * @author Damilare Akinlaja
 */
@:enum
abstract ADDRESS(Int)
{
	/**
	 * Ignores the integer part of texture coordinates; using only the fractional part.
	 */
	var REPEAT = 0;

	/**
	 * Clamps texture coordinate to the range 0 to 1.
	 */
	var CLAMP_TO_EDGE = 1;

	/**
	 * Texture coordinate to be set to the fractional part if the integer part is even; if the integer part is odd;
	 * then the texture coordinate is set to 1 minus the fractional part.
	 */
	var MIRRORED_REPEAT = 2;
}