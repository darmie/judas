package judas.math;

import haxe.io.*;
import haxe.ds.*;

    /**
    * @class A 3x3 matrix.
    * @description Creates a new Mat3 object
    * @param v0 - The value in row 0, column 0.
    * @param v1 - The value in row 1, column 0.
    * @param v2 - The value in row 2, column 0.
    * @param v3 - The value in row 0, column 1.
    * @param v4 - The value in row 1, column 1.
    * @param v5 - The value in row 2, column 1.
    * @param v6 - The value in row 0, column 2.
    * @param v7 - The value in row 1, column 2.
    * @param v8 - The value in row 2, column 2.
    */
class Mat3 {

	private var data:Vector<Float>;

	public function new(
		v0:Float = 1, 
		v1:Float = 0, 
		v2:Float = 0, 
		v3:Float = 0, 
		v4:Float = 1, 
		v5:Float = 0, 
		v6:Float = 0, 
		v7:Float = 0, 
		v8:Float = 1)
		{

			this.data = new Vector(9);

			
			this.data[0] = v0;
			this.data[1] = v1;
			this.data[2] = v2;
			this.data[3] = v3;
			this.data[4] = v4;
			this.data[5] = v5;
			this.data[6] = v6;
			this.data[7] = v7;
			this.data[8] = v8;
						
		}

	/**
	 *  Creates a duplicate of the specified matrix.
     *  @example
     *  var src = new judas.math.Mat3().translate(10, 20, 30);
     *  var dst = src.clone();	  
	 *  @return Mat3
	 */
	public function clone():Mat3 {
		return new Mat3().copy(this);
	}

	/**
	 *  Copies the contents of a source 3x3 matrix to a destination 3x3 matrix.
	 *  @param rhs - src A 3x3 matrix to be copied.
	 *  @example
     *  var src = new Mat3().translate(10, 20, 30);
     *  var dst = new Mat3();
     *  dst.copy(src);
	 *  @return Mat3
	 */
	public function copy(rhs:Mat3):Mat3 {
            var src:Vector<Float> = rhs.data;

            this.data = src.copy();

            return this;
	}

	/**
	 *  Reports whether two matrices are equal.
	 *  @param rhs - rhs The other matrix
     *  @example
     *  var a = new Mat3().translate(10, 20, 30);
     *  var b = new Mat3();	
	 *  trace(a.equals(b)); 
	 *  @return Bool
	 */
	public function equals(rhs:Mat3):Bool {
            var l = this.data;
            var r = rhs.data;

            return ((l[0] == r[0]) &&
                    (l[1] == r[1]) &&
                    (l[2] == r[2]) &&
                    (l[3] == r[3]) &&
                    (l[4] == r[4]) &&
                    (l[5] == r[5]) &&
                    (l[6] == r[6]) &&
                    (l[7] == r[7]) &&
                    (l[8] == r[8]));		
	}

	/**
	 *  Reports whether the specified matrix is the identity matrix.
	 *  @return Bool
	 */
	public function isIdentity():Bool {
            var m = this.data;
            return ((m[0] == 1) &&
                    (m[1] == 0) &&
                    (m[2] == 0) &&
                    (m[3] == 0) &&
                    (m[4] == 1) &&
                    (m[5] == 0) &&
                    (m[6] == 0) &&
                    (m[7] == 0) &&
                    (m[8] == 1));		
	}

	/**
	 *  Sets the matrix to the identity matrix.
	 *  @return Mat3
	 */
	public function setIdentity():Mat3 {
            var m = this.data;
            m[0] = 1;
            m[1] = 0;
            m[2] = 0;

            m[3] = 0;
            m[4] = 1;
            m[5] = 0;

            m[6] = 0;
            m[7] = 0;
            m[8] = 1;

            return this;
	}

	/**
	 *  Converts the matrix to string form.
	 *  @return String
	 */
	public function toString():String{
            var t = "[";
            for (i in 0...9) {
                t += this.data[i];
                t += (i != 9) ? ", " : "";
            }
            t += "]";
            return t;
	}
	/**
	 *  Generates the transpose of the specified 3x3 matrix.
	 *  @return Mat3
	 */
	public function transpose():Mat3{
            var m = this.data;

            var tmp;
            tmp = m[1]; m[1] = m[3]; m[3] = tmp;
            tmp = m[2]; m[2] = m[6]; m[6] = tmp;
            tmp = m[5]; m[5] = m[7]; m[7] = tmp;

            return this;
	}

	/**
	 *  A constant matrix set to the identity.
	 */
	@:readOnly public static var IDENTITY:Mat3 = new Mat3();

	/**
	 *  A constant matrix with all elements set to 0.
	 */
	@:readOnly public static var ZERO:Mat3 = new Mat3(0, 0, 0, 0, 0, 0, 0, 0, 0);

}