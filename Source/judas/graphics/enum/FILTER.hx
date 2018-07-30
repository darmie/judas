package judas.graphics.enum;

/**
 * ...
 * @author Damilare Akinlaja
 */
@:enum
abstract FILTER(Int) 
{
	/**
	 * Point sample filtering
	 */
	var NEAREST = 0;

	/**
	 * Bilinear filtering.
	 */
	var LINEAR = 1;

	/**
	 * Use the nearest neighbor in the nearest mipmap level.
	 */
	var NEAREST_MIPMAP_NEAREST = 2;

	/**
	 * Linearly interpolate in the nearest mipmap level
	 */
	var NEAREST_MIPMAP_LINEAR = 3;

	/**
	 * Use the nearest neighbor after linearly interpolating between mipmap levels.
	 */
	var LINEAR_MIPMAP_NEAREST = 4;

	/**
	 * Linearly interpolate both the mipmap levels and between texels.
	 */
	var LINEAR_MIPMAP_LINEAR = 5;
}