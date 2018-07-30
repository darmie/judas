package judas.graphics.enum;

/**
 * ...
 * @author Damilare Akinlaja
 */
@:enum
abstract BUFFER(Int)
{
	/**
	 * The data store contents will be modified once and used many times.
	 */
	var STATIC = 0;

	/**
	 * The data store contents will be modified repeatedly and used many times.
	 */
	var DYNAMIC = 1;

	/**
	 * The data store contents will be modified once and used at most a few times.
	 */
	var STREAM = 2;

	/**
	 * The data store contents will be modified repeatedly on the GPU and used many times. Optimal for transform feedback usage
	 */
	var GPUDYNAMIC = 3;
}