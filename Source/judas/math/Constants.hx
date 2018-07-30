package judas.math;

import haxe.io.*;
import haxe.*;

class Constants{
    /**
     * Conversion factor between degrees and radians
     * @example
     * // Convert 180 degrees to pi radians
     * var rad = 180 * judas.math.Constants.DEG_TO_RAD;
     */
	public static var DEG_TO_RAD:Float = Math.PI / 180;

    /**
     * Conversion factor between degrees and radians
     * @example
     * // Convert pi radians to 180 degrees
     * var deg = Math.PI * judas.math.Constants.RAD_TO_DEG;
     */	

	public static var RAD_TO_DEG:Float = 180 / Math.PI;

    /**
    * Inverse log 2
    */
    public static var INV_LOG2:Float =  1 / Math.log(2);


    /**
     * Clamp a number between min and max inclusive.
     * @param value Number to clamp
     * @param min Min value
     * @param max Max value
     * @return The clamped value
     */	

	public static function clamp(value:Float, min:Float, max:Float):Float {
        if(value >= max) return max;
        if(value <= min) return min;
        return value;		
	}

    /**
     * Convert an 24 bit integer into an array of 3 bytes.
     * @param i Number holding an integer value
     * @return  An array of 3 bytes.
     * @example
     * // Set bytes to [0x11, 0x22, 0x33]
     * var bytes = judas.math.Constants.intToBytes24(0x112233);
     */
    public static function intToBytes24(i:Int):Bytes {
        var r, g, b;

        r = (i >> 16) & 0xff;
        g = (i >> 8) & 0xff;
        b = (i) & 0xff;

		var bytes:Bytes = Bytes.alloc(3);

		bytes.set(0, r);
		bytes.set(1, g);
		bytes.set(2, b); 

        return bytes;
	}


    /**
     *  intToBytes32
     *  Convert an 32 bit integer into an array of 4 bytes.
     * @return {Bytes} An array of 4 bytes
     * @param {Int32} i Number holding an integer value
     * @example
     * // Set bytes to [0x11, 0x22, 0x33, 0x44]
     * var bytes = judas.math.Constant.intToBytes32(0x11223344);
     */
    public static function intToBytes32(i:Int32):Bytes {
        var r, g, b, a;

        r = (i >> 24) & 0xff;
        g = (i >> 16) & 0xff;
        b = (i >> 8) & 0xff;
        a = (i) & 0xff;

		var bytes:Bytes = Bytes.alloc(4);

		bytes.set(0, r);
		bytes.set(1, g);
		bytes.set(2, b);
		bytes.set(3, a);

        return bytes;
    }

    /**
     *  bytesToInt24
     *  Convert 3 8 bit Numbers into a single unsigned 24 bit Number.
     * @example
     * // Set result1 to 0x112233 from an array of 3 values
	 * var bytes:Bytes = Bytes.alloc(3);
	 * bytes.set(0, 0x11);
	 * bytes.set(1, 0x22);
	 * bytes.set(2, 0x33);
     * var result1 = judas.math.Constants.bytesToInt24(bytes);
     * @param {Bytes} bytes
     * @return {Int} A single unsigned 24 bit Number.
     */
    public static function bytesToInt24(bytes:Bytes):Int {
		var r, g, b;

        b = bytes.get(2);
        g = bytes.get(1);
        r = bytes.get(0);
        return ((r << 16) | (g << 8) | b);
    }		


    /**
     *  bytesToInt32
     *  Convert 4 1-byte Numbers into a single unsigned 32bit Number.
     * @return {Int32} A single unsigned 32bit Number.
     * @example
      * // Set result1 to 0x11223344 from an bytes array of 4 values
	  * var bytes = Bytes.alloc(4);
	  * bytes.set(0, 0x11);
	  * bytes.set(1, 0x22);
	  * bytes.set(2, 0x33);
	  * bytes.set(3, 0x44);
      * var result2 = judas.math.Constants.bytesToInt32(, 0x22, 0x33, 0x44);
     * @param {Bytes} bytes
     */
    public static function bytesToInt32(bytes:Bytes):Int32 {
       
        var a = bytes.get(3);
        var b = bytes.get(2);
        var g = bytes.get(1);
        var r = bytes.get(0);
        
        // Why ((r << 24)>>>32)?
        // << operator uses signed 32 bit numbers, so 128<<24 is negative.
        // >>> used unsigned so >>>32 converts back to an unsigned.
        // See http://stackoverflow.com/questions/1908492/unsigned-integer-in-javascript
        return ((r << 24) | (g << 16) | (b << 8) | a)>>>32;
	}

