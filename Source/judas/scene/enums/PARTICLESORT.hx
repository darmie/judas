package judas.scene.enums;

/**
 * ...
 * @author Damilare Akinlaja
 */
@:enum
abstract PARTICLESORT(Int) 
{
	var	NONE	=	0;
	var	DISTANCE = 	1;
	var	NEWER_FIRST	= 2;
	var OLDER_FIRST	= 3;
}