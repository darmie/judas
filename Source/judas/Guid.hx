package judas;
import com.hurlant.crypto.extra.UUID;
/**
 * ...
 * @author Damilare Akinlaja
 */
class Guid 
{

	public static function create():String
	{
	   return UUID.generateRandom().toString();
	}
	
}