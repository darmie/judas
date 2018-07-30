package judas;
import haxe.DynamicAccess;
import judas.Tags;
import judas.scene.GraphNode;

/**
 * ...
 * @author Damilare Akinlaja
 */
class TagsCache
{

	public var index:DynamicAccess<Tags>;
	public var key:String;

	public function new(key:String)
	{
		this.index = DynamicAccess<Dynamic>();
		this.key = key != null ? key : null;
	}

	public function addItem(item:Dynamic):Void
	{
		var tags:Array<Dynamic> = item.tags._list;
		for (i in 0...(tags.length))
			this.add(tags[i], item);
	}

	public function removeItem(item:Dynamic):Void
	{
		var tags:Array<Dynamic> = item.tags._list;

		for (i in 0...(tags.length))
			this.remove(tags[i], item);
	}

	public function add(tag:String, item:Dynamic):Void
	{
		// already in cache
		if (this.index.get(tag) != null && cast(this.index.get(tag).list, Array<Dynamic>).indexOf(item) != -1)
			return;

		// create index for tag
		if (this.index.get(tag) == null)
		{
			this.index.set(tag, new Tags());
			this.index.get(tag).list = [];
			// key indexing is available
			if (this.key != null)
				this.index[tag].keys = { };
		}

		// add to index list
		cast(this.index.get(tag).list, Array<Dynamic>).push(item);

		// add to index keys
		if (this.key)
			this.index.get(tag).keys[item[this.key]] = item;
	}

	public function remove(tag:Dynamic, item:Dynamic):Void
	{
		// no index created for that tag
		if (this.index.get(tag) == null)
			return;

		// check if item not in cache
		if (this.key != null)
		{
			// by key
			if (this.index.get(tag).keys[item[this.key]] == null)
				return;
		}

		// by position in list
		var ind = cast(this.index.get(tag).list, Array<Dynamic>).indexOf(item);
		if (ind == -1)
			return;

		// remove item from index list
		cast(this.index.get(tag).list, Array<Dynamic>).splice(ind, 1);

		// rmeove item from index keys
		if (this.key != null)
			this.index.get(tag).keys[item[this.key]] = null;

		// if index empty, remove it
		if (this.index.get(tag).list.length == 0)
			this.index.remove(tag);
	}

	public function find(arg:Array<Dynamic>):Void
	{
		var self:TagsCache = this;
		var index = { };
		var items:Array<Dynamic> = [ ];
		
		var item:Array<Dynamic> = []; 
		var tag:Dynamic;
		var tags:Array<Dynamic>
		var tagsRest;
		var missingIndex:Bool;

		var sort = function(a, b)
		{
			return self.index[a].list.length - self.index[b].list.length;
		};

		for (i in 0...(args.length))
		{
			tag = args[i];

			if (Std.is(tag, Array))
			{
				if (tag.length == 0)
					continue;

				if (tag.length == 1)
				{
					tag = tag[0];
				}
				else
				{
					// check if all indexes are in present
					missingIndex = false;
					for (t in 0...(tag.length))
					{
						if (this.index[tag[t]] == null)
						{
							missingIndex = true;
							break;
						}
					}
					if (missingIndex)
						continue;

					// sort tags by least number of matches first
					tags = tag.slice(0).sort(sort);

					// remainder of tags for `has` checks
					tagsRest = tags.slice(1);
					if (tagsRest.length == 1)
						tagsRest = tagsRest[0];

					for (n in 0...(this.index[tags[0]].list.length))
					{
						item = this.index[tags[0]].list[n];
						if ((this.key != null ? index[item[this.key]] == null : (items.indexOf(item) == -1)) && item.tags.has(tagsRest))
						{
							if (this.key != null)
								index[item[this.key]] = true;
							items.push(item);
						}
					}

					continue;
				}
			}

			if (tag != null && Std.is(tag, String) && this.index[tag])
			{
				for (n = 0; n < this._index[tag].list.length)
				{
					item = this.index[tag].list[n];

					if (this.key != null)
					{
						if (index[item[this.key]] == null)
						{
							index[item[this.key]] = true;
							items.push(item);
						}
					}
					else if (items.indexOf(item) == -1)
					{
						items.push(item);
					}
				}
			}
		}

		return items;
	}
	
	
	

}