package judas.scene;
import haxe.DynamicAccess;
import judas.math.Mat3;
import judas.math.Mat4;
import judas.math.Quat;
import judas.math.Vec3;

using StringTools;

/**
 * ...
 * @author Damilare Akinlaja
 */
class GraphNode
{
	private var scaleCompensatePosTransform:Mat4;
	private var scaleCompensatePos:Vec3;
	private var scaleCompensateRot:Quat;
	private var scaleCompensateRot2:Quat;
	private var scaleCompensateScale:Vec3;
	private var scaleCompensateScaleForParent:Vec3;

	public var name:String;
	public var tags:Tags;

	private var _labels:DynamicAccess<Bool>;

	// Local-space properties of transform (only first 3 are settable by the user)
	public var localPosition:Vec3;
	public var localRotation:Quat;
	public var localScale:Vec3;
	public var localEulerAngles:Vec3; // Only calculated on request

	// World-space properties of transform
	public var position:Vec3;
	public var rotation:Quat;
	public var eulerAngles:Vec3;

	public var localTransform:Mat4;
	private var _dirtyLocal:Bool;
	private var _aabbVer:Int;

	public var worldTransform:Mat4;
	private var _dirtyWorld:Bool;

	public var normalMatrix:Mat3;
	private var _dirtyNormal:Bool;

	private var tmpMat4:Mat4 = new Mat4();
	private var tmpQuat:Quat = new Quat();

	/**
	 * The normalized local space X-axis vector of the graph node in world space.
	 */
	@:isVar public var right(get, null):Vec3;
	/**
	 * The normalized local space Y-axis vector of the graph node in world space.
	 */
	@:isVar public var up(get, null):Vec3;
	/**
	 * The normalized local space negative Z-axis vector of the graph node in world space.
	 */
	@:isVar public var forward(get, null):Vec3;

	/**
	 * A read-only property to get a parent graph node
	 */
	@:readOnly @:isVar public var parent(get, null):GraphNode;
	@:readOnly @:isVar public var children(get, null):Array<GraphNode>;

	/**
	 * Enable or disable a GraphNode. If one of the GraphNode's parents is disabled
	 * there will be no other side effects. If all the parents are enabled then
	 * the new value will activate / deactivate all the enabled children of the GraphNode.
	 */
	@:isVar public var enabled(get, set):Bool;
	private var _enabledInHierarchy:Bool;

	public var scaleCompensation:Bool;

	@:isVar public var root(get, null):GraphNode;

	public function new(?name:String)
	{
		this.name = name == null ? "Untitled" : name; // Non-unique human readable name
		this.tags = new Tags(this);

		this._labels = new DynamicAccess<Bool>();

		// Local-space properties of transform (only first 3 are settable by the user)
		this.localPosition = new Vec3(0, 0, 0);
		this.localRotation = new Quat(0, 0, 0, 1);
		this.localScale = new Vec3(1, 1, 1);
		this.localEulerAngles = new Vec3(0, 0, 0); // Only calculated on request

		// World-space properties of transform
		this.position = new Vec3(0, 0, 0);
		this.rotation = new Quat(0, 0, 0, 1);
		this.eulerAngles = new Vec3(0, 0, 0);

		this.localTransform = new Mat4();
		this._dirtyLocal = false;
		this._aabbVer = 0;

		this.worldTransform = new Mat4();
		this._dirtyWorld = false;

		this.normalMatrix = new Mat3();
		this._dirtyNormal = true;

		this.right = new Vec3();
		this.up = new Vec3();
		this.forward = new Vec3();

		this.parent = null;
		this.children = [ ];

		this.enabled = true;
		this._enabledInHierarchy = false;

		this.scaleCompensation = false;
	}

	public function get_right():Vec3
	{
		return this.getWorldTransform().getX(this.right).normalize();
	}

	public function get_up():Vec3
	{
		return this.getWorldTransform().getY(this.up).normalize();
	}

	public function get_forward():Vec3
	{
		return this.getWorldTransform().getZ(this.forward).normalize();
	}

	public function get_enabled():Bool
	{
		// make sure to check this._enabled too because if that
		// was false when a parent was updated the _enabledInHierarchy
		// flag may not have been updated for optimization purposes
		return this.enabled && this._enabledInHierarchy;
	}

