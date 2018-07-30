package judas.graphics.enum;

/**
 * ...
 * @author Damilare Akinlaja
 */
@:enum
abstract PIXELFORMAT(Int)
{
	/**
	 * 8-bit alpha.
	 */
	var A8= 0;
	/**
	 * 8-bit luminance.
	 */
	var L8= 1;
	/**
	 * 8-bit luminance with 8-bit alpha.
	 */
	var L8_A8= 2;
	/**
	 * 16-bit RGB (5-bits for red channel; 6 for green and 5 for blue).
	 */
	var R5_G6_B5= 3;
	/**
	 * 16-bit RGBA (5-bits for red channel; 5 for green; 5 for blue with 1-bit alpha).
	 */
	var R5_G5_B5_A1= 4;
	/**
	 * 16-bit RGBA (4-bits for red channel; 4 for green; 4 for blue with 4-bit alpha).
	 */
	var R4_G4_B4_A4= 5;
	/**
	 * 24-bit RGB (8-bits for red channel; 8 for green and 8 for blue).
	 */
	var R8_G8_B8= 6;
	/**
	 * 32-bit RGBA (8-bits for red channel; 8 for green; 8 for blue with 8-bit alpha).
	 */
	var R8_G8_B8_A8= 7;
	/**
	 * Block compressed format; storing 16 input pixels in 64 bits of output; consisting of two 16-bit RGB 5=6=5 color values and a 4x4 two bit lookup table.
	 */
	var DXT1= 8;
	/**
	 * Block compressed format; storing 16 input pixels (corresponding to a 4x4 pixel block) into 128 bits of output; consisting of 64 bits of alpha channel data (4 bits for each pixel) followed by 64 bits of color data; encoded the same way as DXT1.
	 */
	var DXT3= 9;
	/**
	 * Block compressed format; storing 16 input pixels into 128 bits of output; consisting of 64 bits of alpha channel data (two 8 bit alpha values and a 4x4 3 bit lookup table) followed by 64 bits of color data (encoded the same way as DXT1).
	 */
	var DXT5= 10;
	/**
	 * 16-bit floating point RGB (16-bit float for each red; green and blue channels).
	 */
	var RGB16F= 11;
	/**
	 * 16-bit floating point RGBA (16-bit float for each red; green; blue and alpha channels).
	 */
	var RGBA16F= 12;
	/**
	 * 32-bit floating point RGB (32-bit float for each red; green and blue channels).
	 */
	var RGB32F= 13;
	/**
	 * 32-bit floating point RGBA (32-bit float for each red; green; blue and alpha channels).
	 */
	var RGBA32F= 14;

	/**
	 * 32-bit floating point single channel format (WebGL2 only).
	 */
	var R32F= 15;

	/**
	 * A readable depth buffer format
	 */
	var DEPTH= 16;

	/**
	 * A readable depth/stencil buffer format (WebGL2 only).
	 */
	var DEPTHSTENCIL= 17;

	/**
	 * A floating-point color-only format with 11 bits for red and green channels; and 10 bits for the blue channel (WebGL2 only).
	 */
	var _111110F= 18;

	/**
	 * Color-only sRGB format (WebGL2 only).
	 */
	var SRGB= 19;

	/**
	 * Color sRGB format with additional alpha channel (WebGL2 only).
	 */
	var SRGBA= 20;

	var ETC1= 21;
	var PVRTC_2BPP_RGB_1= 22;
	var PVRTC_2BPP_RGBA_1= 23;
	var PVRTC_4BPP_RGB_1= 24;
	var PVRTC_4BPP_RGBA_1= 25;
}