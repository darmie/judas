package judas;

/**
 * ...
 * @author Damilare Akinlaja
 */
class Tags extends Events
{
	public var parent:Dynamic;
	public var index:Dynamic;
	public var _list:Array<Dynamic>;
	
	@:isVar public var size(get, null):Int;

	public function new(parent:Dynamic)
	{
		super();
		this.index = {};
		this._list = [];
		this.parent = parent;
	}

	/**
	 * Add a tag, duplicates are ignored. Can be array or comma separated arguments for multiple tags.
	 * @param	args array of tag names
	 * @return Bool
	 */
	public function add(args:Array<String>):Bool
	{
		var changed:Bool = false;
		var tags:Array<String> = args;

		if (tags.length == 0)
			return changed;

		for (i in 0...(tags.length))
		{
			if (this.index[tags[i]])
				continue;

			changed = true;

			this.index[tags[i]] = true;
			this._list.push(tags[i]);

			this.fire('add', [tags[i], this.parent]);
		}

		if (changed)
			this.fire('change', [this.parent]);

		return changed;
	}

	/**
	 * Remove tag.
	 * @param	args	array of tags
	 * @return Bool
	 */
	public function remove(args:Array<String>):Bool
	{
		var changed = false;

		if (this._list.length == 0)
			return changed;

		var tags = args;

		if (tags.length == 0)
			return changed;

		for (i in 0...(tags.length))
		{
			if (this.index[tags[i]] == null)
				continue;

			changed = true;

			Reflect.deleteField(this.index, tags[i]);

			this._list.splice(this._list.indexOf(tags[i]), 1);

			this.fire('remove', [tags[i], this.parent]);
		}

		if (changed)
			this.fire('change', [this.parent]);

		return changed;
	}

	/**
	 * Remove all tags.
	 */
	public function clear():Void
	{
		if (this._list.length == 0)
			return;

		var tags = this._list.slice(0);
		this._list = [ ];
		this.index = {};

		for (i in 0..(tags.length))
			this.fire('remove', [tags[i], this.parent]);

		this.fire('change', [this.parent]);
	}

	public function has(args:Array<Dynamic>):Bool
	{
		if (this._list.length == 0)
			return false;

		return this._has(args);
	}

	private function _has(tags:Array<Dynamic>):Bool
	{
		if (this._list.length == 0 || tags.length == 0)
			return false;

		for (i in 0...tags.length)
		{
			if (Std.is(tags[i], Array<String>))
			{
				// single occurance
				if (this.index[tags[i]] != null)
					return true;
			}
			else if (Std.is(tags[i], Array<Array<String>>))
			{
				// combined occurance
				var multiple = true;

				for (t in 0...(tags[i].length))
				{
					if (this.index[tags[i][t]] != null)
						continue;

					multiple = false;
					break;
				}

				if (multiple)
					return true;
			}
		}

		return false;
	}
	
	/**
	 * Returns immutable array of tags
	 * @return	Array<String>
	 */
	public function list():Array<String>
	{
		return this._list.slice(0);
	}
	
	/**
	 * Number of tags in set
	 * @return Int
	 */
	public function get_size():Int
	{
		return this._list.length;
	}

}