	public function set_enabled(enabled:Bool):Bool
	{
		if (this.enabled != enabled)
		{
			this.enabled = enabled;

			if (this.parent == null || this.parent.enabled)
				this._notifyHierarchyStateChanged(this, enabled);
		}
	}

	public function get_root():GraphNode
	{
		var parent = this.parent;
		if (parent == null)
			return this;

		while (parent.parent != null)
			parent = parent.parent;

		return parent;
	}

	public function get_children():Array<GraphNode>
	{
		return this.children;
	}

	public function notifyHierarchyStateChanged(node:GraphNode, enabled:Bool):Void
	{
		node.onHierarchyStateChanged(enabled);

		var c:Array<GraphNode> = node.children;
		var len:Int =	c.length;
		for (i in 0...len)
		{
			if (c[i].enabled)
				this.notifyHierarchyStateChanged(c[i], enabled);
		}
	}

	/**
	 * Called when the enabled flag of the entity or one of its
	 * parents changes
	 * @param	enabled
	 */
	public function onHierarchyStateChanged(enabled:Bool):Void
	{
		// Override in derived classes
		this._enabledInHierarchy = enabled;
	}

	private function cloneInterval(clone:GraphNode):Void
	{
		clone.name = this.name;

		var tags = this.tags._list;
		for (i in 0...tags.length)
			clone.tags.add(tags[i]);

		clone._labels = this._labels.copy();

		clone.localPosition.copy(this.localPosition);
		clone.localRotation.copy(this.localRotation);
		clone.localScale.copy(this.localScale);
		clone.localEulerAngles.copy(this.localEulerAngles);

		clone.position.copy(this.position);
		clone.rotation.copy(this.rotation);
		clone.eulerAngles.copy(this.eulerAngles);

		clone.localTransform.copy(this.localTransform);
		clone._dirtyLocal = this._dirtyLocal;

		clone.worldTransform.copy(this.worldTransform);
		clone._dirtyWorld = this._dirtyWorld;
		clone._dirtyNormal = this._dirtyNormal;
		clone._aabbVer = this._aabbVer + 1;

		clone.enabled = this.enabled;

		clone.scaleCompensation = this.scaleCompensation;

		// false as this node is not in the hierarchy yet
		clone._enabledInHierarchy = false;
	}

	public function clone():GraphNode
	{
		var clone = new GraphNode();
		this.cloneInterval(clone);

		return clone;
	}

	/**
	 * Search the graph for nodes that satisfy conditions.
	 * @param	attr	This can either be a method or a string.
	 * If it's a method it is executed for each descendant node, to test if node satisfies search logic.
	 * Returning true from that method will include node into results.
	 * If it's a string then it represents the name of a field or a method of the node.
	 * If this is the name of a field then the value passed as the second argument will be checked for equality.
	 * If this is the name of a function then the return value of the function will be checked for equality against the valued passed as the second argument to this function.
	 * @return	Array<GraphNode>
	 */
	public function find(attr:Dynamic, ?value:Dynamic):Array<GraphNode>
	{
		var results:Array<GraphNode> = [];
		var len = this.children.length;
		var descendants:Array<GraphNode> = [];

		//If is function
		if (!Std.is(attr, String))
		{
			var fn:GraphNode->Dynamic = attr;

			for (i in 0...len)
			{
				if (fn(this.children[i]) != null)
					results.push(this.children[i]);

				descendants = this.children[i].find(fn);
				if (descendants.length)
					results = results.concat(descendants);
			}
		}
		else {
			var testValue:Dynamic = null;
			var clsFields:Array<String> = Type.getInstanceFields(Type.getClass(this));
			var val:Dynamic = clsFields[clsFields.indexOf(attr)];

			if (val != null)
			{
				if (Reflect.isFunction(val))
				{
					testValue = val();
				}
				else
				{
					testValue = val;
				}
				if (testValue == value)
					results.push(this);
			}

			for (i in 0...len)
			{
				descendants = this.children[i].find(attr, value);
				if (descendants.length)
					results = results.concat(descendants);
			}
		}

		return results;
	}

