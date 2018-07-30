package judas.scene;
import haxe.ds.Vector;
import judas.Color;
import judas.math.Vec3;
import judas.scene.enums.*;

/**
 * ...
 * @author Damilare Akinlaja
 */
class Scene 
{
	public var root:Dynamic;
	public var _gravity:Vec3;
	public var drawCalls:Array<Dynamic>;
	public var shadowCasters:Array<Dynamic>;
	public var immediateDrawCalls:Array<Dynamic>;
	
	@:isVar
	public var fog(get, set):FOG;
	
	public var fogColor:Color;
	public var fogStart:Int;
	public var fogEnd:Int;
	public var fogDensity:Float;
	
	public var ambientLight:Color;
	
	@:isVar
	public var gammaCorrection(get, set):GAMMA;
	
	@:isVar
	public var toneMapping(get, set):TONEMAP;
	
	public var exposure:Float;
	
	@:isVar
	public var skyboxPrefiltered128(get, set):Vector<Array>;
	
	@:isVar
	public var skyboxPrefiltered64(get, set):Vector<Array>;	
	
	@:isVar
	public var skyboxPrefiltered32(get, set):Vector<Array>;	
	
	@:isVar
	public var skyboxPrefiltered16(get, set):Vector<Array>;	
	
	@:isVar
	public var skyboxPrefiltered8(get, set):Vector<Array>;	
	
	@:isVar
	public var skyboxPrefiltered4(get, set):Vector<Array>;		
	
	public var _skyboxPrefiltered:Vector<Dynamic>;
	
	public var _skyboxCubeMap:Dynamic;
	
	public var _skyboxModel:Dynamic;
	
	@:isVar
	public var skyboxIntensity(get, set):Int;
	
	@:isVar
	public var skyboxMip(get, set):Int;
	
	@:isVar
	public var skybox(get, set):Texture;
	
	public var lightmapSizeMultiplier:Int;
	public var lightmapMaxResolution:Int;
	public var lightmapMode:BAKE;
	
	public var _stats:Dynamic;
	public var _models:Array<Dynamic>;
	public var _lights:Array<Dynamic>;
	public var _globalLights:Array<Dynamic>;
	public var _localLights:Array<Array<Dynamic>>;
	
	@:isVar
	public var updateShaders(get, set):Bool;
	public var _sceneShadersVersion:Int;
	public var _needsStaticPrepare:Bool;
	
	/**
	 * A scene is graphical representation of an environment. It manages the scene hierarchy, all
     * graphical objects, lights, and scene-wide properties.
	 */
	public function new() 
	{
        this.root = null;

        this._gravity = new Vec3(0, -9.8, 0);

        this.drawCalls = [];     // All mesh instances and commands
        this.shadowCasters = []; // All mesh instances that cast shadows
        this.immediateDrawCalls = []; // Only for this frame

        this.fog = FOG.NONE;
        this.fogColor = new Color(0, 0, 0);
        this.fogStart = 1;
        this.fogEnd = 1000;
        this.fogDensity = 0;

        this.ambientLight = new Color(0, 0, 0);

        this.gammaCorrection = GAMMA.NONE;
        this.toneMapping = 0;
        this.exposure = 1.0;

        this._skyboxPrefiltered = new Vector(6);

        this._skyboxCubeMap = null;
        this._skyboxModel = null;

        this.skyboxIntensity = 1;
        this.skyboxMip = 0;

        this.lightmapSizeMultiplier = 1;
        this.lightmapMaxResolution = 2048;
        this.lightmapMode = BAKE.COLORDIR;

        this._stats = {
            meshInstances: 0,
            lights: 0,
            dynamicLights: 0,
            bakedLights: 0,
            lastStaticPrepareFullTime: 0,
            lastStaticPrepareSearchTime: 0,
            lastStaticPrepareWriteTime: 0,
            lastStaticPrepareTriAabbTime: 0,
            lastStaticPrepareCombineTime: 0,
            updateShadersTime: 0
        };

        // Models
        this._models = [];

        // Lights
        this._lights = [];
        this._globalLights = []; // All currently enabled directionals
        this._localLights = [[], []]; // All currently enabled points and spots

        this.updateShaders = true;
        this._sceneShadersVersion = 0;

        this._needsStaticPrepare = true;		
	}
	
	public function applySettings(settings:Dynamic){
        // settings
        this._gravity.set(settings.physics.gravity[0], settings.physics.gravity[1], settings.physics.gravity[2]);
        this.ambientLight.set(settings.render.global_ambient[0], settings.render.global_ambient[1], settings.render.global_ambient[2]);
        this.fog = settings.render.fog;
        this.fogColor.set(settings.render.fog_color[0], settings.render.fog_color[1], settings.render.fog_color[2]);
        this.fogStart = cast(settings.render.fog_start, Int);
        this.fogEnd = cast(settings.render.fog_end, Int);
        this.fogDensity = cast(settings.render.fog_density, Int);
        this.gammaCorrection = cast(settings.render.gamma_correction, GAMMA);
        this.toneMapping = cast(settings.render.tonemapping, TONEMAP);
        this.lightmapSizeMultiplier = settings.render.lightmapSizeMultiplier;
        this.lightmapMaxResolution = settings.render.lightmapMaxResolution;
        this.lightmapMode = settings.render.lightmapMode;
        this.exposure = settings.render.exposure;
        this.skyboxIntensity = settings.render.skyboxIntensity == null ? 1 : settings.render.skyboxIntensity;
        this.skyboxMip = settings.render.skyboxMip == null ? 0 : settings.render.skyboxMip;

        this.resetSkyboxModel();
        this.updateShaders = true;		
	}
	
	
	private function resetSkyboxModel(){
		
	}
	
}