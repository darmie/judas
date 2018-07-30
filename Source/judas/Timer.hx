package judas;
/**
 * ...
 * @author Damilare Akinlaja
 */
class Timer 
{
	public var _isRunning:Bool;
	
	private var _a:Float = 0;
    private var _b:Float = 0;

	/**
	 * A Timer counts milliseconds from when start() is called until when stop() is called.
	 * Create a new Timer instance
	 */
	public function new() 
	{
        this._isRunning = false;
        this._a = 0;
        this._b = 0;		
	}
	
	/**
	 * Start the timer
	 */
	public function start():Void
	{
		this._isRunning = true;
		
		this._a = Date.now().getTime();
	}
	
	/**
	 * Stop the timer
	 */
	public function stop():Void
	{
		this._b = Date.now().getTime();
		this._isRunning = false;
	}
	
	/**
	 * Get the number of milliseconds that passed between start() and stop() being called
	 * @return	Float
	 */
	public function getMilliseconds():Float {
		return this._b - this._a;
	}	
	
	
}