	/**
	 * Depth first search the graph for nodes using supplied method to find first matching node.
	 * @param	attr	Method which is executed for each descendant node, to test if node satisfies search logic. Returning true from that method will stop search and return that node.
	 * @param	value
	 * @return
	 */
	public function findOne(attr:Dynamic, ?value:Dynamic):GraphNode
	{

		var len:Int = this.children.length;
		var result:GraphNode = null;

		if (!Std.is(attr, String))
		{
			var fn:GraphNode->Dynamic = attr;

			result = fn(this);
			if (result != null)
				return this;

			for (i in 0...len)
			{
				result = this.children[i].findOne(fn);
				if (result)
					return this.children[i];
			}
		}
		else {
			var testValue:Dynamic = null;
			var clsFields:Array<String> = Type.getInstanceFields(Type.getClass(this));
			var val:Dynamic = clsFields[clsFields.indexOf(attr)];

			if (val != null)
			{
				if (Reflect.isFunction(val))
				{
					testValue = val();
				}
				else
				{
					testValue = val;
				}
				if (testValue == value)
					return this;
			}

			for (i in 0...len)
			{
				result = this.children[i].findOne(attr, value);
				if (result != null)
					return result;
			}
		}

		return null;
	}

	/**
	 * Return all graph nodes that satisfy the search query.
	 * Query can be simply a string, or comma separated strings,
	 * to have inclusive results of assets that match at least one query.
	 * A query that consists of an array of tags can be used to match graph nodes that have each tag of array
	 *
	 * @param	argumentsarray of tags
	 * @return	Array<GraphNode>
	 */
	public function findByTag(arguments:Dynamic):Array<GraphNode>
	{
		var tags = this.tags._processArguments(arguments);
		return this._findByTag(tags);
	}

	public function _findByTag(tags:Dynamic):Array<GraphNode>
	{
		var result:Array<GraphNode> = [ ];
		var len:Int = this.children.length;
		var descendants;

		for (i in 0...len)
		{
			if (this.children[i].tags._has(tags))
				result.push(this.children[i]);

			descendants = this.children[i]._findByTag(tags);
			if (descendants.length)
				result = result.concat(descendants);
		}

		return result;
	}

	/**
	 * Get the first node found in the graph with the name. The search
	 * is depth first.
	 * @param	name	The name of the graph.
	 * @return	GraphNode
	 */
	public function findByName(name:String):GraphNode
	{
		if (this.name == name) return this;

		for (i in 0...this.children.length)
		{
			var found:GraphNode = this.children[i].findByName(name);
			if (found != null) return found;
		}
		return null;
	}

	/**
	 * Get the first node found in the graph by its full path in the graph.
	 * The full path has this form 'parent/child/sub-child'. The search is depth first.
	 * @param	path	The full path of the GraphNode.
	 * @return	GraphNode
	 */
	public function findByPath(path:String):GraphNode
	{
		// split the paths in parts. Each part represents a deeper hierarchy level
		var parts:Array<String> = path.split('/');
		var currentParent:GraphNode = this;
		var result:GraphNode = null;
		var imax:Int = parts.length;
		var i:Int = 0;

		while (i < imax && currentParent != null)
		{
			var part:String = parts[i];
			result = null;
			// check all the children
			var children:Array<GraphNode> = currentParent.children;
			var jmax:Int = children.length;
			for (j in 0...jmax)
			{
				if (children[j].name == part)
				{
					result = children[j];
					break;
				}
			}

			// keep going deeper in the hierarchy
			currentParent = result;
		}

		return result;
	}

	/**
	 * Gets the path of the entity relative to the root of the hierarchy
	 * @return String The path
	 */
	public function getPath():String
	{
		var parent = this.parent;
		if (parent != null)
		{
			var path = this.name;

			while (parent != null && parent.parent != null)
			{
				path = parent+"/"+path;
				parent = parent.parent;
			}

			return path;
		}
		else {
			return '';
		}
	}

	/**
	 * Get the highest ancestor node from this graph node.
	 * @return GraphNode - The root node of the hierarchy to which this node belongs.
	 */
	public function getRoot():GraphNode
	{
		var parent = this.parent;
		if (parent == null)
		{
			return this;
		}

		while (parent.parent != null)
		{
			parent = parent.parent;
		}

		return parent;
	}

	/**
	 * Get the parent GraphNode
	 * @return	GraphNode -The parent node
	 */
	public function getParent():GraphNode
	{
		return this.parent;
	}

