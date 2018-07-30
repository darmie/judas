package judas.scene.enums;

/**
 * ...
 * @author Damilare Akinlaja
 */
@:enum
abstract SHADER(Int) 
{
	var FORWARD	=	0;
	var	FORWARDHDR =	1;
	var DEPTH	=	2;
	var	SHADOW	=	3;
	var	VSM8	=	4;
	var VSM16	=	5;
	var VSM32	=	6;
	var	PCF5	=	7;
	var	PCF3_POINT =	8;
	var	VSM8_POINT =	9;
	var VSM16_POINT =	10;
	var VSM32_POINT	=	11;
	var PCF5_POINT	=	12;
	var PCF3_SPOT	=	13;
	var VSM8_SPOT	=	14;
	var VSM16_SPOT	=	15;
	var VSM32_SPOT	=	16;
	var PCF5_SPOT	=	17;
	var PICK		=	18;
}