package judas.graphics.enum;

/**
 * ...
 * @author Damilare Akinlaja
 */
@:enum
abstract PRIMITIVE(Int)
{
	/**
	 * List of distinct points.
	 */
	var POINTS= 0;
	/**
	 * Discrete list of line segments.
	 */
	var LINES= 1;
	/**
	 * List of points that are linked sequentially by line segments; with a closing line segment between the last and first points.
	 */
	var LINELOOP= 2;
	/**
	 * List of points that are linked sequentially by line segments.
	 */
	var LINESTRIP= 3;
	/**
	 * Discrete list of triangles.
	 */
	var TRIANGLES= 4;
	/**
	 * Connected strip of triangles where a specified vertex forms a triangle using the previous two.
	 */
	var TRISTRIP= 5;
	/**
	 * Connected fan of triangles where the first vertex forms triangles with the following pairs of vertices.
	 */
	var TRIFAN= 6;

}