	/**
	 * Check if node is descendant of another node.
	 * @param	node
	 * @return	Bool
	 */
	public function isDescendantOf(node:GraphNode):Bool
	{
		var parent:GraphNode = this.parent;
		while (parent !=null)
		{
			if (parent == node)
				return true;

			parent = parent.parent;
		}
		return false;
	}

	/**
	 * Check if node is ancestor for another node.
	 * @param	node
	 * @return	Bool
	 */
	public function isAncestorOf(node:GraphNode):Bool
	{
		return node.isDescendantOf(this);
	}

	/**
	 * Get the children of this graph node.
	 * @return Array<GraphNode>
	 */
	public function getChildren():Array<GraphNode>
	{
		return this.children;
	}

	/**
	 * Get the world space rotation for the specified GraphNode in Euler angle
	 * form. The order of the returned Euler angles is XYZ. The value returned by this function
	 * should be considered read-only.
	 * @return	Vec3
	 */
	public function getEulerAngles():Vec3
	{
		this.getWorldTransform().getEulerAngles(this.eulerAngles);
		return this.eulerAngles;
	}

	/**
	 * Get the rotation in local space for the specified GraphNode. The rotation
	 * is returned as euler angles in a 3-dimensional vector where the order is XYZ. The
	 * returned vector should be considered read-only
	 * @return	Vec3
	 */
	public function getLocalEulerAngles():Vec3
	{
		this.localRotation.getEulerAngles(this.localEulerAngles);
		return this.localEulerAngles;
	}

	/**
	 * Get the position in local space for the specified GraphNode. The position
	 * is returned as a 3-dimensional vector
	 * @return	Vec3
	 */
	public function getLocalPosition():Vec3
	{
		return this.localPosition;
	}

	/**
	 * Get the rotation in local space for the specified GraphNode. The rotation
	 * is returned as a quaternion. The returned quaternion should be considered read-only.
	 * @return	Quat
	 */
	public function getLocalRotation():Quat
	{
		return this.localRotation;
	}

	/**
	 * Get the scale in local space for the specified GraphNode. The scale
	 * is returned as a 3-dimensional vector. The returned vector should be considered read-only.
	 * @return
	 */
	public function getLocalScale():Vec3
	{
		return this.localScale;
	}

	/**
	 * Get the local transform matrix for this graph node. This matrix
	 * is the transform relative to the node's parent's world transformation matrix.
	 * @return Mat4
	 */

	public function getLocalTransform():Mat4
	{
		if (this._dirtyLocal)
		{
			this.localTransform.setTRS(this.localPosition, this.localRotation, this.localScale);
			this._dirtyLocal = false;
		}
		return this.localTransform;
	}

	/**
	 * Get the human-readable name for this graph node. Note the name
	 * is not guaranteed to be unique. For Entities, this is the name that is set in the Editor.
	 * @return
	 */
	public function getName():String
	{
		return this.name;
	}

	/**
	 * Get the world space position for the specified GraphNode. The
	 * value returned by this function should be considered read-only
	 * @return
	 */
	public function getPosition():Vec3
	{
		this.getWorldTransform().getTranslation(this.position);
		return this.position;
	}

	/**
	 * Get the world space rotation for the specified GraphNode in quaternion
	 * form. The value returned by this function should be considered read-only
	 * @return	Quat
	 */
	public function getRotation():Quat
	{
		this.rotation.setFromMat4(this.getWorldTransform());
		return this.rotation;
	}

	/**
	 * Get the world transformation matrix for this graph node.
	 * @return	Mat4
	 */
	public function getWorldTransform():Mat4
	{
		if (! this._dirtyLocal && ! this._dirtyWorld)
			return this.worldTransform;

		if (this.parent)
			this.parent.getWorldTransform();

		this._sync();

		return this.worldTransform;
	}

	/**
	 * Remove graph node from current parent and add as child to new parent
	 */
	public function reparent():Void
	{
		var current = this.parent;
		if (current != null)
			current.removeChild(this);

		if (parent != null)
		{
			if (index >= 0)
			{
				parent.insertChild(this, index);
			}
			else
			{
				parent.addChild(this);
			}
		}
	}

