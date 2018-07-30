package judas.scene.enums;

/**
 * ...
 * @author Damilare Akinlaja
 */
@:enum
abstract TONEMAP(Int) 
{
	var	LINEAR	=	0;
	var	FILMIC	=	1;
	var	HEJL	=	2;
	var	ACES	=	3;
	var	ACES2	=	4;
}