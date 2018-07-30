package judas.scene.enums;

/**
 * ...
 * @author Damilare Akinlaja
 */
@:enum
abstract SHADOW(Int) 
{
	var PCF3	=	0;
	/** alias for .PCF3 for backwards compatibility */
	var DEPTH	=	0;
	var	VSM8	=	1;
	var	VSM16	=	2;
	var	VSM32	=	3;
	var PCF5	=	4;
	
}