	/**
	 * Sets the local space rotation of the specified graph node using euler angles.
	 * Eulers are interpreted in XYZ order. Eulers must be specified in degrees.
	 * @param	x - {Vec3 | Float}
	 * @param	y - {Float}
	 * @param	z - {Float}
	 */
	public function setLocalEulerAngles(x:Dynamic, ?y:Float, ?z:Float):Void
	{
		if (Std.is(x, Vec3))
		{
			var holdx:Vec3 = cast(x, Vec3);
			this.localRotation.setFromEulerAngles(holdx.data[0], holdx.data[1], holdx.data[2]);
		}
		else {
			this.localRotation.setFromEulerAngles(cast(x, Float), y, z);
		}

		if (! this._dirtyLocal)
			this._dirtify(true);
	}

	/**
	 * Sets the local space position of the specified graph node.
	 * @param	x - {Vec3 | Float}
	 * @param	y
	 * @param	z
	 */
	public function setLocalPosition(x:Dynamic, ?y:Float, ?z:Float):Void
	{
		if (Std.is(x, Vec3))
		{
			this.localPosition.copy(x);
		}
		else
		{
			this.localPosition.set(x, y, z);
		}

		if (! this._dirtyLocal)
			this._dirtify(true);
	}

	/**
	 * Sets the local space rotation of the specified graph node.
	 * @param	x - {Quat | Float}
	 * @param	y - Float
	 * @param	z - Float
	 * @param	w - Float
	 */
	public function setLocalRotation(x:Dynamic, ?y:Float, ?z:Float, ?w:Float):Void
	{
		if (Std.is(x,Quat))
		{
			this.localRotation.copy(x);
		}
		else {
			this.localRotation.set(x, y, z, w);
		}

		if (! this._dirtyLocal)
			this._dirtify(true);
	}

	/**
	 * Sets the local space scale factor of the specified graph node.
	 * @param	x - {Vec3 | Float}
	 * @param	y
	 * @param	z
	 */
	public function setLocalScale(x:Dynamic, ?y:Float, ?z:Float):Void
	{
		if (Std.is(x, Vec3))
		{
			this.localScale.copy(x);
		}
		else {
			this.localScale.set(x, y, z);
		}

		if (! this._dirtyLocal)
			this._dirtify(true);
	}

	/**
	 * Sets the non-unique name for this graph node.
	 * @param	name
	 */
	public function setName(name:String):Void
	{
		this.name = name;
	}

	public function _dirtify(local:Bool):Void
	{
		if ((! local || (local && this._dirtyLocal)) && this._dirtyWorld)
			return;

		if (local)
			this._dirtyLocal = true;

		if (! this._dirtyWorld)
		{
			this._dirtyWorld = true;

			var i = this.children.length;
			while (i--)
			{
				if (this.children[i]._dirtyWorld)
					continue;

				this.children[i]._dirtify();
			}
		}

		this._dirtyNormal = true;
		this._aabbVer++;
	}

	/**
	 * Sets the world space position of the specified graph node.
	 * @param	x {Float | Vec3}
	 * @param	y {Float}
	 * @param	z {Float}
	 */
	public function setPosition(x:Dynamic, ?y:Float, ?z:FLoat):Void
	{
		var position = new Vec3();
		var invParentWtm:Mat4 = new Mat4();

		if (Std.is(x, Vec3))
		{
			position.copy(x);
		}
		else {
			position.set(x, y, z);
		}

		if (this.parent == null)
		{
			this.localPosition.copy(position);
		}
		else {
			invParentWtm.copy(this.parent.getWorldTransform()).invert();
			invParentWtm.transformPoint(position, this.localPosition);
		}

		if (! this._dirtyLocal)
			this._dirtify(true);
	}

	/**
	 * Sets the world space rotation of the specified graph node using quarternion
	 * @param	x {Float | Quat}
	 * @param	y Float
	 * @param	z Float
	 * @param	w Float
	 */
	public function setRotation(x:Dynamic, ?y:Float, ?z:Float, ?w:Float):Void
	{
		var rotation = new Quat();
		var invParentRot = new Quat();

		if (Std.is(x, Quat))
		{
			rotation.copy(x);
		}
		else {
			rotation.set(x, y, z, w);
		}

		if (this.parent == null)
		{
			this.localRotation.copy(rotation);
		}
		else {
			var parentRot = this.parent.getRotation();
			invParentRot.copy(parentRot).invert();
			this.localRotation.copy(invParentRot).mul(rotation);
		}

		if (! this._dirtyLocal)
			this._dirtify(true);
	}