    /**
     *  lerp
     * @return {Float} The linear interpolation of two numbers.
     *  Calculates the linear interpolation of two numbers.
     * @param {Float} a Number to linearly interpolate from.
     * @param {Float} b Number to linearly interpolate to.
     * @param {Float} alpha The value controlling the result of interpolation. When alpha is 0,
     * a is returned. When alpha is 1, b is returned. Between 0 and 1, a linear interpolation between
     * a and b is returned. alpha is clamped between 0 and 1.
     */
    public static function lerp(a:Float, b:Float, alpha:Float):Float {
        return a + (b - a) * judas.math.Constants.clamp(alpha, 0, 1);
    }


    /**
     *  lerpAngle
     *  Calculates the linear interpolation of two angles ensuring that interpolation
     * is correctly performed across the 360 to 0 degree boundary. Angles are supplied in degrees.
     * @return {Float} The linear interpolation of two angles
     * @param {Float} a Angle (in degrees) to linearly interpolate from.
     * @param {Float} b Angle (in degrees) to linearly interpolate to.
     * @param {Float} alpha The value controlling the result of interpolation. When alpha is 0,
     * a is returned. When alpha is 1, b is returned. Between 0 and 1, a linear interpolation between
     * a and b is returned. alpha is clamped between 0 and 1.
     */
    public static function lerpAngle(a:Float, b:Float, alpha:Float):Float {
        if (b - a > 180 ) {
            b -= 360;
        }
        if (b - a < -180 ) {
            b += 360;
        }
        return judas.math.Constants.lerp(a, b, judas.math.Constants.clamp(alpha, 0, 1));
    }

    /**
     *  powerOfTwo
     *  Returns true if argument is a power-of-two and false otherwise.
     * @param {Number} x Number to check for power-of-two property.
     * @return {Boolean} true if power-of-two and false otherwise.
     */
    public static function powerOfTwo(x:Int):Bool {
        return ((x !== 0) && !(x & (x - 1)));
	}

    /**
     *  nextPowerOfTwo
     *  Returns the next power of 2 for the specified value.
     * @param {Int} val The value for which to calculate the next power of 2.
     * @return {Int} The next power of 2.
     */
    public static function nextPowerOfTwo(val:Int):Int {
        val--;
        val = (val >> 1) | val;
        val = (val >> 2) | val;
        val = (val >> 4) | val;
        val = (val >> 8) | val;
        val = (val >> 16) | val;
        val++;
        return val;
    }

    /**
     *  Return a pseudo-random number between min and max.
     * The number generated is in the range [min, max), that is inclusive of the minimum but exclusive of the maximum.
     * @param {Float} min Lower bound for range.
     * @param {Float} max Upper bound for range.
     * @return {Float} Pseudo-random number between the supplied range.
     */
    public static function  random(min:Float, max:Float):Float {
        var diff = max - min;
        return Math.random() * diff + min;
    }

    /**
     *  smoothstep
     *  The function interpolates smoothly between two input values based on
     * a third one that should be between the first two. The returned value is clamped
     * between 0 and 1.
     * <br/>The slope (i.e. derivative) of the smoothstep function starts at 0 and ends at 0.
     * This makes it easy to create a sequence of transitions using smoothstep to interpolate
     * each segment rather than using a more sophisticated or expensive interpolation technique.
     * <br/>See http://en.wikipedia.org/wiki/Smoothstep for more details.
     * @param {Float} min The lower bound of the interpolation range.
     * @param {Float} max The upper bound of the interpolation range.
     * @param {Float} x The value to interpolate.
     * @return {Float} The smoothly interpolated value clamped between zero and one.
     */
    public static function  smoothstep(min:Float, max:Float, x:Float):Float {
        if (x <= min) return 0;
        if (x >= max) return 1;

        x = (x - min) / (max - min);

        return x * x * (3 - 2 * x);
    }

    /**
     * smootherstep
     *  An improved version of the judas.math.Constants.smoothstep function which has zero
     * 1st and 2nd order derivatives at t=0 and t=1.
     * <br/>See http://en.wikipedia.org/wiki/Smoothstep for more details.
     * @param {Float} min The lower bound of the interpolation range.
     * @param {Float} max The upper bound of the interpolation range.
     * @param {Float} x The value to interpolate.
     * @return {Float} The smoothly interpolated value clamped between zero and one.
     */
    public static function smootherstep(min:Float, max:Float, x:Float):Float {
        if (x <= min) return 0;
        if (x >= max) return 1;

        x = (x - min) / (max - min);

        return x * x * x * (x * (x * 6 - 15) + 10);
    }


	public static function log2(x:Float):Float{
		return Math.log(x) * judas.math.Constants.INV_LOG2;
	}							
        	 
}