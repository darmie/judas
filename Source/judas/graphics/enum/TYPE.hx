package judas.graphics.enum;

/**
 * ...
 * @author Damilare Akinlaja
 */
@:enum
abstract TYPE(Int)
{
	/**
	 * Signed byte vertex element type.
	 */
	var INT8 = 0;

	/**
	 * Unsigned byte vertex element type.
	 */
	var UINT8 = 1;

	/**
	 * Signed short vertex element type.
	 */
	var INT16 = 2;

	/**
	 * Unsigned short vertex element type.
	 */
	var UINT16 = 3;

	/**
	 * Signed integer vertex element type.
	 */
	var INT32 =  4;

	/**
	 * Unsigned integer vertex element type.
	 */
	var UINT32 = 5;

	/**
	 * Floating point vertex element type.
	 */
	var FLOAT32 = 6;
}