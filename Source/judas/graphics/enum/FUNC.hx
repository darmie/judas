package judas.graphics.enum;

/**
 * ...
 * @author Damilare Akinlaja
 */
@:enum
abstract FUNC(Int)
{
	var NEVER= 0;
	var LESS= 1;
	var EQUAL= 2;
	var LESSEQUAL= 3;
	var GREATER= 4;
	var NOTEQUAL= 5;
	var GREATEREQUAL= 6;
	var ALWAYS = 7;
}