	/**
	 * Sets the world space orientation of the specified graph node
	 * using Euler angles. Angles are specified in degrees in XYZ order.
	 * @param	x {Float | Vec3}
	 * @param	y Float
	 * @param	z Float
	 */
	public function setEulerAngles(x:Dynamic, ?y:Float, ?z:Float):Void
	{
		var invParentRot = new Quat();

		if (Std.is(x, Vec3))
		{
			this.localRotation.setFromEulerAngles(x.data[0], x.data[1], x.data[2]);
		}
		else {
			this.localRotation.setFromEulerAngles(x, y, z);
		}

		if (this.parent != null)
		{
			var parentRot = this.parent.getRotation();
			invParentRot.copy(parentRot).invert();
			this.localRotation.mul2(invParentRot, this.localRotation);
		}

		if (! this._dirtyLocal)
			this._dirtify(true);
	}

	/**
	 * Add a new child to the child list and update the parent value of the child node
	 * @param	node	The new child to add
	 */
	public function addChild(node:GraphNode):Void
	{
		if (node.parent != null)
			throw "GraphNode is already parented";

		this.children.push(node);
		this._onInsertChild(node);
	}

	/**
	 * Add child node and cache the transform
	 * @param	node
	 */
	public function addChildAndSaveTransform(node:GraphNode)
	{
		var wPos = node.getPosition();
		var wRot = node.getRotation();

		var current = node.parent;
		if (current)
			current.removeChild(node);

		if (this.tmpMat4 == null)
		{
			this.tmpMat4 = new Mat4();
			this.tmpQuat = new Quat();
		}

		node.setPosition(this.tmpMat4.copy(this.worldTransform).invert().transformPoint(wPos));
		node.setRotation(this.tmpQuat.copy(this.getRotation()).invert().mul(wRot));

		this.children.push(node);

		this._onInsertChild(node);
	}

	/**
	 * Insert a new child to the child list at the specified index and update the parent value of the child node
	 * @param	node	The new child to insert
	 * @param	index	The index in the child list of the parent where the new node will be inserted
	 */
	public function insertChild(node:GraphNode, index:Int):Void
	{
		if (node.parent != null)
			throw "GraphNode is already parented";

		this.children.splice(index, 0).insert(index, node);
		this._onInsertChild(node);
	}

	public function _onInsertChild(node:GraphNode):Void
	{
		node.parent = this;

		// the child node should be enabled in the hierarchy only if itself is enabled and if
		// this parent is enabled
		var enabledInHierarchy = (node.enabled && this.enabled);
		if (node.enabledInHierarchy != enabledInHierarchy)
		{
			node.enabledInHierarchy = enabledInHierarchy;

			// propagate the change to the children - necessary if we reparent a node
			// under a parent with a different enabled state (if we reparent a node that is
			// not active in the hierarchy under a parent who is active in the hierarchy then
			// we want our node to be activated)
			node.notifyHierarchyStateChanged(node, enabledInHierarchy);
		}

		// The child (plus subhierarchy) will need world transforms to be recalculated
		node._dirtify();

		// alert an entity that it has been inserted
		if (node.fire) node.fire('insert', this);
	}

	/**
	 * Remove the node from the child list and update the parent value of the child.
	 * @param	node	The node to remove
	 */
	public function removeChild(node:GraphNode):Void
	{
		var length = this.children.length;

		// Remove from child list
		for (i in 0...length)
		{
			if (this.children[i] == child)
			{
				this.children.splice(i, 1);

				// Clear parent
				node.parent = null;

				return;
			}
		}
	}

	/**
	 * Add a string label to this graph node, labels can be used to group
	 * and filter nodes. For example, the 'enemies' label could be applied to a group of NPCs
	 * who are enemies.
	 * @param	label	The label to apply to this graph node.
	 */
	public function addLabel(label:String):Void
	{
		this._labels.set(label, true);
	}

	/**
	 * Get an array of all labels applied to this graph node.
	 * @return	Array<String>
	 */
	public function getLabels():Array<String>
	{
		return this._labels.keys();
	}

