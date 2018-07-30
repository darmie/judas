package judas.scene.enums;

/**
 * ...
 * @author Damilare Akinlaja
 */

@:enum
abstract BLEND(Int) 
{
	/**
	 *  Subtract the color of the source fragment from the destination fragment
     *  and write the result to the frame buffer.
	 */
	var SUBTRACTIVE = 0;
	
	/**
	 * Add the color of the source fragment to the destination fragment
     * and write the result to the frame buffer.
	 */
	var ADDITIVE =	1;
	
	/**
	 * Enable simple translucency for materials such as glass. This is
     * equivalent to enabling a source blend mode of judas.graphics.enum.BLENDMODE.SRC_ALPHA and a destination
     * blend mode of judas.graphics.enum.BLENDMODE.ONE_MINUS_SRC_ALPHA.
	 */
	var NORMAL	=	2;
	
	/**
	 *  Disable blending.
	 */
	var NONE = 3;
	
	/**
	 * Similar to .BLEND.NORMAL except the source fragment is assumed to have
     * already been multiplied by the source alpha value.
	 */
	var PREMULTIPLIED = 4;
	
	/**
	 * Multiply the color of the source fragment by the color of the destination
     * fragment and write the result to the frame buffer.
	 */
	var MULTIPLICATIVE = 5;
	
	/**
	 * Same as .BLEND.ADDITIVE except the source RGB is multiplied by the source alpha.
	 */
	var ADDITIVEALPHA = 6;
	
	/**
	 * Multiplies colors and doubles the result
	 */
	var MULTIPLICATIVE2X = 7;
	
	/**
	 * Softer version of additive
	 */
	var SCREEN	=	8;
	
	/**
	 * Minimum color.
	 */
	var MIN	=	9;
	
	/**
	 * Maximum color.
	 */
	var MAX	=	10;
}