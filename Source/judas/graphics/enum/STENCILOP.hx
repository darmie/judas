package judas.graphics.enum;

/**
 * ...
 * @author Damilare Akinlaja
 */
@:enum
abstract STENCILOP(Int)
{
	var KEEP= 0;
	var ZERO= 1;
	var REPLACE= 2;
	var INCREMENT= 3;
	var INCREMENTWRAP= 4;
	var DECREMENT= 5;
	var DECREMENTWRAP= 6;
	var INVERT= 7;
}