	/**
	 * Test if a label has been applied to this graph node.
	 * @param	label	The label to test for.
	 * @return	Bool
	 */
	public function hasLabel(label:String):Bool
	{
		return this._labels.exists(label);
	}

	/**
	 * Remove label from this graph node.
	 * @param	label	The label to remove from this node.
	 */
	public function removeLabel(label:String):Void
	{
		this._labels.remove(label);
	}

	/**
	 * Find all graph nodes from the root and all descendants with the label.
	 * @param	label	The label to search for.
	 * @param	results	An array to store the results in.
	 * @return	Array<GraphNode>
	 */
	public function findByLabel(label:String, results:Array<GraphNode>):Array<GraphNode>
	{
		var length = this.children.length;

		if (this.hasLabel(label))
		{
			results.push(this);
		}

		for (i in 0...length)
		{
			results = this.children[i].findByLabel(label, results);
		}

		return results;
	}

	public function _sync():Void
	{
		if (this._dirtyLocal)
		{
			this.localTransform.setTRS(this.localPosition, this.localRotation, this.localScale);

			this._dirtyLocal = false;
		}

		if (this._dirtyWorld)
		{
			if (this.parent == null)
			{
				this.worldTransform.copy(this.localTransform);
			}
			else
			{
				if (this.scaleCompensation)
				{
					var parentWorldScale;
					var parent = this.parent;

					// Find a parent of the first uncompensated node up in the hierarchy and use its scale * localScale
					var scale = this.localScale;
					var parentToUseScaleFrom = parent; // current parent
					if (parentToUseScaleFrom != null)
					{
						while (parentToUseScaleFrom && parentToUseScaleFrom.scaleCompensation)
						{
							parentToUseScaleFrom = parentToUseScaleFrom.parent;
						}
						// topmost node with scale compensation
						if (parentToUseScaleFrom != null)
						{
							parentToUseScaleFrom = parentToUseScaleFrom.parent; // node without scale compensation
							if (parentToUseScaleFrom != null)
							{
								parentWorldScale = parentToUseScaleFrom.worldTransform.getScale();
								scaleCompensateScale.mul2(parentWorldScale, this.localScale);
								scale = scaleCompensateScale;
							}
						}
					}

					// Rotation is as usual
					scaleCompensateRot2.setFromMat4(parent.worldTransform);
					scaleCompensateRot.mul2(scaleCompensateRot2, this.localRotation);

					// Find matrix to transform position
					var tmatrix = parent.worldTransform;
					if (parent.scaleCompensation)
					{
						scaleCompensateScaleForParent.mul2(parentWorldScale, parent.getLocalScale());
						scaleCompensatePosTransform.setTRS(parent.worldTransform.getTranslation(scaleCompensatePos),
														   scaleCompensateRot2,
														   scaleCompensateScaleForParent);
						tmatrix = scaleCompensatePosTransform;
					}
					tmatrix.transformPoint(this.localPosition, scaleCompensatePos);

					this.worldTransform.setTRS(scaleCompensatePos, scaleCompensateRot, scale);

				}
				else
				{
					this.worldTransform.mul2(this._parent.worldTransform, this.localTransform);
				}
			}

			this._dirtyWorld = false;
		}
	}

	/**
	 * Updates the world transformation matrices at this node and all of its descendants.
	 */
	public function syncHierarchy():Void
	{
		if (! this.enabled)
			return;

		if (this._dirtyLocal || this._dirtyWorld)
			this._sync();

		for (i in 0...(this.children.length))
			this.children[i].syncHierarchy();
	}

