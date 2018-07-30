package judas.graphics.enum;

/**
 * ...
 * @author Damilare Akinlaja
 */
@:enum
abstract UNIFORMTYPE(Int)
{
	var BOOL= 0;
	var INT= 1;
	var FLOAT= 2;
	var VEC2= 3;
	var VEC3= 4;
	var VEC4= 5;
	var IVEC2= 6;
	var IVEC3= 7;
	var IVEC4= 8;
	var BVEC2= 9;
	var BVEC3= 10;
	var BVEC4= 11;
	var MAT2= 12;
	var MAT3= 13;
	var MAT4= 14;
	var TEXTURE2D= 15;
	var TEXTURECUBE= 16;
	var FLOATARRAY= 17;
	var TEXTURE2D_SHADOW= 18;
	var TEXTURECUBE_SHADOW= 19;
	var TEXTURE3D= 20
}