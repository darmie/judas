package judas.graphics.enum;

/**
 * ...
 * @author Damilare Akinlaja
 */
@:enum
abstract TEXTURELOCK(Int)
{
	/**
	 * Read only. Any changes to the locked mip level's pixels will not update the texture.
	 */
	var READ= 1;
	/**
	 * Write only. The contents of the specified mip level will be entirely replaced.
	 */
	var WRITE= 2;
}