	/**
	 * Reorients the graph node so that the negative z axis points towards the target.
	 * @param	tx	- {x:Float or target:Vec3} X-component of the world space coordinate to 'look at' OR The world space coordinate to 'look at'.
	 * @param	ty	- {y:Float or up:Vec3}	Y-component of the world space coordinate to 'look at'. OR The up vector for the look at transform. If left unspecified, this is set to the world space y axis.
	 * @param	tz	- Z-component of the world space coordinate to 'look at'.
	 * @param	ux	- X-component of the up vector for the look at transform. If left unspecified, this is set to the world space y axis.
	 * @param	uy	- Y-component of the up vector for the look at transform. If left unspecified, this is set to the world space y axis.
	 * @param	uz	- Z-component of the up vector for the look at transform. If left unspecified, this is set to the world space y axis.
	 */
	public function lookAt(tx:Dynamic, ?ty:Dynamic, ?tz:Float, ?ux:Float, ?uy:Float, ?uz:Float):Void
	{
		var matrix = new Mat4();
		var target = new Vec3();
		var up = new Vec3();
		var rotation = new Quat();

		if (Std.is(tx,Vec3))
		{
			target.copy(tx);

			if (Std.is(ty, Vec3))   // vec3, vec3
			{
				up.copy(ty);
			}
			else     // vec3
			{
				up.copy(Vec3.UP);
			}
		}
		else if (tz == null)
		{
			return;
		}
		else {
			target.set(tx, ty, tz);

			if (ux != null)   // float, float, float, float, float, float
			{
				up.set(ux, uy, uz);
			}
			else {   // float, float, float
				up.copy(Vec3.UP);
			}
		}

		matrix.setLookAt(this.getPosition(), target, up);
		rotation.setFromMat4(matrix);
		this.setRotation(rotation);
	}

	/**
	 * Translates the graph node in world space by the specified translation vector.
	 * @param	x or translation - {x:Float, translation:Vec3}
	 * @param	y	Float
	 * @param	z	Float
	 */
	public function translate(x:Dynamic, ?y:Float, ?z:Float):Void
	{
		var translation = new Vec3();
		if (Std.is(x,Vec3))
		{
			translation.copy(cast(x, Vec3));
		}
		else {
			translation.set(x, y, z);
		}

		translation.add(this.getPosition());
		this.setPosition(translation);
	}

	/**
	 * Translates the graph node in local space by the specified translation vector.
	 * @param	x or translation - {x:Float, translation:Vec3}
	 * @param	y	Float
	 * @param	z	Float
	 */
	public function translateLocal(x:Dynamic, ?y:Float, ?z:Float):Void
	{
		var translation = new Vec3();
		if (Std.is(x, Vec3))
		{
			translation.copy(x);
		}
		else {
			translation.set(x, y, z);
		}

		this.localRotation.transformVector(translation, translation);
		this.localPosition.add(translation);

		if (! this._dirtyLocal)
			this._dirtify(true);

	}

	/**
	 * Rotates the graph node in world space by the specified Euler angles.
	 * Eulers are specified in degrees in XYZ order.
	 * @param	x or rotation - {x:Float, rotation:Vec3}
	 * @param	y	Float
	 * @param	z	Float
	 */
	public function rotate(x:Dynamic, ?y:Float, ?z:Float):Void
	{
		var quaternion = new Quat();
		var invParentRot = new Quat();

		if (Std.is(x, Vec3))
		{

			quaternion.setFromEulerAngles(cast(x, Vec3).data[0], cast(x, Vec3).data[1], cast(x, Vec3).data[2]);
		}
		else {
			quaternion.setFromEulerAngles(x, y, z);
		}

		if (this.parent == null)
		{
			this.localRotation.mul2(quaternion, this.localRotation);
		}
		else {
			var rot = this.getRotation();
			var parentRot = this.parent.getRotation();

			invParentRot.copy(parentRot).invert();
			quaternion.mul2(invParentRot, quaternion);
			this.localRotation.mul2(quaternion, rot);
		}

		if (! this._dirtyLocal)
			this._dirtify(true);
	}

	/**
	 * Rotates the graph node in local space by the specified Euler angles.
	 * Eulers are specified in degrees in XYZ order.
	 * @param	x or rotation - {x:Float, rotation:Vec3}
	 * @param	y	Float
	 * @param	z	Float
	 */
	public function rotateLocal(x:Dynamic, ?y:Float, ?z:Float):Void
	{
		var quaternion = new Quat();
		if (Std.is(x, Vec3))
		{
			quaternion.setFromEulerAngles(cast(x, Vec3).data[0], cast(x, Vec3).data[1], cast(x, Vec3).data[2]);
		}
		else {
			quaternion.setFromEulerAngles(x, y, z);
		}

		this.localRotation.mul(quaternion);

		if (! this._dirtyLocal)
			this._dirtify(true);
	}

}