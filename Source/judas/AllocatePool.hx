package judas;
import de.polygonal.ds.NativeArray;
import de.polygonal.ds.tools.ObjectPool;
using de.polygonal.ds.tools.NativeArrayTools;
/**
 * ...
 * @author Damilare Akinlaja
 */
class AllocatePool extends ObjectPool<Dynamic>
{

	public function new(constructor:Void->Dynamic, size:Int) 
	{
		super(constructor, null, size);
	}
	
	
	public function _resize(size:Int):Void
	{
		this.maxSize = size;
		this.resize();
	}
	
	
	public function allocate():Dynamic{
		var inc:Int = this.maxSize+1;
		this.preallocate(inc);
		return this.mPool[this.size -1];
	}
	
	
	public function freeAll(){
		this.free();
	}
	
	
	
}