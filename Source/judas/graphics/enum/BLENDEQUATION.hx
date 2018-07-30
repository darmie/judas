package judas.graphics.enum;

/**
 * ...
 * @author Damilare Akinlaja
 */
@:enum
abstract BLENDEQUATION(Int)
{
	/**
	 * Add the results of the source and destination fragment multiplies.
	 */
	var ADD = 0;

	/**
	 * Subtract the results of the source and destination fragment multiplies.
	 */
	var SUBTRACT = 1;

	/**
	 * Reverse and subtract the results of the source and destination fragment multiplies.
	 */
	var REVERSE_SUBTRACT = 2;

	/**
	 * Use the smallest value.
	 */
	var MIN = 3;

	/**
	 * Use the largest value.
	 */
	var MAX = 4;
}