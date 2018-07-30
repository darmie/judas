package judas.scene.enums;

/**
 * ...
 * @author Damilare Akinlaja
 */
@:enum
abstract SHADERDEF(Int) 
{
	var	NOSHADOW	=	0;
	var	SKIN		=	1;
	var UV0			=	2;
	var UV1			=	3;
	var VCOLOR		=	4;
	var INSTANCING	=	5;
	var LM			=	6;
	var	DIRLM		=	7;
	var	SCREENSPACE	=	8;
}