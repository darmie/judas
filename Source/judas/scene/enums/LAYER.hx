package judas.scene.enums;

/**
 * ...
 * @author Damilare Akinlaja
 */
@:enum
abstract LAYER(Int) 
{
	var HUD	= 	0;
	var GIZMO = 1;
	var FX	=	2;
	//3 - 14 are custom user layers
	var WORLD =	15;
}