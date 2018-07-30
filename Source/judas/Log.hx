package judas;
import Console;
/**
 * ...
 * @author Damilare Akinlaja
 */
class Log 
{
	private static var version:String = "1.0";
	private static var revision:String = "0";
	/**
	 * Write text to console
	 * @param	text
	 */
	public static function write(text:String) 
	{
		Console.log(text);
	}
	
	
	/**
	 * Starting logging to the console
	 * @param	text
	 */
	public static function open()
	{
		Log.write("Powered by Judas " + version + " " + revision);
	}
	
	
	public static function info(text:String){
		Console.log("<blue><b>INFO</b>: " + text + "</blue>");
	}
	
	public static function debug(text:String){
		Console.debug("<b>DEBUG</b>:" + text);
	}
	
	public static function error(text:String){
		Console.error("<b>ERROR</b>:" + text);
	}
	
	public static function warning(text:String){
		Console.warn("<b>WARNING</b>:" + text);
	}
	
	public static function alert(text:String){
		Console.log("<cyan><b>ALERT</b></cyan>:" + text);
	}
	
	public static function assert(condition:Bool, text:String){
		if (condition == false){
			Console.error("<b>ASSERT failed</b>:" + text);
		}
		
	}
	
}