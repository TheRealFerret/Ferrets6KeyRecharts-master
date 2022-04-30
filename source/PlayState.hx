package;

import GameJolt;
import GameJolt.GameJoltAPI;
import openfl.ui.KeyLocation;
import openfl.events.Event;
import haxe.EnumTools;
import openfl.ui.Keyboard;
import openfl.events.KeyboardEvent;
import Replay.Ana;
import Replay.Analysis;
import Shaders.PulseEffect;
#if cpp
import webm.WebmPlayer;
#end
import flixel.input.keyboard.FlxKey;
import haxe.Exception;
import openfl.geom.Matrix;
import openfl.display.BitmapData;
import openfl.utils.AssetType;
import lime.graphics.Image;
import flixel.graphics.FlxGraphic;
import openfl.utils.AssetManifest;
import openfl.utils.AssetLibrary;
import flixel.system.FlxAssets;
import openfl.filters.BlurFilter;

import lime.app.Application;
import lime.media.AudioContext;
import lime.media.AudioManager;
import openfl.Lib;
import Section.SwagSection;
import Song.SwagSong;
import WiggleEffect.WiggleEffectType;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.FlxTrailArea;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
import haxe.Json;
import lime.utils.Assets;
import openfl.display.BlendMode;
import openfl.display.StageQuality;
import openfl.filters.ShaderFilter;
import flixel.input.FlxKeyManager;
import flixel.group.FlxSpriteGroup;
import flixel.addons.text.FlxTypeText;
import flixel.addons.plugin.screengrab.FlxScreenGrab;
import flixel.addons.display.FlxBackdrop;

#if windows
import Discord.DiscordClient;
#end
#if windows
import Sys;
import sys.FileSystem;
#end

using StringTools;

class PlayState extends MusicBeatState
{
	var doRGB:Bool = false;

	var lastrgb:Int = -1;

	public static var instance:PlayState = null;

	public static var curStage:String = '';
	public static var SONG:SwagSong;
	public static var isStoryMode:Bool = false;
	public static var storyWeek:Int = 0;
	public static var storyPlaylist:Array<String> = [];
	public static var storyDifficulty:Int = 1;
	public static var weekSong:Int = 0;
	public static var weekScore:Int = 0;
	public static var shits:Int = 0;
	public static var bads:Int = 0;
	public static var goods:Int = 0;
	public static var sicks:Int = 0;
	public static var mania:Int = 0;
	public static var keyAmmo:Array<Int> = [4, 6, 9, 5, 7, 8, 1, 2, 3];
	private var ctrTime:Float = 0;

	public static var screenshader:Shaders.PulseEffect = new PulseEffect();

	public var elapsedtime:Float = 0;

	var zardyBackground:FlxSprite;

	var daSign:FlxSprite;
	var gramlan:FlxSprite;

	var oldspinArray:Array<Int>;
	var spinArray:Array<Int>;
	var ycrspinArray:Array<Int>;
	var ttspinArray:Array<Int>;
	
	public static var songPosBG:FlxSprite;
	public var visibleCombos:Array<FlxSprite> = [];
	public static var songPosBar:FlxBar;

	public static var rep:Replay;
	public static var loadRep:Bool = false;

	var resyncingVocals:Bool = true;

	var randomUsername:Array<String> = [ //picks a random username to display in chat -heat
		'Shtek543',
		'Bigduck6443',
		'Feetlover5',
		'Taylor',
		'Jurgenchung',
		'Sugmadickus',
		'I-like-ass543',
		'Maurice',
		'heat',
		'TobTheDev',
		'Engineer Gaming',
		'Scout Gaming',
		'Spy Gaming',
		'Heavy gaming',
		'Pyro Gaming',
		'Demo Gaming',
		'Medic Gaming',
		'Soldier Gaming',
		'Sniper gaming',
		'funny engineer',
		'Your Mother',
		'FNF Girlfriend',
		'Medicore cole',
		'Tricky from FNF', // OMG GUYS ITS TRICKY FROM FNF!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! lmao
		'TheFakeFerret',
		'KnownPlayer'
	];

	public static var noteBools:Array<Bool> = [false, false, false, false];

	var randomText:Array<String> = [ //picks a random message to display in the chat -heat. // ok. -tob
		"I hate MrBreast",
		"I love Non-fungible tokens",
		"I play Genshin Impact",
		"Medick from tf2 is so sexy",
		"fuck off",
		"guys anyone got a duped shovel",
		"heavy is dead",
		"pootis",
		"Spy!",
		"Selling unusual for 1 quadrillion keys pls buy",
		"This rechart is hard, Im going to compare it to MFM to make myself feel better.",
		"guys ferret's recharts are so cool right these are the best recharts ever!!!" // /j

		//you can't play this mod on linux or on a website lmao!!!!!
		/*#if linux
		"You're a Linux User!!",
		"lmao youre using Linux",
		#end

		#if html5
		"Stop playing the web version and go play the actual mod",
		"Your pc is trash (You have to go on a website to actually play the mod)",
		"*Gamebanana link* go download the mod there instead of playing it on a website",
		"143.25.34.246",
		"Why did we open source this...",
		"I hope you're not playing this mod on some random website"
		#end*/
	];

	var halloweenLevel:Bool = false;

	var songLength:Float = 0;
	var kadeEngineWatermark:FlxText;
	
	#if windows
	// Discord RPC variables
	var storyDifficultyText:String = "";
	var iconRPC:String = "";
	var detailsText:String = "";
	var detailsPausedText:String = "";
	#end

	private var vocals:FlxSound;

	// tricky lines
	public var TrickyLinesSing:Array<String> = ["SUFFER","INCORRECT", "INCOMPLETE", "INSUFFICIENT", "INVALID", "CORRECTION", "MISTAKE", "REDUCE", "ERROR", "ADJUSTING", "IMPROBABLE", "IMPLAUSIBLE", "MISJUDGED"];
	public var ExTrickyLinesSing:Array<String> = ["YOU AREN'T HANK", "WHERE IS HANK", "HANK???", "WHO ARE YOU", "WHERE AM I", "THIS ISN'T RIGHT", "MIDGET", "SYSTEM UNRESPONSIVE", "WHY CAN'T I KILL?????"];
	public var TrickyLinesMiss:Array<String> = ["TERRIBLE", "WASTE", "MISS CALCULTED", "PREDICTED", "FAILURE", "DISGUSTING", "ABHORRENT", "FORESEEN", "CONTEMPTIBLE", "PROGNOSTICATE", "DISPICABLE", "REPREHENSIBLE"];

	public var originalX:Float;

	public static var dad:Character;
	public static var gf:Character;
	public static var boyfriend:Boyfriend;
	var MAINLIGHT:FlxSprite;

	public var notes:FlxTypedGroup<Note>;
	var noteSplashes:FlxTypedGroup<NoteSplash>;
	private var unspawnNotes:Array<Note> = [];
	private var sDir:Array<String> = ['LEFT', 'DOWN', 'UP', 'RIGHT'];
	public var strumLine:FlxSprite;
	private var curSection:Int = 0;

	var camLocked:Bool = true;

	var tstatic:FlxSprite = new FlxSprite(0,0).loadGraphic(Paths.image('TrickyStatic','shared'), true, 320, 180);

	var tStaticSound:FlxSound = new FlxSound().loadEmbedded(Paths.sound("staticSound","preload"));

	var funnyFloatyBoys:Array<String> = ['bambi-3d'];
	var canFloat:Bool = true;

	public var curbg:FlxSprite;

	private var camFollow:FlxObject;

	private static var prevCamFollow:FlxObject;

	public static var strumLineNotes:FlxTypedGroup<FlxSprite> = null;
	public static var playerStrums:FlxTypedGroup<FlxSprite> = null;
	public static var cpuStrums:FlxTypedGroup<FlxSprite> = null;

	var grace:Bool = false;

	private var camZooming:Bool = false;
	private var autoCam:Bool = true;
	private var curSong:String = "";
	private var floatshit:Float = 0;

	private var gfSpeed:Int = 1;
	public var health:Float = 1; //making public because sethealth doesnt work without it
	private var combo:Int = 0;
	public static var misses:Int = 0;
	public static var campaignMisses:Int = 0;
	public static var campaignSicks:Int = 0;
	public static var campaignGoods:Int = 0;
	public static var campaignBads:Int = 0;
	public static var campaignShits:Int = 0;
	public var accuracy:Float = 0.00;
	private var accuracyDefault:Float = 0.00;
	private var totalNotesHit:Float = 0;
	private var totalNotesHitDefault:Float = 0;
	private var totalPlayed:Int = 0;
	private var ss:Bool = false;


	private var healthBarBG:FlxSprite;
	private var healthBar:FlxBar;
	private var overhealthBar:FlxBar;
	private var songPositionBar:Float = 0;
	
	private var generatedMusic:Bool = false;
	private var startingSong:Bool = false;

	private var shakeCam:Bool = false;
	private var shakeCam2:Bool = false;
	private var shakeCam3:Bool = false;

	public var iconP1:HealthIcon; //making these public again because i may be stupid
	public var iconP2:HealthIcon; //what could go wrong?
	public var camHUD:FlxCamera;
	public var camHUD2:FlxCamera; // jumpscares, ect..
	public var camEst:FlxCamera;
	public var camOverlay:FlxCamera;
	public var camSustains:FlxCamera;
	public var camNotes:FlxCamera;
	var cs_reset:Bool = false;
	public var cannotDie = false;
	private var camGame:FlxCamera;

	var daSection:Int = 1;
	var daJumpscare:FlxSprite = new FlxSprite(0, 0);
	var daP3Static:FlxSprite = new FlxSprite(0, 0);
	var daNoteStatic:FlxSprite = new FlxSprite(0, 0);

	public static var offsetTesting:Bool = false;

	var notesHitArray:Array<Date> = [];
	var currentFrames:Int = 0;
	var idleToBeat:Bool = true; // change if bf and dad would idle to the beat of the song
	var idleBeat:Int = 2; // how frequently bf and dad would play their idle animation(1 - every beat, 2 - every 2 beats and so on)

	public var dialogue:Array<String> = ['dad:blah blah blah', 'bf:coolswag'];

	var bg:FlxSprite;
	var stageFront:FlxSprite;
	var stageCurtains:FlxSprite;

	var halloweenBG:FlxSprite;
	var isHalloween:Bool = false;

	var NHroom:FlxSprite;
	var isNHroom:Bool = false;

	var phillyCityLights:FlxTypedGroup<FlxSprite>;
	var phillyTrain:FlxSprite;
	var trainSound:FlxSound;

	var limo:FlxSprite;
	var grpLimoDancers:FlxTypedGroup<BackgroundDancer>;
	var fastCar:FlxSprite;
	var songName:FlxText;
	var upperBoppers:FlxSprite;
	var bottomBoppers:FlxSprite;
	var santa:FlxSprite;
	var bgfolks:FlxSprite;
	var frontfolks:FlxSprite;
	var bgcrowd:FlxSprite;
	var frontcrowd:FlxSprite;

	var dreamscape:FlxSprite;
	var dreamscapeOuter:FlxSprite;

	var theGuys:FlxSprite;
	var dark:FlxSprite;

	var poopThing:Bool = false;

	var curTiming:Int = 0; // used for switching stuff mid song (alt idle anim, mid song events, etc.)
	var uhm:Bool = false;
	var stupidAHHHH:Bool = false;
	var songIsWeird:Bool = false;
	var soldierShake:Bool = false;
	var slashThingie:Bool = false;
	var swaggyOptim:Int = 0;

	var isCutscene:Bool = false;
	var background:FlxSprite;
	public var curColor = 0;
	public var wall:FlxSprite;
	public var frontDudes:FlxSprite;
	var floorthing:FlxSprite;
	var thingy:FlxSprite;
	var truck:FlxSprite;
	var backgthing:FlxSprite;
	var statttt:FlxSprite;

	var balling:FlxSprite = new FlxSprite(0, 0);

	var weirdstatic:FlxSprite; 
	var penissound:FlxSound;

	var dokipopup:FlxSprite;
	var space:FlxBackdrop;

	var mouth:FlxSprite;
	var tvL:FlxSprite;
	var tvR:FlxSprite;
	var fgFog:FlxSprite;

	var canDodge:Bool = false;
	var dodging:Bool = false;

	var heatlhDrop:Float = 0;
	
	var porker:FlxSprite;
	var thechamber:FlxSprite;
	var floor:FlxSprite;
	var fleetwaybgshit:FlxSprite;
	var emeraldbeam:FlxSprite;
	var emeraldbeamyellow:FlxSprite;
	var pebles:FlxSprite;
	var hands:FlxSprite;
	var tree:FlxSprite;
	var eyeflower:FlxSprite;
	var blackFuck:FlxSprite;
	var startCircle:FlxSprite;
	var startText:FlxSprite;
	var isRing:Bool = SONG.isRing;
	var bgspec:FlxSprite;
	var funpillarts1ANIM:FlxSprite;
	var funpillarts2ANIM:FlxSprite;
	var funboppers1ANIM:FlxSprite;
	var funboppers2ANIM:FlxSprite;

	var p3staticbg:FlxSprite;

	var tailscircle:String = '';
	var ezTrail:FlxTrail;
	var camX:Int = 0;
	var camY:Int = 0;
	var popup:Bool = true;
	var floaty:Float = 0;

	public var daveStand:Character;
	public var garrettStand:Character;
	public var hallMonitorStand:Character;
	public var playRobotStand:Character;

	public var standersGroup:FlxTypedGroup<FlxSprite>;

	private var swagSpeed:Float;

	var daveJunk:FlxSprite;
	var davePiss:FlxSprite;
	var garrettJunk:FlxSprite;
	var monitorJunk:FlxSprite;
	var robotJunk:FlxSprite;
	var diamondJunk:FlxSprite;

	var bgRocks:FlxSprite;

	var fc:Bool = true;

	var bgGirls:BackgroundGirls;
	var wiggleShit:WiggleEffect = new WiggleEffect();

	var talking:Bool = true;
	public var songScore:Int = 0;
	var songScoreDef:Int = 0;
	var scoreTxt:FlxText;
	var ringCounter:FlxSprite;
	var counterNum:FlxText;
	var cNum:Int = 0;
	var replayTxt:FlxText;
	var startedCountdown:Bool = false;

	var maniaChanged:Bool = false;

	var moreDark:FlxSprite;

	var bobmadshake:FlxSprite;
	var bobsound:FlxSound;

	var IsNoteSpinning:Bool = false;
	var SpinAmount:Float = 0;
	var windowX:Float = Lib.application.window.x;
	var windowY:Float = Lib.application.window.y;

	var pantalla:FlxSprite;

	public static var campaignScore:Int = 0;

	var defaultCamZoom:Float = 1.05;

	public static var daPixelZoom:Float = 6;

	public static var theFunne:Bool = true;
	var funneEffect:FlxSprite;
	var inCutscene:Bool = false;
	public static var repPresses:Int = 0;
	public static var repReleases:Int = 0;

	public static var timeCurrently:Float = 0;
	public static var timeCurrentlyR:Float = 0;
	
	// Will fire once to prevent debug spam messages and broken animations
	private var triggeredAlready:Bool = false;
	
	// Will decide if she's even allowed to headbang at all depending on the song
	private var allowedToHeadbang:Bool = false;
	// Per song additive offset
	public static var songOffset:Float = 0;
	// BotPlay text
	private var botPlayState:FlxText;
	// Replay shit
	private var saveNotes:Array<Dynamic> = [];
	private var saveJudge:Array<String> = [];
	private var replayAna:Analysis = new Analysis(); // replay analysis

	public static var highestCombo:Int = 0;

	private var executeModchart = false;
	public static var startTime = 0.0;

	var chatUsername:String;
	var chatText:String;

	var usernameTxt:FlxText;
	var chatTxt:FlxText;

	var ghostNotes:Bool = false;

	var totalMouseNotesHit:Int = 0;
	var totalEbolaNotesHit:Int = 0;

	public var ebolabitch:FlxSprite = new FlxSprite();
	public var housesmoke:FlxSprite = new FlxSprite();
	public var yotsuPANIC:FlxSprite = new FlxSprite();
	public var r9k:FlxSprite = new FlxSprite();
	public var cat:FlxSprite = new FlxSprite();
	public var blackguy:FlxSprite = new FlxSprite();
	public var unsmile:FlxSprite = new FlxSprite();
	public var scaredyo:FlxSprite = new FlxSprite();
	public var aaaaa:FlxSprite = new FlxSprite();
	public var blackboi:FlxSprite;

	public var yotsu:FlxSprite = new FlxSprite();
	public var man:FlxSprite = new FlxSprite();
	public var trv:FlxSprite = new FlxSprite();
	public var xtan:FlxSprite = new FlxSprite();
	public var chinkMoot:FlxTypedGroup<FakeMoot>;
	public var vrtan1:FlxSprite = new FlxSprite();
	public var vrtan2:FlxSprite = new FlxSprite();
	public var FUCK:FlxSprite = new FlxSprite();
	public static var noo:Int = 1; 

	var sonicbg:FlxSprite;
	var fleetbg:FlxSprite;
	var vintage:FlxSprite;

	public static var inScene:Bool = true;////to fix the fucked up camera at the intro

	// API stuff
	
	public function addObject(object:FlxBasic) { add(object); }
	public function removeObject(object:FlxBasic) { remove(object); }

	//they say it's gay shit so it must be
	var sky:FlxSprite;
	var woods:FlxSprite;

	override public function create()
	{
		if (FlxG.save.data.fullscreen)
			Lib.application.window.fullscreen = true;
		else if (curSong.toLowerCase() == 'onslaught' && FlxG.save.data.shakingscreen|| curSong.toLowerCase() == 'bloodshed' || curSong.toLowerCase() == 'run' && FlxG.save.data.shakingscreen)
			Lib.application.window.fullscreen = false;
		else
			Lib.application.window.fullscreen = false;

		chatUsername = randomUsername[FlxG.random.int(0, randomUsername.length -1)] + ":";
		chatText = randomText[FlxG.random.int(0, randomText.length -1)];

		blackFuck = new FlxSprite().makeGraphic(4096,2048, FlxColor.BLACK);

		startCircle = new FlxSprite();
		startText = new FlxSprite();
	

		FlxG.mouse.visible = false;

		oldspinArray = [272, 276, 336, 340, 400, 404, 464, 468, 528, 532, 592, 596, 656, 660, 720, 724, 789, 793, 863, 867, 937, 941, 1012, 1016, 1086, 1090, 1160, 1164, 1531, 1535, 1607, 1611, 1681, 1685, 1754, 1758];
		
		spinArray = [
			272, 276, 336, 340, 400, 404, 464, 468, 528, 532, 592, 596, 656, 660, 720, 724, 784, 788, 848, 852, 912, 916, 976, 980, 1040, 1044, 1104, 1108,
			1424, 1428, 1488, 1492, 1552, 1556, 1616, 1620
		];

		ycrspinArray = [
			1176, 1180, 1208, 1212, 1240, 1244, 1272, 1276, 1304, 1308, 1336, 1340, 1368, 1372, 1400, 1404
		];

		ttspinArray = [
			152, 216, 280, 344, 536, 600, 664, 728, 920, 984, 1176, 1240, 1432, 1496, 1560, 1624, 1816, 1880, 1944, 2008, 2072, 2136, 2200, 2264, 2584, 2648, 2712, 2776, 2968, 3032, 3096, 3160, 3224, 3264,
			3288, 3352, 3416, 3480, 3544, 3608, 3672, 3736, 3800, 3864, 3928, 4120, 4184, 4248, 4312, 4376, 4440, 4504, 4568, 4632, 4696, 4760, 4824, 4888, 4952, 5016, 5080 
		];

		instance = this;

		var cover:FlxSprite = new FlxSprite(-180, 755).loadGraphic(Paths.image('cover'));
		var hole:FlxSprite = new FlxSprite(50, 530).loadGraphic(Paths.image('Spawnhole_Ground_BACK'));
		var converHole:FlxSprite = new FlxSprite(7,578).loadGraphic(Paths.image('Spawnhole_Ground_COVER'));
		
		if (FlxG.save.data.fpsCap > 290)
			(cast (Lib.current.getChildAt(0), Main)).setFPSCap(800);
		
		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		if (!isStoryMode)
		{
			sicks = 0;
			bads = 0;
			shits = 0;
			goods = 0;
		}
		misses = 0;

		repPresses = 0;
		repReleases = 0;

		resetSpookyText = true;

		PlayStateChangeables.useDownscroll = FlxG.save.data.downscroll;
		PlayStateChangeables.safeFrames = FlxG.save.data.frames;
		PlayStateChangeables.scrollSpeed = FlxG.save.data.scrollSpeed;
		PlayStateChangeables.botPlay = FlxG.save.data.botplay;
		PlayStateChangeables.Optimize = FlxG.save.data.optimize;
		PlayStateChangeables.zoom = FlxG.save.data.zoom;

		// pre lowercasing the song name (create)
		var songLowercase = StringTools.replace(PlayState.SONG.song, " ", "-").toLowerCase();
		switch (songLowercase) {
			case 'dad-battle': songLowercase = 'dadbattle';
			case 'philly-nice': songLowercase = 'philly';
		}
		
		removedVideo = false;

		#if windows
		executeModchart = FileSystem.exists(Paths.lua(songLowercase  + "/modchart"));
		if (executeModchart)
			PlayStateChangeables.Optimize = false;
		#end
		#if !cpp
		executeModchart = false; // FORCE disable for non cpp targets
		#end

		trace('Mod chart: ' + executeModchart + " - " + Paths.lua(songLowercase + "/modchart"));


		noteSplashes = new FlxTypedGroup<NoteSplash>();
		var daSplash = new NoteSplash(100, 100, 0);
		daSplash.alpha = 0;
		noteSplashes.add(daSplash);


		#if windows
		// Making difficulty text for Discord Rich Presence.
			storyDifficultyText = CoolUtil.difficultyFromInt(storyDifficulty);

		iconRPC = SONG.player2;

		// To avoid having duplicate images in Discord assets
		switch (iconRPC)
		{
			case 'senpai-angry':
				iconRPC = 'senpai';
			case 'monster-christmas':
				iconRPC = 'monster';
			case 'mom-car':
				iconRPC = 'mom';
		}

		// String that contains the mode defined here so it isn't necessary to call changePresence for each mode
		if (isStoryMode)
		{
			detailsText = "Story Mode: Week " + storyWeek;
		}
		else
		{
			detailsText = "Freeplay";
		}

		// String for when the game is paused
		detailsPausedText = "Paused - " + detailsText;

		// Updating Discord Rich Presence.
		DiscordClient.changePresence(detailsText + " " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), "\nAcc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
		#end


		// var gameCam:FlxCamera = FlxG.camera;
		camGame = new FlxCamera();
		camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;
		camHUD2 = new FlxCamera();
		camHUD2.bgColor.alpha = 0;
		camEst = new FlxCamera();
		camEst.bgColor.alpha = 0;
		camOverlay = new FlxCamera();
		camOverlay.bgColor.alpha = 0;
		camSustains = new FlxCamera();
		camSustains.bgColor.alpha = 0;
		camNotes = new FlxCamera();
		camNotes.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camEst);
		FlxG.cameras.add(camHUD);
		FlxG.cameras.add(camSustains);
		FlxG.cameras.add(camNotes);
		FlxG.cameras.add(camOverlay);
		FlxG.cameras.add(camHUD2);

		camHUD.zoom = PlayStateChangeables.zoom;
		camHUD2.zoom = PlayStateChangeables.zoom;

		FlxCamera.defaultCameras = [camGame];

		persistentUpdate = true;
		persistentDraw = true;

		mania = SONG.mania;

		if (SONG == null)
			SONG = Song.loadFromJson('madness', 'madness');

		Conductor.mapBPMChanges(SONG);
		Conductor.changeBPM(SONG.bpm);

		//unhardcode tricky sing strings lmao
		TrickyLinesSing = CoolUtil.coolTextFile(Paths.txt('trickySingStrings'));
		TrickyLinesMiss = CoolUtil.coolTextFile(Paths.txt('trickyMissStrings'));
		ExTrickyLinesSing = CoolUtil.coolTextFile(Paths.txt('trickyExSingStrings'));

		trace('INFORMATION ABOUT WHAT U PLAYIN WIT:\nFRAMES: ' + PlayStateChangeables.safeFrames + '\nZONE: ' + Conductor.safeZoneOffset + '\nTS: ' + Conductor.timeScale + '\nBotPlay : ' + PlayStateChangeables.botPlay);
	
		//dialogue shit
		switch (songLowercase)
		{
			case 'tutorial':
				dialogue = ["Hey you're pretty cute.", 'Use the arrow keys to keep up \nwith me singing.'];
			case 'bopeebo':
				dialogue = [
					'HEY!',
					"You think you can just sing\nwith my daughter like that?",
					"If you want to date her...",
					"You're going to have to go \nthrough ME first!"
				];
			case 'fresh':
				dialogue = ["Not too shabby boy.", ""];
			case 'dadbattle':
				dialogue = [
					"gah you think you're hot stuff?",
					"If you can beat me here...",
					"Only then I will even CONSIDER letting you\ndate my daughter!"
				];
			case 'senpai':
				dialogue = CoolUtil.coolTextFile(Paths.txt('senpai/senpaiDialogue'));
			case 'roses':
				dialogue = CoolUtil.coolTextFile(Paths.txt('roses/rosesDialogue'));
			case 'thorns':
				dialogue = CoolUtil.coolTextFile(Paths.txt('thorns/thornsDialogue'));
			case 'honorbound':
				uhm = true;
				stupidAHHHH = true;
				swaggyOptim = 3;
		}

		//defaults if no stage was found in chart
		var stageCheck:String = 'stage';
		
		if (SONG.stage == null) {
			switch(storyWeek)
			{
				case 2: stageCheck = 'halloween';
				case 3: stageCheck = 'philly';
				case 4: stageCheck = 'limo';
				case 5: if (songLowercase == 'winter-horrorland') {stageCheck = 'mallEvil';} else {stageCheck = 'mall';}
				case 6: if (songLowercase == 'thorns') {stageCheck = 'schoolEvil';} else {stageCheck = 'school';}
				//i should check if its stage (but this is when none is found in chart anyway)
			}
		} else {stageCheck = SONG.stage;}

		if (!PlayStateChangeables.Optimize)
		{

		switch(stageCheck)
		{
			case 'halloween': 
			{
				curStage = 'spooky';
				halloweenLevel = true;

				var hallowTex = Paths.getSparrowAtlas('halloween_bg','week2');

				halloweenBG = new FlxSprite(-200, -100);
				halloweenBG.frames = hallowTex;
				halloweenBG.animation.addByPrefix('idle', 'halloweem bg0');
				halloweenBG.animation.addByPrefix('lightning', 'halloweem bg lightning strike', 24, false);
				halloweenBG.animation.play('idle');
				halloweenBG.antialiasing = FlxG.save.data.antialiasing;
				add(halloweenBG);

				isHalloween = true;
			}
			case 'philly': 
					{
					curStage = 'philly';

					var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('philly/sky', 'week3'));
					bg.scrollFactor.set(0.1, 0.1);
					add(bg);

					var city:FlxSprite = new FlxSprite(-10).loadGraphic(Paths.image('philly/city', 'week3'));
					city.scrollFactor.set(0.3, 0.3);
					city.setGraphicSize(Std.int(city.width * 0.85));
					city.updateHitbox();
					add(city);

					phillyCityLights = new FlxTypedGroup<FlxSprite>();
					if(FlxG.save.data.distractions){
						add(phillyCityLights);
					}

					for (i in 0...5)
					{
							var light:FlxSprite = new FlxSprite(city.x).loadGraphic(Paths.image('philly/win' + i, 'week3'));
							light.scrollFactor.set(0.3, 0.3);
							light.visible = false;
							light.setGraphicSize(Std.int(light.width * 0.85));
							light.updateHitbox();
							light.antialiasing = FlxG.save.data.antialiasing;
							phillyCityLights.add(light);
					}

					var streetBehind:FlxSprite = new FlxSprite(-40, 50).loadGraphic(Paths.image('philly/behindTrain','week3'));
					add(streetBehind);

					phillyTrain = new FlxSprite(2000, 360).loadGraphic(Paths.image('philly/train','week3'));
					if(FlxG.save.data.distractions){
						add(phillyTrain);
					}

					trainSound = new FlxSound().loadEmbedded(Paths.sound('train_passes','week3'));
					FlxG.sound.list.add(trainSound);

					// var cityLights:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.win0.png);

					var street:FlxSprite = new FlxSprite(-40, streetBehind.y).loadGraphic(Paths.image('philly/street','week3'));
					add(street);
			}
			case 'limo':
			{
					curStage = 'limo';
					defaultCamZoom = 0.90;

					var skyBG:FlxSprite = new FlxSprite(-120, -50).loadGraphic(Paths.image('limo/limoSunset','week4'));
					skyBG.scrollFactor.set(0.1, 0.1);
					skyBG.antialiasing = FlxG.save.data.antialiasing;
					add(skyBG);

					var bgLimo:FlxSprite = new FlxSprite(-200, 480);
					bgLimo.frames = Paths.getSparrowAtlas('limo/bgLimo','week4');
					bgLimo.animation.addByPrefix('drive', "background limo pink", 24);
					bgLimo.animation.play('drive');
					bgLimo.scrollFactor.set(0.4, 0.4);
					bgLimo.antialiasing = FlxG.save.data.antialiasing;
					add(bgLimo);
					if(FlxG.save.data.distractions){
						grpLimoDancers = new FlxTypedGroup<BackgroundDancer>();
						add(grpLimoDancers);
	
						for (i in 0...5)
						{
								var dancer:BackgroundDancer = new BackgroundDancer((370 * i) + 130, bgLimo.y - 400);
								dancer.scrollFactor.set(0.4, 0.4);
								grpLimoDancers.add(dancer);
						}
					}

					var overlayShit:FlxSprite = new FlxSprite(-500, -600).loadGraphic(Paths.image('limo/limoOverlay','week4'));
					overlayShit.alpha = 0.5;
					// add(overlayShit);

					// var shaderBullshit = new BlendModeEffect(new OverlayShader(), FlxColor.RED);

					// FlxG.camera.setFilters([new ShaderFilter(cast shaderBullshit.shader)]);

					// overlayShit.shader = shaderBullshit;

					var limoTex = Paths.getSparrowAtlas('limo/limoDrive','week4');

					limo = new FlxSprite(-120, 550);
					limo.frames = limoTex;
					limo.animation.addByPrefix('drive', "Limo stage", 24);
					limo.animation.play('drive');
					limo.antialiasing = FlxG.save.data.antialiasing;

					fastCar = new FlxSprite(-300, 160).loadGraphic(Paths.image('limo/fastCarLol','week4'));
					fastCar.antialiasing = FlxG.save.data.antialiasing;
					// add(limo);
			}
			case 'mall':
			{
					curStage = 'mall';

					defaultCamZoom = 0.80;

					var bg:FlxSprite = new FlxSprite(-1000, -500).loadGraphic(Paths.image('christmas/bgWalls','week5'));
					bg.antialiasing = FlxG.save.data.antialiasing;
					bg.scrollFactor.set(0.2, 0.2);
					bg.active = false;
					bg.setGraphicSize(Std.int(bg.width * 0.8));
					bg.updateHitbox();
					add(bg);

					upperBoppers = new FlxSprite(-240, -90);
					upperBoppers.frames = Paths.getSparrowAtlas('christmas/upperBop','week5');
					upperBoppers.animation.addByPrefix('bop', "Upper Crowd Bob", 24, false);
					upperBoppers.antialiasing = FlxG.save.data.antialiasing;
					upperBoppers.scrollFactor.set(0.33, 0.33);
					upperBoppers.setGraphicSize(Std.int(upperBoppers.width * 0.85));
					upperBoppers.updateHitbox();
					if(FlxG.save.data.distractions){
						add(upperBoppers);
					}


					var bgEscalator:FlxSprite = new FlxSprite(-1100, -600).loadGraphic(Paths.image('christmas/bgEscalator','week5'));
					bgEscalator.antialiasing = FlxG.save.data.antialiasing;
					bgEscalator.scrollFactor.set(0.3, 0.3);
					bgEscalator.active = false;
					bgEscalator.setGraphicSize(Std.int(bgEscalator.width * 0.9));
					bgEscalator.updateHitbox();
					add(bgEscalator);

					var tree:FlxSprite = new FlxSprite(370, -250).loadGraphic(Paths.image('christmas/christmasTree','week5'));
					tree.antialiasing = FlxG.save.data.antialiasing;
					tree.scrollFactor.set(0.40, 0.40);
					add(tree);

					bottomBoppers = new FlxSprite(-300, 140);
					bottomBoppers.frames = Paths.getSparrowAtlas('christmas/bottomBop','week5');
					bottomBoppers.animation.addByPrefix('bop', 'Bottom Level Boppers', 24, false);
					bottomBoppers.antialiasing = FlxG.save.data.antialiasing;
					bottomBoppers.scrollFactor.set(0.9, 0.9);
					bottomBoppers.setGraphicSize(Std.int(bottomBoppers.width * 1));
					bottomBoppers.updateHitbox();
					if(FlxG.save.data.distractions){
						add(bottomBoppers);
					}


					var fgSnow:FlxSprite = new FlxSprite(-600, 700).loadGraphic(Paths.image('christmas/fgSnow','week5'));
					fgSnow.active = false;
					fgSnow.antialiasing = FlxG.save.data.antialiasing;
					add(fgSnow);

					santa = new FlxSprite(-840, 150);
					santa.frames = Paths.getSparrowAtlas('christmas/santa','week5');
					santa.animation.addByPrefix('idle', 'santa idle in fear', 24, false);
					santa.antialiasing = FlxG.save.data.antialiasing;
					if(FlxG.save.data.distractions){
						add(santa);
					}
			}
			case 'mallEvil':
			{
					curStage = 'mallEvil';
					var bg:FlxSprite = new FlxSprite(-400, -500).loadGraphic(Paths.image('christmas/evilBG','week5'));
					bg.antialiasing = FlxG.save.data.antialiasing;
					bg.scrollFactor.set(0.2, 0.2);
					bg.active = false;
					bg.setGraphicSize(Std.int(bg.width * 0.8));
					bg.updateHitbox();
					add(bg);

					var evilTree:FlxSprite = new FlxSprite(300, -300).loadGraphic(Paths.image('christmas/evilTree','week5'));
					evilTree.antialiasing = FlxG.save.data.antialiasing;
					evilTree.scrollFactor.set(0.2, 0.2);
					add(evilTree);

					var evilSnow:FlxSprite = new FlxSprite(-200, 700).loadGraphic(Paths.image("christmas/evilSnow",'week5'));
						evilSnow.antialiasing = FlxG.save.data.antialiasing;
					add(evilSnow);
					}
			case 'school':
			{
					curStage = 'school';

					// defaultCamZoom = 0.9;

					var bgSky = new FlxSprite().loadGraphic(Paths.image('weeb/weebSky','week6'));
					bgSky.scrollFactor.set(0.1, 0.1);
					add(bgSky);

					var repositionShit = -200;

					var bgSchool:FlxSprite = new FlxSprite(repositionShit, 0).loadGraphic(Paths.image('weeb/weebSchool','week6'));
					bgSchool.scrollFactor.set(0.6, 0.90);
					add(bgSchool);

					var bgStreet:FlxSprite = new FlxSprite(repositionShit).loadGraphic(Paths.image('weeb/weebStreet','week6'));
					bgStreet.scrollFactor.set(0.95, 0.95);
					add(bgStreet);

					var fgTrees:FlxSprite = new FlxSprite(repositionShit + 170, 130).loadGraphic(Paths.image('weeb/weebTreesBack','week6'));
					fgTrees.scrollFactor.set(0.9, 0.9);
					add(fgTrees);

					var bgTrees:FlxSprite = new FlxSprite(repositionShit - 380, -800);
					var treetex = Paths.getPackerAtlas('weeb/weebTrees','week6');
					bgTrees.frames = treetex;
					bgTrees.animation.add('treeLoop', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18], 12);
					bgTrees.animation.play('treeLoop');
					bgTrees.scrollFactor.set(0.85, 0.85);
					add(bgTrees);

					var treeLeaves:FlxSprite = new FlxSprite(repositionShit, -40);
					treeLeaves.frames = Paths.getSparrowAtlas('weeb/petals','week6');
					treeLeaves.animation.addByPrefix('leaves', 'PETALS ALL', 24, true);
					treeLeaves.animation.play('leaves');
					treeLeaves.scrollFactor.set(0.85, 0.85);
					add(treeLeaves);

					var widShit = Std.int(bgSky.width * 6);

					bgSky.setGraphicSize(widShit);
					bgSchool.setGraphicSize(widShit);
					bgStreet.setGraphicSize(widShit);
					bgTrees.setGraphicSize(Std.int(widShit * 1.4));
					fgTrees.setGraphicSize(Std.int(widShit * 0.8));
					treeLeaves.setGraphicSize(widShit);

					fgTrees.updateHitbox();
					bgSky.updateHitbox();
					bgSchool.updateHitbox();
					bgStreet.updateHitbox();
					bgTrees.updateHitbox();
					treeLeaves.updateHitbox();

					bgGirls = new BackgroundGirls(-100, 190);
					bgGirls.scrollFactor.set(0.9, 0.9);

					if (songLowercase == 'roses')
						{
							if(FlxG.save.data.distractions){
								bgGirls.getScared();
							}
						}

					bgGirls.setGraphicSize(Std.int(bgGirls.width * daPixelZoom));
					bgGirls.updateHitbox();
					if(FlxG.save.data.distractions){
						add(bgGirls);
					}
			}
			case 'schoolEvil':
			{
					curStage = 'schoolEvil';

					if (!PlayStateChangeables.Optimize)
						{
							var waveEffectBG = new FlxWaveEffect(FlxWaveMode.ALL, 2, -1, 3, 2);
							var waveEffectFG = new FlxWaveEffect(FlxWaveMode.ALL, 2, -1, 5, 2);
						}

					var posX = 400;
					var posY = 200;

					var bg:FlxSprite = new FlxSprite(posX, posY);
					bg.frames = Paths.getSparrowAtlas('weeb/animatedEvilSchool','week6');
					bg.animation.addByPrefix('idle', 'background 2', 24);
					bg.animation.play('idle');
					bg.scrollFactor.set(0.8, 0.9);
					bg.scale.set(6, 6);
					add(bg);

					/* 
							var bg:FlxSprite = new FlxSprite(posX, posY).loadGraphic(Paths.image('weeb/evilSchoolBG'));
							bg.scale.set(6, 6);
							// bg.setGraphicSize(Std.int(bg.width * 6));
							// bg.updateHitbox();
							add(bg);
							var fg:FlxSprite = new FlxSprite(posX, posY).loadGraphic(Paths.image('weeb/evilSchoolFG'));
							fg.scale.set(6, 6);
							// fg.setGraphicSize(Std.int(fg.width * 6));
							// fg.updateHitbox();
							add(fg);
							wiggleShit.effectType = WiggleEffectType.DREAMY;
							wiggleShit.waveAmplitude = 0.01;
							wiggleShit.waveFrequency = 60;
							wiggleShit.waveSpeed = 0.8;
						*/

					// bg.shader = wiggleShit.shader;
					// fg.shader = wiggleShit.shader;

					/* 
								var waveSprite = new FlxEffectSprite(bg, [waveEffectBG]);
								var waveSpriteFG = new FlxEffectSprite(fg, [waveEffectFG]);
								// Using scale since setGraphicSize() doesnt work???
								waveSprite.scale.set(6, 6);
								waveSpriteFG.scale.set(6, 6);
								waveSprite.setPosition(posX, posY);
								waveSpriteFG.setPosition(posX, posY);
								waveSprite.scrollFactor.set(0.7, 0.8);
								waveSpriteFG.scrollFactor.set(0.9, 0.8);
								// waveSprite.setGraphicSize(Std.int(waveSprite.width * 6));
								// waveSprite.updateHitbox();
								// waveSpriteFG.setGraphicSize(Std.int(fg.width * 6));
								// waveSpriteFG.updateHitbox();
								add(waveSprite);
								add(waveSpriteFG);
						*/
			}
			case 'stage':
				{
						defaultCamZoom = 0.9;
						curStage = 'stage';
						bg = new FlxSprite(-600, -200).loadGraphic(Paths.image('stageback'));
						bg.antialiasing = FlxG.save.data.antialiasing;
						bg.scrollFactor.set(0.9, 0.9);
						bg.active = false;
						add(bg);
	
						stageFront = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefront'));
						stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
						stageFront.updateHitbox();
						stageFront.antialiasing = FlxG.save.data.antialiasing;
						stageFront.scrollFactor.set(0.9, 0.9);
						stageFront.active = false;
						add(stageFront);
	
						stageCurtains = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagecurtains'));
						stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
						stageCurtains.updateHitbox();
						stageCurtains.antialiasing = FlxG.save.data.antialiasing;
						stageCurtains.scrollFactor.set(1.3, 1.3);
						stageCurtains.active = false;
	
						add(stageCurtains);
				}
				case 'nevada':
				{
						defaultCamZoom = 0.75;
						curStage = 'nevada';

						tstatic.antialiasing = FlxG.save.data.antialiasing;
						tstatic.scrollFactor.set(0,0);
						tstatic.setGraphicSize(Std.int(tstatic.width * 8.3));
						tstatic.animation.add('static', [0, 1, 2], 24, true);
						tstatic.animation.play('static');
			
						tstatic.alpha = 0;

						bg = new FlxSprite(-350, -300).loadGraphic(Paths.image('red','shared'));
						// bg.setGraphicSize(Std.int(bg.width * 2.5));
						// bg.updateHitbox();
						bg.antialiasing = FlxG.save.data.antialiasing;
						bg.scrollFactor.set(0.9, 0.9);

						stageFront = new FlxSprite(-1100, -460).loadGraphic(Paths.image('island_but_rocks_float'));
						stageFront.setGraphicSize(Std.int(stageFront.width * 1.4));
						stageFront.antialiasing = FlxG.save.data.antialiasing;
						stageFront.scrollFactor.set(0.9, 0.9);
						stageFront.active = false;
						add(stageFront);

						MAINLIGHT = new FlxSprite(-470, -150).loadGraphic(Paths.image('hue','shared'));
						MAINLIGHT.alpha - 0.3;
						MAINLIGHT.setGraphicSize(Std.int(MAINLIGHT.width * 0.9));
						MAINLIGHT.blend = "screen";
						MAINLIGHT.updateHitbox();
						MAINLIGHT.antialiasing = FlxG.save.data.antialiasing;
						MAINLIGHT.scrollFactor.set(1.2, 1.2);
				}
				case 'auditorHell':
				{
						defaultCamZoom = 0.55;
						curStage = 'auditorHell';

						tstatic.antialiasing = FlxG.save.data.antialiasing;
						tstatic.scrollFactor.set(0,0);
						tstatic.setGraphicSize(Std.int(tstatic.width * 8.3));
						tstatic.animation.add('static', [0, 1, 2], 24, true);
						tstatic.animation.play('static');
			
						tstatic.alpha = 0;

						bg = new FlxSprite(-10, -10).loadGraphic(Paths.image('bg'));
						bg.antialiasing = FlxG.save.data.antialiasing;
						bg.scrollFactor.set(0.9, 0.9);
						bg.active = false;
						bg.setGraphicSize(Std.int(bg.width * 4));
						add(bg);
			
						var energyWall:FlxSprite = new FlxSprite(1350, -690).loadGraphic(Paths.image("Energywall"));
						energyWall.antialiasing = FlxG.save.data.antialiasing;
						energyWall.scrollFactor.set(0.9, 0.9);
						add(energyWall);

						stageFront = new FlxSprite(-350, -355).loadGraphic(Paths.image('daBackground'));
						stageFront.antialiasing = FlxG.save.data.antialiasing;
						stageFront.scrollFactor.set(0.9, 0.9);
						stageFront.setGraphicSize(Std.int(stageFront.width * 1.55));
						add(stageFront);

						cover.antialiasing = FlxG.save.data.antialiasing;
						cover.scrollFactor.set(0.9, 0.9);
						cover.setGraphicSize(Std.int(cover.width * 1.55));

						hole.antialiasing = FlxG.save.data.antialiasing;
						hole.scrollFactor.set(0.9, 0.9);
						hole.setGraphicSize(Std.int(hole.width * 1.55));

						converHole.antialiasing = FlxG.save.data.antialiasing;
						converHole.scrollFactor.set(0.9, 0.9);
						converHole.setGraphicSize(Std.int(converHole.width * 1.3));

						daSign = new FlxSprite(0,0);

						daSign.frames = Paths.getSparrowAtlas('Sign_Post_Mechanic');
		
						daSign.setGraphicSize(Std.int(daSign.width * 0.67));
						add(daSign);
						remove(daSign);

						gramlan = new FlxSprite(0,0);

						gramlan.frames = Paths.getSparrowAtlas('HP GREMLIN');

						gramlan.setGraphicSize(Std.int(gramlan.width * 0.76));
						add(gramlan);
						remove(gramlan);
				}
			case 'defeat':
				{
					defaultCamZoom = 0.9;
					curStage = 'defeat';
					var defeat:FlxSprite = new FlxSprite(0, 100).loadGraphic(Paths.image('defeatfnf'));		
					defeat.setGraphicSize(Std.int(defeat.width * 2));
					defeat.scrollFactor.set(1,1);
					defeat.antialiasing = FlxG.save.data.antialiasing;
					add(defeat);
				}
			case 'arcade':
				{
						defaultCamZoom = 0.9;
						curStage = 'arcade';
						var arcade:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('arcadeback'));
						arcade.antialiasing = FlxG.save.data.antialiasing;
						arcade.scrollFactor.set(0.9, 0.9);
						arcade.active = false;
						add(arcade);
	
						var arcadeFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('arcadefront'));
						arcadeFront.setGraphicSize(Std.int(arcadeFront.width * 1.1));
						arcadeFront.updateHitbox();
						arcadeFront.antialiasing = FlxG.save.data.antialiasing;
						arcadeFront.scrollFactor.set(0.9, 0.9);
						arcadeFront.active = false;
						add(arcadeFront);
	
						var arcadeCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('arcadecurtains'));
						arcadeCurtains.setGraphicSize(Std.int(arcadeCurtains.width * 0.9));
						arcadeCurtains.updateHitbox();
						arcadeCurtains.antialiasing = FlxG.save.data.antialiasing;
						arcadeCurtains.scrollFactor.set(1.3, 1.3);
						arcadeCurtains.active = false;
	
						add(arcadeCurtains);

						bgcrowd = new FlxSprite(-600, -200);
						bgcrowd.frames = Paths.getSparrowAtlas('bgcrowd');
						bgcrowd.animation.addByPrefix('dance', 'Bottom Level Boppers', 24, false);
						bgcrowd.antialiasing = FlxG.save.data.antialiasing;
						bgcrowd.scrollFactor.set(0.92, 0.92);
						bgcrowd.setGraphicSize(Std.int(bgcrowd.width * 1));
						bgcrowd.updateHitbox();
						add(bgcrowd);

						frontcrowd = new FlxSprite(-600, -200);
						frontcrowd.frames = Paths.getSparrowAtlas('frontcrowd');
						frontcrowd.animation.addByPrefix('dance', "Upper Crowd Bob", 24, false);
						frontcrowd.antialiasing = FlxG.save.data.antialiasing;
						frontcrowd.scrollFactor.set(1.05, 1.05);
						frontcrowd.setGraphicSize(Std.int(frontcrowd.width * 1));
						frontcrowd.updateHitbox();
						add(frontcrowd);
				}		
			case 'banknight':
				{
						defaultCamZoom = 0.9;
						curStage = 'banknight';
						var nbankbg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('nbankback'));
						nbankbg.antialiasing = FlxG.save.data.antialiasing;
						nbankbg.scrollFactor.set(0.9, 0.9);
						nbankbg.active = false;
						add(nbankbg);
	
						var nbankstageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('nbankfront'));
						nbankstageFront.setGraphicSize(Std.int(nbankstageFront.width * 1.1));
						nbankstageFront.updateHitbox();
						nbankstageFront.antialiasing = FlxG.save.data.antialiasing;
						nbankstageFront.scrollFactor.set(0.9, 0.9);
						nbankstageFront.active = false;
						add(nbankstageFront);
	
						var nbankstageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('nbankcurtains'));
						nbankstageCurtains.setGraphicSize(Std.int(nbankstageCurtains.width * 0.9));
						nbankstageCurtains.updateHitbox();
						nbankstageCurtains.antialiasing = FlxG.save.data.antialiasing;
						nbankstageCurtains.scrollFactor.set(1.3, 1.3);
						nbankstageCurtains.active = false;
	
						add(nbankstageCurtains);
				}
			case 'illusion':
			{
				curStage = 'illusion';
				defaultCamZoom = 0.85;

				var bg:FlxSprite = new FlxSprite(-300, -300).loadGraphic(Paths.image('buildingsevil'));
				bg.antialiasing = FlxG.save.data.antialiasing;
				bg.scrollFactor.set(0.8, 0.8);
				add(bg);

				var signs:FlxSprite = new FlxSprite(-300, -35).loadGraphic(Paths.image('floorevil'));
				signs.antialiasing = FlxG.save.data.antialiasing;
				signs.scrollFactor.set(0.9, 0.9);
				add(signs);

				mouth = new FlxSprite(350, 770);
				mouth.frames = Paths.getSparrowAtlas('MOUTH');
				mouth.animation.addByPrefix('mouthh', "MOUTHANIM", 24, false);
				mouth.antialiasing = FlxG.save.data.antialiasing;
				mouth.scrollFactor.set(0.9, 0.9);
				mouth.setGraphicSize(Std.int(mouth.width * 1.0));
				mouth.updateHitbox();
				add(mouth);

				tvL = new FlxSprite(-250, 150);
				tvL.frames = Paths.getSparrowAtlas('XO_TV_L');
				tvL.animation.addByPrefix('spoopyTV1', "BG SPEAKERS TVS", 24, true);
				tvL.antialiasing = FlxG.save.data.antialiasing;
				tvL.scrollFactor.set(0.9, 0.9);
				tvL.setGraphicSize(Std.int(tvL.width * 1.0));
				tvL.updateHitbox();
				add(tvL);

				tvR = new FlxSprite(1000, 120);
				tvR.frames = Paths.getSparrowAtlas('XO_TV_R');
				tvR.animation.addByPrefix('spoopyTV2', "BG SPEAKERS TVS OtherSide", 24, true);
				tvR.antialiasing = FlxG.save.data.antialiasing;
				tvR.scrollFactor.set(0.9, 0.9);
				tvR.setGraphicSize(Std.int(tvR.width * 1.0));
				tvR.updateHitbox();
				add(tvR);
				
				fgFog = new FlxSprite(-450, -550).loadGraphic(Paths.image('fog'));
				fgFog.active = false;
				fgFog.antialiasing = FlxG.save.data.antialiasing;
				fgFog.setGraphicSize(Std.int(fgFog.width * 1.30));
				FlxTween.tween(fgFog,{x: fgFog.x + 100}, 5.5,{ease:FlxEase.cubeOut,type:PINGPONG});
			}	
			case 'night': 
			{
				curStage = 'night';
				halloweenLevel = true;
				
				var hallowTex = Paths.getSparrowAtlas('halloween_bg','shared');

				halloweenBG = new FlxSprite(-200, -100);
				halloweenBG.frames = hallowTex;
				halloweenBG.animation.addByPrefix('idle', 'halloweem bg0');
				halloweenBG.animation.addByPrefix('lightning', 'halloweem bg lightning strike', 24, false);
				halloweenBG.animation.play('idle');
				halloweenBG.antialiasing = FlxG.save.data.antialiasing;
				add(halloweenBG);

				isHalloween = true;
			}

			case 'OldLordXStage':
			{	
			defaultCamZoom = .73;
			curStage = 'OldLordXStage';



			var sky:FlxSprite = new FlxSprite(-1900, -1006).loadGraphic(Paths.image('exe/LordXStage/sky','shared'));
			sky.setGraphicSize(Std.int(sky.width * .5));
			sky.antialiasing = FlxG.save.data.antialiasing;
			sky.scrollFactor.set(.95, 1);
			sky.active = false;
			add(sky);

			var hills1:FlxSprite = new FlxSprite(-1900, -1006).loadGraphic(Paths.image('exe/LordXStage/oldhills1','shared'));
			hills1.setGraphicSize(Std.int(hills1.width * .5));
			hills1.antialiasing = FlxG.save.data.antialiasing;
			hills1.scrollFactor.set(.95, 1);
			hills1.active = false;
			add(hills1);

			var hills2:FlxSprite = new FlxSprite(-1900, -1006).loadGraphic(Paths.image('exe/LordXStage/hills2','shared'));
			hills2.setGraphicSize(Std.int(hills2.width * .5));
			hills2.antialiasing = FlxG.save.data.antialiasing;
			hills2.scrollFactor.set(.97, 1);
			hills2.active = false;
			add(hills2);

			var floor:FlxSprite = new FlxSprite(-1900, -996).loadGraphic(Paths.image('exe/LordXStage/oldfloor','shared'));
			floor.setGraphicSize(Std.int(floor.width * .5));
			floor.antialiasing = FlxG.save.data.antialiasing;
			floor.scrollFactor.set(1, 1);
			floor.active = false;
			add(floor);

			eyeflower = new FlxSprite(-200,300);
			eyeflower.frames = Paths.getSparrowAtlas('exe/LordXStage/ANIMATEDeye', 'shared');
			eyeflower.animation.addByPrefix('animatedeye', 'EyeAnimated', 24);
			eyeflower.setGraphicSize(Std.int(eyeflower.width * 2));
			eyeflower.antialiasing = FlxG.save.data.antialiasing;
			eyeflower.scrollFactor.set(1, 1);
			add(eyeflower);

			
			hands = new FlxSprite(-200, -600); 
			hands.frames = Paths.getSparrowAtlas('exe/LordXStage/SonicXHandsAnimated', 'shared');
			hands.animation.addByPrefix('handss', 'HandsAnimated', 24);
			hands.setGraphicSize(Std.int(hands.width * .5));
			hands.antialiasing = FlxG.save.data.antialiasing;
			hands.scrollFactor.set(1, 1);
			add(hands);

			var smallflower:FlxSprite = new FlxSprite(-1900, -1006).loadGraphic(Paths.image('exe/LordXStage/oldsmallflower','shared'));
			smallflower.setGraphicSize(Std.int(smallflower.width * .5));
			smallflower.antialiasing = FlxG.save.data.antialiasing;
			smallflower.scrollFactor.set(1.005, 1.005);
			smallflower.active = false;
			add(smallflower);

			var smallflower:FlxSprite = new FlxSprite(-1900, -1006).loadGraphic(Paths.image('exe/LordXStage/oldsmallflower','shared'));
			smallflower.setGraphicSize(Std.int(smallflower.width * .5));
			smallflower.antialiasing = FlxG.save.data.antialiasing;
			smallflower.scrollFactor.set(1.005, 1.005);
			smallflower.active = false;
			add(smallflower);

			var smallflowe2:FlxSprite = new FlxSprite(-1900, -1006).loadGraphic(Paths.image('exe/LordXStage/oldsmallflowe2','shared'));
			smallflowe2.setGraphicSize(Std.int(smallflower.width * .5));
			smallflowe2.antialiasing = FlxG.save.data.antialiasing;
			smallflowe2.scrollFactor.set(1.005, 1.005);
			smallflowe2.active = false;
			add(smallflowe2);

			tree = new FlxSprite(1250, -50);
			tree.frames = Paths.getSparrowAtlas('exe/LordXStage/TreeAnimatedMoment', 'shared');
			tree.animation.addByPrefix('treeanimation', 'TreeAnimated', 24);
			tree.setGraphicSize(Std.int(tree.width * 2));
			tree.antialiasing = FlxG.save.data.antialiasing;
			tree.scrollFactor.set(1, 1);
			add(tree);
			}
		case 'room-space': 
			{
                defaultCamZoom = 0.8;
				curStage = 'room-space';
				
				var space:FlxSprite = new FlxSprite(-800, -370).loadGraphic(Paths.image('Outside_Space', 'shared'));
				space.setGraphicSize(Std.int(space.width * 0.8));
				space.antialiasing = FlxG.save.data.antialiasing;
				space.scrollFactor.set(0.8, 0.8);
				space.active = false;
				add(space);
				
				var spaceTex = Paths.getSparrowAtlas('BACKGROUND_space', 'shared');

				NHroom = new FlxSprite( -800, -370);
				NHroom.frames = spaceTex;
				NHroom.animation.addByPrefix('space', 'Wall Broken anim', 24, true);
				NHroom.animation.play('space');
				NHroom.setGraphicSize(Std.int(NHroom.width * 0.9));
				NHroom.antialiasing = FlxG.save.data.antialiasing;
				add(NHroom);
			}
		case 'boxing': 
			{
                defaultCamZoom = 0.9;
				curStage = 'boxing';
				var bg:FlxSprite = new FlxSprite(-400, -220).loadGraphic(Paths.image('bg_boxn'));
				bg.antialiasing = FlxG.save.data.antialiasing;
				bg.scrollFactor.set(0.8, 0.8);
				bg.active = false;
				add(bg);

				var bg_r:FlxSprite = new FlxSprite(-810, -380).loadGraphic(Paths.image('bg_boxr'));
				bg_r.antialiasing = FlxG.save.data.antialiasing;
				bg_r.scrollFactor.set(1, 1);
				bg_r.active = false;
				add(bg_r);

			}	
		case 'spookyBOO': 
			{
				curStage = 'spookyBOO';
				defaultCamZoom = 0.6;
				halloweenLevel = true;

				var bg:FlxSprite = new FlxSprite(-200, -100).loadGraphic(Paths.image('week2bgtaki'));
				bg.antialiasing = FlxG.save.data.antialiasing;
				add(bg);
			}	
		case 'void':
			{
				defaultCamZoom = 0.55;
				curStage = 'void';

				var white:FlxSprite = new FlxSprite().makeGraphic(FlxG.width * 5, FlxG.height * 5, FlxColor.WHITE);
				white.screenCenter();
				white.scrollFactor.set();
				add(white);

				var void:FlxSprite = new FlxSprite(0, 0);
				void.frames = Paths.getSparrowAtlas('The_void');
				void.animation.addByPrefix('move', 'VoidShift', 50, true);
				void.animation.play('move');
				void.setGraphicSize(Std.int(void.width * 2.5));
				void.screenCenter();
				void.y += 250;
				void.x += 55;
				void.antialiasing = FlxG.save.data.antialiasing;
				void.scrollFactor.set(0.7, 0.7);
				add(void);

				bgRocks = new FlxSprite(-1000, -700).loadGraphic(Paths.image('Void_Back'));
				bgRocks.setGraphicSize(Std.int(bgRocks.width * 0.5));
				bgRocks.antialiasing = FlxG.save.data.antialiasing;
				bgRocks.scrollFactor.set(0.7, 0.7);
				add(bgRocks);

				var frontRocks:FlxSprite = new FlxSprite(-1000, -600).loadGraphic(Paths.image('Void_Front'));
				//frontRocks.setGraphicSize(Std.int(frontRocks.width * 3));
				frontRocks.updateHitbox();
				frontRocks.antialiasing = FlxG.save.data.antialiasing;
				frontRocks.scrollFactor.set(0.9, 0.9);
				add(frontRocks);
			}	
				// SONG 1 STAGE
				case 'SONICstage':
					{
						defaultCamZoom = 1.0;
						curStage = 'SONICstage';

						var sSKY:FlxSprite = new FlxSprite(-222, -16 + 150).loadGraphic(Paths.image('exe/P1/SKY'));
						sSKY.antialiasing = FlxG.save.data.antialiasing;
						sSKY.scrollFactor.set(1, 1);
						sSKY.active = false;
						add(sSKY);

						var hills:FlxSprite = new FlxSprite(-264, -156 + 150).loadGraphic(Paths.image('exe/P1/HILLS'));
						hills.antialiasing = FlxG.save.data.antialiasing;
						hills.scrollFactor.set(1.1, 1);
						hills.active = false;
						add(hills);

						var bg2:FlxSprite = new FlxSprite(-345, -289 + 170).loadGraphic(Paths.image('exe/P1/FLOOR2'));
						bg2.updateHitbox();
						bg2.antialiasing = FlxG.save.data.antialiasing;
						bg2.scrollFactor.set(1.2, 1);
						bg2.active = false;
						add(bg2);

						var bg:FlxSprite = new FlxSprite(-297, -246 + 150).loadGraphic(Paths.image('exe/P1/FLOOR1'));
						bg.antialiasing = FlxG.save.data.antialiasing;
						bg.scrollFactor.set(1.3, 1);
						bg.active = false;
						add(bg);

						var eggman:FlxSprite = new FlxSprite(-218, -219 + 150).loadGraphic(Paths.image('exe/P1/EGGMAN'));
						eggman.updateHitbox();
						eggman.antialiasing = FlxG.save.data.antialiasing;
						eggman.scrollFactor.set(1.32, 1);
						eggman.active = false;

						add(eggman);

						var tail:FlxSprite = new FlxSprite(-199 - 150, -259 + 150).loadGraphic(Paths.image('exe/P1/TAIL'));
						tail.updateHitbox();
						tail.antialiasing = FlxG.save.data.antialiasing;
						tail.scrollFactor.set(1.34, 1);
						tail.active = false;

						add(tail);

						var knuckle:FlxSprite = new FlxSprite(185 + 100, -350 + 150).loadGraphic(Paths.image('exe/P1/KNUCKLE'));
						knuckle.updateHitbox();
						knuckle.antialiasing = FlxG.save.data.antialiasing;
						knuckle.scrollFactor.set(1.36, 1);
						knuckle.active = false;

						add(knuckle);

						var sticklol:FlxSprite = new FlxSprite(-100, 50);
						sticklol.frames = Paths.getSparrowAtlas('TailsSpikeAnimated');
						sticklol.animation.addByPrefix('a', 'Tails Spike Animated instance 1', 4, true);
						sticklol.setGraphicSize(Std.int(sticklol.width * 1.2));
						sticklol.updateHitbox();
						sticklol.antialiasing = FlxG.save.data.antialiasing;
						sticklol.scrollFactor.set(1.37, 1);

						add(sticklol);

						sticklol.animation.play('a', true);

						daJumpscare.frames = Paths.getSparrowAtlas('sonicJUMPSCARE', 'exe');
						daJumpscare.animation.addByPrefix('jump', 'sonicSPOOK', 24, false);
						add(daJumpscare);
						daJumpscare.animation.play('jump');
		
						daNoteStatic.frames = Paths.getSparrowAtlas('hitStatic');
						daNoteStatic.animation.addByPrefix('static', 'staticANIMATION', 24, false);
						daNoteStatic.animation.play('static');
		
						remove(daNoteStatic);
					}
				case 'OldsonicFUNSTAGE':
					{
							defaultCamZoom = 0.9;
							curStage = 'OldsonicFUNSTAGE';

							var funsky:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('exe/FunInfiniteStage/sonicFUNsky'));
							funsky.setGraphicSize(Std.int(funsky.width * 0.9));
							funsky.antialiasing = FlxG.save.data.antialiasing;
							funsky.scrollFactor.set(0.3, 0.3);
							funsky.active = false;
							add(funsky);

							var funfloor:FlxSprite = new FlxSprite(-600, -400).loadGraphic(Paths.image('exe/FunInfiniteStage/sonicFUNfloor'));
							funfloor.setGraphicSize(Std.int(funfloor.width * 0.9), Std.int(funfloor.height * 1.2));
							funfloor.antialiasing = FlxG.save.data.antialiasing;
							funfloor.scrollFactor.set(0.5, 0.5);
							funfloor.active = false;
							add(funfloor);

							var funpillars3:FlxSprite = new FlxSprite(-600, -0).loadGraphic(Paths.image('exe/FunInfiniteStage/sonicFUNpillars3'));
							funpillars3.setGraphicSize(Std.int(funpillars3.width * 0.7));
							funpillars3.antialiasing = FlxG.save.data.antialiasing;
							funpillars3.scrollFactor.set(0.6, 0.7);
							funpillars3.active = false;
							add(funpillars3);

							var funpillars2:FlxSprite = new FlxSprite(-600, -0).loadGraphic(Paths.image('exe/FunInfiniteStage/sonicFUNpillars2'));
							funpillars2.setGraphicSize(Std.int(funpillars2.width * 0.7));
							funpillars2.antialiasing = FlxG.save.data.antialiasing;
							funpillars2.scrollFactor.set(0.7, 0.7);
							funpillars2.active = false;
							add(funpillars2);

							funpillarts1ANIM = new FlxSprite(-400, 0);
							funpillarts1ANIM.frames = Paths.getSparrowAtlas('exe/FunInfiniteStage/FII_BG', 'shared');
							funpillarts1ANIM.animation.addByPrefix('bumpypillar', 'sonicboppers', 24);
							funpillarts1ANIM.setGraphicSize(Std.int(funpillarts1ANIM.width * 0.7));
							funpillarts1ANIM.antialiasing = FlxG.save.data.antialiasing;
							funpillarts1ANIM.scrollFactor.set(0.82, 0.82);
							add(funpillarts1ANIM);

						
					}	
			case 'zardy':
					defaultCamZoom = 0.9;
					curStage = 'zardy';
					zardyBackground = new FlxSprite(-600, -200);
					zardyBackground.frames = Paths.getSparrowAtlas('Maze');
					zardyBackground.animation.addByPrefix('Maze','Stage', 16);
					zardyBackground.antialiasing = FlxG.save.data.antialiasing;
					zardyBackground.scrollFactor.set(0.9, 0.9);
					zardyBackground.animation.play('Maze');
					add(zardyBackground);	
			case 'hellstage':
			{
				curStage = 'hellstage';
				if (FlxG.save.data.happybob)
				{
					var bg:FlxSprite = new FlxSprite( -100).loadGraphic(Paths.image('happy/hell'));
				bg.updateHitbox();
				bg.active = false;
				bg.antialiasing = FlxG.save.data.antialiasing;
				bg.scrollFactor.set(0.1, 0.1);
				add(bg);
				
				var thingidk:FlxSprite = new FlxSprite( -271).loadGraphic(Paths.image('happy/middlething'));
				thingidk.updateHitbox();
				thingidk.active = false;
				thingidk.antialiasing = FlxG.save.data.antialiasing;
				thingidk.scrollFactor.set(0.3, 0.3);
				add(thingidk);
				
				var dead:FlxSprite = new FlxSprite( -60, 50).loadGraphic(Paths.image('happy/theydead'));
				dead.updateHitbox();
				dead.active = false;
				dead.antialiasing = FlxG.save.data.antialiasing;
				dead.scrollFactor.set(0.8, 0.8);
				add(dead);

				var ground:FlxSprite = new FlxSprite(-537, -158).loadGraphic(Paths.image('happy/ground'));
				ground.updateHitbox();
				ground.active = false;
				ground.antialiasing = FlxG.save.data.antialiasing;
				add(ground);
				
				bobmadshake = new FlxSprite( -198, -118).loadGraphic(Paths.image('happy/bobscreen'));
				bobmadshake.scrollFactor.set(0, 0);
				bobmadshake.visible = false;
				}
				else
				{
					var bg:FlxSprite = new FlxSprite( -100).loadGraphic(Paths.image('hell'));
				bg.updateHitbox();
				bg.active = false;
				bg.antialiasing = FlxG.save.data.antialiasing;
				bg.scrollFactor.set(0.1, 0.1);
				add(bg);
				
				var thingidk:FlxSprite = new FlxSprite( -271).loadGraphic(Paths.image('middlething'));
				thingidk.updateHitbox();
				thingidk.active = false;
				thingidk.antialiasing = FlxG.save.data.antialiasing;
				thingidk.scrollFactor.set(0.3, 0.3);
				add(thingidk);
				
				var dead:FlxSprite = new FlxSprite( -60, 50).loadGraphic(Paths.image('theydead'));
				dead.updateHitbox();
				dead.active = false;
				dead.antialiasing = FlxG.save.data.antialiasing;
				dead.scrollFactor.set(0.8, 0.8);
				add(dead);

				var ground:FlxSprite = new FlxSprite(-537, -158).loadGraphic(Paths.image('ground'));
				ground.updateHitbox();
				ground.active = false;
				ground.antialiasing = FlxG.save.data.antialiasing;
				add(ground);
				
				bobmadshake = new FlxSprite( -198, -118).loadGraphic(Paths.image('bobscreen'));
				bobmadshake.scrollFactor.set(0, 0);
				bobmadshake.visible = false;
				}
				
				bobsound = new FlxSound().loadEmbedded(Paths.sound('bobscreen'));
				
			}	
			case 'unknownfile':
				{
						curStage = 'unknownfile';
						FlxG.sound.cache(Paths.sound('crash', 'shared'));
						defaultCamZoom = 0.56;
	
						var bg:FlxSprite = new FlxSprite(-600, -300).loadGraphic(Paths.image('staticredbg'));
						bg.antialiasing = FlxG.save.data.antialiasing;
						bg.scrollFactor.set(0.2, 0.2);
						bg.setGraphicSize(Std.int(bg.width * 0.8));
						bg.updateHitbox();
						bg.scale.set(1.2, 1.2);
						add(bg);

						var bgbinary:FlxSprite = new FlxSprite(-600, -300).loadGraphic(Paths.image('binarycodebg'));
						bgbinary.antialiasing = FlxG.save.data.antialiasing;
						bgbinary.scrollFactor.set(0.2, 0.2);
						bgbinary.setGraphicSize(Std.int(bgbinary.width * 0.8));
						bgbinary.updateHitbox();
						bgbinary.scale.set(1.2, 1.2);
						add(bgbinary);
	
						var bg3d:FlxSprite = new FlxSprite(-600, -300).loadGraphic(Paths.image('3dbinary'));
						bg3d.antialiasing = FlxG.save.data.antialiasing;
						bg3d.scrollFactor.set(0.36, 0.36);
						bg3d.setGraphicSize(Std.int(bg3d.width * 0.8));
						bg3d.updateHitbox();
						bg3d.scale.set(1.2, 1.2);
						add(bg3d);
	
						var glitchy:FlxSprite = new FlxSprite(-600, -300).loadGraphic(Paths.image('bigF'));
						glitchy.antialiasing = FlxG.save.data.antialiasing;
						glitchy.scrollFactor.set(0.6, 0.6);
						glitchy.setGraphicSize(Std.int(glitchy.width * 0.8));
						glitchy.updateHitbox();
						glitchy.scale.set(1.2, 1.2);
						add(glitchy);
	
	
						var neatfloor:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('neatfloor'));
						neatfloor.antialiasing = FlxG.save.data.antialiasing;
						neatfloor.setGraphicSize(Std.int(neatfloor.width * 0.8));
						neatfloor.updateHitbox();
						neatfloor.scale.set(1.3, 1.3);
						add(neatfloor);
						FlxTransitionableState.skipNextTransIn = true;
						FlxTransitionableState.skipNextTransOut = true;
						
						// that moment when you forgot to set position
				}	
				case 'hillzoneSonic':
					{
					  defaultCamZoom = 1;
					  curStage = 'hillzoneSonic';
					  bg = new FlxSprite(-600, -200).loadGraphic(Paths.image('skytgt','shared'));
					  bg.antialiasing = FlxG.save.data.antialiasing;
					  bg.scrollFactor.set(0.4, 0.4);
					  bg.active = false;
					  add(bg);
			  
					  stageFront = new FlxSprite(-650, 600).loadGraphic(Paths.image('grasstgt','shared'));
					  stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
					  stageFront.updateHitbox();
					  stageFront.antialiasing = FlxG.save.data.antialiasing;
					  stageFront.scrollFactor.set(0.9, 0.9);
					  stageFront.active = false;
					  add(stageFront);
			  
					  stageCurtains = new FlxSprite(-450, -150).loadGraphic(Paths.image('foreground','shared'));
					  stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.87));
					  stageCurtains.updateHitbox();
					  stageCurtains.antialiasing = FlxG.save.data.antialiasing;
					  stageCurtains.scrollFactor.set(1.3, 1.3);
					  stageCurtains.active = false;
			  
					  add(stageCurtains);

					  var dad1 = new Character (20, 295, 'sonic-mad');
					  add(dad1);
					  remove(dad1);

					  var dad2 = new Character (20, 295, 'sonic-forced');
					  add(dad2);
					  remove(dad2);
					}
				case 'iglesia':
					{
						defaultCamZoom = 0.7;
						curStage = 'iglesia';
						stageFront = new FlxSprite(-550, -930).loadGraphic(Paths.image('base'));
						stageFront.setGraphicSize(Std.int(stageFront.width * 1.7));
						stageFront.setGraphicSize(Std.int(stageFront.height * 1.7));
						stageFront.updateHitbox();
						stageFront.antialiasing = FlxG.save.data.antialiasing;
						stageFront.scrollFactor.set(0.9, 0.9);
						stageFront.active = false;
						add(stageFront);
					}	
				case 'sonicFUNSTAGE':
					{
						defaultCamZoom = 0.9;
						curStage = 'sonicFUNSTAGE';

						var funsky:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('exe/FunInfiniteStage/sonicFUNsky'));
						funsky.setGraphicSize(Std.int(funsky.width * 0.9));
						funsky.antialiasing = FlxG.save.data.antialiasing;
						funsky.scrollFactor.set(0.3, 0.3);
						funsky.active = false;
						add(funsky);

						var funbush:FlxSprite = new FlxSprite(-42, 171).loadGraphic(Paths.image('exe/FunInfiniteStage/Bush2'));
						funbush.antialiasing = FlxG.save.data.antialiasing;
						funbush.scrollFactor.set(0.3, 0.3);
						funbush.active = false;
						add(funbush);

						funpillarts2ANIM = new FlxSprite(182, -100); // Zekuta why...
						funpillarts2ANIM.frames = Paths.getSparrowAtlas('exe/FunInfiniteStage/Majin Boppers Back', 'shared');
						funpillarts2ANIM.animation.addByPrefix('bumpypillar', 'MajinBop2 instance 1', 24);
						// funpillarts2ANIM.setGraphicSize(Std.int(funpillarts2ANIM.width * 0.7));
						funpillarts2ANIM.antialiasing = FlxG.save.data.antialiasing;
						funpillarts2ANIM.scrollFactor.set(0.6, 0.6);
						add(funpillarts2ANIM);

						var funbush2:FlxSprite = new FlxSprite(132, 354).loadGraphic(Paths.image('exe/FunInfiniteStage/Bush 1'));
						funbush2.antialiasing = FlxG.save.data.antialiasing;
						funbush2.scrollFactor.set(0.3, 0.3);
						funbush2.active = false;
						add(funbush2);

						funpillarts1ANIM = new FlxSprite(-169, -167);
						funpillarts1ANIM.frames = Paths.getSparrowAtlas('exe/FunInfiniteStage/Majin Boppers Front', 'shared');
						funpillarts1ANIM.animation.addByPrefix('bumpypillar', 'MajinBop1 instance 1', 24);
						// funpillarts1ANIM.setGraphicSize(Std.int(funpillarts1ANIM.width * 0.7));
						funpillarts1ANIM.antialiasing = FlxG.save.data.antialiasing;
						funpillarts1ANIM.scrollFactor.set(0.6, 0.6);
						add(funpillarts1ANIM);

						var funfloor:FlxSprite = new FlxSprite(-340, 660).loadGraphic(Paths.image('exe/FunInfiniteStage/floor BG'));
						funfloor.antialiasing = FlxG.save.data.antialiasing;
						funfloor.scrollFactor.set(0.5, 0.5);
						funfloor.active = false;
						add(funfloor);

						funboppers1ANIM = new FlxSprite(1126, 903);
						funboppers1ANIM.frames = Paths.getSparrowAtlas('exe/FunInfiniteStage/majin FG1', 'shared');
						funboppers1ANIM.animation.addByPrefix('bumpypillar', 'majin front bopper1', 24);
						funboppers1ANIM.antialiasing = FlxG.save.data.antialiasing;
						funboppers1ANIM.scrollFactor.set(0.8, 0.8);

						funboppers2ANIM = new FlxSprite(-293, 871);
						funboppers2ANIM.frames = Paths.getSparrowAtlas('exe/FunInfiniteStage/majin FG2', 'shared');
						funboppers2ANIM.animation.addByPrefix('bumpypillar', 'majin front bopper2', 24);
						funboppers2ANIM.antialiasing = FlxG.save.data.antialiasing;
						funboppers2ANIM.scrollFactor.set(0.8, 0.8);
					}
					case 'LordXStage': // epic
					{
						defaultCamZoom = 0.8;
						curStage = 'LordXStage';

						var sky:FlxSprite = new FlxSprite(-1900, -1006).loadGraphic(Paths.image('exe/LordXStage/sky'));
						sky.setGraphicSize(Std.int(sky.width * .5));
						sky.antialiasing = FlxG.save.data.antialiasing;
						sky.scrollFactor.set(1, 1);
						sky.active = false;
						add(sky);

						var hills1:FlxSprite = new FlxSprite(-1440, -806 + 200).loadGraphic(Paths.image('exe/LordXStage/hills1'));
						hills1.setGraphicSize(Std.int(hills1.width * .5));
						hills1.scale.x = 0.6;
						hills1.antialiasing = FlxG.save.data.antialiasing;
						hills1.scrollFactor.set(1.1, 1);
						hills1.active = false;
						add(hills1);

						var floor:FlxSprite = new FlxSprite(-1400, -496).loadGraphic(Paths.image('exe/LordXStage/floor'));
						floor.setGraphicSize(Std.int(floor.width * .5));
						floor.antialiasing = FlxG.save.data.antialiasing;
						floor.scrollFactor.set(1.5, 1);
						floor.scale.x = 1;
						floor.active = false;
						add(floor);

						eyeflower = new FlxSprite(100 - 500, 100);
						eyeflower.frames = Paths.getSparrowAtlas('exe/LordXStage/WeirdAssFlower_Assets', 'shared');
						eyeflower.animation.addByPrefix('animatedeye', 'flower', 30, true);
						eyeflower.setGraphicSize(Std.int(eyeflower.width * 0.8));
						eyeflower.antialiasing = FlxG.save.data.antialiasing;
						eyeflower.scrollFactor.set(1.5, 1);
						add(eyeflower);

						hands = new FlxSprite(100 - 300, -400 + 25);
						hands.frames = Paths.getSparrowAtlas('exe/LordXStage/NotKnuckles_Assets', 'shared');
						hands.animation.addByPrefix('handss', 'Notknuckles', 30, true);
						hands.setGraphicSize(Std.int(hands.width * .5));
						hands.antialiasing = FlxG.save.data.antialiasing;
						hands.scrollFactor.set(1.5, 1);
						add(hands);

						var smallflower:FlxSprite = new FlxSprite(-1500, -506).loadGraphic(Paths.image('exe/LordXStage/smallflower'));
						smallflower.setGraphicSize(Std.int(smallflower.width * .6));
						smallflower.antialiasing = FlxG.save.data.antialiasing;
						smallflower.scrollFactor.set(1.5, 1);
						smallflower.active = false;
						add(smallflower);

						var bFsmallflower:FlxSprite = new FlxSprite(-1500 + 300, -506 - 50).loadGraphic(Paths.image('exe/LordXStage/smallflower'));
						bFsmallflower.setGraphicSize(Std.int(bFsmallflower.width * .6));
						bFsmallflower.antialiasing = FlxG.save.data.antialiasing;
						bFsmallflower.scrollFactor.set(1.5, 1);
						bFsmallflower.active = false;
						bFsmallflower.flipX = true;
						add(bFsmallflower);

						var smallflowe2:FlxSprite = new FlxSprite(-1500, -506).loadGraphic(Paths.image('exe/LordXStage/smallflowe2'));
						smallflowe2.setGraphicSize(Std.int(smallflower.width * .6));
						smallflowe2.antialiasing = FlxG.save.data.antialiasing;
						smallflowe2.scrollFactor.set(1.5, 1);
						smallflowe2.active = false;
						add(smallflowe2);

						var tree:FlxSprite = new FlxSprite(-1900 + 650 - 100, -1006 + 350).loadGraphic(Paths.image('exe/LordXStage/tree'));
						tree.setGraphicSize(Std.int(tree.width * .7));
						tree.antialiasing = FlxG.save.data.antialiasing;
						tree.scrollFactor.set(1.5, 1);
						tree.active = false;
						add(tree);

						if (FlxG.save.data.distractions)
						{ // My brain is constantly expanding
							hands.animation.play('handss', true);
							eyeflower.animation.play('animatedeye', true);
						}
					}
				case 'sunkStage':
					{
						defaultCamZoom = 0.9;
						curStage = 'sunkStage';

						var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('exe/SunkBG', 'shared'));
						bg.setGraphicSize(Std.int(bg.width * 0.8));
						bg.antialiasing = FlxG.save.data.antialiasing;
						bg.scrollFactor.set(.91, .91);
						bg.x -= 670;
						bg.y -= 260;
						bg.active = false;
						add(bg);
					}
				case 'TDStage':
					{
						defaultCamZoom = 0.9;
						curStage = 'TDStage';

						bgspec = new FlxSprite().loadGraphic(Paths.image('exe/TailsBG', 'shared'));
						bgspec.setGraphicSize(Std.int(bgspec.width * 1.2));
						bgspec.antialiasing = FlxG.save.data.antialiasing;
						bgspec.scrollFactor.set(.91, .91);
						bgspec.x -= 370;
						bgspec.y -= 130;
						bgspec.active = false;
						add(bgspec);

						var bfdeathshit:FlxSprite = new FlxSprite(); // Yo what if i just preload the game over :)
						bfdeathshit.frames = Paths.getSparrowAtlas('3DGOpng');
						bfdeathshit.setGraphicSize(720, 720);
						bfdeathshit.animation.addByPrefix('firstdeath', 'DeathAnim', 24, false);
						bfdeathshit.screenCenter();
						bfdeathshit.animation.play('firstdeath');
						add(bfdeathshit);
						bfdeathshit.alpha = 0;
						bfdeathshit.animation.finishCallback = function(b:String)
						{
							remove(bfdeathshit);
						}
						dad = new Character(100, 100, 'TDollAlt');
						add(dad);
						remove(dad);
					}
				case 'stageSpook':
					{
						defaultCamZoom = 5;
						curStage = 'stageSpook';

						var bg:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('placeholder Hell'));
						bg.antialiasing = false;
						bg.scrollFactor.set(0.95, 0.95);
						bg.active = false;
						bg.setGraphicSize(Std.int(bg.width * 3));
						add(bg);

						theGuys = new FlxSprite(0, 0);
						theGuys.frames = Paths.getSparrowAtlas('people', 'shared');
						theGuys.animation.addByPrefix('TheGuys', 'the guys', 24);
						theGuys.antialiasing = false;
						theGuys.setGraphicSize(Std.int(theGuys.width * 3));
						theGuys.scrollFactor.set(0.95, 0.95);
						add(theGuys);

						dark = new FlxSprite().loadGraphic(Paths.image('dark'));
						dark.antialiasing = false;
						dark.setGraphicSize(Std.int(dark.width * 3));
						dark.scrollFactor.set(1, 1);
						dark.active = false;
					}
				case 'chamber': // fleetbal
					{
						defaultCamZoom = .7;
						curStage = 'chamber';

						wall = new FlxSprite(-2379.05, -1211.1);
						wall.frames = Paths.getSparrowAtlas('Wall');
						wall.animation.addByPrefix('a', 'Wall instance 1');
						wall.animation.play('a');
						wall.antialiasing = FlxG.save.data.antialiasing;
						wall.scrollFactor.set(1.1, 1.1);
						add(wall);

						floor = new FlxSprite(-2349, 921.25);
						floor.antialiasing = FlxG.save.data.antialiasing;
						add(floor);
						floor.frames = Paths.getSparrowAtlas('FleetFloor');
						floor.animation.addByPrefix('a', 'floor blue');
						floor.animation.addByPrefix('b', 'floor yellow');
						floor.animation.play('b', true);
						floor.animation.play('a', true); // whenever song starts make sure this is playing
						floor.scrollFactor.set(1.1, 1);
						floor.antialiasing = FlxG.save.data.antialiasing;

						fleetwaybgshit = new FlxSprite(-2629.05, -1344.05);
						add(fleetwaybgshit);
						fleetwaybgshit.frames = Paths.getSparrowAtlas('FleetwayBGshit');
						fleetwaybgshit.animation.addByPrefix('a', 'BGblue');
						fleetwaybgshit.animation.addByPrefix('b', 'BGyellow');
						fleetwaybgshit.animation.play('b', true);
						fleetwaybgshit.animation.play('a', true);
						fleetwaybgshit.antialiasing = FlxG.save.data.antialiasing;
						fleetwaybgshit.scrollFactor.set(1.1, 1);

						emeraldbeam = new FlxSprite(0, -1376.95 - 200);
						emeraldbeam.antialiasing = FlxG.save.data.antialiasing;
						emeraldbeam.frames = Paths.getSparrowAtlas('Emerald Beam');
						emeraldbeam.animation.addByPrefix('a', 'Emerald Beam instance 1', 24, true);
						emeraldbeam.animation.play('a');
						emeraldbeam.scrollFactor.set(1.1, 1);
						emeraldbeam.visible = true; // this starts true, then when sonic falls in and screen goes white, this turns into flase
						add(emeraldbeam);

						emeraldbeamyellow = new FlxSprite(-300, -1376.95 - 200);
						emeraldbeamyellow.antialiasing = FlxG.save.data.antialiasing;
						emeraldbeamyellow.frames = Paths.getSparrowAtlas('Emerald Beam Charged');
						emeraldbeamyellow.animation.addByPrefix('a', 'Emerald Beam Charged instance 1', 24, true);
						emeraldbeamyellow.animation.play('a');
						emeraldbeamyellow.scrollFactor.set(1.1, 1);
						emeraldbeamyellow.visible = false; // this starts off on false and whenever emeraldbeam dissapears, this turns true so its visible once song starts
						add(emeraldbeamyellow);

						var emeralds:FlxSprite = new FlxSprite(326.6, -191.75);
						emeralds.antialiasing = FlxG.save.data.antialiasing;
						emeralds.frames = Paths.getSparrowAtlas('Emeralds');
						emeralds.animation.addByPrefix('a', 'TheEmeralds instance 1', 24, true);
						emeralds.animation.play('a');
						emeralds.scrollFactor.set(1.1, 1);
						emeralds.antialiasing = FlxG.save.data.antialiasing;
						add(emeralds);

						thechamber = new FlxSprite(-225.05, 463.9);
						thechamber.frames = Paths.getSparrowAtlas('The Chamber');
						thechamber.animation.addByPrefix('a', 'Chamber Sonic Fall', 24, false);
						thechamber.scrollFactor.set(1.1, 1);
						thechamber.antialiasing = FlxG.save.data.antialiasing;

						pebles = new FlxSprite(-562.15 + 100, 1043.3);
						add(pebles);
						pebles.frames = Paths.getSparrowAtlas('pebles');
						pebles.animation.addByPrefix('a', 'pebles instance 1');
						pebles.animation.addByPrefix('b', 'pebles instance 2');
						pebles.animation.play('b', true);
						pebles.animation.play('a',
							true); // during cutscene this is gonna play first and then whenever the yellow beam appears, make it play "a"
						pebles.scrollFactor.set(1.1, 1);
						pebles.antialiasing = FlxG.save.data.antialiasing;

						porker = new FlxSprite(2880.15, -762.8);
						porker.frames = Paths.getSparrowAtlas('Porker Lewis');
						porker.animation.addByPrefix('porkerbop', 'Porker FG');

						porker.scrollFactor.set(1.4, 1);
						porker.antialiasing = FlxG.save.data.antialiasing;

						FlxG.bitmap.add(Paths.image('characters/fleetway1', 'shared'));
						FlxG.bitmap.add(Paths.image('characters/fleetway2', 'shared'));
						FlxG.bitmap.add(Paths.image('characters/fleetway3', 'shared'));
						FlxG.bitmap.add(Paths.image('Warning'));
						FlxG.bitmap.add(Paths.image('spacebar_icon'));
		
						var dad1:Character = new Character(0, 0, 'fleetway-extras');
						dad1.alpha = 0.01;
						add(dad1);
						remove(dad1);
		
						var dad2:Character = new Character(0, 0, 'fleetway-extras2');
						dad2.alpha = 0.01;
						add(dad2);
						remove(dad2);
		
						var dad3:Character = new Character(0, 0, 'fleetway-extras3');
						dad3.alpha = 0.01;
						add(dad3);
						remove(dad3);
		
						boyfriend = new Boyfriend(2040.55 - 200, 685.6 - 130, 'bf-super');
						add(boyfriend);
						remove(boyfriend);
		
						var poo4:FlxSprite = new FlxSprite();
						add(poo4);
						poo4.frames = Paths.getSparrowAtlas('Warning');
						poo4.animation.addByPrefix('a', 'Warning Flash', 24, false);
						poo4.animation.play('a', true);
						poo4.alpha = 0.01;
						remove(poo4);
		
						var poo1:FlxSprite = new FlxSprite();
						add(poo1);
						poo1.frames = Paths.getSparrowAtlas('spacebar_icon');
						poo1.animation.addByPrefix('a', 'spacebar', 24, false);
						poo1.animation.play('a', true);
						poo1.alpha = 0.01;
						remove(poo1);
					}
					case 'algebra':
						curStage = 'algebra';
						defaultCamZoom = 0.85;
						if (!FlxG.save.data.modchart)
							swagSpeed = 1.6;
						else
							swagSpeed = SONG.speed;
						var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('dave/algebraBg'));
						bg.setGraphicSize(Std.int(bg.width * 1.35), Std.int(bg.height * 1.35));
						bg.updateHitbox();
						//this is temp until good positioning gets done
						bg.screenCenter(); // no its not
						add(bg);
		
						daveJunk = new FlxSprite(424, 122).loadGraphic(Paths.image('dave/bgJunkers/dave'));
						davePiss = new FlxSprite(427, 94);
						davePiss.frames = Paths.getSparrowAtlas('dave/bgJunkers/davePiss');
						davePiss.animation.addByIndices('idle', 'GRR', [0], '', 0, false);
						davePiss.animation.addByPrefix('d', 'GRR', 24, false);
						davePiss.animation.play('idle');
		
						garrettJunk = new FlxSprite(237, 59).loadGraphic(Paths.image('dave/bgJunkers/bitch'));
						garrettJunk.y += 45;
		
						monitorJunk = new FlxSprite(960, 61).loadGraphic(Paths.image('dave/bgJunkers/rubyIsAngryRN'));
						monitorJunk.x += 275;
						monitorJunk.y += 75;
		
						diamondJunk = new FlxSprite(645, -16).loadGraphic(Paths.image('dave/bgJunkers/lanceyIsGoingToMakeAFakeLeakAndPostItInGeneral'));
						diamondJunk.x += 75;
		
						robotJunk = new FlxSprite(-160, 225).loadGraphic(Paths.image('dave/bgJunkers/myInternetJustWentOut'));
						robotJunk.x -= 250;
						robotJunk.y += 75;
		
						for (i in [diamondJunk, garrettJunk, daveJunk, davePiss, monitorJunk, robotJunk]) {
							//i.offset.set(i.getMidpoint().x - bg.getMidpoint().x, i.getMidpoint().y - bg.getMidpoint().y);
							i.scale.set(1.35, 1.35);
							//i.updateHitbox();
							//i.x += (i.getMidpoint().x - bg.getMidpoint().x) * 0.35;
							//i.y += (i.getMidpoint().y - bg.getMidpoint().y) * 0.35;
							i.visible = false;
							i.antialiasing = false;
							add(i);
						}
					case 'clubroomevil':
						{
							curStage = 'clubroomevil';
			
							defaultCamZoom = 0.8;
							var scale = 1;
							var posX = -250;
							var posY = -167;
			
							space = new FlxBackdrop(Paths.image('bigmonika/Sky', 'shared'), 0.1, 0.1);
							space.velocity.set(-10, 0);
							// space.scale.set(1.65, 1.65);
							add(space);
			
							var bg:FlxSprite = new FlxSprite(posX, posY).loadGraphic(Paths.image('bigmonika/BG', 'shared'));
							bg.antialiasing = FlxG.save.data.antialiasing;
							// bg.scale.set(2.3, 2.3);
							bg.scrollFactor.set(0.4, 0.6);
							add(bg);
			
							var stageFront:FlxSprite = new FlxSprite(-332, -77).loadGraphic(Paths.image('bigmonika/FG', 'shared'));
							stageFront.antialiasing = FlxG.save.data.antialiasing;
							// stageFront.scale.set(1.5, 1.5);
							stageFront.scrollFactor.set(1, 1);
							add(stageFront);
			
							dokipopup = new FlxSprite(312, 432);
							dokipopup.frames = Paths.getSparrowAtlas('bigmonika/bigika_delete', 'shared');
							dokipopup.animation.addByPrefix('idle', "PopUpAnim", 24, false);
							dokipopup.antialiasing = FlxG.save.data.antialiasing;
							dokipopup.scrollFactor.set(1, 1);
							dokipopup.setGraphicSize(Std.int(dokipopup.width * 1));
							dokipopup.updateHitbox();
							dokipopup.animation.play('idle', true);
							dokipopup.visible = false;
							}	
					case 'sanicStage':
						{
							defaultCamZoom = 0.9;
							curStage = 'sanicStage';
			
							var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('exe/sanicbg', 'shared'));
							bg.setGraphicSize(Std.int(bg.width * 1.2));
							bg.antialiasing = FlxG.save.data.antialiasing;
							bg.scrollFactor.set(.91, .91);
							bg.x -= 370;
							bg.y -= 130;
							bg.active = false;
							add(bg);
						}
					case 'ronhell':
						{
							defaultCamZoom = 0.9;
							curStage = 'ronhell';
							var bg:FlxSprite = new FlxSprite(300, 200).loadGraphic(Paths.image('madRon_ground'));
							bg.setGraphicSize(Std.int(bg.width * 5));
							bg.setGraphicSize(Std.int(bg.height * 5));
							bg.antialiasing = FlxG.save.data.antialiasing;
							bg.scrollFactor.set(0.9, 0.9);
							bg.active = false;
							add(bg);
							}
					case 'honor':
						{
							defaultCamZoom = 0.9;
							curStage = 'honor';
							var bg:FlxSprite = new FlxSprite(-400, 0).loadGraphic(Paths.image('honor'));
							bg.antialiasing = FlxG.save.data.antialiasing;
							bg.screenCenter(); // dont know how to position your bg? simple! just use Bg.screenCenter()!
							bg.scrollFactor.set(0.9, 0.9);
							bg.active = false;
							add(bg);
						}
					case 'slaught' :
						{
							defaultCamZoom = 0.9;
							curStage = 'slaught';
							var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('scary_sky'));
							bg.updateHitbox();
							bg.active = false;
							bg.antialiasing = FlxG.save.data.antialiasing;
							bg.scrollFactor.set(0.1, 0.1);
							add(bg);
							/*var glitchEffect = new FlxGlitchEffect(8,10,0.4,FlxGlitchDirection.HORIZONTAL);
							var glitchSprite = new FlxEffectSprite(bg, [glitchEffect]);
							add(glitchSprite);*/
								
							var ground:FlxSprite = new FlxSprite(-537, -158).loadGraphic(Paths.image('GlitchedGround'));
							ground.updateHitbox();
							ground.active = false;
							ground.antialiasing = FlxG.save.data.antialiasing;
							add(ground);
								
						}
					case 'woods':
						{
							defaultCamZoom = 0.7;
							curStage = 'woods';

							sky = new FlxSprite(0, 0, Paths.image('herosky'));
							sky.scale.x = 1.5;
							sky.scale.y = 1.5;
							sky.scrollFactor.set();
							sky.antialiasing = FlxG.save.data.antialiasing;
							sky.screenCenter();
							add(sky);
			
							woods = new FlxSprite(0, 0, Paths.image('woods'));
							woods.antialiasing = FlxG.save.data.antialiasing;
							woods.screenCenter();
							add(woods);
			
							/*lightning = new FlxSprite(0, 0);
							lightning.frames = Paths.getSparrowAtlas('woods/lightning');
							lightning.animation.addByPrefix('idle', 'null', 1);
							lightning.animation.addByPrefix('hit', 'strike', 24);
							lightning.animation.play('idle');
							lightning.screenCenter();
							lightning.updateHitbox();*/
						}
					case 'vecindario':
						{
							// i dont understand this language
							defaultCamZoom = 0.67;
							curStage = 'vecindario';

							bg = new FlxSprite(0, 0).loadGraphic(Paths.image('Destruido'));
							bg.antialiasing = FlxG.save.data.antialiasing;
							add(bg);
							
							var dad1 = new Character (700, 0, 'suicide');
							add(dad1);
							remove(dad1);
						}
					case 'daveHouse':
						{
							defaultCamZoom = 0.9;
							curStage = 'daveHouse';
							var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('davesky'));
							bg.antialiasing = FlxG.save.data.antialiasing;
							bg.scrollFactor.set(0.75, 0.75);
							bg.active = false;
			
							add(bg);
				
							var stageHills:FlxSprite = new FlxSprite(-225, -125).loadGraphic(Paths.image('davehills'));
							stageHills.setGraphicSize(Std.int(stageHills.width * 1.25));
							stageHills.updateHitbox();
							stageHills.antialiasing = FlxG.save.data.antialiasing;
							stageHills.scrollFactor.set(0.8, 0.8);
							stageHills.active = false;
							add(stageHills);
				
							var gate:FlxSprite = new FlxSprite(-200, -125).loadGraphic(Paths.image('gate'));
							gate.setGraphicSize(Std.int(gate.width * 1.2));
							gate.updateHitbox();
							gate.antialiasing = FlxG.save.data.antialiasing;
							gate.scrollFactor.set(0.9, 0.9);
							gate.active = false;

							add(gate);
				
							var stageFront:FlxSprite = new FlxSprite(-225, -125).loadGraphic(Paths.image('davegrass'));
							stageFront.setGraphicSize(Std.int(stageFront.width * 1.2));
							stageFront.updateHitbox();
							stageFront.antialiasing = FlxG.save.data.antialiasing;
							stageFront.active = false;
							
							add(stageFront);

							/*if (SONG.song.toLowerCase() == 'insanity')
							{
								var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('dave/redsky_insanity'));
								bg.alpha = 0.75;
								bg.active = true;
								bg.visible = false;
								add(bg);
								// below code assumes shaders are always enabled which is bad
								var testshader:Shaders.GlitchEffect = new Shaders.GlitchEffect();
								testshader.waveAmplitude = 0.1;
								testshader.waveFrequency = 5;
								testshader.waveSpeed = 2;
								bg.shader = testshader.shader;
								curbg = bg;
							}*/
						}
					case 'green-void':
						{
							defaultCamZoom = 0.9;
							curStage = 'green-void';
							var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('cheater'));
							bg.active = true;
							add(bg);
							// below code assumes shaders are always enabled which is bad
							// i wouldnt consider this an eyesore though
							var testshader:Shaders.GlitchEffect = new Shaders.GlitchEffect();
							testshader.waveAmplitude = 0.1;
							testshader.waveFrequency = 5;
							testshader.waveSpeed = 2;
							bg.shader = testshader.shader;
							curbg = bg;
						}
					case 'barnblitz-heavy':
						{
							defaultCamZoom = 0.82;
							curStage = 'barnblitz-heavy';
							var bg:FlxSprite = new FlxSprite(-400, -175).loadGraphic(Paths.image('barnblitz2'));
							bg.antialiasing = FlxG.save.data.antialiasing;
							bg.scrollFactor.set(0.9, 0.9);
							bg.active = false;
							add(bg);
						}
					case 'softmallEvil':
						{
							defaultCamZoom = 0.80;
							curStage = 'softmallEvil';
							var bg:FlxSprite = new FlxSprite(-400, -500).loadGraphic(Paths.image('softevilBG','shared'));
							bg.antialiasing = FlxG.save.data.antialiasing;
							bg.scrollFactor.set(0.2, 0.2);
							bg.active = false;
							bg.setGraphicSize(Std.int(bg.width * 0.8));
							bg.updateHitbox();
							add(bg);
				
							var evilTree:FlxSprite = new FlxSprite(300, -300).loadGraphic(Paths.image('softevilTree','shared'));
							evilTree.antialiasing = FlxG.save.data.antialiasing;
							evilTree.scrollFactor.set(0.2, 0.2);
							add(evilTree);
				
							var evilSnow:FlxSprite = new FlxSprite(-200, 700).loadGraphic(Paths.image("softevilSnow",'shared'));
							evilSnow.antialiasing = FlxG.save.data.antialiasing;
							add(evilSnow);
						}
					case 'hapenis': 
						{
							curStage = 'hapenis';
				
							defaultCamZoom = 0.75;
							var bfbg:FlxSprite = new FlxSprite(-600, -400).loadGraphic(Paths.image('BGB', 'shared'));
							bfbg.antialiasing = FlxG.save.data.antialiasing;
							bfbg.scrollFactor.set(0.9, 0.9);
							bfbg.active = false;
							add(bfbg);
						}
					case 'issue':
						{
							defaultCamZoom = 0.9;
							curStage = 'issue';
							var bg:FlxSprite = new FlxSprite(-300, -100).loadGraphic(Paths.image('badwatur'));
							bg.antialiasing = FlxG.save.data.antialiasing;
							bg.scrollFactor.set(0.9, 0.9);
							bg.active = false;
							add(bg);
			
							bottomBoppers = new FlxSprite(153, 186);
							bottomBoppers.frames = Paths.getSparrowAtlas('lol');
							bottomBoppers.animation.addByPrefix('lol', 'lol', 24, true);
							bottomBoppers.antialiasing = FlxG.save.data.antialiasing;
							bottomBoppers.scrollFactor.set(0.9, 0.9);
							add(bottomBoppers);	
						}
					case 'issue-two':
						{
							defaultCamZoom = 0.9;
							curStage = 'issue-two';
							var bg:FlxSprite = new FlxSprite(-300, -100).loadGraphic(Paths.image('upword'));
							bg.antialiasing = FlxG.save.data.antialiasing;
							bg.scrollFactor.set(0.9, 0.9);
							bg.active = false;
							add(bg);
			
							bottomBoppers = new FlxSprite(153, 186);
							bottomBoppers.frames = Paths.getSparrowAtlas('lol');
							bottomBoppers.animation.addByPrefix('lol', 'lol', 24, true);
							bottomBoppers.antialiasing = FlxG.save.data.antialiasing;
							bottomBoppers.scrollFactor.set(0.9, 0.9);
							add(bottomBoppers);	
						}
					case 'issue-three':
						{
							defaultCamZoom = 0.9;
							curStage = 'issue-three';
							var bg:FlxSprite = new FlxSprite(-300, -100).loadGraphic(Paths.image('swifwatur'));
							bg.antialiasing = FlxG.save.data.antialiasing;
							bg.scrollFactor.set(0.9, 0.9);
							bg.active = false;
							add(bg);
			
							bottomBoppers = new FlxSprite(153, 186);
							bottomBoppers.frames = Paths.getSparrowAtlas('lol');
							bottomBoppers.animation.addByPrefix('lol', 'lol', 24, true);
							bottomBoppers.antialiasing = FlxG.save.data.antialiasing;
							bottomBoppers.scrollFactor.set(0.9, 0.9);
							add(bottomBoppers);	
						}
					case 'bonus':
					{
						curStage = 'bonus';	
						defaultCamZoom = 0.95;
						//
						var whitebg:FlxSprite = new FlxSprite(-246,-181).loadGraphic(Paths.image('bonus/whitebg','shared'));
						//
						var mountains:FlxSprite = new FlxSprite(-120,-86).loadGraphic(Paths.image('bonus/mountains','shared'));			
						mountains.scrollFactor.set(0.5,0.5);
											
						//
						var house = Paths.getSparrowAtlas('bonus/house','shared');
						housesmoke.frames = house;
						housesmoke.animation.addByPrefix('house', 'house' ,24,true);
						housesmoke.animation.play('house');
						housesmoke.setPosition(382,-225);
						housesmoke.scrollFactor.set(0.9,0.9);
						//
						var ground:FlxSprite = new FlxSprite(-220,475).loadGraphic(Paths.image('bonus/base','shared'));
			
						///
						var yotsobaa = Paths.getSparrowAtlas('bonus/misc/yo','shared');
						scaredyo.frames = yotsobaa;
						scaredyo.animation.addByPrefix('aaaa', 'yotsuscaled' ,24,false);
						scaredyo.setPosition(housesmoke.x-150,ground.y-87);
						
						
						
						
						var botbro = Paths.getSparrowAtlas('bonus/misc/r9k','shared');
							r9k.frames = botbro;
							r9k.animation.addByPrefix('ded', 'r9k' ,24,false);
						
							r9k.setPosition(-150,0);					
						var blackbro = Paths.getSparrowAtlas('bonus/misc/black','shared');
							blackguy.frames = blackbro;
							blackguy.animation.addByPrefix('ded', 'black' ,24,false);
							blackguy.scale.set(1.2,1.2);
							
							blackguy.setPosition(-10,-10);					   									
						var smilebro = Paths.getSparrowAtlas('bonus/misc/smile','shared');
							unsmile.frames = smilebro;
							unsmile.animation.addByPrefix('ded', 'crawling' ,24,false);						
							
							unsmile.setPosition(-50,290);
						var catbro = Paths.getSparrowAtlas('bonus/misc/cat','shared');
							cat.frames = catbro;
							cat.animation.addByPrefix('ded', 'runnigcat' ,24,false);
							cat.scale.set(1.2,1.2);
							
							cat.setPosition(-60,-10);
						var autistic = Paths.getSparrowAtlas('bonus/can/scream','shared');	
							aaaaa.frames = autistic;			 
							aaaaa.animation.addByPrefix('aaaaaaaa','cancer_scream',24,false);
							aaaaa.scale.set(0.92,0.92);                
							
						    //layering
							add(whitebg);
							add(mountains);									
							add(housesmoke);													
							add(scaredyo);													
							add(ground);
							
					
					}
					case 'fleet':
					{
							defaultCamZoom = 0.92;
							curStage = 'fleet';
							sonicbg = new FlxSprite().loadGraphic(Paths.image('sonic'));
							sonicbg.antialiasing = FlxG.save.data.antialiasing;
							sonicbg.scrollFactor.set(0.9, 0.9);
							sonicbg.active = false;
							add(sonicbg);

							fleetbg = new FlxSprite().loadGraphic(Paths.image('fleet'));
							fleetbg.antialiasing = FlxG.save.data.antialiasing;
							fleetbg.scrollFactor.set(0.9, 0.9);
							fleetbg.active = false;
							add(fleetbg);
							remove(fleetbg);
							
							var boyfriend1 = new Character (20, 295, 'bf-fleetway-chaos');
							add(boyfriend);
							remove(boyfriend);
					}
					case 'SONICexestage': // i fixed the bgs and shit!!! - razencro part 1
					{
						defaultCamZoom = .9;
						curStage = 'SONICexestage';

						var sSKY:FlxSprite = new FlxSprite(-414, -440.8).loadGraphic(Paths.image('exe/SonicP2/sky'));
						sSKY.antialiasing = FlxG.save.data.antialiasing;
						sSKY.scrollFactor.set(1, 1);
						sSKY.active = false;
						sSKY.scale.x = 1.4;
						sSKY.scale.y = 1.4;
						add(sSKY);

						var trees:FlxSprite = new FlxSprite(-290.55, -298.3).loadGraphic(Paths.image('exe/SonicP2/backtrees'));
						trees.antialiasing = FlxG.save.data.antialiasing;
						trees.scrollFactor.set(1.1, 1);
						trees.active = false;
						trees.scale.x = 1.2;
						trees.scale.y = 1.2;
						add(trees);

						var bg2:FlxSprite = new FlxSprite(-306, -334.65).loadGraphic(Paths.image('exe/SonicP2/trees'));
						bg2.updateHitbox();
						bg2.antialiasing = FlxG.save.data.antialiasing;
						bg2.scrollFactor.set(1.2, 1);
						bg2.active = false;
						bg2.scale.x = 1.2;
						bg2.scale.y = 1.2;
						add(bg2);

						var bg:FlxSprite = new FlxSprite(-309.95, -240.2).loadGraphic(Paths.image('exe/SonicP2/ground'));
						bg.antialiasing = FlxG.save.data.antialiasing;
						bg.scrollFactor.set(1.3, 1);
						bg.active = false;
						bg.scale.x = 1.2;
						bg.scale.y = 1.2;
						add(bg);

						bgspec = new FlxSprite(-428.5 + 50 + 700, -449.35 + 25 + 392 + 105 + 50).loadGraphic(Paths.image("exe/SonicP2/GreenHill"));
						bgspec.antialiasing = false;
						bgspec.scrollFactor.set(1, 1);
						bgspec.active = false;
						bgspec.visible = false;
						bgspec.scale.x = 8;
						bgspec.scale.y = 8;
						add(bgspec);

						daNoteStatic.frames = Paths.getSparrowAtlas('hitStatic');
						daNoteStatic.animation.addByPrefix('static', 'staticANIMATION', 24, false);
						daNoteStatic.animation.play('static');
		
						remove(daNoteStatic);
		
						dad = new Character(100, 100, 'sonic.exe alt');
						add(dad);
						remove(dad);
					}
				case 'chantown':
					{
						curStage = 'chantown';
						defaultCamZoom = 0.93;

						var scrollshit:Float = 0.62;
						//
						var whitebg:FlxSprite = new FlxSprite(-375,-133).loadGraphic(Paths.image('V/whitebg','shared'));
						
						//
						var mountains:FlxSprite = new FlxSprite(-325,27).loadGraphic(Paths.image('V/mountains','shared'));
							mountains.scrollFactor.set(0.4, 0.4);				
						///
						var chantown:FlxSprite = new FlxSprite(-275,64).loadGraphic(Paths.image('V/homes','shared'));
							chantown.antialiasing = true;
							chantown.scrollFactor.set(0.6, 0.6);		
						///
							chinkMoot = new FlxTypedGroup<FakeMoot>();
						var bigBalls:FakeMoot = new FakeMoot(406,-75);
							bigBalls.scrollFactor.set(0.5, 0.5);			
							//
						var ground:FlxSprite = new FlxSprite(-309,498).loadGraphic(Paths.image('V/ground','shared'));					
							//
						var yotsuba = Paths.getSparrowAtlas('V/Backbros/yotsuba','shared');
							yotsu.frames = yotsuba;
							yotsu.animation.addByPrefix('standing', 'Ystanding' , 24);
							yotsu.animation.addByPrefix('sleeping',"Ysleeping", 24);
							yotsu.animation.addByPrefix('chilling',"Ysitting2", 24);
							//rare sprites 
							yotsu.animation.addByPrefix('sitting',"Ysitting0", 24);
							yotsu.animation.addByPrefix('dead',"ygrave", 24);						
							//
							yotsu.scale.set(0.85,0.85);							
							yotsu.scrollFactor.set(scrollshit, scrollshit);							
							yotsu.antialiasing =true;
							yotsu.updateHitbox();
							//
						var dumbman = Paths.getSparrowAtlas('V/Backbros/man','shared');
							man.frames = dumbman;
							man.animation.addByPrefix('lookaMan', 'man' ,24,false);
							man.scrollFactor.set(scrollshit, scrollshit);
							man.setPosition(145,296);
							man.updateHitbox();					
							//
						var xtanf = Paths.getSparrowAtlas('V/Backbros/xtan','shared');
							xtan.frames = xtanf;
							xtan.animation.addByPrefix('peakan', 'xtans' ,24,false);
							xtan.scrollFactor.set(scrollshit,scrollshit);
							xtan.setPosition(980,260);
							xtan.updateHitbox();
							xtan.scale.set(0.82,0.82);
							
							//
						var trvf = Paths.getSparrowAtlas('V/Backbros/trv','shared');
							trv.frames = trvf;
							trv.animation.addByPrefix('walkan', 'trv' ,24,false);
							trv.scrollFactor.set(scrollshit, scrollshit);
							trv.setPosition(232,280);
							trv.scale.set(0.8,0.8);
							trv.updateHitbox();
						
						///layering						
						add(whitebg);	
						if (songLowercase == 'sage'){add(trv);}
						add(mountains);				
						add(chinkMoot);
						chinkMoot.add(bigBalls);
						add(chantown);
						add(ground);
						add(yotsu);
						add(man);				
						add(xtan);		
						
						var choosesprite = FlxG.random.int(1,10);//rare ?

						if (songLowercase == 'sage')
							{															
						
								if (choosesprite == 5){yotsu.animation.play("sitting");	yotsu.setPosition(600,295);	}
								else{yotsu.animation.play("chilling");yotsu.setPosition(600,309);}																									
						
							}
						
						var fuu =  Paths.getSparrowAtlas('V/v/fuck','shared');
							FUCK.frames = fuu;
							FUCK.animation.addByPrefix('FFFFUU','vrage_ffff',24,false);
							FUCK.antialiasing = true;
						
						var vr1 = Paths.getSparrowAtlas('V/Backbros/vr','shared');
							vrtan1.frames = vr1;
							vrtan1.animation.addByPrefix('walkan', 'vr', 24, false);					
							vrtan1.setPosition(-300,350);
							vrtan1.scale.set(1.3,1.3);
							vrtan1.antialiasing = true;
						var vr2 = Paths.getSparrowAtlas('V/Backbros/vr2','shared');
							vrtan2.frames = vr2;
							vrtan2.animation.addByPrefix('funkan', 'vr2', 24, true);					
							vrtan2.setPosition(vrtan1.x,vrtan1.y);
							vrtan2.scale.set(1.3,1.3);
							vrtan2.antialiasing = true;
						
					
					}
					case 'TrioStage': // i fixed the bgs and shit!!! - razencro part 1
					{
						defaultCamZoom = .9;
						curStage = 'TrioStage';

						var sSKY:FlxSprite = new FlxSprite(-621.1, -395.65).loadGraphic(Paths.image('exe/Phase3/Glitch'));
						sSKY.antialiasing = true;
						sSKY.scrollFactor.set(0.9, 1);
						sSKY.active = false;
						sSKY.scale.x = 1.2;
						sSKY.scale.y = 1.2;
						add(sSKY);

						p3staticbg = new FlxSprite(0, 0);
						p3staticbg.frames = Paths.getSparrowAtlas('NewTitleMenuBG', 'shared');
						p3staticbg.animation.addByPrefix('P3Static', 'TitleMenuSSBG instance 1', 24, true);
						p3staticbg.animation.play('P3Static');
						p3staticbg.screenCenter();
						p3staticbg.scale.x = 4.5;
						p3staticbg.scale.y = 4.5;
						p3staticbg.visible = false;
						add(p3staticbg);

						var trees:FlxSprite = new FlxSprite(-607.35, -401.55).loadGraphic(Paths.image('exe/Phase3/Trees'));
						trees.antialiasing = true;
						trees.scrollFactor.set(0.95, 1);
						trees.active = false;
						trees.scale.x = 1.2;
						trees.scale.y = 1.2;
						add(trees);

						var bg2:FlxSprite = new FlxSprite(-623.5, -410.4).loadGraphic(Paths.image('exe/Phase3/Trees2'));
						bg2.updateHitbox();
						bg2.antialiasing = true;
						bg2.scrollFactor.set(1, 1);
						bg2.active = false;
						bg2.scale.x = 1.2;
						bg2.scale.y = 1.2;
						add(bg2);

						var bg:FlxSprite = new FlxSprite(-630.4, -266).loadGraphic(Paths.image('exe/Phase3/Grass'));
						bg.antialiasing = true;
						bg.scrollFactor.set(1.1, 1);
						bg.active = false;
						bg.scale.x = 1.2;
						bg.scale.y = 1.2;
						add(bg);

						bgspec = new FlxSprite(-428.5 + 50, -449.35 + 25).makeGraphic(2199, 1203, FlxColor.BLACK);
						bgspec.antialiasing = true;
						bgspec.scrollFactor.set(1, 1);
						bgspec.active = false;
						bgspec.visible = false;

						bgspec.scale.x = 1.2;
						bgspec.scale.y = 1.2;
						add(bgspec);

						daP3Static.frames = Paths.getSparrowAtlas('Phase3Static', 'shared');
						daP3Static.animation.addByPrefix('P3Static', 'Phase3Static instance 1', 24, false);
						add(daP3Static);
						daP3Static.animation.play('P3Static');
						remove(daP3Static);
		
						daNoteStatic.frames = Paths.getSparrowAtlas('hitStatic');
						daNoteStatic.animation.addByPrefix('static', 'staticANIMATION', 24, false);
						daNoteStatic.animation.play('static');
		
						remove(daNoteStatic);
		
						dad = new Character(61.15, -94.75, 'beast');
						add(dad);
						remove(dad);

						dad = new Character(61.15, -94.75, 'beast-cam-fix');
						add(dad);
						remove(dad);
		
						dad = new Character(61.15, -94.75, 'knucks');
						add(dad);
						remove(dad);
		
						dad = new Character(61.15, -94.75, 'eggdickface');
						add(dad);
						remove(dad);
		
						dad = new Character(61.15, -94.75, 'tails');
						add(dad);
						remove(dad);
		
						boyfriend = new Boyfriend(466.1, 685.6 - 300, 'bf-perspective-flipped');
						add(boyfriend);
						remove(boyfriend);
		
						boyfriend = new Boyfriend(466.1, 685.6 - 300, 'bf-perspective');
						add(boyfriend);
						remove(boyfriend);
					}
					case 'snake-spy':
						{
								defaultCamZoom = 0.82;
								curStage = 'snake-spy';
								var bg:FlxSprite = new FlxSprite(-400, -175).loadGraphic(Paths.image('snakewater3'));
								bg.antialiasing = true;
								bg.scrollFactor.set(0.9, 0.9);
								bg.active = false;
								add(bg);
						}
					case 'degroot':
						{
							defaultCamZoom = 0.82;
							curStage = 'degroot';
							var bg:FlxSprite = new FlxSprite(-425, -155).loadGraphic(Paths.image('degroot'));
							bg.antialiasing = true;
							bg.screenCenter(); // dont know how to position your bg? simple! just use Bg.screenCenter()!
							bg.scrollFactor.set(0.9, 0.9);
							bg.active = false;
							add(bg);
						}
					default:
						{
							defaultCamZoom = 0.9;
							curStage = 'stage';
							bg = new FlxSprite(-600, -200).loadGraphic(Paths.image('stageback'));
							bg.antialiasing = FlxG.save.data.antialiasing;
							bg.scrollFactor.set(0.9, 0.9);
							bg.active = false;
							add(bg);

							stageFront = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefront'));
							stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
							stageFront.updateHitbox();
							stageFront.antialiasing = FlxG.save.data.antialiasing;
							stageFront.scrollFactor.set(0.9, 0.9);
							stageFront.active = false;
							add(stageFront);

							stageCurtains = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagecurtains'));
							stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
							stageCurtains.updateHitbox();
							stageCurtains.antialiasing = FlxG.save.data.antialiasing;
							stageCurtains.scrollFactor.set(1.3, 1.3);
							stageCurtains.active = false;

							add(stageCurtains);
						}
			}
		}
		//defaults if no gf was found in chart
		var gfCheck:String = 'gf';
		
		if (SONG.gfVersion == null) {
			switch(storyWeek)
			{
				case 4: gfCheck = 'gf-car';
				case 5: gfCheck = 'gf-christmas';
				case 6: gfCheck = 'gf-pixel';
			}
		} else {gfCheck = SONG.gfVersion;}

		var curGf:String = '';
		switch (gfCheck)
		{
			case 'gf-car':
				curGf = 'gf-car';
			case 'gf-christmas':
				curGf = 'gf-christmas';
			case 'gf-pixel':
				curGf = 'gf-pixel';
			case 'gf-tied':
				curGf = 'gf-tied';
			case 'gf-itsumi':
				curGf = 'gf-itsumi';
			case 'gf-mii':
				curGf = 'gf-mii';
			case 'gf-tea':
				curGf = 'gf-tea';
			case 'gf-rocks':
				curGf = 'gf-rocks';		
			case 'gf-troll':
				curGf = 'gf-troll';
			case 'gf-tf2':
				curGf = 'gf-tf2';
			case 'gf-pixel-alt':
				curGf = 'gf-pixel-alt';
			case 'gf-v':
				curGf = 'gf-v';
			default:
				curGf = 'gf';
		}
		
		screenshader.waveAmplitude = 1;
		screenshader.waveFrequency = 2;
		screenshader.waveSpeed = 1;
		screenshader.shader.uTime.value[0] = new flixel.math.FlxRandom().float(-100000, 100000);

		gf = new Character(400, 130, curGf);
		if (curStage == 'void')
			{
				gf.scrollFactor.set(0.8, 0.8);
			}
		else if (curStage == 'SONICstage' || curStage == 'SONICexestage')
			{
				gf.scrollFactor.set(1.37, 1);
			}
		else
			{
				gf.scrollFactor.set(0.95, 0.95);
			}

		standersGroup = new FlxTypedGroup<FlxSprite>();
		add(standersGroup);

		if (SONG.song.toLowerCase() == 'algebra') {
			algebraStander('garrett', garrettStand, 500, 225); 
				algebraStander('og-dave-angey', daveStand, 250, 100); 
				algebraStander('hall-monitor', hallMonitorStand, 0, 100); 
				algebraStander('playrobot-scary', playRobotStand, 750, 100, false, true);
		}

		dad = new Character(100, 100, SONG.player2);

		var camPos:FlxPoint = new FlxPoint(dad.getGraphicMidpoint().x, dad.getGraphicMidpoint().y);

		repositionDad();

		switch (SONG.player2)
		{
			case 'gf':
				dad.setPosition(gf.x, gf.y);
				gf.visible = false;
				if (isStoryMode)
				{
					camPos.x += 600;
					tweenCamIn();
				}

			case "spooky":
				dad.y += 200;
			case "monster":
				dad.y += 100;
			case 'monster-christmas':
				dad.y += 130;
			case 'dad':
				camPos.x += 400;
			case 'pico':
				camPos.x += 600;
				dad.y += 300;
			case 'parents-christmas':
				dad.x -= 500;
			case 'senpai':
				dad.x += 150;
				dad.y += 360;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);
			case 'senpai-angry':
				dad.x += 150;
				dad.y += 360;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);
			case 'spirit':
				if (FlxG.save.data.distractions)
					{
						// trailArea.scrollFactor.set();
						if (!PlayStateChangeables.Optimize)
						{
							var evilTrail = new FlxTrail(dad, null, 4, 24, 0.3, 0.069);
							// evilTrail.changeValuesEnabled(false, false, false, false);
							// evilTrail.changeGraphic()
							add(evilTrail);
						}
						// evilTrail.scrollFactor.set(1.1, 1.1);
					}
				dad.x -= 150;
				dad.y += 100;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);
			case 'tricky':
				camPos.x += 400;
				camPos.y += 600;
			case 'extricky':
				dad.x -= 250;
				dad.y -= 365;
			case 'black':
				camPos.y += -200;
				camPos.x += 400;
				dad.y += 50;
				dad.x -= 400;
			case "henryangry":
				dad.y += 200;	
			case "neomonster":
				dad.y -= 100;
				dad.x -= 130;
			case "opheebop":
				dad.y += 100;
				camPos.x += 70;		
			case 'nonsense-god':
				dad.y -= 150;
				dad.x -= 200;	
			case 'mattangry':
				dad.y += 320;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);	
			case "taki":
				dad.y += 160;
				dad.x += 230;
			case 'agoti':
				camPos.x += 400;
				dad.y += 100;
				dad.x -= 100;
			case 'sonic':
				dad.x -= 130;
				dad.y += -50;
			case 'zardy':
				camPos.set(dad.getGraphicMidpoint().x, dad.getGraphicMidpoint().y + 240);
				dad.x -= 80;	
			case 'hellbob':
				camPos.x += 600;
				dad.y += 350;
			case 'redbald':
				dad.x = -375;
				dad.y = 100;	
			case 'bf-better':
				dad.y += 350;	
			case "sonic-tgt":
				dad.x -= 100;
				dad.y += 195;
			case "sonic-forced":
				dad.x -= 100;
				dad.y += 195;
			case "sonic-mad":
				dad.x -= 100;	
				dad.y += 195;	
			case 'selever_angry':
				if (FlxG.save.data.distractions/* && songLowercase == 'attack'*/) {
					// trailArea.scrollFactor.set();
					if (!PlayStateChangeables.Optimize)
					{
						var evilTrail = new FlxTrail(dad, null, 4, 12, 0.25, 0.069);
						evilTrail.framesEnabled = true;
						evilTrail.color = 0xaa0044;
						//evilTrail.changeValuesEnabled(false, false, false, false);
						// evilTrail.changeGraphic()
						add(evilTrail);
					}
					// evilTrail.scrollFactor.set(1.1, 1.1);
				}
				dad.x += -310;
				dad.y += 180;
				camPos.x += 330;
				camPos.y += -150;
			case 'sunky':
				dad.setGraphicSize(Std.int(dad.width * 0.2));
				dad.x -= 1840;
				dad.y += 80;
				dad.y -= 1500;	
			case 'boo':
				dad.x -= 150;
				dad.y += 200;
			case 'bigmonika':
				dad.x += 0;
				dad.y += 0;
				camPos.set(dad.getGraphicMidpoint().x - 100, dad.getGraphicMidpoint().y - 200);
			case 'hellron':
				dad.x += 70;
				dad.y += 250;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);
			case 'soldierai':
				dad.y += -125;
			case 'glitched-bob':
				camPos.x += 600;
				dad.y += 300;
			case 'smileeeeer':
				dad.x += -315;
				dad.y += 125;
				camPos.x += -120;
				camPos.y += 30;
			case 'suicide':
				dad.x += -215;
				dad.y += 115;
				camPos.x += -240;
				camPos.y += 30;
			case 'bambi-old':
				dad.y += 400;
			case 'bambi-3d':
				dad.y += 35;
				camPos.set(dad.getGraphicMidpoint().x, dad.getGraphicMidpoint().y + 150);
			case 'fairestmonster-christmas':
				gf.y += 10000;
				camPos.x += 600;
				camPos.y += 100;
			case 'happy':
				dad.y -= 25;
				camPos.set(dad.getGraphicMidpoint().x, dad.getGraphicMidpoint().y - 300);
			case 'snoiper':
				dad.y += 200;
				dad.x += -100;
			case 'cancer':
				dad.x = -210;
				dad.y = -25;
			case 'v-rage':
				dad.x = 35;
				dad.y = 225;	
			case 'tails':
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);
			case 'demoknight':
				dad.y += 120;
		}


		
		boyfriend = new Boyfriend(770, 450, SONG.player1);

		if (curStage == 'woods') // darkens bf and gf
			{
				var col:Int = 200;
				boyfriend.color = FlxColor.fromRGB(col,col,col);
				gf.color = FlxColor.fromRGB(col,col,col);
			}

		// REPOSITIONING PER STAGE
		switch (curStage)
		{
			case 'limo':
				boyfriend.y -= 220;
				boyfriend.x += 260;
				if(FlxG.save.data.distractions){
					resetFastCar();
					add(fastCar);
				}

			case 'mall':
				boyfriend.x += 200;

			case 'mallEvil':
				boyfriend.x += 320;
				dad.y -= 80;
			case 'school':
				boyfriend.x += 200;
				boyfriend.y += 220;
				gf.x += 180;
				gf.y += 300;
			case 'schoolEvil':
				boyfriend.x += 200;
				boyfriend.y += 220;
				gf.x += 180;
				gf.y += 300;
			case 'nevada':
				boyfriend.y -= 0;
				boyfriend.x += 260;
			case 'auditorHell':
				boyfriend.y -= 160;
				boyfriend.x += 350;
				gf.x += 345;
				gf.y -= 25;
			case 'illusion':
				boyfriend.x += 200;
				dad.x -= 100;
				dad.y -= 30;
			case 'OldLordXStage':
				dad.scale.x = 1.4;
				dad.scale.y = 1.4;
				dad.y += 50;
				boyfriend.y += 40;
				camPos.set(dad.getGraphicMidpoint().x + 200, dad.getGraphicMidpoint().y);
			case 'boxing':
				gf.x += 70;
				boyfriend.x += 130;	
			case 'spookyBOO':
				boyfriend.x = 1086.7;
				boyfriend.y = 604.7;
				gf.x = 524;
				gf.y = 245;
				gf.scrollFactor.set(1.0, 1.0);
					if (FlxG.save.data.distractions) {
						var evilTrail = new FlxTrail(dad, null, 4, 24, 0.3, 0.069);
						evilTrail.framesEnabled = false;
						add(evilTrail);
					}
			case 'void':
				boyfriend.y += 50;
				boyfriend.x += 100; 
				gf.y -= 250;	
			case 'SONICstage':
				boyfriend.y += 25;
				dad.y += 200;
				dad.x += 200;
				dad.scale.x = 1.1;
				dad.scale.y = 1.1;
				dad.scrollFactor.set(1.37, 1);
				boyfriend.scrollFactor.set(1.37, 1);
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y - 100);
			case 'OldsonicFUNSTAGE':
				boyfriend.y += 340;
				boyfriend.x += 80;
				dad.y += 450;
				gf.y += 300;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y - 200);
			case 'zardy':
				dad.y += 140;
				gf.y += 140;
				boyfriend.x += 80;
				boyfriend.y += 140;
			case 'unknownfile':
				boyfriend.x += 300;
				dad.x -= 300;
				gf.y += 10000;
			case 'iglesia':
				gf.y += 10;
				dad.y += 190;
				boyfriend.x += 190;
				boyfriend.y += 200;
			case 'sonicFUNSTAGE':
				boyfriend.y += 334;
				boyfriend.x += 80;
				dad.y += 470;
				gf.y += 300;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y - 200);
			case 'LordXStage':
				dad.y += 190 - 50;
				dad.x = -113 - 50;
				boyfriend.y += 150 - 25;
				boyfriend.x += 50;
				boyfriend.scale.x = 1.2;
				boyfriend.scale.y = 1.2;
				dad.scrollFactor.set(1.53, 1);
				boyfriend.scrollFactor.set(1.53, 1);
				camPos.set(dad.getGraphicMidpoint().x + 200, dad.getGraphicMidpoint().y);
			case 'sunkStage':
				boyfriend.x -= 100;
				dad.x = -180;
				dad.y = 200;
				dad.scale.x = 1;
				dad.scale.y = 1;
			case 'TDStage':
				dad.y += 230;
				dad.x -= 250;
			case 'stageSpook':
				boyfriend.y -= 100;
				boyfriend.x -= 80;
			case 'chamber':
				boyfriend.x = 2040.55;
				boyfriend.y = 685.6;

				dad.x = 61.15;
				dad.y = -94.75;

				dad.scrollFactor.set(1.1, 1);
				boyfriend.scrollFactor.set(1.1, 1);
			case 'clubroomevil':
				dad.x = 16;
				dad.y = -139;
				boyfriend.x = 16;
				boyfriend.y = -139;
				gf.y = 2000;
			case 'sanicStage':
				dad.y -= 560;
				dad.x -= 1000;
			case 'ronhell':
				if(FlxG.save.data.distractions){
				// trailArea.scrollFactor.set();
				var evilTrail = new FlxTrail(dad, null, 4, 24, 0.3, 0.069);
				// evilTrail.changeValuesEnabled(false, false, false, false);
				// evilTrail.changeGraphic()
				add(evilTrail);
				// evilTrail.scrollFactor.set(1.1, 1.1);
				}
			case 'honor':
				boyfriend.y += -100;
				gf.y -= 300;
			case 'woods':
				boyfriend.x += 225;
				boyfriend.y += 25;
				gf.x += 412.5;
				gf.y += 25;
				dad.y += 25;
			case 'vecindario':
				dad.y += 200;
				dad.x += 770;
				boyfriend.x += 770;
				boyfriend.y += 200;
			case 'barnblitz-heavy':
				gf.y -= 200;
			case 'softmallEvil':
				boyfriend.x += 320;
				boyfriend.y -=30;
				dad.x += 230;
				dad.y += 10;
				camPos.x += 400;
			case 'hapenis':
				boyfriend.y -= 300;
				boyfriend.x -= 800;
			case 'issue','issue-two','issue-three':
				gf.y -= 200;
			case 'bonus':
				boyfriend.setPosition(625,219);
			case 'fleet':
				dad.alpha = 0;
			case 'sonic.exe alt':
				camPos.set(dad.getGraphicMidpoint().x, dad.getGraphicMidpoint().y);
			case 'SONICexestage':

				dad.y -= 125;

				boyfriend.x = 1036 - 100;
				boyfriend.y = 300;

				dad.scrollFactor.set(1.37, 1);
				boyfriend.scrollFactor.set(1.37, 1);

				gf.x = 635.5 - 50 - 100;
				gf.y = 265.1 - 250;

				camPos.set(boyfriend.getGraphicMidpoint().x, boyfriend.getGraphicMidpoint().y);
			case 'chantown':
				boyfriend.setPosition(724,333);
				gf.setPosition(570,365);
			case 'TrioStage':
				dad.scrollFactor.set(1.1, 1);
				boyfriend.scrollFactor.set(1.1, 1);

				boyfriend.x = 466.1;
				boyfriend.y = 373.4;

				dad.x = -43.65;
				dad.y = 274.05 + 24;
				camPos.set(dad.getGraphicMidpoint().x, dad.getGraphicMidpoint().y);
			case 'snake-spy':
				gf.y -= 200;
		}
		if (!PlayStateChangeables.Optimize)
		{
			if (curStage == 'defeat' || curStage == 'illusion' || curStage == 'OldLordXStage' || curStage == 'OldsonicFUNSTAGE' || curStage == 'sonicFUNSTAGE' || curStage == 'LordXStage' || curStage == 'sunkStage' || curStage == 'TDStage' || curStage == 'stageSpook' || curStage == 'chamber' || curStage == 'algebra' || curStage == 'sanicStage' || curStage == 'vecindario' || curStage == 'bonus' || curStage == 'fleet' || curStage == 'TrioStage' || curStage == 'degroot')
				remove(gf);
			else
				add(gf);

			if (curStage == 'bonus')
				{
					add(dad);					 ///remember to NOT add(dad) for bonus below		 					
					r9k.visible=false;
					unsmile.visible=false;
					blackguy.visible=false;
					unsmile.visible=false;
					cat.visible=false;
					add(r9k);								
					add(blackguy);							
					add(unsmile);											
					add(cat);						
					add(boyfriend);
				}
			if (curStage == 'auditorHell')
				add(hole);
			// Shitty layering but whatev it works LOL
			if (curStage == 'limo')
				add(limo);

			add(dad);

			if (curStage == 'auditorHell')
				{
					// Clown init
					cloneOne = new FlxSprite(0,0);
					cloneTwo = new FlxSprite(0,0);
					cloneOne.frames = Paths.getSparrowAtlas('Clone', 'shared');
					cloneTwo.frames = Paths.getSparrowAtlas('Clone', 'shared');
					cloneOne.alpha = 0;
					cloneTwo.alpha = 0;
					cloneOne.animation.addByPrefix('clone','Clone',24,false);
					cloneTwo.animation.addByPrefix('clone','Clone',24,false);
		
					// cover crap
		
					add(cloneOne);
					add(cloneTwo);
					add(cover);
					add(converHole);
					add(dad.exSpikes);
				}

			add(boyfriend);

			if (SONG.song.toLowerCase() == 'epiphany')
				add(dokipopup);
	
			if (curStage == 'sonicFUNSTAGE')
				{
					add(funboppers1ANIM);
					add(funboppers2ANIM);
				}
			if (curStage == 'SONICstage')
				{
					add(bgspec);
				}
			if (curStage == 'arcade')
				{
					add(frontcrowd);
				}
			if (curStage == 'illusion')
				{
					add(fgFog);
				}
			if (curStage == 'nevada')
				{	
					add(MAINLIGHT);
				}
			if (curStage == 'stageSpook')
				{	
					add(dark);
				}
			if (curStage == 'chamber')
				{	
					add(thechamber);
					add(porker);
				}
			if (curStage == 'vecindario')
				{
					add(pantalla);
				}
			if (curStage == 'hapenis')
				{
					remove(dad);
					remove(boyfriend);
					remove(gf);
					add(boyfriend);
					var bgf:FlxSprite = new FlxSprite(-600, -400).loadGraphic(Paths.image('BGF', 'shared'));
					bgf.antialiasing = FlxG.save.data.antialiasing;
					bgf.scrollFactor.set(1, 1);
					bgf.active = false;
					add(bgf);
					add(dad);
					boyfriend.scrollFactor.set(0.9,0.9);
				}
		}

		if (loadRep)
		{
			FlxG.watch.addQuick('rep rpesses',repPresses);
			FlxG.watch.addQuick('rep releases',repReleases);
			// FlxG.watch.addQuick('Queued',inputsQueued);

			PlayStateChangeables.useDownscroll = rep.replay.isDownscroll;
			PlayStateChangeables.safeFrames = rep.replay.sf;
			PlayStateChangeables.botPlay = true;
		}

		trace('uh ' + PlayStateChangeables.safeFrames);

		trace("SF CALC: " + Math.floor((PlayStateChangeables.safeFrames / 60) * 1000));

		var doof:DialogueBox = new DialogueBox(false, dialogue);
		// doof.x += 70;
		// doof.y = FlxG.height * 0.5;
		doof.scrollFactor.set();
		doof.finishThing = startCountdown;

		Conductor.songPosition = -5000;

		var dreamscapeSongs = ["genesis"];

		if(dreamscapeSongs.contains(SONG.song.toLowerCase())){

			dreamscapeOuter = new FlxSprite().loadGraphic(Paths.image('dreamscapeOuter', "shared"));
			dreamscapeOuter.cameras = [camOverlay];
			dreamscapeOuter.screenCenter();
			add(dreamscapeOuter);

			dreamscape = new FlxSprite().loadGraphic(Paths.image('dreamscapeAnim.ss', "shared"), true, 1280, 720);
			dreamscape.animation.add("smoke", [0, 1, 2, 3, 4, 5], 8, true);
			dreamscape.animation.play("smoke");
			dreamscape.cameras = [camOverlay];
			dreamscape.screenCenter();
			add(dreamscape);

			switch(SONG.song.toLowerCase()){

				case "genesis":
					dreamscape.color = 0xFFFF9A9A;
					dreamscapeOuter.color = 0xFFFF9A9A;
					camOverlay.alpha = 0;

					

				default:

			}
		}
		
		strumLine = new FlxSprite(0, 50).makeGraphic(FlxG.width, 10);
		strumLine.scrollFactor.set();
		
		if (PlayStateChangeables.useDownscroll)
			strumLine.y = FlxG.height - 165;

		strumLineNotes = new FlxTypedGroup<FlxSprite>();
		add(strumLineNotes);
		add(noteSplashes);
		playerStrums = new FlxTypedGroup<FlxSprite>();
		cpuStrums = new FlxTypedGroup<FlxSprite>();

		// startCountdown();

		if (SONG.song == null)
			trace('song is null???');
		else
			trace('song looks gucci');

		generateSong(SONG.song);

		/*for(i in unspawnNotes)
			{
				var dunceNote:Note = i;
				notes.add(dunceNote);
				if (executeModchart)
				{
					if (!dunceNote.isSustainNote)
						dunceNote.cameras = [camNotes];
					else
						dunceNote.cameras = [camSustains];
				}
				else
				{
					dunceNote.cameras = [camHUD];
				}
			}
	
			if (startTime != 0)
				{
					var toBeRemoved = [];
					for(i in 0...notes.members.length)
					{
						var dunceNote:Note = notes.members[i];
		
						if (dunceNote.strumTime - startTime <= 0)
							toBeRemoved.push(dunceNote);
						else 
						{
							if (PlayStateChangeables.useDownscroll)
							{
								if (dunceNote.mustPress)
									dunceNote.y = (playerStrums.members[Math.floor(Math.abs(dunceNote.noteData))].y
										+ 0.45 * (startTime - dunceNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed,
											2)) - dunceNote.noteYOff;
								else
									dunceNote.y = (strumLineNotes.members[Math.floor(Math.abs(dunceNote.noteData))].y
										+ 0.45 * (startTime - dunceNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed,
											2)) - dunceNote.noteYOff;
							}
							else
							{
								if (dunceNote.mustPress)
									dunceNote.y = (playerStrums.members[Math.floor(Math.abs(dunceNote.noteData))].y
										- 0.45 * (startTime - dunceNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed,
											2)) + dunceNote.noteYOff;
								else
									dunceNote.y = (strumLineNotes.members[Math.floor(Math.abs(dunceNote.noteData))].y
										- 0.45 * (startTime - dunceNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed,
											2)) + dunceNote.noteYOff;
							}
						}
					}
		
					for(i in toBeRemoved)
						notes.members.remove(i);
				}*/

		trace('generated');

		// add(strumLine);

		camFollow = new FlxObject(0, 0, 1, 1);

		camFollow.setPosition(camPos.x, camPos.y);

		if (prevCamFollow != null)
		{
			camFollow = prevCamFollow;
			prevCamFollow = null;
		}

		add(camFollow);

		if (curSong.toLowerCase() == 'too slow')
			{
				FlxG.camera.follow(camFollow, LOCKON, 0.05 * (30 / (cast(Lib.current.getChildAt(0), Main)).getFPS()));
			}
		else if (curSong.toLowerCase() == 'old endless' || curSong.toLowerCase() == 'endless' || curSong.toLowerCase() == 'milk')
			{
				FlxG.camera.follow(camFollow, LOCKON, 0.04 * (30 / (cast (Lib.current.getChildAt(0), Main)).getFPS()));
			}
		else if (curSong.toLowerCase() == 'execution' || curSong.toLowerCase() == 'cycles')
			{
				FlxG.camera.follow(camFollow, LOCKON, 0.08 * (30 / (cast (Lib.current.getChildAt(0), Main)).getFPS()));
			}
		else if (curSong.toLowerCase() == 'sunshine')
			{
				if (FlxG.save.data.vfx)
				{
					var vcr:VCRDistortionShader;
					vcr = new VCRDistortionShader();
		
					var daStatic:FlxSprite = new FlxSprite(0, 0);
		
					daStatic.frames = Paths.getSparrowAtlas('daSTAT');
		
					daStatic.setGraphicSize(FlxG.width, FlxG.height);
		
					daStatic.alpha = 0.05;
		
					daStatic.screenCenter();
		
					daStatic.cameras = [camHUD2];
		
					daStatic.animation.addByPrefix('static', 'staticFLASH', 24, true);
		
					add(daStatic);
		
					daStatic.animation.play('static');
		
					camGame.setFilters([new ShaderFilter(vcr)]);
		
					camHUD2.setFilters([new ShaderFilter(vcr)]);
				}
		
				FlxG.camera.follow(camFollow, LOCKON, 0.06 * (30 / (cast(Lib.current.getChildAt(0), Main)).getFPS()));
			}	
		else if (curSong.toLowerCase() == 'chaos')
		{
			FlxG.camera.follow(camFollow, LOCKON, 0.06 * (30 / (cast(Lib.current.getChildAt(0), Main)).getFPS()));
		}
		else if (curSong.toLowerCase() == 'too fest')
			{
				camFollow.y = dad.getMidpoint().y + 700;
				camFollow.x = dad.getMidpoint().x + 700;
				FlxG.camera.follow(camFollow, LOCKON, 0.05 * (30 / (cast(Lib.current.getChildAt(0), Main)).getFPS()));
			}
		else if (curSong.toLowerCase() == 'you cant run')
			{
				FlxG.camera.follow(camFollow, LOCKON, 0.06 * (30 / (cast(Lib.current.getChildAt(0), Main)).getFPS()));
			}
		else if (curSong.toLowerCase() == 'triple trouble')
			{
				FlxG.camera.follow(camFollow, LOCKON, 0.12 * (30 / (cast(Lib.current.getChildAt(0), Main)).getFPS()));
			}
		FlxG.camera.follow(camFollow, LOCKON, 0.04 * (30 / (cast (Lib.current.getChildAt(0), Main)).getFPS()));
		// FlxG.camera.setScrollBounds(0, FlxG.width, 0, FlxG.height);
		FlxG.camera.zoom = defaultCamZoom;
		FlxG.camera.focusOn(camFollow.getPosition());

		FlxG.worldBounds.set(0, 0, FlxG.width, FlxG.height);

		FlxG.fixedTimestep = false;

		if (FlxG.save.data.songPosition) // I dont wanna talk about this code :(
			{
				songPosBG = new FlxSprite(0, 10).loadGraphic(Paths.image('healthBar'));
				if (PlayStateChangeables.useDownscroll)
					songPosBG.y = FlxG.height * 0.9 + 45; 
				songPosBG.screenCenter(X);
				songPosBG.scrollFactor.set();
				add(songPosBG);
				
				songPosBar = new FlxBar(songPosBG.x + 4, songPosBG.y + 4, LEFT_TO_RIGHT, Std.int(songPosBG.width - 8), Std.int(songPosBG.height - 8), this,
					'songPositionBar', 0, 90000);
				songPosBar.scrollFactor.set();
				songPosBar.createFilledBar(FlxColor.GRAY, FlxColor.LIME);
				add(songPosBar);
	
				var songName = new FlxText(songPosBG.x + (songPosBG.width / 2) - (SONG.song.length * 5),songPosBG.y,0,SONG.song, 16);
				if (PlayStateChangeables.useDownscroll)
					songName.y -= 3;
				if (SONG.song.toLowerCase() == 'algebra' || SONG.song.toLowerCase() == 'supernovae' || SONG.song.toLowerCase() == 'cheating' || curSong.toLowerCase() == 'piracy'){
					songName.setFormat(Paths.font("comic.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
				}
				else if (SONG.song.toLowerCase() == 'honorbound' || SONG.song.toLowerCase() == 'strongmann' || SONG.song.toLowerCase() == 'skill issue' || SONG.song.toLowerCase() == 'infiltrator' || SONG.song.toLowerCase() == 'eyelander'){
					songName.setFormat(Paths.font("tf2build.ttf"), 20, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
				}
				else{
					songName.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
				}
				
				songName.scrollFactor.set();
				add(songName);
				songName.cameras = [camHUD];
			}

		usernameTxt = new FlxText(29,640, 0, chatUsername);
		usernameTxt.scale.set(1.2, 1.2);
		usernameTxt.antialiasing = FlxG.save.data.antialiasing;

		usernameTxt.setFormat(Paths.font("tf2build.ttf"), 16, FlxColor.RED, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

		usernameTxt.scrollFactor.set();

		chatTxt = new FlxText(usernameTxt.x + 154, usernameTxt.y, chatText);
		chatTxt.scale.set(1.2, 1.2);
		chatTxt.antialiasing = FlxG.save.data.antialiasing;
		chatTxt.setFormat(Paths.font("tf2build.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		chatTxt.scrollFactor.set();

		healthBarBG = new FlxSprite(0, FlxG.height * 0.9).loadGraphic(Paths.image('healthBar'));
		if (PlayStateChangeables.useDownscroll)
			healthBarBG.y = 50;
		healthBarBG.screenCenter(X);
		healthBarBG.scrollFactor.set();
		add(healthBarBG);

		if (curSong == "Happiness")
			{
				healthBar = new FlxBar(healthBarBG.x + 4, healthBarBG.y + 4, LEFT_TO_RIGHT, Std.int(healthBarBG.width - 8), Std.int(healthBarBG.height - 8), this,
				'health', 0, 2);
				healthBar.scrollFactor.set();
				switch (SONG.song.toLowerCase())
				{
					default: { healthBar.createFilledBar(FlxColor.fromString('#' + dad.iconColor), FlxColor.fromString('#' + boyfriend.iconColor)); }
				}
			}
		else{
			healthBar = new FlxBar(healthBarBG.x + 4, healthBarBG.y + 4, RIGHT_TO_LEFT, Std.int(healthBarBG.width - 8), Std.int(healthBarBG.height - 8), this, 'health', 0, 2);
			healthBar.scrollFactor.set();
			healthBar.createFilledBar(FlxColor.fromString('#' + dad.iconColor), FlxColor.fromString('#' + boyfriend.iconColor));
		}

		// healthBar
		add(healthBar);

		overhealthBar = new FlxBar(healthBarBG.x + 4, healthBarBG.y + 4, RIGHT_TO_LEFT, Std.int(healthBarBG.width - 8), Std.int(healthBarBG.height - 8), this,
		'health', 2.2, 4);
		overhealthBar.scrollFactor.set();
		overhealthBar.createFilledBar(FlxColor.fromString('#' + dad.iconColor), FlxColor.fromString('#' + boyfriend.iconColor));
		// healthBar
		//add(overhealthBar);

		// Add Kade Engine watermark
		kadeEngineWatermark = new FlxText(4,healthBarBG.y + 50,0,SONG.song + " - " + CoolUtil.difficultyFromInt(storyDifficulty) + (Main.watermarks ? " | KE " + MainMenuState.kadeEngineVer : ""), 16);
		if (SONG.song.toLowerCase() == 'algebra' || SONG.song.toLowerCase() == 'supernovae' || SONG.song.toLowerCase() == 'cheating' || curSong.toLowerCase() == 'piracy'){
			kadeEngineWatermark.setFormat(Paths.font("comic.ttf"), 16, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		}
		else if (SONG.song.toLowerCase() == 'honorbound' || SONG.song.toLowerCase() == 'strongmann' || SONG.song.toLowerCase() == 'skill issue' || SONG.song.toLowerCase() == 'infiltrator' || SONG.song.toLowerCase() == 'eyelander'){
			kadeEngineWatermark.setFormat(Paths.font("tf2build.ttf"), 20, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		}
		else{
			kadeEngineWatermark.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		}
		kadeEngineWatermark.scrollFactor.set();
		add(kadeEngineWatermark);

		if (PlayStateChangeables.useDownscroll)
			kadeEngineWatermark.y = FlxG.height * 0.9 + 45;

		scoreTxt = new FlxText(FlxG.width / 2 - 235, healthBarBG.y + 50, 0, "", 20);

		scoreTxt.screenCenter(X);

		originalX = scoreTxt.x;

		scoreTxt.scrollFactor.set();
		
		if (SONG.song.toLowerCase() == 'algebra' || SONG.song.toLowerCase() == 'supernovae' || SONG.song.toLowerCase() == 'cheating' || curSong.toLowerCase() == 'piracy'){
			scoreTxt.setFormat(Paths.font("comic.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		}
		else if (SONG.song.toLowerCase() == 'honorbound' || SONG.song.toLowerCase() == 'strongmann' || SONG.song.toLowerCase() == 'skill issue' || SONG.song.toLowerCase() == 'infiltrator' || SONG.song.toLowerCase() == 'eyelander'){
			scoreTxt.setFormat(Paths.font("tf2build.ttf"), 20, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		}
		else{
			scoreTxt.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		}

		add(scoreTxt);

		replayTxt = new FlxText(healthBarBG.x + healthBarBG.width / 2 - 75, healthBarBG.y + (PlayStateChangeables.useDownscroll ? 100 : -100), 0, "REPLAY", 20);
		if (SONG.song.toLowerCase() == 'algebra' || SONG.song.toLowerCase() == 'supernovae' || SONG.song.toLowerCase() == 'cheating' || curSong.toLowerCase() == 'piracy'){
			replayTxt.setFormat(Paths.font("comic.ttf"), 42, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		}
		else if (SONG.song.toLowerCase() == 'honorbound' || SONG.song.toLowerCase() == 'strongmann' || SONG.song.toLowerCase() == 'skill issue' || SONG.song.toLowerCase() == 'infiltrator' || SONG.song.toLowerCase() == 'eyelander'){
			replayTxt.setFormat(Paths.font("tf2build.ttf"), 42, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		}
		else{
			replayTxt.setFormat(Paths.font("vcr.ttf"), 42, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		}
		
		replayTxt.borderSize = 4;
		replayTxt.borderQuality = 2;
		replayTxt.scrollFactor.set();
		if (loadRep)
		{
			add(replayTxt);
		}
		// Literally copy-paste of the above, fu
		if (SONG.song.toLowerCase() == 'honorbound' || SONG.song.toLowerCase() == 'strongmann' || SONG.song.toLowerCase() == 'skill issue' || SONG.song.toLowerCase() == 'infiltrator' || SONG.song.toLowerCase() == 'eyelander'){
			botPlayState = new FlxText(healthBarBG.x + healthBarBG.width / 2 - 75, healthBarBG.y + (PlayStateChangeables.useDownscroll ? 100 : -100), 0, "HI I AM VERY BAD AT THE GAME", 20);
		}
		else{
			botPlayState = new FlxText(healthBarBG.x + healthBarBG.width / 2 - 75, healthBarBG.y + (PlayStateChangeables.useDownscroll ? 100 : -100), 0, "BOTPLAY", 20);
		}
		if (SONG.song.toLowerCase() == 'algebra' || SONG.song.toLowerCase() == 'supernovae' || SONG.song.toLowerCase() == 'cheating' || curSong.toLowerCase() == 'piracy'){
			botPlayState.setFormat(Paths.font("comic.ttf"), 42, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		}
		else if (SONG.song.toLowerCase() == 'honorbound' || SONG.song.toLowerCase() == 'strongmann' || SONG.song.toLowerCase() == 'skill issue' || SONG.song.toLowerCase() == 'infiltrator' || SONG.song.toLowerCase() == 'eyelander'){
			botPlayState.setFormat(Paths.font("tf2build.ttf"), 42, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		}
		else{
			botPlayState.setFormat(Paths.font("vcr.ttf"), 42, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		}
		botPlayState.scrollFactor.set();
		botPlayState.borderSize = 4;
		botPlayState.borderQuality = 2;
		if(PlayStateChangeables.botPlay && !loadRep) add(botPlayState);

		iconP1 = new HealthIcon(SONG.player1, true);
		iconP1.y = healthBar.y - (iconP1.height / 2);
		add(iconP1);

		iconP2 = new HealthIcon(SONG.player2, false);
		iconP2.y = healthBar.y - (iconP2.height / 2);
		add(iconP2);
		if (curSong.toLowerCase() == 'phantasm')
			iconP2.alpha = 0;

		usernameTxt.alpha = 0;
		chatTxt.alpha = 0;
		
		add(usernameTxt);
		add(chatTxt);

		if (isRing)
			{
				if (FlxG.save.data.downscroll)
				{
					ringCounter = new FlxSprite(1133, 30).loadGraphic(Paths.image('Counter', 'shared'));
					add(ringCounter);
					ringCounter.cameras = [camHUD];
	
					counterNum = new FlxText(1207, 36, 0, '0', 10, false);
					counterNum.setFormat('EurostileTBla', 60, FlxColor.fromRGB(255, 204, 51), FlxTextBorderStyle.OUTLINE, FlxColor.fromRGB(204, 102, 0));
					counterNum.setBorderStyle(OUTLINE, FlxColor.fromRGB(204, 102, 0), 3, 1);
					add(counterNum);
					counterNum.cameras = [camHUD];
				}
				else
				{
					ringCounter = new FlxSprite(1133, 610).loadGraphic(Paths.image('Counter', 'shared'));
					add(ringCounter);
					ringCounter.cameras = [camHUD];
	
					counterNum = new FlxText(1207, 606, 0, '0', 10, false);
					counterNum.setFormat('EurostileTBla', 60, FlxColor.fromRGB(255, 204, 51), FlxTextBorderStyle.OUTLINE, FlxColor.fromRGB(204, 102, 0));
					counterNum.setBorderStyle(OUTLINE, FlxColor.fromRGB(204, 102, 0), 3, 1);
					add(counterNum);
					counterNum.cameras = [camHUD];
				}
			}

		noteSplashes.cameras = [camNotes];
		strumLineNotes.cameras = [camNotes];
		notes.cameras = [camNotes];
		healthBar.cameras = [camHUD];
		overhealthBar.cameras = [camHUD];
		healthBarBG.cameras = [camHUD];
		if(SONG.song.toLowerCase() == 'crucify')
			{
				moreDark = new FlxSprite(0, 0).loadGraphic(Paths.image('evenMOREdarkShit'));
				moreDark.cameras = [camHUD2];
				add(moreDark);
			}
		if(SONG.song.toLowerCase() == 'unknown suffering')
			{
				pantalla = new FlxSprite(0, 0);
				pantalla.frames = Paths.getSparrowAtlas('pantalla', 'shared');
				pantalla.animation.addByPrefix('oldpantalla', 'pantalla', 24);
				pantalla.cameras = [camHUD2];
				add(pantalla);
			}
		botPlayState.cameras = [camHUD];
		iconP1.cameras = [camHUD];
		iconP2.cameras = [camHUD];
		scoreTxt.cameras = [camHUD];
		usernameTxt.cameras = [camHUD];
		chatTxt.cameras = [camHUD];
		doof.cameras = [camHUD];
		startCircle.cameras = [camHUD2];
		startText.cameras = [camHUD2];
		blackFuck.cameras = [camHUD2];

		if (FlxG.save.data.songPosition)
		{
			songPosBG.cameras = [camHUD];
			songPosBar.cameras = [camHUD];
		}
		kadeEngineWatermark.cameras = [camHUD];
		if (loadRep)
			replayTxt.cameras = [camHUD];

		// if (SONG.song == 'South')
		// FlxG.camera.alpha = 0.7;
		// UI_camera.zoom = 1;

		// cameras = [FlxG.cameras.list[1]];
		startingSong = true;

		if (curStage == "nevada" || curStage == 'auditorHell')
			add(tstatic);

		if (curStage == 'auditorHell')
			tstatic.alpha = 0.1;

		if (curStage == 'auditorHell')
		{
			tstatic.setGraphicSize(Std.int(tstatic.width * 12));
			tstatic.x += 600;
		}
		
		trace('starting');

		if (isStoryMode)
		{
			switch (StringTools.replace(curSong," ", "-").toLowerCase())
			{
				case "winter-horrorland":
					var blackScreen:FlxSprite = new FlxSprite(0, 0).makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);
					add(blackScreen);
					blackScreen.scrollFactor.set();
					camHUD.visible = false;
					camNotes.visible = false;

					new FlxTimer().start(0.1, function(tmr:FlxTimer)
					{
						remove(blackScreen);
						FlxG.sound.play(Paths.sound('Lights_Turn_On'));
						camFollow.y = -2050;
						camFollow.x += 200;
						FlxG.camera.focusOn(camFollow.getPosition());
						FlxG.camera.zoom = 1.5;

						new FlxTimer().start(0.8, function(tmr:FlxTimer)
						{
							camHUD.visible = true;
							camNotes.visible = true;
							remove(blackScreen);
							FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 2.5, {
								ease: FlxEase.quadInOut,
								onComplete: function(twn:FlxTween)
								{
									startCountdown();
								}
							});
						});
					});
				case 'senpai':
					schoolIntro(doof);
				case 'roses':
					FlxG.sound.play(Paths.sound('ANGRY'));
					schoolIntro(doof);
				case 'thorns':
					schoolIntro(doof);
	
					default:
						startCountdown();
				}
			}
			else
					{
					if (curSong.toLowerCase() == 'epiphany'){
						epipdarkstart(doof);
					}
					else if (curSong.toLowerCase() == 'too slow')
					{
						startSong();
						startCountdown();
						add(blackFuck);
						startCircle.loadGraphic(Paths.image('StartScreens/CircleTooSlow', 'shared'));
						startCircle.x += 777;
						add(startCircle);
						startText.loadGraphic(Paths.image('StartScreens/TextTooSlow', 'shared'));
						startText.x -= 1200;
						add(startText);				
		
						new FlxTimer().start(0.6, function(tmr:FlxTimer)
						{
							FlxTween.tween(startCircle, {x: 0}, 0.5);
							FlxTween.tween(startText, {x: 0}, 0.5);
						});
						
						new FlxTimer().start(1.9, function(tmr:FlxTimer)
						{
							FlxTween.tween(startCircle, {alpha: 0}, 1);
							FlxTween.tween(startText, {alpha: 0}, 1);
							FlxTween.tween(blackFuck, {alpha: 0}, 1);
						});
					}	
					else if (curSong.toLowerCase() =='you cant run')
					{
						startSong();
						startCountdown();
						add(blackFuck);
						startCircle.loadGraphic(Paths.image('StartScreens/CircleYouCantRun', 'shared'));
						startCircle.x += 777;
						add(startCircle);
						startText.loadGraphic(Paths.image('StartScreens/TextYouCantRun', 'shared'));
						startText.x -= 1200;
						add(startText);
	
						new FlxTimer().start(0.6, function(tmr:FlxTimer)
						{
							FlxTween.tween(startCircle, {x: 0}, 0.5);
							FlxTween.tween(startText, {x: 0}, 0.5);
						});
	
						new FlxTimer().start(1.9, function(tmr:FlxTimer)
						{
							FlxTween.tween(startCircle, {alpha: 0}, 1);
							FlxTween.tween(startText, {alpha: 0}, 1);
							FlxTween.tween(blackFuck, {alpha: 0}, 1);
						});
					}
					else if (curSong.toLowerCase() =='triple trouble')
						{
							startCountdown();
							add(blackFuck);
							startCircle.loadGraphic(Paths.image('StartScreens/CircleTripleTrouble', 'shared'));
							startCircle.x += 777;
							add(startCircle);
							startText.loadGraphic(Paths.image('StartScreens/TextTripleTrouble', 'shared'));
							startText.x -= 1200;
							add(startText);
		
							new FlxTimer().start(0.6, function(tmr:FlxTimer)
							{
								FlxTween.tween(startCircle, {x: 0}, 0.5);
								FlxTween.tween(startText, {x: 0}, 0.5);
							});
		
							new FlxTimer().start(1.9, function(tmr:FlxTimer)
							{
								FlxTween.tween(startCircle, {alpha: 0}, 1);
								FlxTween.tween(startText, {alpha: 0}, 1);
								FlxTween.tween(blackFuck, {alpha: 0}, 1);
							});
						}
					else if (curSong.toLowerCase() == 'old endless' || curSong.toLowerCase() == 'endless')
					{
						add(blackFuck);
						startCircle.loadGraphic(Paths.image('StartScreens/CircleMajin', 'shared'));
						startCircle.x += 777;
						add(startCircle);
						startText.loadGraphic(Paths.image('StartScreens/TextMajin', 'shared'));
						startText.x -= 1200;
						add(startText);
						
						new FlxTimer().start(0.6, function(tmr:FlxTimer)
						{
							FlxTween.tween(startCircle, {x: 0}, 0.5);
							FlxTween.tween(startText, {x: 0}, 0.5);
						});
						
						new FlxTimer().start(1.9, function(tmr:FlxTimer)
							{
							FlxTween.tween(startCircle, {alpha: 0}, 1);
							FlxTween.tween(startText, {alpha: 0}, 1);
							FlxTween.tween(blackFuck, {alpha: 0}, 1);
						});
					}
					else if (curSong.toLowerCase() == 'cycles')
						{
							startSong();
							startCountdown();
							add(blackFuck);
							startCircle.loadGraphic(Paths.image('StartScreens/CircleCycles', 'shared'));
							startCircle.x += 777;
							add(startCircle);
							startText.loadGraphic(Paths.image('StartScreens/TextCycles', 'shared'));
							startText.x -= 1200;
							add(startText);
							
							new FlxTimer().start(0.6, function(tmr:FlxTimer)
							{
								FlxTween.tween(startCircle, {x: 0}, 0.5);
								FlxTween.tween(startText, {x: 0}, 0.5);
							});
							
							new FlxTimer().start(1.9, function(tmr:FlxTimer)
								{
								FlxTween.tween(startCircle, {alpha: 0}, 1);
								FlxTween.tween(startText, {alpha: 0}, 1);
								FlxTween.tween(blackFuck, {alpha: 0}, 1);
							});
		
						}
					else if (curSong.toLowerCase() == 'milk')
						{
							add(blackFuck);
							startCircle.loadGraphic(Paths.image('StartScreens/Sunky', 'shared'));
							startCircle.scale.x = 0;
							startCircle.x += 50;
							add(startCircle);
							new FlxTimer().start(0.6, function(tmr:FlxTimer)
							{
								FlxTween.tween(startCircle.scale, {x: 1}, 0.2, {ease: FlxEase.elasticOut});
								FlxG.sound.play(Paths.sound('flatBONK', 'shared'));
							});
				
							new FlxTimer().start(1.9, function(tmr:FlxTimer)
							{
								FlxTween.tween(blackFuck, {alpha: 0}, 1);
								FlxTween.tween(startCircle, {alpha: 0}, 1);
							});
						}
					else if (curSong.toLowerCase() == 'sunshine')
						{
							canPause = false;
							bgspec.visible = false;
							kadeEngineWatermark.visible = false;
							healthBarBG.visible = false;
							healthBar.visible = false;
							botPlayState.visible = false;
							iconP1.visible = false;
							iconP2.visible = false;
							scoreTxt.visible = false;
							boyfriend.alpha = 1;
							bgspec.visible = true;
							kadeEngineWatermark.visible = true;
							botPlayState.visible = true;
							healthBarBG.visible = true;
							healthBar.visible = true;
							iconP1.visible = true;
							iconP2.visible = true;
							scoreTxt.visible = true;
							var startthingy:FlxSprite = new FlxSprite();
				
							startthingy.frames = Paths.getSparrowAtlas('TdollStart', 'shared');
							startthingy.animation.addByPrefix('sus', 'Start', 24, false);
							startthingy.cameras = [camHUD2];
							add(startthingy);
							startthingy.screenCenter();
							var ready:FlxSprite = new FlxSprite().loadGraphic(Paths.image('tdsunshine/ready', 'shared'));
							var set:FlxSprite = new FlxSprite().loadGraphic(Paths.image('tdsunshine/set', 'shared'));
							var go:FlxSprite = new FlxSprite().loadGraphic(Paths.image('tdsunshine/go', 'shared'));
				
							ready.scale.x = 0.5; // i despise all coding.
							set.scale.x = 0.5;
							go.scale.x = 0.7;
							ready.scale.y = 0.5;
							set.scale.y = 0.5;
							go.scale.y = 0.7;
							ready.screenCenter();
							set.screenCenter();
							go.screenCenter();
							ready.cameras = [camHUD];
							set.cameras = [camHUD];
							go.cameras = [camHUD];
							var amongus:Int = 0;
				
							new FlxTimer().start(1, function(tmr:FlxTimer)
							{
								startthingy.animation.play('sus', true);
							});
				
							startthingy.animation.finishCallback = function(pog:String)
							{
								new FlxTimer().start(Conductor.crochet / 3000, function(tmr:FlxTimer)
								{
									switch (amongus)
									{
										case 0:
											startCountdown();
											add(ready);
											FlxTween.tween(ready.scale, {x: .9, y: .9}, Conductor.crochet / 500);
											FlxG.sound.play(Paths.sound('ready', 'shared'));
										case 1:
											ready.visible = false;
											add(set);
											FlxTween.tween(set.scale, {x: .9, y: .9}, Conductor.crochet / 500);
											FlxG.sound.play(Paths.sound('set', 'shared'));
										case 2:
											set.visible = false;
											add(go);
											FlxTween.tween(go.scale, {x: 1.1, y: 1.1}, Conductor.crochet / 500);
											FlxG.sound.play(Paths.sound('go', 'shared'));
										case 3:
											go.visible = false;
											canPause = true;
									}
									amongus += 1;
									if (amongus < 5)
										tmr.reset(Conductor.crochet / 700);
								});
							}
						}	
					else if (curSong.toLowerCase() == 'execution')
					{
						startSong();
						startCountdown();
						add(blackFuck);
						startCircle.loadGraphic(Paths.image('StartScreens/CircleExecution', 'shared'));
						startCircle.x += 777;
						add(startCircle);
						startText.loadGraphic(Paths.image('StartScreens/TextExectution', 'shared'));
						startText.x -= 1200;
						add(startText);
						
						new FlxTimer().start(0.6, function(tmr:FlxTimer)
						{
							FlxTween.tween(startCircle, {x: 0}, 0.5);
							FlxTween.tween(startText, {x: 0}, 0.5);
						});
						
						new FlxTimer().start(1.9, function(tmr:FlxTimer)
							{
							FlxTween.tween(startCircle, {alpha: 0}, 1);
							FlxTween.tween(startText, {alpha: 0}, 1);
							FlxTween.tween(blackFuck, {alpha: 0}, 1);
						});
	
					}
					else if (curSong.toLowerCase() == 'chaos')
						{
							FlxG.camera.zoom = defaultCamZoom;
							camHUD.visible = false;
							camNotes.visible = false;
							dad.visible = false;
							dad.setPosition(600, 400);
							camFollow.setPosition(900, 700);
							FlxG.camera.focusOn(camFollow.getPosition());
							new FlxTimer().start(0.5, function(lol:FlxTimer)
							{
									new FlxTimer().start(1, function(lol:FlxTimer)
									{
										FlxTween.tween(FlxG.camera, {zoom: 1.5}, 3, {ease: FlxEase.cubeOut});
										FlxG.sound.play(Paths.sound('robot', 'shared'));
										if (FlxG.save.data.flashing){
										FlxG.camera.flash(FlxColor.RED, 0.2);}
									});
									new FlxTimer().start(2, function(lol:FlxTimer)
									{
										FlxG.sound.play(Paths.sound('sonic', 'shared'));
										thechamber.animation.play('a');
									});
									new FlxTimer().start(6, function(lol:FlxTimer)
									{
										startCountdown();
										FlxG.sound.play(Paths.sound('beam', 'shared'));
										FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 0.2, {ease: FlxEase.cubeOut});
										FlxG.camera.shake(0.02, 0.2);
										if (FlxG.save.data.flashing){
											FlxG.camera.flash(FlxColor.WHITE, 0.2);}
										floor.animation.play('b');
										fleetwaybgshit.animation.play('b');
										pebles.animation.play('b');
										emeraldbeamyellow.visible = true;
										emeraldbeam.visible = false;
									});
							});
						}
					else if (curSong.toLowerCase() == 'infitrigger'){
						vmodintros();
					}
				switch (curSong.toLowerCase())
				{
					case 'sunshine','chaos','infitrigger','triple trouble':
					default:
						startCountdown();
				}
			}

		if (!loadRep)
			rep = new Replay("na");

		switch (curStage)
		{
			case 'hellstage':
				add(bobmadshake);
		}


		FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN,handleInput);
		FlxG.stage.addEventListener(KeyboardEvent.KEY_UP, releaseInput);

		super.create();
	}

	function vmodintros():Void
		{
             ///flx timer abuse
			switch(curSong.toLowerCase())
				{ 
								case'infitrigger':
									inScene = true;				
									camFollow.setPosition(boyfriend.getMidpoint().x -415, boyfriend.getMidpoint().y - 165);	
											FlxG.camera.zoom = 1.2;
											camHUD.visible = false; 	
											dad.visible = false;
											remove(boyfriend);
											var cancer1 = new FlxSprite(640,-40);
											cancer1.scale.set(0.85,0.85);
											cancer1.frames = Paths.getSparrowAtlas('bonus/intro/cancer1');
											cancer1.animation.addByPrefix('comehere','cancer_intro_1',24,false);
											cancer1.antialiasing = FlxG.save.data.antialiasing;
											add(cancer1);
											
											var cancer2 = new FlxSprite(dad.x,dad.y-89);
											cancer2.scale.set(0.92,0.92);
											cancer2.frames = Paths.getSparrowAtlas('bonus/intro/cancer2');
											cancer2.animation.addByPrefix('sit','cancer_intro_2',24,false);
											cancer2.antialiasing = FlxG.save.data.antialiasing;
											
											var boy = new FlxSprite(boyfriend.x,boyfriend.y);
											boy.frames = Paths.getSparrowAtlas('bonus/intro/bf');
											boy.animation.addByPrefix('sit','bf_intro',24,false);
											boy.antialiasing = FlxG.save.data.antialiasing;
											


											new FlxTimer().start(1, function(holdem:FlxTimer)
												{
													cancer1.animation.play('comehere');
													cancer1.animation.finishCallback = function(whitewhitty:String)
															{			
																FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom},1, {ease: FlxEase.quadInOut,
																	onComplete: function(twn:FlxTween)
																			{
																				new FlxTimer().start(1, function(holdem:FlxTimer)
																					{
																							add(boy);
																							 add(cancer2);
																							 boy.animation.play('sit');
																							 cancer2.animation.play('sit');
																							 cancer2.animation.finishCallback = function(lol:String)
																							 {	
																									boy.kill();
																									cancer2.kill();																						
																								    				
																									 dad.visible = true;
																									 add(boyfriend);
																									 new FlxTimer().start(0.3, function(startin:FlxTimer)
																										{
																											camHUD.visible = true;
																											startCountdown();			     	
																									    });
																						 
								}											 
							});
						}
					});																				
				} 
			});
		}
	}

	function vintageEffect()
		{
			remove(vintage);

			vintage = new FlxSprite(0, 0);

			vintage.frames = Paths.getSparrowAtlas('vintage');

			vintage.scale.set(3.0, 3.0);
	
			vintage.screenCenter();
	
			vintage.cameras = [camHUD2];

			vintage.animation.addByPrefix('idle', 'idle', 24, false);

			vintage.animation.play('idle', true);
	
			add(vintage);

			vintage.alpha = 0.8;

			FlxG.sound.play(Paths.sound('stat'), 0.3, false);
	
			FlxTween.tween(vintage, {alpha: 0}, 1, {ease: FlxEase.linear});

			new FlxTimer().start(1.01, function(trol:FlxTimer)
			{
				remove(vintage);
			});
		}

	function staticHitMiss()
		{
			trace('lol you missed the static note!');
			daNoteStatic = new FlxSprite(0, 0);
			daNoteStatic.frames = Paths.getSparrowAtlas('hitStatic');
	
			daNoteStatic.setGraphicSize(FlxG.width, FlxG.height);
	
			daNoteStatic.screenCenter();
	
			daNoteStatic.cameras = [camHUD2];
	
			daNoteStatic.animation.addByPrefix('static', 'staticANIMATION', 24, false);
	
			daNoteStatic.animation.play('static', true);
	
			shakeCam2 = true;
	
			new FlxTimer().start(0.8, function(tmr:FlxTimer)
			{
				shakeCam2 = false;
			});
	
			FlxG.sound.play(Paths.sound("hitStatic1"));
	
			add(daNoteStatic);
	
			new FlxTimer().start(.38, function(trol:FlxTimer) // fixed lmao
			{
				daNoteStatic.alpha = 0;
				trace('ended HITSTATICLAWL');
				remove(daNoteStatic);
			});
		}


	function doStaticSign(lestatic:Int = 0, leopa:Bool = true)
	{
		trace('static MOMENT HAHAHAH ' + lestatic);
		var daStatic:FlxSprite = new FlxSprite(0, 0);

		daStatic.frames = Paths.getSparrowAtlas('daSTAT');

		daStatic.setGraphicSize(FlxG.width, FlxG.height);

		daStatic.screenCenter();

		daStatic.cameras = [camHUD2];

		switch (lestatic)
		{
			case 0:
				daStatic.animation.addByPrefix('static', 'staticFLASH', 24, false);
		}
		add(daStatic);

		FlxG.sound.play(Paths.sound('staticBUZZ'));

		if (leopa)
		{
			if (daStatic.alpha != 0)
				daStatic.alpha = FlxG.random.float(0.1, 0.5);
		}
		else
			daStatic.alpha = 1;

		daStatic.animation.play('static');

		daStatic.animation.finishCallback = function(pog:String)
		{
			trace('ended static');
			remove(daStatic);
		}
	}

	function doSimpleJump()
	{
		trace('SIMPLE JUMPSCARE');

		var simplejump:FlxSprite = new FlxSprite().loadGraphic(Paths.image('simplejump', 'shared'));

		simplejump.setGraphicSize(FlxG.width, FlxG.height);

		simplejump.screenCenter();

		simplejump.cameras = [camHUD2];

		FlxG.camera.shake(0.0025, 0.50);

		add(simplejump);

		FlxG.sound.play(Paths.sound('sppok', 'shared'), 1);

		new FlxTimer().start(0.2, function(tmr:FlxTimer)
		{
			trace('ended simple jump');
			remove(simplejump);
		});

		// now for static

		var daStatic:FlxSprite = new FlxSprite(0, 0);

		daStatic.frames = Paths.getSparrowAtlas('daSTAT');

		daStatic.setGraphicSize(FlxG.width, FlxG.height);

		daStatic.screenCenter();

		daStatic.cameras = [camHUD2];

		daStatic.animation.addByPrefix('static', 'staticFLASH', 24, false);

		add(daStatic);

		FlxG.sound.play(Paths.sound('staticBUZZ'));

		if (daStatic.alpha != 0)
			daStatic.alpha = FlxG.random.float(0.1, 0.5);

		daStatic.animation.play('static');

		daStatic.animation.finishCallback = function(pog:String)
		{
			trace('ended static');
			remove(daStatic);
		}
	}

	function doP3JumpTAILS()
		{
			trace('SIMPLE JUMPSCARE');
	
			var doP3JumpTAILS:FlxSprite = new FlxSprite().loadGraphic(Paths.image('JUMPSCARES/Tails', 'shared'));
	
			doP3JumpTAILS.setGraphicSize(FlxG.width, FlxG.height);
	
			doP3JumpTAILS.screenCenter();
	
			doP3JumpTAILS.cameras = [camHUD2];
	
			FlxG.camera.shake(0.0025, 0.50);
	
			add(doP3JumpTAILS);
	
			FlxG.sound.play(Paths.sound('P3Jumps/TailsScreamLOL', 'shared'), .1);
	
			new FlxTimer().start(0.2, function(tmr:FlxTimer)
			{
				trace('ended simple jump');
				remove(doP3JumpTAILS);
			});
	
			balling.frames = Paths.getSparrowAtlas('daSTAT', 'shared');
			balling.animation.addByPrefix('static', 'staticFLASH', 24, false);
	
			balling.setGraphicSize(FlxG.width, FlxG.height);
	
			balling.screenCenter();
	
			balling.cameras = [camHUD2];
	
			add(balling);
	
			FlxG.sound.play(Paths.sound('staticBUZZ'));
	
			if (balling.alpha != 0)
				balling.alpha = FlxG.random.float(0.1, 0.5);
	
			balling.animation.play('static');
	
			balling.animation.finishCallback = function(pog:String)
			{
				trace('ended static');
				remove(balling);
			}
		}
	
		function doP3JumpKNUCKLES()
		{
			trace('SIMPLE JUMPSCARE');
	
			var doP3JumpKNUCKLES:FlxSprite = new FlxSprite().loadGraphic(Paths.image('JUMPSCARES/Knuckles', 'shared'));
	
			doP3JumpKNUCKLES.setGraphicSize(FlxG.width, FlxG.height);
	
			doP3JumpKNUCKLES.screenCenter();
	
			doP3JumpKNUCKLES.cameras = [camHUD2];
	
			FlxG.camera.shake(0.0025, 0.50);
	
			add(doP3JumpKNUCKLES);
	
			FlxG.sound.play(Paths.sound('P3Jumps/KnucklesScreamLOL', 'shared'), .1);
	
			new FlxTimer().start(0.2, function(tmr:FlxTimer)
			{
				trace('ended simple jump');
				remove(doP3JumpKNUCKLES);
			});
	
			balling.frames = Paths.getSparrowAtlas('daSTAT');
	
			balling.setGraphicSize(FlxG.width, FlxG.height);
	
			balling.screenCenter();
	
			balling.cameras = [camHUD2];
	
			balling.animation.addByPrefix('static', 'staticFLASH', 24, false);
	
			add(balling);
	
			FlxG.sound.play(Paths.sound('staticBUZZ'));
	
			if (balling.alpha != 0)
				balling.alpha = FlxG.random.float(0.1, 0.5);
	
			balling.animation.play('static');
	
			balling.animation.finishCallback = function(pog:String)
			{
				trace('ended static');
				remove(balling);
			}
		}
	
		function doP3JumpEGGMAN()
		{
			trace('SIMPLE JUMPSCARE');
	
			var doP3JumpEGGMAN:FlxSprite = new FlxSprite().loadGraphic(Paths.image('JUMPSCARES/Eggman', 'shared'));
	
			doP3JumpEGGMAN.setGraphicSize(FlxG.width, FlxG.height);
	
			doP3JumpEGGMAN.screenCenter();
	
			doP3JumpEGGMAN.cameras = [camHUD2];
	
			FlxG.camera.shake(0.0025, 0.50);
	
			add(doP3JumpEGGMAN);
	
			FlxG.sound.play(Paths.sound('P3Jumps/EggmanScreamLOL', 'shared'), .1);
	
			new FlxTimer().start(0.2, function(tmr:FlxTimer)
			{
				trace('ended simple jump');
				remove(doP3JumpEGGMAN);
			});
	
			balling.frames = Paths.getSparrowAtlas('daSTAT');
	
			balling.setGraphicSize(FlxG.width, FlxG.height);
	
			balling.screenCenter();
	
			balling.cameras = [camHUD2];
	
			balling.animation.addByPrefix('static', 'staticFLASH', 24, false);
	
			add(balling);
	
			FlxG.sound.play(Paths.sound('staticBUZZ'));
	
			if (balling.alpha != 0)
				balling.alpha = FlxG.random.float(0.1, 0.5);
	
			balling.animation.play('static');
	
			balling.animation.finishCallback = function(pog:String)
			{
				trace('ended static');
				remove(balling);
			}
		}

	function doJumpscare()
	{
		trace('JUMPSCARE aaaa');

		daJumpscare.frames = Paths.getSparrowAtlas('sonicJUMPSCARE', 'shared');
		daJumpscare.animation.addByPrefix('jump', 'sonicSPOOK', 24, false);

		daJumpscare.screenCenter();

		daJumpscare.scale.x = 1.1;
		daJumpscare.scale.y = 1.1;

		daJumpscare.y += 370;

		daJumpscare.cameras = [camHUD2];

		FlxG.sound.play(Paths.sound('jumpscare', 'shared'), 1);
		FlxG.sound.play(Paths.sound('datOneSound', 'shared'), 1);

		add(daJumpscare);

		daJumpscare.animation.play('jump');

		daJumpscare.animation.finishCallback = function(pog:String)
		{
			trace('ended jump');
			remove(daJumpscare);
		}
	}
		
			function swageffect(){
				var blood:FlxSprite = new FlxSprite();
				blood.frames = Paths.getSparrowAtlas('Effects_Assets');
				blood.animation.addByPrefix('sploosh', 'blood 1', 24, false);
				blood.setPosition(boyfriend.x + 225, boyfriend.y - 75);
				add(blood);
				blood.setGraphicSize(Std.int(blood.width * 2.35));
				blood.animation.play('sploosh');
				FlxTween.tween(blood, {alpha: 0}, 0.5, {
					ease: FlxEase.expoInOut,
						onComplete: function(twn:FlxTween)
						{
							remove(blood);
					}
				});
			}

			function laserThingy(first:Bool)
				{
					var s:Int = 0;
			
					FlxG.sound.play(Paths.sound('laser'));
			
					var warning:FlxSprite = new FlxSprite();
					warning.frames = Paths.getSparrowAtlas('Warning');
					warning.cameras = [camHUD2];
					warning.scale.set(0.5, 0.5);
					warning.screenCenter();
					warning.animation.addByPrefix('a', 'Warning Flash', 24, false);
					warning.alpha = 0;
					add(warning);
					canDodge = true;
			
					var dodgething:FlxSprite = new FlxSprite(0, 600);
					dodgething.frames = Paths.getSparrowAtlas('spacebar_icon');
					dodgething.animation.addByPrefix('a', 'spacebar', 24, false);
					dodgething.scale.x = .5;
					dodgething.scale.y = .5;
					dodgething.screenCenter();
					dodgething.x -= 60;
					dodgething.cameras = [camHUD2];
					add(dodgething);
			
					new FlxTimer().start(0, function(a:FlxTimer)
					{
						s++;
						warning.animation.play('a', true);
						if (s < 4)
							a.reset(0.32);
						else
							remove(warning);
						if (s == 3)
						{
							remove(dad);
							tailscircle = '';
							dodgething.animation.play('a', true);
							dad = new Character(61.15, -74.75, 'fleetway-extras3');
							add(dad);
							dad.playAnim('a', true);
							dad.animation.finishCallback = function(a:String)
							{
								remove(dad);
								tailscircle = 'hovering';
								dad = new Character(61.15, -94.75, 'fleetway');
								add(dad);
							}
						}
						else if (s == 4)
						{
							remove(dodgething);
						}
					});
				}

	function doStopSign(sign:Int = 0, fuck:Bool = false)
	{
		//trace('sign ' + sign);
		daSign = new FlxSprite(0,0);

		daSign.frames = Paths.getSparrowAtlas('Sign_Post_Mechanic');

		daSign.setGraphicSize(Std.int(daSign.width * 0.67));

		daSign.cameras = [camHUD2];

		switch(sign)
		{
			case 0:
				daSign.animation.addByPrefix('sign','Signature Stop Sign 1',24, false);
				daSign.x = FlxG.width - 650;
				daSign.angle = -90;
				daSign.y = -300;
			case 1:
				/*daSign.animation.addByPrefix('sign','Signature Stop Sign 2',20, false);
				daSign.x = FlxG.width - 670;
				daSign.angle = -90;*/ // this one just doesn't work???
			case 2:
				daSign.animation.addByPrefix('sign','Signature Stop Sign 3',24, false);
				daSign.x = FlxG.width - 780;
				daSign.angle = -90;
				if (FlxG.save.data.downscroll)
					daSign.y = -395;
				else
					daSign.y = -980;
			case 3:
				daSign.animation.addByPrefix('sign','Signature Stop Sign 4',24, false);
				daSign.x = FlxG.width - 1070;
				daSign.angle = -90;
				daSign.y = -145;
		}
		add(daSign);
		daSign.flipX = fuck;
		daSign.animation.play('sign');
		daSign.animation.finishCallback = function(pog:String)
			{
				//trace('ended sign');
				remove(daSign);
			}
	}		

	function canScream():Void
		{
			FlxG.camera.shake(0.009,1);           
			trace('cancer chimping out !!!!');
			
				remove(dad);
				aaaaa.setPosition(dad.x,dad.y);  
				add(aaaaa);
				aaaaa.animation.play('aaaaaaaa');
				aaaaa.animation.finishCallback = function(hh:String)
					{							
						remove(aaaaa);	
						add(dad);								
					}	
		}
		
	var totalDamageTaken:Float = 0;

	var shouldBeDead:Bool = false;

	var interupt = false;

	// basic explanation of this is:
	// get the health to go to
	// tween the gremlin to the icon
	// play the grab animation and do some funny maths,
	// to figure out where to tween to.
	// lerp the health with the tween progress
	// if you loose any health, cancel the tween.
	// and fall off.
	// Once it finishes, fall off.

	function doGremlin(hpToTake:Int, duration:Int,persist:Bool = false)
		{
			interupt = false;
	
			grabbed = true;

			canPause = false;
			
			totalDamageTaken = 0;
	
			var gramlan:FlxSprite = new FlxSprite(0,0);
	
			gramlan.frames = Paths.getSparrowAtlas('HP GREMLIN', 'shared');
	
			gramlan.setGraphicSize(Std.int(gramlan.width * 0.76));
	
			gramlan.cameras = [camHUD];
	
			gramlan.x = iconP1.x;
			gramlan.y = healthBarBG.y - 325;
	
			gramlan.animation.addByIndices('come','HP Gremlin ANIMATION',[0,1], "", 24, false);
			gramlan.animation.addByIndices('grab','HP Gremlin ANIMATION',[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24], "", 24, false);
			gramlan.animation.addByIndices('hold','HP Gremlin ANIMATION',[25,26,27,28],"",24);
			gramlan.animation.addByIndices('release','HP Gremlin ANIMATION',[29,30,31,32,33],"",24,false);
	
			gramlan.antialiasing = FlxG.save.data.antialiasing;
	
			add(gramlan);
	
			if(FlxG.save.data.downscroll){
				gramlan.flipY = true;
				gramlan.y -= 150;
			}
			
			// over use of flxtween :)
	
			var startHealth = health;
			var toHealth = (hpToTake / 100) * startHealth; // simple math, convert it to a percentage then get the percentage of the health
	
			var perct = toHealth / 2 * 100;
	
			trace('start: $startHealth\nto: $toHealth\nwhich is prect: $perct');
	
			var onc:Bool = false;
	
			FlxG.sound.play(Paths.sound('GremlinWoosh'));
	
			gramlan.animation.play('come');
			new FlxTimer().start(0.14, function(tmr:FlxTimer) {
				gramlan.animation.play('grab');
				FlxTween.tween(gramlan,{x: iconP1.x - 140},1,{ease: FlxEase.elasticIn, onComplete: function(tween:FlxTween) {
					trace('I got em');
					gramlan.animation.play('hold');
					FlxTween.tween(gramlan,{
						x: (healthBar.x + 
						(healthBar.width * (FlxMath.remapToRange(perct, 0, 100, 100, 0) * 0.01) 
						- 26)) - 75}, duration,
					{
						onUpdate: function(tween:FlxTween) { 
							// lerp the health so it looks pog
							if (interupt && !onc && !persist)
							{
								onc = true;
								trace('oh shit');
								gramlan.animation.play('release');
								gramlan.animation.finishCallback = function(pog:String) { gramlan.alpha = 0;}
							}
							else if (!interupt || persist)
							{
								var pp = FlxMath.lerp(startHealth,toHealth, tween.percent);
								if (pp <= 0)
									pp = 0.1;
								health = pp;
							}
	
							if (shouldBeDead)
								health = 0;
						},
						onComplete: function(tween:FlxTween)
						{
							if (interupt && !persist)
							{
								remove(gramlan);
								grabbed = false;
								canPause = true;
							}
							else
							{
								trace('oh shit');
								gramlan.animation.play('release');
								if (persist && totalDamageTaken >= 0.7)
									health -= totalDamageTaken; // just a simple if you take a lot of damage wtih this, you'll loose probably.
								gramlan.animation.finishCallback = function(pog:String) { remove(gramlan);}
								grabbed = false;
								canPause = true;
							}
						}
					});
				}});
			});
		}	
	
	var cloneOne:FlxSprite;
	var cloneTwo:FlxSprite;

	function doClone(side:Int)
	{
		switch(side)
		{
			case 0:
				if (cloneOne.alpha == 1)
					return;
				cloneOne.x = dad.x - 20;
				cloneOne.y = dad.y + 140;
				cloneOne.alpha = 1;

				cloneOne.animation.play('clone');
				cloneOne.animation.finishCallback = function(pog:String) {cloneOne.alpha = 0;}
			case 1:
				if (cloneTwo.alpha == 1)
					return;
				cloneTwo.x = dad.x + 390;
				cloneTwo.y = dad.y + 140;
				cloneTwo.alpha = 1;

				cloneTwo.animation.play('clone');
				cloneTwo.animation.finishCallback = function(pog:String) {cloneTwo.alpha = 0;}
		}

	}

	function epipdarkstart(?dialogueBox:DialogueBox):Void
		{
			remove(gf);
			remove(boyfriend);
			startCountdown();
		}
		
	function doP3Static()
		{
			trace('p3static XDXDXD');
	
			daP3Static.frames = Paths.getSparrowAtlas('Phase3Static', 'shared');
			daP3Static.animation.addByPrefix('P3Static', 'Phase3Static instance 1', 24, false);
		
			daP3Static.screenCenter();
		
			daP3Static.scale.x = 4;
			daP3Static.scale.y = 4;
			daP3Static.alpha = 0.5;
		
			daP3Static.cameras = [camHUD2];
		
			add(daP3Static);
		
			daP3Static.animation.play('P3Static');
	
			daP3Static.animation.finishCallback = function(pog:String)
			{
				trace('ended p3static');
				daP3Static.alpha = 0;
		
				remove(daP3Static);
			}
		}

	function schoolIntro(?dialogueBox:DialogueBox):Void
	{
		var black:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
		black.scrollFactor.set();
		add(black);

		var red:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, 0xFFff1b31);
		red.scrollFactor.set();

		var senpaiEvil:FlxSprite = new FlxSprite();
		senpaiEvil.frames = Paths.getSparrowAtlas('weeb/senpaiCrazy');
		senpaiEvil.animation.addByPrefix('idle', 'Senpai Pre Explosion', 24, false);
		senpaiEvil.setGraphicSize(Std.int(senpaiEvil.width * 6));
		senpaiEvil.scrollFactor.set();
		senpaiEvil.updateHitbox();
		senpaiEvil.screenCenter();

		if (StringTools.replace(PlayState.SONG.song, " ", "-").toLowerCase() == 'roses' || StringTools.replace(PlayState.SONG.song, " ", "-").toLowerCase() == 'thorns')
		{
			remove(black);

			if (StringTools.replace(PlayState.SONG.song, " ", "-").toLowerCase() == 'thorns')
			{
				add(red);
			}
		}

		new FlxTimer().start(0.3, function(tmr:FlxTimer)
		{
			black.alpha -= 0.15;

			if (black.alpha > 0)
			{
				tmr.reset(0.3);
			}
			else
			{
			if (dialogueBox != null)
			{
				inCutscene = true;
				add(dialogueBox);
					}
					else
						startCountdown();
				}
			});
		}


	var startTimer:FlxTimer;
	var perfectMode:Bool = false;

	var luaWiggles:Array<WiggleEffect> = [];

	#if windows
	public static var luaModchart:ModchartState = null;
	#end

	var keys = [false, false, false, false, false, false, false, false, false];

	function three():Void
		{
			var three:FlxSprite = new FlxSprite().loadGraphic(Paths.image('three', 'shared'));
			three.scrollFactor.set();
			three.updateHitbox();
			three.screenCenter();
			three.y -= 100;
			three.alpha = 0.5;
					add(three);
					FlxTween.tween(three, {y: three.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							three.destroy();
						}
					});
		}

	function two():Void
		{
			var two:FlxSprite = new FlxSprite().loadGraphic(Paths.image('two', 'shared'));
			two.scrollFactor.set();
			two.screenCenter();
			two.y -= 100;
			two.alpha = 0.5;
					add(two);
					FlxTween.tween(two, {y: two.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							two.destroy();
						}
					});
					
		}

		function one():Void
			{
				var one:FlxSprite = new FlxSprite().loadGraphic(Paths.image('one', 'shared'));
				one.scrollFactor.set();
				one.screenCenter();
				one.y -= 100;
				one.alpha = 0.5;

						add(one);
						FlxTween.tween(one, {y: one.y += 100, alpha: 0}, Conductor.crochet / 1000, {
							ease: FlxEase.cubeInOut,
							onComplete: function(twn:FlxTween)
							{
								one.destroy();
							}
						});
						
			}
	
	function gofun():Void
		{
			var gofun:FlxSprite = new FlxSprite().loadGraphic(Paths.image('gofun', 'shared'));
			gofun.scrollFactor.set();

			gofun.updateHitbox();

			gofun.screenCenter();
			gofun.y -= 100;
			gofun.alpha = 0.5;

					add(gofun);
					FlxTween.tween(gofun, {y: gofun.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							gofun.destroy();
						}
					});
		}

	function startCountdown():Void
	{
		ezTrail = new FlxTrail(dad, null, 2, 5, 0.3, 0.04);
		
		SONG.noteStyle = ChartingState.defaultnoteStyle;

		var theThing = curSong.toLowerCase();
		var doesitTween:Bool = false;

		inCutscene = false;
		inScene = false;

		switch (curSong) // null obj refrence so don't fuck with this
		{
			case "sunshine" | "infitrigger" | "triple trouble":

			default:
				generateStaticArrows(0);
				generateStaticArrows(1);
		}

		switch(mania) //moved it here because i can lol
		{
			case 0: 
				keys = [false, false, false, false];
			case 1: 
				keys = [false, false, false, false, false, false];
			case 2: 
				keys = [false, false, false, false, false, false, false, false, false];
			case 3: 
				keys = [false, false, false, false, false];
			case 4: 
				keys = [false, false, false, false, false, false, false];
			case 5: 
				keys = [false, false, false, false, false, false, false, false];
			case 6: 
				keys = [false];
			case 7: 
				keys = [false, false];
			case 8: 
				keys = [false, false, false];
		}
	
		


		#if windows
		// pre lowercasing the song name (startCountdown)
		var songLowercase = StringTools.replace(PlayState.SONG.song, " ", "-").toLowerCase();
		switch (songLowercase) {
			case 'dad-battle': songLowercase = 'dadbattle';
			case 'philly-nice': songLowercase = 'philly';
		}
		if (executeModchart)
		{
			luaModchart = ModchartState.createModchartState();
			luaModchart.executeState('start',[songLowercase]);
		}
		#end
		talking = false;
		startedCountdown = true;
		Conductor.songPosition = 0;
		Conductor.songPosition -= Conductor.crochet * 5;
		
		var swagCounter:Int = 0;
		
		startTimer = new FlxTimer().start(Conductor.crochet / 1000, function(tmr:FlxTimer)
		{
			if (curSong.toLowerCase() == 'onslaught')
			{
				if (curBeat <= 500)
				{
					dad.dance();
				}
			}
			dad.dance();
			gf.dance();
			boyfriend.playAnim('idle');
			
			var introAssets:Map<String, Array<String>> = new Map<String, Array<String>>();
			introAssets.set('default', ['ready', "set", "go"]);
			introAssets.set('school', ['weeb/pixelUI/ready-pixel', 'weeb/pixelUI/set-pixel', 'weeb/pixelUI/date-pixel']);
			introAssets.set('schoolEvil', ['weeb/pixelUI/ready-pixel', 'weeb/pixelUI/set-pixel', 'weeb/pixelUI/date-pixel']);
			introAssets.set('unknownfile', ['ready-baldi', 'set-baldi', 'go-baldi']);
			introAssets.set('chantown', ['vready', "vset", "vgo"]);
			introAssets.set('bonus', ['vready', "vset", "vgo"]);

			var introAlts:Array<String> = introAssets.get('default');
			var altSuffix:String = "";

			for (value in introAssets.keys())
			{
				if (value == curStage)
				{
					introAlts = introAssets.get(value);
					//altSuffix = '-pixel';
				}
			}
			if (SONG.song.toLowerCase() == 'honorbound' || SONG.song.toLowerCase() == 'strongmann' || SONG.song.toLowerCase() == 'skill issue' || SONG.song.toLowerCase() == 'infiltrator' || SONG.song.toLowerCase() == 'eyelander'){
				altSuffix = '-tf2';
			}
			if (SONG.song.toLowerCase() == 'piracy'){
				altSuffix = '-baldi';
			}

			switch (swagCounter)

			{
				case 0:
					if (curSong.toLowerCase() == 'piracy' || curSong.toLowerCase() == 'too slow' || curSong.toLowerCase() == 'you cant run' || curSong.toLowerCase() == 'triple trouble' || curSong.toLowerCase() == 'endless' || curSong.toLowerCase() == 'cycles' || curSong.toLowerCase() == 'milk' || curSong.toLowerCase() == 'sunshine' || curSong.toLowerCase() == 'old endless' || curSong.toLowerCase() == 'execution' || curSong.toLowerCase() == 'chaos' || curSong.toLowerCase() == 'too fest'){
						//FlxG.sound.play(Paths.sound('intro3' + altSuffix), 0.6);
					}
					else
					{

						FlxG.sound.play(Paths.sound('intro3' + altSuffix), 0.6);
					}
					if (curSong.toLowerCase() == 'infiltrator'){
						camHUD.visible = false;
						camNotes.visible = false;
					}
				case 1:
					if (curSong.toLowerCase() == 'too slow' || curSong.toLowerCase() == 'you cant run' || curSong.toLowerCase() == 'triple trouble' || curSong.toLowerCase() == 'endless' || curSong.toLowerCase() == 'cycles' || curSong.toLowerCase() == 'milk' || curSong.toLowerCase() == 'sunshine' || curSong.toLowerCase() == 'old endless' || curSong.toLowerCase() == 'execution' || curSong.toLowerCase() == 'chaos' || curSong.toLowerCase() == 'too fest'){
						//FlxG.sound.play(Paths.sound('intro3' + altSuffix), 0.6);
					}
					else
					{
					var ready:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[0]));
					ready.scrollFactor.set();
					ready.updateHitbox();

					if (curStage.startsWith('school'))
						ready.setGraphicSize(Std.int(ready.width * daPixelZoom));

					ready.screenCenter();
					add(ready);
					FlxTween.tween(ready, {y: ready.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							ready.destroy();
						}
					});
					FlxG.sound.play(Paths.sound('intro2' + altSuffix), 0.6);
					}
				case 2:
					if (curSong.toLowerCase() == 'too slow' || curSong.toLowerCase() == 'you cant run' || curSong.toLowerCase() == 'triple trouble' || curSong.toLowerCase() == 'endless' || curSong.toLowerCase() == 'cycles' || curSong.toLowerCase() == 'milk' || curSong.toLowerCase() == 'sunshine' || curSong.toLowerCase() == 'old endless' || curSong.toLowerCase() == 'execution' || curSong.toLowerCase() == 'chaos' || curSong.toLowerCase() == 'too fest'){
						//FlxG.sound.play(Paths.sound('intro3' + altSuffix), 0.6);
					}
					else
					{
					var set:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[1]));
					set.scrollFactor.set();

					if (curStage.startsWith('school'))
						set.setGraphicSize(Std.int(set.width * daPixelZoom));

					set.screenCenter();
					add(set);
					FlxTween.tween(set, {y: set.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							set.destroy();
						}
					});
					FlxG.sound.play(Paths.sound('intro1' + altSuffix), 0.6);
					}
				case 3:
					if (curSong.toLowerCase() == 'too slow' || curSong.toLowerCase() == 'you cant run' || curSong.toLowerCase() == 'triple trouble' || curSong.toLowerCase() == 'endless' || curSong.toLowerCase() == 'cycles' || curSong.toLowerCase() == 'milk' || curSong.toLowerCase() == 'sunshine' || curSong.toLowerCase() == 'old endless' || curSong.toLowerCase() == 'execution' || curSong.toLowerCase() == 'chaos' || curSong.toLowerCase() == 'too fest'){
						//FlxG.sound.play(Paths.sound('intro3' + altSuffix), 0.6);
					}
					else
					{
					var go:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[2]));
					go.scrollFactor.set();

					if (curStage.startsWith('school'))
						go.setGraphicSize(Std.int(go.width * daPixelZoom));

					go.updateHitbox();

					go.screenCenter();
					add(go);
					FlxTween.tween(go, {y: go.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							go.destroy();
						}
					});
					FlxG.sound.play(Paths.sound('introGo' + altSuffix), 0.6);
					}
				case 4:
			}

			swagCounter += 1;
			// generateSong('fresh');
		}, 5);

		if (SONG.song.toLowerCase() == 'expurgation')
			{
				new FlxTimer().start(25, function(tmr:FlxTimer) {
					if (curStep < 2400)
					{
						if (canPause && !paused && health >= 1.5 && !grabbed)
							doGremlin(40,3);
						trace('checka ' + health);
						tmr.reset(25);
					}
				});
			}

	}

	var grabbed = false;

	var previousFrameTime:Int = 0;
	var lastReportedPlayheadPosition:Int = 0;
	var songTime:Float = 0;

	private function getKey(charCode:Int):String
	{
		for (key => value in FlxKey.fromStringMap)
		{
			if (charCode == value)
				return key;
		}
		return null;
	}
	



	private function releaseInput(evt:KeyboardEvent):Void // handles releases
	{
		@:privateAccess
		var key = FlxKey.toStringMap.get(evt.keyCode);

		var binds:Array<String> = [FlxG.save.data.leftBind,FlxG.save.data.downBind, FlxG.save.data.upBind, FlxG.save.data.rightBind];
		var data = -1;
		switch(mania)
		{
			case 0: 
				binds = [FlxG.save.data.leftBind,FlxG.save.data.downBind, FlxG.save.data.upBind, FlxG.save.data.rightBind];
				switch(evt.keyCode) // arrow keys // why the fuck are arrow keys hardcoded it fucking breaks the controls with extra keys
				{
					case 37:
						data = 0;
					case 40:
						data = 1;
					case 38:
						data = 2;
					case 39:
						data = 3;
				}
			case 1: 
				binds = [FlxG.save.data.L1Bind, FlxG.save.data.U1Bind, FlxG.save.data.R1Bind, FlxG.save.data.L2Bind, FlxG.save.data.D1Bind, FlxG.save.data.R2Bind];
				switch(evt.keyCode) // arrow keys
				{
					case 37:
						data = 3;
					case 40:
						data = 4;
					case 39:
						data = 5;
				}
			case 2: 
				binds = [FlxG.save.data.N0Bind, FlxG.save.data.N1Bind, FlxG.save.data.N2Bind, FlxG.save.data.N3Bind, FlxG.save.data.N4Bind, FlxG.save.data.N5Bind, FlxG.save.data.N6Bind, FlxG.save.data.N7Bind, FlxG.save.data.N8Bind];
				switch(evt.keyCode) // arrow keys
				{
					case 37:
						data = 5;
					case 40:
						data = 6;
					case 38:
						data = 7;
					case 39:
						data = 8;
				}
			case 3: 
				binds = [FlxG.save.data.leftBind,FlxG.save.data.downBind, FlxG.save.data.N4Bind, FlxG.save.data.upBind, FlxG.save.data.rightBind];
				switch(evt.keyCode) // arrow keys
				{
					case 37:
						data = 0;
					case 40:
						data = 1;
					case 38:
						data = 3;
					case 39:
						data = 4;
				}
			case 4: 
				binds = [FlxG.save.data.L1Bind, FlxG.save.data.U1Bind, FlxG.save.data.R1Bind,FlxG.save.data.N4Bind, FlxG.save.data.L2Bind, FlxG.save.data.D1Bind, FlxG.save.data.R2Bind];
				switch(evt.keyCode) // arrow keys
				{
					case 37:
						data = 4;
					case 40:
						data = 5;
					case 39:
						data = 6;
				}
			case 5: 
				binds = [FlxG.save.data.N0Bind, FlxG.save.data.N1Bind, FlxG.save.data.N2Bind, FlxG.save.data.N3Bind, FlxG.save.data.N5Bind, FlxG.save.data.N6Bind, FlxG.save.data.N7Bind, FlxG.save.data.N8Bind];
				switch(evt.keyCode) // arrow keys
				{
					case 37:
						data = 4;
					case 40:
						data = 5;
					case 38:
						data = 6;
					case 39:
						data = 7;
				}
			case 6: 
				binds = [FlxG.save.data.N4Bind];
			case 7: 
				binds = [FlxG.save.data.leftBind, FlxG.save.data.rightBind];
				switch(evt.keyCode) // arrow keys 
				{
					case 37:
						data = 0;
					case 39:
						data = 1;
				}

			case 8: 
				binds = [FlxG.save.data.leftBind, FlxG.save.data.N4Bind, FlxG.save.data.rightBind];
				switch(evt.keyCode) // arrow keys 
				{
					case 37:
						data = 0;
					case 39:
						data = 2;
				}

		}

		


		for (i in 0...binds.length) // binds
		{
			if (binds[i].toLowerCase() == key.toLowerCase())
				data = i;
		}

		if (data == -1)
			return;

		keys[data] = false;
	}

	public var closestNotes:Array<Note> = [];

	private function handleInput(evt:KeyboardEvent):Void { // this actually handles press inputs

		if (PlayStateChangeables.botPlay || loadRep || paused)
			return;

		// first convert it from openfl to a flixel key code
		// then use FlxKey to get the key's name based off of the FlxKey dictionary
		// this makes it work for special characters

		@:privateAccess
		var key = FlxKey.toStringMap.get(evt.keyCode);
		var data = -1;
		var binds:Array<String> = [FlxG.save.data.leftBind,FlxG.save.data.downBind, FlxG.save.data.upBind, FlxG.save.data.rightBind];
		switch(mania)
		{
			case 0: 
				binds = [FlxG.save.data.leftBind,FlxG.save.data.downBind, FlxG.save.data.upBind, FlxG.save.data.rightBind];
				switch(evt.keyCode) // arrow keys // why the fuck are arrow keys hardcoded it fucking breaks the controls with extra keys
				{
					case 37:
						data = 0;
					case 40:
						data = 1;
					case 38:
						data = 2;
					case 39:
						data = 3;
				}
			case 1: 
				binds = [FlxG.save.data.L1Bind, FlxG.save.data.U1Bind, FlxG.save.data.R1Bind, FlxG.save.data.L2Bind, FlxG.save.data.D1Bind, FlxG.save.data.R2Bind];
				switch(evt.keyCode) // arrow keys
				{
					case 37:
						data = 3;
					case 40:
						data = 4;
					case 39:
						data = 5;
				}
			case 2: 
				binds = [FlxG.save.data.N0Bind, FlxG.save.data.N1Bind, FlxG.save.data.N2Bind, FlxG.save.data.N3Bind, FlxG.save.data.N4Bind, FlxG.save.data.N5Bind, FlxG.save.data.N6Bind, FlxG.save.data.N7Bind, FlxG.save.data.N8Bind];
				switch(evt.keyCode) // arrow keys
				{
					case 37:
						data = 5;
					case 40:
						data = 6;
					case 38:
						data = 7;
					case 39:
						data = 8;
				}
			case 3: 
				binds = [FlxG.save.data.leftBind,FlxG.save.data.downBind, FlxG.save.data.N4Bind, FlxG.save.data.upBind, FlxG.save.data.rightBind];
				switch(evt.keyCode) // arrow keys
				{
					case 37:
						data = 0;
					case 40:
						data = 1;
					case 38:
						data = 3;
					case 39:
						data = 4;
				}
			case 4: 
				binds = [FlxG.save.data.L1Bind, FlxG.save.data.U1Bind, FlxG.save.data.R1Bind,FlxG.save.data.N4Bind, FlxG.save.data.L2Bind, FlxG.save.data.D1Bind, FlxG.save.data.R2Bind];
				switch(evt.keyCode) // arrow keys
				{
					case 37:
						data = 4;
					case 40:
						data = 5;
					case 39:
						data = 6;
				}
			case 5: 
				binds = [FlxG.save.data.N0Bind, FlxG.save.data.N1Bind, FlxG.save.data.N2Bind, FlxG.save.data.N3Bind, FlxG.save.data.N5Bind, FlxG.save.data.N6Bind, FlxG.save.data.N7Bind, FlxG.save.data.N8Bind];
				switch(evt.keyCode) // arrow keys
				{
					case 37:
						data = 4;
					case 40:
						data = 5;
					case 38:
						data = 6;
					case 39:
						data = 7;
				}
			case 6: 
				binds = [FlxG.save.data.N4Bind];
			case 7: 
				binds = [FlxG.save.data.leftBind, FlxG.save.data.rightBind];
				switch(evt.keyCode) // arrow keys 
				{
					case 37:
						data = 0;
					case 39:
						data = 1;
				}

			case 8: 
				binds = [FlxG.save.data.leftBind, FlxG.save.data.N4Bind, FlxG.save.data.rightBind];
				switch(evt.keyCode) // arrow keys 
				{
					case 37:
						data = 0;
					case 39:
						data = 2;
				}

		}

			for (i in 0...binds.length) // binds
				{
					if (binds[i].toLowerCase() == key.toLowerCase())
						data = i;
				}
				if (data == -1)
				{
					trace("couldn't find a keybind with the code " + key);
					return;
				}
				if (keys[data])
				{
					//trace("ur already holding " + key);
					return;
				}
		
				keys[data] = true;
		
				var ana = new Ana(Conductor.songPosition, null, false, "miss", data);
		
				var dataNotes = [];
				for(i in closestNotes)
					if (i.noteData == data)
						dataNotes.push(i);

				
				if (!FlxG.save.data.gthm)
				{
					if (dataNotes.length != 0)
						{
							var coolNote = null;
				
							for (i in dataNotes)
								if (!i.isSustainNote)
								{
									coolNote = i;
									break;
								}
				
							if (coolNote == null) // Note is null, which means it's probably a sustain note. Update will handle this (HOPEFULLY???)
							{
								return;
							}
				
							if (dataNotes.length > 1) // stacked notes or really close ones
							{
								for (i in 0...dataNotes.length)
								{
									if (i == 0) // skip the first note
										continue;
				
									var note = dataNotes[i];
				
									if (!note.isSustainNote && (note.strumTime - coolNote.strumTime) < 2)
									{
										trace('found a stacked/really close note ' + (note.strumTime - coolNote.strumTime));
										// just fuckin remove it since it's a stacked note and shouldn't be there
										note.kill();
										notes.remove(note, true);
										note.destroy();
									}
								}
							}
				
							goodNoteHit(coolNote);
							var noteDiff:Float = -(coolNote.strumTime - Conductor.songPosition);
							ana.hit = true;
							ana.hitJudge = Ratings.CalculateRating(noteDiff, Math.floor((PlayStateChangeables.safeFrames / 60) * 1000));
							ana.nearestNote = [coolNote.strumTime, coolNote.noteData, coolNote.sustainLength];
						
						}
					else if (!FlxG.save.data.ghost && songStarted && !grace)
						{
							if (!isRing || (isRing && data != 3))
							{
								noteMiss(data, null);
								ana.hit = false;
								ana.hitJudge = "shit";
								ana.nearestNote = [];
								//health -= 0.20;
								if (cNum == 0)
									health -= 0.04;
							}
						}
				}
		
	}

	var songStarted = false;

	function startSong():Void
	{
		startingSong = false;
		songStarted = true;
		previousFrameTime = FlxG.game.ticks;
		lastReportedPlayheadPosition = 0;

		if (!paused)
		{
			FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), 1, false);
		}

		if (FlxG.save.data.noteSplash)
			{
				switch (mania)
				{
					case 0: 
						NoteSplash.colors = ['purple', 'blue', 'green', 'red'];
					case 1: 
						NoteSplash.colors = ['purple', 'green', 'red', 'yellow', 'blue', 'darkblue'];	
					case 2: 
						NoteSplash.colors = ['purple', 'blue', 'green', 'red', 'white', 'yellow', 'violet', FlxG.save.data.noteColor, 'darkblue'];
					case 3: 
						NoteSplash.colors = ['purple', 'blue', 'white', 'green', 'red'];
						if (FlxG.save.data.gthc)
							NoteSplash.colors = ['green', 'red', 'yellow', 'darkblue', 'orange'];
					case 4: 
						NoteSplash.colors = ['purple', 'green', 'red', 'white', 'yellow', 'blue', 'darkblue'];
					case 5: 
						NoteSplash.colors = ['purple', 'blue', 'green', 'red', 'yellow', 'violet', FlxG.save.data.noteColor, 'darkblue'];
					case 6: 
						NoteSplash.colors = ['white'];
					case 7: 
						NoteSplash.colors = ['purple', 'red'];
					case 8: 
						NoteSplash.colors = ['purple', 'white', 'red'];
				}
			}

		FlxG.sound.music.onComplete = endSong;
		resyncVocals();
		vocals.play();

		// Song duration in a float, useful for the time left feature
		songLength = FlxG.sound.music.length;

		if (FlxG.save.data.songPosition)
		{
			remove(songPosBG);
			remove(songPosBar);
			remove(songName);

			songPosBG = new FlxSprite(0, 10).loadGraphic(Paths.image('healthBar'));
			if (PlayStateChangeables.useDownscroll)
				songPosBG.y = FlxG.height * 0.9 + 45; 
			songPosBG.screenCenter(X);
			songPosBG.scrollFactor.set();
			add(songPosBG);

			songPosBar = new FlxBar(songPosBG.x + 4, songPosBG.y + 4, LEFT_TO_RIGHT, Std.int(songPosBG.width - 8), Std.int(songPosBG.height - 8), this,
				'songPositionBar', 0, songLength - 1000);
			songPosBar.numDivisions = 1000;
			songPosBar.scrollFactor.set();
			songPosBar.createFilledBar(FlxColor.GRAY, FlxColor.LIME);
			add(songPosBar);

			var songName = new FlxText(songPosBG.x + (songPosBG.width / 2) - (SONG.song.length * 5),songPosBG.y,0,SONG.song, 20);
			if (PlayStateChangeables.useDownscroll)
				songName.y -= 3;
			if (SONG.song.toLowerCase() == 'algebra' || SONG.song.toLowerCase() == 'supernovae' || SONG.song.toLowerCase() == 'cheating' || curSong.toLowerCase() == 'piracy'){
				songName.setFormat(Paths.font("comic.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
			}
			else if (SONG.song.toLowerCase() == 'honorbound' || SONG.song.toLowerCase() == 'strongmann' || SONG.song.toLowerCase() == 'skill issue' || SONG.song.toLowerCase() == 'infiltrator' || SONG.song.toLowerCase() == 'eyelander'){
				songName.setFormat(Paths.font("tf2build.ttf"), 20, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
			}
			else{
				songName.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
			}
			songName.scrollFactor.set();
			add(songName);

			songPosBG.cameras = [camHUD];
			songPosBar.cameras = [camHUD];
			songName.cameras = [camHUD];
		}
		
		// Song check real quick
		switch(curSong)
		{
			case 'Bopeebo' | 'Philly Nice' | 'Blammed' | 'Cocoa' | 'Eggnog': allowedToHeadbang = true;
			default: allowedToHeadbang = false;
		}

		if (useVideo)
			GlobalVideo.get().resume();
		
		#if windows
		// Updating Discord Rich Presence (with Time Left)
		DiscordClient.changePresence(detailsText + " " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), "\nAcc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
		#end
	}

	function fleetON()
		{
			remove(boyfriend);
			boyfriend = new Boyfriend (770, 450, 'bf-fleetway-chaos');
			add(boyfriend);
			remove(iconP1);
			iconP1 = new HealthIcon('bf-fleetway-chaos', true);
			iconP1.y = healthBar.y - (iconP1.height / 2);
			add(iconP1);
			iconP1.cameras = [camHUD];
			healthBar.createFilledBar(FlxColor.fromString('#' + dad.iconColor), FlxColor.fromString('#' + boyfriend.iconColor));
			remove(sonicbg);
			add(fleetbg);
			vintageEffect();
		}
	
	function fleetOFF()
		{
			remove(boyfriend);
			boyfriend = new Boyfriend (770, 450, 'bf-sonic-chaos');
			add(boyfriend);
			remove(iconP1);
			iconP1 = new HealthIcon('bf-sonic-chaos', true);
			iconP1.y = healthBar.y - (iconP1.height / 2);
			add(iconP1);
			iconP1.cameras = [camHUD];
			healthBar.createFilledBar(FlxColor.fromString('#' + dad.iconColor), FlxColor.fromString('#' + boyfriend.iconColor));
			remove(fleetbg);
			add(sonicbg);
			vintageEffect();
		}

	function teleportShit() 
		{
			dad.flipX = true;
			boyfriend.flipX = true;
			dad.x += 190;
			boyfriend.x -= 200;
			if (!FlxG.save.data.middlescroll){
				for (i in 0...PlayState.strumLineNotes.length) {
					var member = PlayState.strumLineNotes.members[i];
					var theValue = Note.swagWidth * (i % 6);
					if (i >= 6) {
						luaModchart.setVar("defaultStrum" + i + "X", 50 + theValue);
						FlxTween.tween(member, {x: 50 + theValue}, 1, {ease: FlxEase.linear});
					} else {
						luaModchart.setVar("defaultStrum" + i + "X", (50 + (FlxG.width / 2)) + theValue);
						FlxTween.tween(member, {x: (50 + (FlxG.width / 2)) + theValue}, 1, {ease: FlxEase.linear});
					}
				}
			}
			curStage = 'unknownfile-alt';
			/*for (spr in playerStrums) {
				spr.x -= (FlxG.width / 2);
			}
			
			for (spr in cpuStrums) {
				spr.x += (FlxG.width / 2);
			}*/
			FlxG.sound.play(Paths.sound('glitch'), 1, false);
		
			/*new FlxTimer().start(20, function(tmr:FlxTimer)
				{
					
				});*/
		}
		function teleportBack()
		{
			dad.flipX = false;
			boyfriend.flipX = false;
			dad.x -= 190;
			boyfriend.x += 200;
			curStage = 'unknownfile';
			if (!FlxG.save.data.middlescroll){
				for (i in 0...PlayState.strumLineNotes.length) {
					var member = PlayState.strumLineNotes.members[i];
					var theValue = Note.swagWidth * (i % 6);
					if (i <= 5) {
						luaModchart.setVar("defaultStrum" + i + "X", 50 + theValue);
						FlxTween.tween(member, {x: 50 + theValue}, 1, {ease: FlxEase.linear});
					} else {
						luaModchart.setVar("defaultStrum" + i + "X", (50 + (FlxG.width / 2)) + theValue);
						FlxTween.tween(member, {x: (50 + (FlxG.width / 2)) + theValue}, 1, {ease: FlxEase.linear});
					}
				}
			}
		}

	var debugNum:Int = 0;

	private function generateSong(dataPath:String):Void
	{
		// FlxG.log.add(ChartParser.parse());

		var songData = SONG;
		Conductor.changeBPM(songData.bpm);

		curSong = songData.song;

		if (SONG.needsVoices)
			vocals = new FlxSound().loadEmbedded(Paths.voices(PlayState.SONG.song));
		else
			vocals = new FlxSound();

		trace('loaded vocals');

		FlxG.sound.list.add(vocals);

		notes = new FlxTypedGroup<Note>();
		add(notes);

		var noteData:Array<SwagSection>;

		// NEW SHIT
		noteData = songData.notes;

		var playerCounter:Int = 0;

		// Per song offset check
		#if windows
			// pre lowercasing the song name (generateSong)
			var songLowercase = StringTools.replace(PlayState.SONG.song, " ", "-").toLowerCase();
				switch (songLowercase) {
					case 'dad-battle': songLowercase = 'dadbattle';
					case 'philly-nice': songLowercase = 'philly';
				}

			var songPath = 'assets/data/' + songLowercase + '/';
			
			for(file in sys.FileSystem.readDirectory(songPath))
			{
				var path = haxe.io.Path.join([songPath, file]);
				if(!sys.FileSystem.isDirectory(path))
				{
					if(path.endsWith('.offset'))
					{
						trace('Found offset file: ' + path);
						songOffset = Std.parseFloat(file.substring(0, file.indexOf('.off')));
						break;
					}else {
						trace('Offset file not found. Creating one @: ' + songPath);
						sys.io.File.saveContent(songPath + songOffset + '.offset', '');
					}
				}
			}
		#end
		var daBeats:Int = 0; // Not exactly representative of 'daBeats' lol, just how much it has looped
		for (section in noteData)
		{
			if (daSection == 58 && curSong.toLowerCase() == 'old endless') 
				SONG.noteStyle = 'majinNOTES';

			if (daSection == 57 && curSong.toLowerCase() == 'endless') 
				SONG.noteStyle = 'majinNOTES';

			if (daSection == 34 && curSong.toLowerCase() == 'you cant run')
				SONG.noteStyle = 'pixel';

			if (daSection == 50 && curSong.toLowerCase() == 'you cant run')
				SONG.noteStyle = 'normal';

			var mn:Int = keyAmmo[mania];
			var coolSection:Int = Std.int(section.lengthInSteps / 4);

			for (songNotes in section.sectionNotes)
			{
				var daStrumTime:Float = songNotes[0] + FlxG.save.data.offset + songOffset;
				if (daStrumTime < 0)
					daStrumTime = 0;
				var daNoteData:Int = Std.int(songNotes[1] % mn);

				var gottaHitNote:Bool = section.mustHitSection;

				if (songNotes[1] >= mn)
				{
					gottaHitNote = !section.mustHitSection;
				}

				var oldNote:Note;
				if (unspawnNotes.length > 0)
					oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];
				else
					oldNote = null;

				var daType = songNotes[3];

				var swagNote:Note = new Note(daStrumTime, daNoteData, oldNote, false, daType);

				if (!gottaHitNote && PlayStateChangeables.Optimize)
					continue;

				swagNote.sustainLength = songNotes[2];
				swagNote.scrollFactor.set(0, 0);

				var susLength:Float = swagNote.sustainLength;

				susLength = susLength / Conductor.stepCrochet;
				unspawnNotes.push(swagNote);

				if (susLength > 0)
					swagNote.isParent = true;

				var type = 0;

				for (susNote in 0...Math.floor(susLength))
				{
					oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];

					var sustainNote:Note = new Note(daStrumTime + (Conductor.stepCrochet * susNote) + (Conductor.stepCrochet / FlxMath.roundDecimal(SONG.speed, 2)), daNoteData, oldNote, true, daType);
					sustainNote.scrollFactor.set();
					unspawnNotes.push(sustainNote);

					sustainNote.mustPress = gottaHitNote;

					if (sustainNote.mustPress)
					{
						sustainNote.x += FlxG.width / 2; // general offset
					}
					sustainNote.parent = swagNote;
					swagNote.children.push(sustainNote);
					sustainNote.spotInLine = type;
					type++;
				}

				swagNote.mustPress = gottaHitNote;

				if (swagNote.mustPress)
				{
					swagNote.x += FlxG.width / 2; // general offset
				}
				else
				{
				}
			}
			daSection += 1;
			daBeats += 1;
		}

		// trace(unspawnNotes.length);
		// playerCounter += 1;

		unspawnNotes.sort(sortByShit);

		generatedMusic = true;
	}

	function sortByShit(Obj1:Note, Obj2:Note):Int
	{
		return FlxSort.byValues(FlxSort.ASCENDING, Obj1.strumTime, Obj2.strumTime);
	}

	function removeStatics()
		{
			playerStrums.forEach(function(todel:FlxSprite)
				{
					playerStrums.remove(todel);
					todel.destroy();
				});
			cpuStrums.forEach(function(todel:FlxSprite)
			{
				cpuStrums.remove(todel);
				todel.destroy();
			});
			strumLineNotes.forEach(function(todel:FlxSprite)
			{
				strumLineNotes.remove(todel);
				todel.destroy();
			});
		}	

	private function generateStaticArrows(player:Int):Void
	{
		for (i in 0...keyAmmo[mania])
		{
			// FlxG.log.add(i);
			var babyArrow:FlxSprite = new FlxSprite(0, strumLine.y);

			//defaults if no noteStyle was found in chart
			var noteTypeCheck:String = 'normal';
		
			if (PlayStateChangeables.Optimize && player == 0)
				continue;

			if (SONG.noteStyle == null) 
			{
				switch(storyWeek) 
				{
					case 6: noteTypeCheck = 'majinNOTES';
				}
			}
			else 
			{
				noteTypeCheck = SONG.noteStyle;
			}

			switch (noteTypeCheck)
			{
				case 'pixel':
					babyArrow.loadGraphic(Paths.image('noteassets/pixel/arrows-pixels'), true, 17, 17);
					babyArrow.animation.add('green', [11]);
					babyArrow.animation.add('red', [12]);
					babyArrow.animation.add('blue', [10]);
					babyArrow.animation.add('purplel', [9]);

					babyArrow.animation.add('white', [13]);
					babyArrow.animation.add('yellow', [14]);
					babyArrow.animation.add('violet', [15]);
					babyArrow.animation.add('black', [16]);
					babyArrow.animation.add('darkred', [16]);
					babyArrow.animation.add('orange', [16]);
					babyArrow.animation.add('dark', [17]);


					babyArrow.setGraphicSize(Std.int(babyArrow.width * daPixelZoom * Note.pixelnoteScale));
					babyArrow.updateHitbox();
					babyArrow.antialiasing = false;

					var numstatic:Array<Int> = [0, 1, 2, 3, 4, 5, 6, 7, 8]; //this is most tedious shit ive ever done why the fuck is this so hard
					var startpress:Array<Int> = [9, 10, 11, 12, 13, 14, 15, 16, 17];
					var endpress:Array<Int> = [18, 19, 20, 21, 22, 23, 24, 25, 26];
					var startconf:Array<Int> = [27, 28, 29, 30, 31, 32, 33, 34, 35];
					var endconf:Array<Int> = [36, 37, 38, 39, 40, 41, 42, 43, 44];
						switch (mania)
						{
							case 1:
								numstatic = [0, 2, 3, 5, 1, 8];
								startpress = [9, 11, 12, 14, 10, 17];
								endpress = [18, 20, 21, 23, 19, 26];
								startconf = [27, 29, 30, 32, 28, 35];
								endconf = [36, 38, 39, 41, 37, 44];

							case 2: 
								babyArrow.x -= Note.tooMuch;
							case 3: 
								numstatic = [0, 1, 4, 2, 3];
								startpress = [9, 10, 13, 11, 12];
								endpress = [18, 19, 22, 20, 21];
								startconf = [27, 28, 31, 29, 30];
								endconf = [36, 37, 40, 38, 39];
							case 4: 
								numstatic = [0, 2, 3, 4, 5, 1, 8];
								startpress = [9, 11, 12, 13, 14, 10, 17];
								endpress = [18, 20, 21, 22, 23, 19, 26];
								startconf = [27, 29, 30, 31, 32, 28, 35];
								endconf = [36, 38, 39, 40, 41, 37, 44];
							case 5: 
								numstatic = [0, 1, 2, 3, 5, 6, 7, 8];
								startpress = [9, 10, 11, 12, 14, 15, 16, 17];
								endpress = [18, 19, 20, 21, 23, 24, 25, 26];
								startconf = [27, 28, 29, 30, 32, 33, 34, 35];
								endconf = [36, 37, 38, 39, 41, 42, 43, 44];
							case 6: 
								numstatic = [4];
								startpress = [13];
								endpress = [22];
								startconf = [31];
								endconf = [40];
							case 7: 
								numstatic = [0, 3];
								startpress = [9, 12];
								endpress = [18, 21];
								startconf = [27, 30];
								endconf = [36, 39];
							case 8: 
								numstatic = [0, 4, 3];
								startpress = [9, 13, 12];
								endpress = [18, 22, 21];
								startconf = [27, 31, 30];
								endconf = [36, 40, 39];


						}
					babyArrow.x += Note.swagWidth * i;
					babyArrow.animation.add('static', [numstatic[i]]);
					babyArrow.animation.add('pressed', [startpress[i], endpress[i]], 12, false);
					babyArrow.animation.add('confirm', [startconf[i], endconf[i]], 24, false);

					case 'majinNOTES':
						{
							babyArrow.frames = Paths.getSparrowAtlas('noteassets/Majin_Notes');
							babyArrow.animation.addByPrefix('green', 'arrowUP');
							babyArrow.animation.addByPrefix('blue', 'arrowDOWN');
							babyArrow.animation.addByPrefix('purple', 'arrowLEFT');
							babyArrow.animation.addByPrefix('red', 'arrowRIGHT');
		
							babyArrow.antialiasing = FlxG.save.data.antialiasing;
							babyArrow.setGraphicSize(Std.int(babyArrow.width * Note.noteScale));
	
							var nSuf:Array<String> = ['LEFT', 'DOWN', 'UP', 'RIGHT'];
							var pPre:Array<String> = ['purple', 'blue', 'green', 'red'];
								switch (mania)
								{
									case 1:
										nSuf = ['LEFT', 'UP', 'RIGHT', 'LEFT', 'DOWN', 'RIGHT'];
										pPre = ['purple', 'green', 'red', 'yellow', 'blue', 'dark'];
	
									case 2:
										nSuf = ['LEFT', 'DOWN', 'UP', 'RIGHT', 'SPACE', 'LEFT', 'DOWN', 'UP', 'RIGHT'];
										pPre = ['purple', 'blue', 'green', 'red', 'white', 'yellow', 'violet', FlxG.save.data.noteColor, 'dark'];
										babyArrow.x -= Note.tooMuch;
									case 3: 
										nSuf = ['LEFT', 'DOWN', 'SPACE', 'UP', 'RIGHT'];
										pPre = ['purple', 'blue', 'white', 'green', 'red'];
										if (FlxG.save.data.gthc)
										{
											nSuf = ['UP', 'RIGHT', 'LEFT', 'RIGHT', 'UP'];
											pPre = ['green', 'red', 'yellow', 'dark', 'orange'];
										}
									case 4: 
										nSuf = ['LEFT', 'UP', 'RIGHT', 'SPACE', 'LEFT', 'DOWN', 'RIGHT'];
										pPre = ['purple', 'green', 'red', 'white', 'yellow', 'blue', 'dark'];
									case 5: 
										nSuf = ['LEFT', 'DOWN', 'UP', 'RIGHT', 'LEFT', 'DOWN', 'UP', 'RIGHT'];
										pPre = ['purple', 'blue', 'green', 'red', 'yellow', 'violet', FlxG.save.data.noteColor, 'dark'];
									case 6: 
										nSuf = ['SPACE'];
										pPre = ['white'];
									case 7: 
										nSuf = ['LEFT', 'RIGHT'];
										pPre = ['purple', 'red'];
									case 8: 
										nSuf = ['LEFT', 'SPACE', 'RIGHT'];
										pPre = ['purple', 'white', 'red'];
	
								}
						
						babyArrow.x += Note.swagWidth * i;
						babyArrow.animation.addByPrefix('static', 'arrow' + nSuf[i]);
						babyArrow.animation.addByPrefix('pressed', pPre[i] + ' press', 24, false);
						babyArrow.animation.addByPrefix('confirm', pPre[i] + ' confirm', 24, false);
						}	
				
					case 'normal':
						{
							babyArrow.frames = Paths.getSparrowAtlas('noteassets/NOTE_assets');
							babyArrow.animation.addByPrefix('green', 'arrowUP');
							babyArrow.animation.addByPrefix('blue', 'arrowDOWN');
							babyArrow.animation.addByPrefix('purple', 'arrowLEFT');
							babyArrow.animation.addByPrefix('red', 'arrowRIGHT');
		
							babyArrow.antialiasing = FlxG.save.data.antialiasing;
							babyArrow.setGraphicSize(Std.int(babyArrow.width * Note.noteScale));
	
							var nSuf:Array<String> = ['LEFT', 'DOWN', 'UP', 'RIGHT'];
							var pPre:Array<String> = ['purple', 'blue', 'green', 'red'];
								switch (mania)
								{
									case 1:
										nSuf = ['LEFT', 'UP', 'RIGHT', 'LEFT', 'DOWN', 'RIGHT'];
										pPre = ['purple', 'green', 'red', 'yellow', 'blue', 'dark'];
	
									case 2:
										nSuf = ['LEFT', 'DOWN', 'UP', 'RIGHT', 'SPACE', 'LEFT', 'DOWN', 'UP', 'RIGHT'];
										pPre = ['purple', 'blue', 'green', 'red', 'white', 'yellow', 'violet', FlxG.save.data.noteColor, 'dark'];
										babyArrow.x -= Note.tooMuch;
									case 3: 
										nSuf = ['LEFT', 'DOWN', 'SPACE', 'UP', 'RIGHT'];
										pPre = ['purple', 'blue', 'white', 'green', 'red'];
										if (FlxG.save.data.gthc)
										{
											nSuf = ['UP', 'RIGHT', 'LEFT', 'RIGHT', 'UP'];
											pPre = ['green', 'red', 'yellow', 'dark', 'orange'];
										}
									case 4: 
										nSuf = ['LEFT', 'UP', 'RIGHT', 'SPACE', 'LEFT', 'DOWN', 'RIGHT'];
										pPre = ['purple', 'green', 'red', 'white', 'yellow', 'blue', 'dark'];
									case 5: 
										nSuf = ['LEFT', 'DOWN', 'UP', 'RIGHT', 'LEFT', 'DOWN', 'UP', 'RIGHT'];
										pPre = ['purple', 'blue', 'green', 'red', 'yellow', 'violet', FlxG.save.data.noteColor, 'dark'];
									case 6: 
										nSuf = ['SPACE'];
										pPre = ['white'];
									case 7: 
										nSuf = ['LEFT', 'RIGHT'];
										pPre = ['purple', 'red'];
									case 8: 
										nSuf = ['LEFT', 'SPACE', 'RIGHT'];
										pPre = ['purple', 'white', 'red'];
	
								}
						
						babyArrow.x += Note.swagWidth * i;
						babyArrow.animation.addByPrefix('static', 'arrow' + nSuf[i]);
						babyArrow.animation.addByPrefix('pressed', pPre[i] + ' press', 24, false);
						babyArrow.animation.addByPrefix('confirm', pPre[i] + ' confirm', 24, false);
						}						
			}

			babyArrow.updateHitbox();
			babyArrow.scrollFactor.set();

			if (!isStoryMode)
			{
				/*babyArrow.y -= 10;
				babyArrow.alpha = 0;
				FlxTween.tween(babyArrow, {y: babyArrow.y + 10, alpha: 1}, 1, {ease: FlxEase.circOut, startDelay: 0.5 + (0.2 * i)});*/
			}

			babyArrow.ID = i;

			switch (player)
			{
				case 0:
					cpuStrums.add(babyArrow);
				case 1:
					playerStrums.add(babyArrow);
			}

			babyArrow.animation.play('static');
			babyArrow.x += 50;
			babyArrow.x += ((FlxG.width / 2) * player);
			
			if (PlayStateChangeables.Optimize)
				babyArrow.x -= 275;

			if (FlxG.save.data.middlescroll && player == 1 && curSong.toLowerCase() != 'infitrigger' && curSong.toLowerCase() != 'defeat' && curSong.toLowerCase() != 'bloodshed' && curSong.toLowerCase() != 'cheating')
				babyArrow.x -= 300/* * keyAmmo[mania]*/;
			if (FlxG.save.data.middlescroll && player == 0 && curSong.toLowerCase() != 'infitrigger' && curSong.toLowerCase() != 'defeat' && curSong.toLowerCase() != 'bloodshed' && curSong.toLowerCase() != 'cheating')
				babyArrow.x -= 1000;
			else if (curSong.toLowerCase() == 'phantasm' && player == 0)
				babyArrow.x -= 1000;
			
			cpuStrums.forEach(function(spr:FlxSprite)
			{					
				spr.centerOffsets(); //CPU arrows start out slightly off-center
			});

			strumLineNotes.add(babyArrow);
		}
	}

	function tweenCamIn():Void
	{
		FlxTween.tween(FlxG.camera, {zoom: 1.3}, (Conductor.stepCrochet * 4 / 1000), {ease: FlxEase.elasticInOut});
	}

	function tweenCam(zoom:Float, duration:Float):Void
		{
			FlxTween.tween(FlxG.camera, {zoom: zoom}, duration ,{ease: FlxEase.quadInOut});
		}

	override function openSubState(SubState:FlxSubState)
	{
		if (paused)
		{
			if (FlxG.sound.music != null)
			{
				FlxG.sound.music.pause();
				vocals.pause();
			}

			#if windows
			DiscordClient.changePresence("PAUSED on " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), "Acc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
			#end
			if (!startTimer.finished)
				startTimer.active = false;
		}

		super.openSubState(SubState);
	}

	override function closeSubState()
	{
		if (paused)
		{
			if (FlxG.sound.music != null && !startingSong)
			{
				resyncVocals();
			}

			if (!startTimer.finished)
				startTimer.active = true;
			paused = false;

			#if windows
			if (startTimer.finished)
			{
				DiscordClient.changePresence(detailsText + " " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), "\nAcc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses, iconRPC, true, songLength - Conductor.songPosition);
			}
			else
			{
				DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), iconRPC);
			}
			#end
		}

		super.closeSubState();
	}
	

	function resyncVocals():Void
	{
		if (resyncingVocals) {
		vocals.pause();

		FlxG.sound.music.play();
		Conductor.songPosition = FlxG.sound.music.time;
		vocals.time = Conductor.songPosition;
		vocals.play();

		#if windows
		DiscordClient.changePresence(detailsText + " " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), "\nAcc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
		#end
		}
	}

	private var paused:Bool = false;

	var canPause:Bool = true;
	var nps:Int = 0;
	var maxNPS:Int = 0;

	var spookyText:FlxText;
	var spookyRendered:Bool = false;
	var spookySteps:Int = 0;

	public static var songRate = 1.5;

	var shake:Bool = false;

	public var stopUpdate = false;
	public var removedVideo = false;

	override public function update(elapsed:Float)
	{
		if (isRing)
			counterNum.text = Std.string(cNum);

		chatTxt.x = usernameTxt.x + (chatUsername.length * 14);

		elapsedtime += elapsed;
		if (curbg != null)
		{
			if (curbg.active) // only the furiosity background is active
			{
				var shad = cast(curbg.shader, Shaders.GlitchShader);
				shad.uTime.value[0] += elapsed;
			}
		}

		//welcome to 3d sinning avenue
		if(funnyFloatyBoys.contains(dad.curCharacter.toLowerCase()) && canFloat)
			{
				dad.y += (Math.sin(elapsedtime) * 0.6);
			}

		if (SONG.song.toLowerCase() == 'cheating' && !inCutscene) // fuck you
			{
				var num:Float = 1.5;
				if (mania == 1) num = 1.4;
				if (mania == 2) num = 1.3;
				playerStrums.forEach(function(spr:FlxSprite)
				{
					spr.x += Math.sin(elapsedtime) * ((spr.ID % 2) == 0 ? 1 : -1);
					spr.x -= Math.sin(elapsedtime) * num;
				});
				cpuStrums.forEach(function(spr:FlxSprite)
				{
					spr.x -= Math.sin(elapsedtime) * ((spr.ID % 2) == 0 ? 1 : -1);
					spr.x += Math.sin(elapsedtime) * num;
				});
			}

		if (curSong.toLowerCase() == 'chaos' && dad.curCharacter == 'fleetway-extras3' && dad.animation.curAnim.curFrame == 15 && !dodging)
			health = 0;

		if ((FlxG.keys.justPressed.SPACE) && canDodge)
			{
				dodging = true;
				boyfriend.playAnim('dodge', true);
				boyfriend.nonanimated = true;
				boyfriend.animation.finishCallback = function(a:String)
				{
					boyfriend.nonanimated = false;
					dodging = false;
					canDodge = false;
				}
			}
		
		switch (curSong)
		{
			default:
				health -= heatlhDrop;
		}

		floaty += 0.03;

		if (shakeCam)
			{
				FlxG.camera.shake(0.005, 0.10);
			}

		if (shakeCam2)
			{
				FlxG.camera.shake(0.0025, 0.10);
			}
		//bgRocks.y = -700 + 1.1 * Math.cos(2) * Math.PI;
		if (SONG.song.toLowerCase() == 'parasite')
			{
				{
					FlxG.camera.angle = Math.sin((Conductor.songPosition / 1000)*(Conductor.bpm/60) * -1.0) * 1.5;
					camHUD.angle = Math.sin((Conductor.songPosition / 1000)*(Conductor.bpm/60) * 1.0) * 2.0;
					camNotes.angle = Math.sin((Conductor.songPosition / 1000)*(Conductor.bpm/60) * 1.0) * 2.0;
				}
		
				gf.y = -120 + Math.sin((Conductor.songPosition / 1000)*(Conductor.bpm/60) * 2.0) * 5.0;
			}
		if (shake)
			{
				FlxG.camera.shake(0.09, 0.01);
				camHUD.shake(0.09, 0.01);
				camNotes.shake(0.09, 0.01);
			}
		#if !debug
		perfectMode = false;
		#end
		floatshit += 0.05;

		if (generatedMusic)
			{
				for(i in notes)
				{
					var diff = i.strumTime - Conductor.songPosition;
					if (diff < 2650 && diff >= -2650)
					{
						i.active = true;
						i.visible = true;
					}
					else
					{
						i.active = false;
						i.visible = false;
					}
				}
			}

		if (PlayStateChangeables.botPlay && FlxG.keys.justPressed.ONE)
			camHUD.visible = !camHUD.visible;


		if (useVideo && GlobalVideo.get() != null && !stopUpdate)
			{		
				if (GlobalVideo.get().ended && !removedVideo)
				{
					remove(videoSprite);
					FlxG.stage.window.onFocusOut.remove(focusOut);
					FlxG.stage.window.onFocusIn.remove(focusIn);
					removedVideo = true;
				}
			}


		
		#if windows
		if (executeModchart && luaModchart != null && songStarted)
		{
			luaModchart.setVar('songPos',Conductor.songPosition);
			luaModchart.setVar('hudZoom', camHUD.zoom);
			luaModchart.setVar('cameraZoom',FlxG.camera.zoom);
			luaModchart.executeState('update', [elapsed]);

			for (i in luaWiggles)
			{
				trace('wiggle le gaming');
				i.update(elapsed);
			}

			/*for (i in 0...strumLineNotes.length) {
				var member = strumLineNotes.members[i];
				member.x = luaModchart.getVar("strum" + i + "X", "float");
				member.y = luaModchart.getVar("strum" + i + "Y", "float");
				member.angle = luaModchart.getVar("strum" + i + "Angle", "float");
			}*/

			FlxG.camera.angle = luaModchart.getVar('cameraAngle', 'float');
			camHUD.angle = luaModchart.getVar('camHudAngle','float');

			if (luaModchart.getVar("showOnlyStrums",'bool'))
			{
				healthBarBG.visible = false;
				kadeEngineWatermark.visible = false;
				healthBar.visible = false;
				overhealthBar.visible = false;
				iconP1.visible = false;
				iconP2.visible = false;
				scoreTxt.visible = false;
			}
			else
			{
				healthBarBG.visible = true;
				kadeEngineWatermark.visible = true;
				healthBar.visible = true;
				overhealthBar.visible = false;
				iconP1.visible = true;
				iconP2.visible = true;
				scoreTxt.visible = true;
			}

			var p1 = luaModchart.getVar("strumLine1Visible",'bool');
			var p2 = luaModchart.getVar("strumLine2Visible",'bool');

			for (i in 0...keyAmmo[mania])
			{
				strumLineNotes.members[i].visible = p1;
				if (i <= playerStrums.length)
					playerStrums.members[i].visible = p2;
			}

			camNotes.zoom = camHUD.zoom;
			camNotes.x = camHUD.x;
			camNotes.y = camHUD.y;
			camNotes.angle = camHUD.angle;
			camSustains.zoom = camHUD.zoom;
			camSustains.x = camHUD.x;
			camSustains.y = camHUD.y;
			camSustains.angle = camHUD.angle;
		}

		#end

		// reverse iterate to remove oldest notes first and not invalidate the iteration
		// stop iteration as soon as a note is not removed
		// all notes should be kept in the correct order and this is optimal, safe to do every frame/update
		{
			var balls = notesHitArray.length-1;
			while (balls >= 0)
			{
				var cock:Date = notesHitArray[balls];
				if (cock != null && cock.getTime() + 1000 < Date.now().getTime())
					notesHitArray.remove(cock);
				else
					balls = 0;
				balls--;
			}
			nps = notesHitArray.length;
			if (nps > maxNPS)
				maxNPS = nps;
		}

		FlxG.camera.setFilters([new ShaderFilter(screenshader.shader)]); // this is very stupid but doesn't effect memory all that much so
		if (shakeCam)
			{
				// var shad = cast(FlxG.camera.screen.shader,Shaders.PulseShader);
				FlxG.camera.shake(0.015, 0.015);
			}
		screenshader.shader.uTime.value[0] += elapsed;
		if (shakeCam3)
			{
				screenshader.shader.uampmul.value[0] = 1;
			}
		else
			{
				screenshader.shader.uampmul.value[0] -= (elapsed / 2);
			}
		screenshader.Enabled = shakeCam3;
		if (FlxG.keys.justPressed.NINE)
		{
			if (iconP1.animation.curAnim.name == 'bf-old')
				iconP1.animation.play(SONG.player1);
			else
				iconP1.animation.play('bf-old');
		}

		switch (curStage)
		{
			case 'philly':
				if (trainMoving && !PlayStateChangeables.Optimize)
				{
					trainFrameTiming += elapsed;

					if (trainFrameTiming >= 1 / 24)
					{
						updateTrainPos();
						trainFrameTiming = 0;
					}
				}
				// phillyCityLights.members[curLight].alpha -= (Conductor.crochet / 1000) * FlxG.elapsed;
		}

		super.update(elapsed);

		if (SONG.song.toLowerCase() == 'onslaught' && IsNoteSpinning){
			var thisX:Float =  Math.sin(SpinAmount * (SpinAmount / 10)) * 100;
			var thisY:Float =  Math.sin(SpinAmount * (SpinAmount)) * 100;
			var yVal = Std.int(windowY + thisY);
			var xVal = Std.int(windowX + thisX);
			if (!FlxG.save.data.shakingscreen)
				Lib.application.window.move(xVal,yVal);
			for (str in playerStrums){
				str.angle = str.angle + SpinAmount;
				SpinAmount = SpinAmount + 0.00005;
			}
		}

		scoreTxt.text = Ratings.CalculateRanking(songScore,songScoreDef,nps,maxNPS,accuracy);

		var lengthInPx = scoreTxt.textField.length * scoreTxt.frameHeight; // bad way but does more or less a better job

		scoreTxt.x = (originalX - (lengthInPx / 2)) + 335;

		if (controls.PAUSE && startedCountdown && canPause && !cannotDie)
		{
			persistentUpdate = false;
			persistentDraw = true;
			paused = true;

			// 1 / 1000 chance for Gitaroo Man easter egg
			if (FlxG.random.bool(0.1))
			{
				trace('GITAROO MAN EASTER EGG');
				FlxG.switchState(new GitarooPause());
			}
			else
				openSubState(new PauseSubState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
		}


		if (FlxG.keys.justPressed.SEVEN && songStarted)
		{
			if (useVideo)
				{
					GlobalVideo.get().stop();
					remove(videoSprite);
					FlxG.stage.window.onFocusOut.remove(focusOut);
					FlxG.stage.window.onFocusIn.remove(focusIn);
					removedVideo = true;
				}
			cannotDie = true;

			if (SONG.song.toLowerCase() == 'honorbound' ||SONG.song.toLowerCase() == 'strongmann' || SONG.song.toLowerCase() == 'skill issue' || SONG.song.toLowerCase() == 'infiltrator' || SONG.song.toLowerCase() == 'eyelander')
			 	{
			 		PlayState.SONG = Song.loadFromJson('skill-issue-hard', 'skill-issue');
			 		shakeCam3 = false;
			 		screenshader.Enabled = false;
			 		FlxG.switchState(new PlayState());
			 		return;
			 		#if windows
			 		DiscordClient.changePresence("LMAO MASSIVE SKILL ISSUE", null, null, true);
			 		#end
			 	}
			else if (SONG.song.toLowerCase() == 'supernovae')
			{
				PlayState.SONG = Song.loadFromJson("cheating", "cheating"); // you dun fucked up
				shakeCam3 = false;
				screenshader.Enabled = false;
				FlxG.switchState(new PlayState());
				return;
				// FlxG.switchState(new VideoState('assets/videos/fortnite/fortniteballs.webm', new CrasherState()));
			}
			else if (SONG.song.toLowerCase() == 'cheating')
				{
					#if debug
					FlxG.switchState(new ChartingState());
						#if windows
						DiscordClient.changePresence("Chart Editor", null, null, true);
						#end
					#end
					Sys.exit(0);
				}
			else if (SONG.song.toLowerCase() == 'run' || SONG.song.toLowerCase() == 'bloodshed')
			{
				#if debug
				FlxG.switchState(new ChartingState());
					#if windows
					DiscordClient.changePresence("Chart Editor", null, null, true);
					#end
				#end
				FlxG.switchState(new CantRunState());
			}
			else if (SONG.song.toLowerCase() == 'onslaught')
			{
				#if debug
				FlxG.switchState(new ChartingState());
					#if windows
					DiscordClient.changePresence("Chart Editor", null, null, true);
					#end
				#end
				FlxG.switchState(new FunState());
			}
			else
			{
				#if debug
				FlxG.switchState(new ChartingState());
					#if windows
					DiscordClient.changePresence("Chart Editor", null, null, true);
					#end
				#end
				FlxG.switchState(new AntiChartState());
			}
			Main.editor = true;
			FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN,handleInput);
			FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP, releaseInput);
			#if windows
			if (luaModchart != null)
			{
				luaModchart.die();
				luaModchart = null;
			}
			#end
		}

		// FlxG.watch.addQuick('VOL', vocals.amplitudeLeft);
		// FlxG.watch.addQuick('VOLRight', vocals.amplitudeRight);
		if (dad.curCharacter == "TDoll" || dad.curCharacter == "fleetway") // Do you really wanna see sonic.exe fly? Me neither.
			{
				if (tailscircle == 'hovering' || tailscircle == 'circling')
					dad.y += Math.sin(floaty) * 1.3;
				if (tailscircle == 'circling')
					dad.x += Math.cos(floaty) * 1.3; // math B)
			}
		if (dad.curCharacter == "nonsense-god"){
			dad.y += Math.sin(floatshit);
		}

		iconP1.setGraphicSize(Std.int(FlxMath.lerp(150, iconP1.width, 0.50)));
		iconP2.setGraphicSize(Std.int(FlxMath.lerp(150, iconP2.width, 0.50)));

		iconP1.updateHitbox();
		iconP2.updateHitbox();

		var iconOffset:Int = 26;

		if (curSong != "Happiness")
			{
				iconP1.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01) - iconOffset);
				iconP2.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01)) - (iconP2.width - iconOffset);	
			}
		else
			{
				iconP1.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 100, 0, 100, 0) * 0.01) - iconOffset);
				iconP2.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 100, 0, 100, 0) * 0.01)) - (iconP2.width - iconOffset);
			}

		if (FlxG.save.data.doubleMaxHealth && !FlxG.save.data.halvedMaxHealth){
			if (health > 8)
				health = 8;
		}
		else if (FlxG.save.data.halvedMaxHealth && !FlxG.save.data.doubleMaxHealth){
			if (health > 2)
				health = 2;
		}
		else{
			if (health > 4)
				health = 4;
		}
		if (curSong != "Happiness")
			{
				if (healthBar.percent < 20){
					switch (dad.curCharacter){
						default:
						if (iconP2.winningIcon == true){
							iconP2.animation.play('Winning');
						}
							iconP1.animation.curAnim.curFrame = 1;
					}
				}
				else{
					switch (dad.curCharacter){
						default: 
							iconP1.animation.curAnim.curFrame = 0;
					}
				}
		
				if (healthBar.percent > 80){
					switch (dad.curCharacter){
						default: 
							iconP2.animation.curAnim.curFrame = 1;
					}
				}
				else{
					switch (dad.curCharacter){
						default: 
							iconP2.animation.curAnim.curFrame = 0;
					}
				}
			}
		else{
			if (healthBar.percent < 20)
				iconP2.animation.curAnim.curFrame = 1;
			else
				iconP2.animation.curAnim.curFrame = 0;
	
			if (healthBar.percent > 80)
				iconP1.animation.curAnim.curFrame = 1;
			else
				iconP1.animation.curAnim.curFrame = 0;
		}

		/* if (FlxG.keys.justPressed.NINE)
			FlxG.switchState(new Charting()); */

		#if debug
		if (FlxG.keys.justPressed.SIX)
		{
			if (useVideo)
				{
					GlobalVideo.get().stop();
					remove(videoSprite);
					FlxG.stage.window.onFocusOut.remove(focusOut);
					FlxG.stage.window.onFocusIn.remove(focusIn);
					removedVideo = true;
				}

			FlxG.switchState(new AnimationDebug(SONG.player2));
			FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN,handleInput);
			FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP, releaseInput);
			#if windows
			if (luaModchart != null)
			{
				luaModchart.die();
				luaModchart = null;
			}
			#end
		}

		if (FlxG.keys.justPressed.ZERO)
		{
			FlxG.switchState(new AnimationDebug(SONG.player1));
			FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN,handleInput);
			FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP, releaseInput);
			#if windows
			if (luaModchart != null)
			{
				luaModchart.die();
				luaModchart = null;
			}
			#end
		}

		#end

		if (startingSong)
			{
				if (startedCountdown)
				{
					Conductor.songPosition += FlxG.elapsed * 1000;
					if (Conductor.songPosition >= 0)
						if (curSong.toLowerCase() != 'too slow' || curSong.toLowerCase() != 'cycles' || curSong.toLowerCase() != 'execution')
						{
							startSong();
						}
				}
			}
			else
			{
				// Conductor.songPosition = FlxG.sound.music.time;
				Conductor.songPosition += FlxG.elapsed * 1000;
				/*@:privateAccess
				{
					FlxG.sound.music._channel.
				}*/
				songPositionBar = Conductor.songPosition;
	
				if (!paused)
				{
					songTime += FlxG.game.ticks - previousFrameTime;
					previousFrameTime = FlxG.game.ticks;
	
					// Interpolation type beat
					if (Conductor.lastSongPos != Conductor.songPosition)
					{
						songTime = (songTime + Conductor.songPosition) / 2;
						Conductor.lastSongPos = Conductor.songPosition;
						// Conductor.songPosition += FlxG.elapsed * 1000;
						// trace('MISSED FRAME');
					}
				}
	
				// Conductor.lastSongPos = FlxG.sound.music.time;
			}
		if(inScene == false)	 
			{
		if (generatedMusic && PlayState.SONG.notes[Std.int(curStep / 16)] != null && inScene == false)
		{
			closestNotes = [];

			notes.forEachAlive(function(daNote:Note)
			{
				if (daNote.canBeHit && daNote.mustPress && !daNote.tooLate && !daNote.wasGoodHit)
					closestNotes.push(daNote);
			}); // Collect notes that can be hit

			closestNotes.sort((a, b) -> Std.int(a.strumTime - b.strumTime));

			if (closestNotes.length != 0)
				FlxG.watch.addQuick("Current Note",closestNotes[0].strumTime - Conductor.songPosition);
			// Make sure Girlfriend cheers only for certain songs
			if(allowedToHeadbang)
			{
				// Don't animate GF if something else is already animating her (eg. train passing)
				if(gf.animation.curAnim.name == 'danceLeft' || gf.animation.curAnim.name == 'danceRight' || gf.animation.curAnim.name == 'idle')
				{
					// Per song treatment since some songs will only have the 'Hey' at certain times
					switch(curSong)
					{
						case 'Philly Nice':
						{
							// General duration of the song
							if(curBeat < 250)
							{
								// Beats to skip or to stop GF from cheering
								if(curBeat != 184 && curBeat != 216)
								{
									if(curBeat % 16 == 8)
									{
										// Just a garantee that it'll trigger just once
										if(!triggeredAlready)
										{
											gf.playAnim('cheer');
											triggeredAlready = true;
										}
									}else triggeredAlready = false;
								}
							}
						}
						case 'Bopeebo':
						{
							// Where it starts || where it ends
							if(curBeat > 5 && curBeat < 130)
							{
								if(curBeat % 8 == 7)
								{
									if(!triggeredAlready)
									{
										gf.playAnim('cheer');
										triggeredAlready = true;
									}
								}else triggeredAlready = false;
							}
						}
						case 'Blammed':
						{
							if(curBeat > 30 && curBeat < 190)
							{
								if(curBeat < 90 || curBeat > 128)
								{
									if(curBeat % 4 == 2)
									{
										if(!triggeredAlready)
										{
											gf.playAnim('cheer');
											triggeredAlready = true;
										}
									}else triggeredAlready = false;
								}
							}
						}
						case 'Cocoa':
						{
							if(curBeat < 170)
							{
								if(curBeat < 65 || curBeat > 130 && curBeat < 145)
								{
									if(curBeat % 16 == 15)
									{
										if(!triggeredAlready)
										{
											gf.playAnim('cheer');
											triggeredAlready = true;
										}
									}else triggeredAlready = false;
								}
							}
						}
						case 'Eggnog':
						{
							if(curBeat > 10 && curBeat != 111 && curBeat < 220)
							{
								if(curBeat % 8 == 7)
								{
									if(!triggeredAlready)
									{
										gf.playAnim('cheer');
										triggeredAlready = true;
									}
								}else triggeredAlready = false;
							}
						}
					}
				}
			}
			
			#if windows
			if (luaModchart != null)
				luaModchart.setVar("mustHit",PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection);
			#end

	if (camLocked)
		{	
			if (camFollow.x != dad.getMidpoint().x + 150 && !PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection && autoCam && inScene == false)
			{
				var offsetX = 0;
				var offsetY = 0;
				#if windows
				if (luaModchart != null)
				{
					offsetX = luaModchart.getVar("followXOffset", "float");
					offsetY = luaModchart.getVar("followYOffset", "float");
				}
				#end
				camFollow.setPosition(dad.getMidpoint().x + 150 + offsetX, dad.getMidpoint().y - 100 + offsetY);
				if (curStage == 'vecindario'){
					defaultCamZoom = 0.8;
				}

				if(inScene == false)
					{
			         switch(curStage)
					 {
							case 'bonus':	camFollow.setPosition(boyfriend.getMidpoint().x -450, boyfriend.getMidpoint().y - 165);
							default :
							camFollow.setPosition(dad.getMidpoint().x + 150 + offsetX, dad.getMidpoint().y - 100 + offsetY);
					 }
				
					}
				#if windows
				if (luaModchart != null)
					luaModchart.executeState('playerTwoTurn', []);
				#end
				// camFollow.setPosition(lucky.getMidpoint().x - 120, lucky.getMidpoint().y + 210);

				switch (dad.curCharacter)
				{
					case 'mom':
						camFollow.y = dad.getMidpoint().y;
					case 'senpai' | 'senpai-angry':
						camFollow.y = dad.getMidpoint().y - 430;
						camFollow.x = dad.getMidpoint().x - 100;
					case 'black':
						camFollow.y = dad.getMidpoint().y - 200;
						camFollow.x = dad.getMidpoint().x - 400;
					case 'oldsonicLordX' | 'sonic' | 'sunky':
						camFollow.y = dad.getMidpoint().y - 30;
						camFollow.x = dad.getMidpoint().x + 120;
					case 'spookyBOO':
						camFollow.x = dad.getMidpoint().x - -400;
					case 'taki':
						camFollow.x = dad.getMidpoint().x - -400;
						camFollow.y = dad.getMidpoint().y - -100;	
					case 'unknownfile-alt':
						camFollow.setPosition(dad.getMidpoint().x - 800 + offsetX, dad.getMidpoint().y - 0 + offsetY);
					case 'unkownfile':
						camFollow.setPosition(dad.getMidpoint().x + 150 + offsetX, dad.getMidpoint().y - 100 + offsetY);
					case 'sonic-tgt' | 'sonic-forced' | 'sonic-mad':
						camFollow.y = dad.getMidpoint().y - 30;		
					case 'sonicLordX':
						camFollow.y = dad.getMidpoint().y - 25;
						camFollow.x = dad.getMidpoint().x + 120;
					case 'TDoll' | 'TDollAlt':
						camFollow.y = dad.getMidpoint().y - 200;
						camFollow.x = dad.getMidpoint().x + 130;
					case 'boo':
						camFollow.y = dad.getMidpoint().y - 100;
						camFollow.x = dad.getMidpoint().x + 175;
					case 'fleetway':
						camFollow.y = dad.getMidpoint().y - 100;
						camFollow.x = dad.getMidpoint().x + 100;
					case 'hall-monitor':
						camFollow.x -= 200;
						camFollow.y -= 180;
					case 'playrobot':
						camFollow.x -= 160;
						camFollow.y = boyfriend.getMidpoint().y - 100;
					case 'playrobot-crazy':
						camFollow.x -= 160;
						camFollow.y -= 10;
					case 'bigmonika':
						camFollow.y = dad.getMidpoint().y - 75;
						camFollow.x = dad.getMidpoint().x;	
					case 'sanic':
						camFollow.y = dad.getMidpoint().y + 700;
						camFollow.x = dad.getMidpoint().x + 700;
					case 'selever_angry':
						camFollow.y = dad.getMidpoint().y - 150;
						camFollow.x = dad.getMidpoint().x + 330;
					case 'happy':
						camFollow.y = dad.getMidpoint().y - 100;
					case 'sonic.exe':
						camFollow.y = dad.getMidpoint().y - 50;
					case 'sonic.exe alt':
						camFollow.y = dad.getMidpoint().y - 350;
						camFollow.x = dad.getMidpoint().x - 200;
					case 'knucks':
						camFollow.y = dad.getMidpoint().y + 50;
						camFollow.x = dad.getMidpoint().x - 200;
					case 'eggdickface':
						camFollow.y = dad.getMidpoint().y - 50;
						camFollow.x = dad.getMidpoint().x + 100;
					case 'beast-cam-fix':
						camFollow.y = dad.getMidpoint().y - 100;
						camFollow.x = dad.getMidpoint().x - 300;
				}

				if (tailscircle == '') // i rlly don't like how the camera moves while a character is flying.
					{
						camFollow.y += camY;
						camFollow.x += camX;
					}

				if (dad.curCharacter == 'mom')
					vocals.volume = 1;
			}

			if (PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection && camFollow.x != boyfriend.getMidpoint().x - 100 && autoCam && inScene == false)
			{
				var offsetX = 0;
				var offsetY = 0;
				#if windows
				if (luaModchart != null)
				{
					offsetX = luaModchart.getVar("followXOffset", "float");
					offsetY = luaModchart.getVar("followYOffset", "float");
				}
				#end
				camFollow.setPosition(boyfriend.getMidpoint().x - 100 + offsetX, boyfriend.getMidpoint().y - 100 + offsetY);
				if (curStage == 'vecindario'){
					defaultCamZoom = 1;
				}

				if(inScene == false)
					{
			         switch(curStage)
					 {
							case 'bonus':	camFollow.setPosition(boyfriend.getMidpoint().x - 370, boyfriend.getMidpoint().y - 165);
							default :
							camFollow.setPosition(boyfriend.getMidpoint().x - 100 + offsetX, boyfriend.getMidpoint().y - 100 + offsetY);
					 }
				
					}

				#if windows
				if (luaModchart != null)
					luaModchart.executeState('playerOneTurn', []);
				#end

				switch (curStage)
				{
					case 'limo':
						camFollow.x = boyfriend.getMidpoint().x - 300;
					case 'mall':
						camFollow.y = boyfriend.getMidpoint().y - 200;
					case 'school','schoolEvil','snake-spy':
						camFollow.x = boyfriend.getMidpoint().x - 200;
						camFollow.y = boyfriend.getMidpoint().y - 200;
					case 'nevada','auditorHell':
						camFollow.y = boyfriend.getMidpoint().y - 300;
					case 'spookyBOO': 
						camFollow.x = boyfriend.getMidpoint().x - 250;
						camFollow.y = boyfriend.getMidpoint().y - 200;
					case 'unknownfile':
						camFollow.setPosition(boyfriend.getMidpoint().x - 700 + offsetX, boyfriend.getMidpoint().y - 300 + offsetY);
					case 'unkownfile-alt':
						camFollow.setPosition(boyfriend.getMidpoint().x - 100 + offsetX, boyfriend.getMidpoint().y - 100 + offsetY);
					case 'iglesia':
						camFollow.y = boyfriend.getMidpoint().y - 250;
					case 'stageSpook':
						camFollow.x = boyfriend.getMidpoint().x - 200;
						camFollow.y = boyfriend.getMidpoint().y - 125;
					case 'honor':
						camFollow.y = boyfriend.getMidpoint().y - 200;
						camFollow.x = boyfriend.getMidpoint().x - 250;
					case 'woods':
						camFollow.x = boyfriend.getMidpoint().x - 250;
						camFollow.y = boyfriend.getMidpoint().y - 160;
					case 'barnblitz-heavy':
						camFollow.y = boyfriend.getMidpoint().y - 250;
						camFollow.x = boyfriend.getMidpoint().x - 300;
					case 'softmallEvil':
						camFollow.y = boyfriend.getMidpoint().y - 200;
						camFollow.x = boyfriend.getMidpoint().x - 100;
					case 'hapenis':
						camFollow.x = boyfriend.getMidpoint().x + 300;
					case 'fleet':
						camFollow.x = boyfriend.getMidpoint().x + 40;
						camFollow.y = boyfriend.getMidpoint().y - 25;
					case 'SONICexestage':
						camFollow.x = boyfriend.getMidpoint().x - 170;
					case 'degroot':
						camFollow.y = boyfriend.getMidpoint().y - 225;
						camFollow.x = boyfriend.getMidpoint().x - 250;
				}

				switch (boyfriend.curCharacter) // camerathingy for diffrent bf's
				{
					case 'bf-perspective-flipped':
						camFollow.y = boyfriend.getMidpoint().y - 250;
						camFollow.x = boyfriend.getMidpoint().x - 300;
					case 'bf-perspective':
						camFollow.y = boyfriend.getMidpoint().y - 250;
						camFollow.x = boyfriend.getMidpoint().x + 300;
					case 'bf-pixel-alt':
						camFollow.y = boyfriend.getMidpoint().y - 250;
						camFollow.x = boyfriend.getMidpoint().x - 300;
					case 'bf-flipped':
						camFollow.y = boyfriend.getMidpoint().y;
						camFollow.x = boyfriend.getMidpoint().x + 100;
					case 'bf-flipped-for-cam':
						camFollow.y = boyfriend.getMidpoint().y - 40;
						camFollow.x = boyfriend.getMidpoint().x + 100;
				}
			}
		}
	}	
	}
		if (camZooming)
		{
			if (FlxG.save.data.zoom < 0.8)
				FlxG.save.data.zoom = 0.8;
	
			if (FlxG.save.data.zoom > 1.2)
				FlxG.save.data.zoom = 1.2;
			if (!executeModchart)
				{
					FlxG.camera.zoom = FlxMath.lerp(defaultCamZoom, FlxG.camera.zoom, 0.95);
					camHUD.zoom = FlxMath.lerp(FlxG.save.data.zoom, camHUD.zoom, 0.95);
	
					camNotes.zoom = camHUD.zoom;
					camSustains.zoom = camHUD.zoom;
				}
				else
				{
					FlxG.camera.zoom = FlxMath.lerp(defaultCamZoom, FlxG.camera.zoom, 0.95);
					camHUD.zoom = FlxMath.lerp(1, camHUD.zoom, 0.95);
	
					camNotes.zoom = camHUD.zoom;
					camSustains.zoom = camHUD.zoom;
				}
		}

		FlxG.watch.addQuick("beatShit", curBeat);
		FlxG.watch.addQuick("stepShit", curStep);

		if (chatTxt.overlaps(usernameTxt))
			{
				chatTxt.x += 1;
			}

		if (curSong == 'Skill Issue')
			{
				randomUsername = [
					"Sn1p3rG4M1NG",
					"SsniperxxX666",
					"xxShadowSniperxx",
					"Iamnotabot"
				];
		
				randomText = [
					"Git Gud M8",
					"Skill issue",
					"Problem?"
				];
			}

		if (curSong == 'Fresh')
		{
			switch (curBeat)
			{
				case 16:
					camZooming = true;
					gfSpeed = 2;
				case 48:
					gfSpeed = 1;
				case 80:
					gfSpeed = 2;
				case 112:
					gfSpeed = 1;
				case 163:
					// FlxG.sound.music.stop();
					// FlxG.switchState(new TitleState());
			}
		}

		if (curSong == 'Bopeebo')
		{
			switch (curBeat)
			{
				case 128, 129, 130:
					vocals.volume = 0;
					// FlxG.sound.music.stop();
					// FlxG.switchState(new PlayState());
			}
		}

		if (curSong == 'Piracy')
			{
				switch (curStep)
					{
						case 1024:
							teleportShit();
						case 1280 | 1904:
							teleportBack();
						case 1664:
							teleportShit();
					}
			}

		if(curStage == 'defeat' && misses == 1 && camHUD.visible)
			{
				camSustains.visible = false;
				camNotes.visible = false;
				camHUD.visible = false;
				inCutscene = true;
				canPause = false;
				camZooming = false;
				startedCountdown = false;
				generatedMusic = false;
		
				vocals.stop();
	
				camFollow.setPosition(dad.getMidpoint().x - 400, dad.getMidpoint().y - 170);	
				dad.changeHoldState(true);
				boyfriend.changeHoldState(true);
				dad.visible = false;
				
				var fakedad:FlxSprite = new FlxSprite();
				fakedad.frames = Paths.getSparrowAtlas('characters/black');
				fakedad.animation.addByPrefix('death', 'BLACK DEATH', 24, false);
				fakedad.setPosition(dad.x - 252, dad.y - 238);
				add(fakedad);
				//fakedad.setGraphicSize(Std.int(fakedad.width * 2.35));
				fakedad.animation.play('death');
				//defaultCamZoom = 0.9;
				fakedad.animation.finishCallback = function(lol:String)
					{
						remove(fakedad);
					}	
	
				camFollow.y = dad.getMidpoint().y - 200;
				camFollow.x = dad.getMidpoint().x - 450;
	
				FlxG.sound.play(Paths.sound('black-death'));
				
				FlxTween.tween(FlxG.camera, {zoom: 1.2}, 1.5, {ease: FlxEase.circOut});
	
				new FlxTimer().start(0.6, function(tmr:FlxTimer)
				{
					boyfriend.stunned = true;
	
					persistentUpdate = false;
					persistentDraw = false;
					paused = true;
	
					vocals.stop();
					FlxG.sound.music.stop();
	
					openSubState(new GameOverSubstate(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
	
					#if windows
					// Game Over doesn't get his own variable because it's only used here
					DiscordClient.changePresence("GAME OVER -- "
						+ SONG.song
						+ " ("
						+ storyDifficultyText
						+ ") "
						+ Ratings.GenerateLetterRank(accuracy),
						"\nAcc: "
						+ HelperFunctions.truncateFloat(accuracy, 2)
						+ "% | Score: "
						+ songScore
						+ " | Misses: "
						+ misses, iconRPC);
					#end
	
					// FlxG.switchState(new GameOverState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
				});
			}

		if (FlxG.save.data.noMiss && misses == 1 || FlxG.save.data.sickOnly && misses == 1)
			{
				boyfriend.stunned = true;
		
				persistentUpdate = false;
				persistentDraw = false;
				paused = true;
		
				vocals.stop();
				FlxG.sound.music.stop();
		
				if (weirdstatic != null) {
					remove(weirdstatic);
					weirdstatic.kill();
				}
				if (penissound != null) {
					FlxG.sound.list.remove(penissound);
					penissound.kill();
				}
		
				openSubState(new GameOverSubstate(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
		
				#if windows
				// Game Over doesn't get his own variable because it's only used here
				DiscordClient.changePresence("GAME OVER -- " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy),"\nAcc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
				#end
		
				// FlxG.switchState(new GameOverState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
				}

		if (health <= 0 && !cannotDie)
		{
			boyfriend.stunned = true;

			persistentUpdate = false;
			persistentDraw = false;
			paused = true;

			vocals.stop();
			FlxG.sound.music.stop();

			if (weirdstatic != null) {
				remove(weirdstatic);
				weirdstatic.kill();
			}
			if (penissound != null) {
				FlxG.sound.list.remove(penissound);
				penissound.kill();
			}

			openSubState(new GameOverSubstate(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));

			#if windows
			// Game Over doesn't get his own variable because it's only used here
			DiscordClient.changePresence("GAME OVER -- " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy),"\nAcc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
			#end

			// FlxG.switchState(new GameOverState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
		}
 		if (!inCutscene && FlxG.save.data.resetButton)
		{
			if(FlxG.keys.justPressed.R)
				{
					boyfriend.stunned = true;

					persistentUpdate = false;
					persistentDraw = false;
					paused = true;
		
					vocals.stop();
					FlxG.sound.music.stop();

					if (weirdstatic != null) {
						remove(weirdstatic);
						weirdstatic.kill();
					}
					if (penissound != null) {
						FlxG.sound.list.remove(penissound);
						penissound.kill();
					}		
		
					openSubState(new GameOverSubstate(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
		
					#if windows
					// Game Over doesn't get his own variable because it's only used here
					DiscordClient.changePresence("GAME OVER -- " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy),"\nAcc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
					#end
		
					// FlxG.switchState(new GameOverState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
				}
		}

		if (unspawnNotes[0] != null)
		{
			if (unspawnNotes[0].strumTime - Conductor.songPosition < 3500)
			{
				var dunceNote:Note = unspawnNotes[0];
				notes.add(dunceNote);

				var index:Int = unspawnNotes.indexOf(dunceNote);
				unspawnNotes.splice(index, 1);
			}
		}

		if (spookyRendered) // move shit around all spooky like
			{
				spookyText.angle = FlxG.random.int(-5,5); // change its angle between -5 and 5 so it starts shaking violently.
				//tstatic.x = tstatic.x + FlxG.random.int(-2,2); // move it back and fourth to repersent shaking.
				if (tstatic.alpha != 0)
					tstatic.alpha = FlxG.random.float(0.1,0.5); // change le alpha too :)
			}

		switch(mania)
		{
			case 0: 
				sDir = ['LEFT', 'DOWN', 'UP', 'RIGHT'];
			case 1: 
				sDir = ['LEFT', 'UP', 'RIGHT', 'LEFT', 'DOWN', 'RIGHT'];
			case 2: 
				sDir = ['LEFT', 'DOWN', 'UP', 'RIGHT', 'UP', 'LEFT', 'DOWN', 'UP', 'RIGHT'];
			case 3: 
				sDir = ['LEFT', 'DOWN', 'UP', 'UP', 'RIGHT'];
			case 4: 
				sDir = ['LEFT', 'UP', 'RIGHT', 'UP', 'LEFT', 'DOWN', 'RIGHT'];
			case 5: 
				sDir = ['LEFT', 'DOWN', 'UP', 'RIGHT', 'LEFT', 'DOWN', 'UP', 'RIGHT'];
			case 6: 
				sDir = ['UP'];
			case 7: 
				sDir = ['LEFT', 'RIGHT'];
			case 8:
				sDir = ['LEFT', 'UP', 'RIGHT'];
		}

		if (generatedMusic)
			{
				var holdArray:Array<Bool> = [controls.LEFT, controls.DOWN, controls.UP, controls.RIGHT];

				switch(mania)
				{
					case 0: 
						holdArray = [controls.LEFT, controls.DOWN, controls.UP, controls.RIGHT];
					case 1: 
						holdArray = [controls.L1, controls.U1, controls.R1, controls.L2, controls.D1, controls.R2];
					case 2: 
						holdArray = [controls.N0, controls.N1, controls.N2, controls.N3, controls.N4, controls.N5, controls.N6, controls.N7, controls.N8];
					case 3: 
						holdArray = [controls.LEFT, controls.DOWN, controls.N4, controls.UP, controls.RIGHT];
					case 4: 
						holdArray = [controls.L1, controls.U1, controls.R1, controls.N4, controls.L2, controls.D1, controls.R2];
					case 5: 
						holdArray = [controls.N0, controls.N1, controls.N2, controls.N3, controls.N5, controls.N6, controls.N7, controls.N8];
					case 6: 
						holdArray = [controls.N4];
					case 7: 
						holdArray = [controls.LEFT, controls.RIGHT];
					case 8: 
						holdArray = [controls.LEFT, controls.N4, controls.RIGHT];
				}
				notes.forEachAlive(function(daNote:Note)
				{	
					if (ghostNotes && !daNote.alreadyTweened && daNote.isOnScreen()){
						if (Conductor.songPosition - daNote.strumTime < 300)
						    ghostNote(daNote);
					}

					// instead of doing stupid y > FlxG.height
					// we be men and actually calculate the time :)
					if (daNote.tooLate)
					{
						daNote.active = false;
						daNote.visible = false;
					}
					else
					{
						daNote.visible = true;
						daNote.active = true;
					}
					
					if (!daNote.modifiedByLua)
						{
							if (PlayStateChangeables.useDownscroll)
							{
								if (daNote.mustPress)
									daNote.y = (playerStrums.members[Math.floor(Math.abs(daNote.noteData))].y
										+ 0.45 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed,
											2)) - daNote.noteYOff;
								else
									daNote.y = (strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].y
										+ 0.45 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed,
											2)) - daNote.noteYOff;
								if (daNote.isSustainNote)
								{
									// Remember = minus makes notes go up, plus makes them go down
									if (daNote.animation.curAnim.name.endsWith('end') && daNote.prevNote != null)
										daNote.y += daNote.prevNote.height;
									else
										daNote.y += daNote.height / 2;
		
									// If not in botplay, only clip sustain notes when properly hit, botplay gets to clip it everytime
									if (!PlayStateChangeables.botPlay)
									{
										if ((!daNote.mustPress || daNote.wasGoodHit || daNote.prevNote.wasGoodHit || holdArray[Math.floor(Math.abs(daNote.noteData))] && !daNote.tooLate)
											&& daNote.y - daNote.offset.y * daNote.scale.y + daNote.height >= (strumLine.y + Note.swagWidth / 2))
										{
											// Clip to strumline
											var swagRect = new FlxRect(0, 0, daNote.frameWidth * 2, daNote.frameHeight * 2);
											swagRect.height = (strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].y
												+ Note.swagWidth / 2
												- daNote.y) / daNote.scale.y;
											swagRect.y = daNote.frameHeight - swagRect.height;
		
											daNote.clipRect = swagRect;
										}
									}
									else
									{
										var swagRect = new FlxRect(0, 0, daNote.frameWidth * 2, daNote.frameHeight * 2);
										swagRect.height = (strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].y
											+ Note.swagWidth / 2
											- daNote.y) / daNote.scale.y;
										swagRect.y = daNote.frameHeight - swagRect.height;
		
										daNote.clipRect = swagRect;
									}
								}
							}
							else
							{
								if (daNote.mustPress)
									daNote.y = (playerStrums.members[Math.floor(Math.abs(daNote.noteData))].y
										- 0.45 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed,
											2)) + daNote.noteYOff;
								else
									daNote.y = (strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].y
										- 0.45 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed,
											2)) + daNote.noteYOff;
								if (daNote.isSustainNote)
								{
									daNote.y -= daNote.height / 2;
		
									if (!PlayStateChangeables.botPlay)
									{
										if ((!daNote.mustPress || daNote.wasGoodHit || daNote.prevNote.wasGoodHit || holdArray[Math.floor(Math.abs(daNote.noteData))] && !daNote.tooLate)
											&& daNote.y + daNote.offset.y * daNote.scale.y <= (strumLine.y + Note.swagWidth / 2))
										{
											// Clip to strumline
											var swagRect = new FlxRect(0, 0, daNote.width / daNote.scale.x, daNote.height / daNote.scale.y);
											swagRect.y = (strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].y
												+ Note.swagWidth / 2
												- daNote.y) / daNote.scale.y;
											swagRect.height -= swagRect.y;
		
											daNote.clipRect = swagRect;
										}
									}
									else
									{
										var swagRect = new FlxRect(0, 0, daNote.width / daNote.scale.x, daNote.height / daNote.scale.y);
										swagRect.y = (strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].y
											+ Note.swagWidth / 2
											- daNote.y) / daNote.scale.y;
										swagRect.height -= swagRect.y;
		
										daNote.clipRect = swagRect;
									}
								}
							}
						}
		
					if (!daNote.mustPress && daNote.wasGoodHit)
					{
						if (SONG.song != 'Tutorial' && !songIsWeird)
							camZooming = true;
						if (dad.curCharacter == 'sonic.exe')
							{
								FlxG.camera.shake(0.005, 0.50);
							}
						if (soldierShake)
							FlxG.camera.shake(0.015,0.04);
						if (curSong.toLowerCase() == 'honorbound' && health >= 0.1)
							health -= 0.02;
						var altAnim:String = "";
						var healthtolower:Float = 0.02;
	
						if (SONG.notes[Math.floor(curStep / 16)] != null)
						{
							if (SONG.notes[Math.floor(curStep / 16)].altAnim)
								if (SONG.song.toLowerCase() != "cheating")
									{
										altAnim = '-alt';
									}
									else
									{
										healthtolower = 0.005;
									}
						}

						if (!(curStep >= 1783 && curStep <= 1791  && curSong =="infitrigger"))
							{   var singData:Int = Std.int(Math.abs(daNote.noteData));
	
								dad.playAnim('sing' + sDir[daNote.noteData] + altAnim, true);
							}

						if (tailscircle == 'circling' && dad.curCharacter == 'TDoll')
							{
								add(ezTrail);
							}
		
						if (curSong.toLowerCase() == 'sunshine' && curStep > 588 && curStep < 860 && !daNote.isSustainNote)
							{
								playerStrums.forEach(function(spr:FlxSprite)
								{
									spr.alpha = 0.7;
									if (spr.alpha != 0)
									{
										new FlxTimer().start(0.01, function(trol:FlxTimer)
										{
											spr.alpha -= 0.03;
											if (spr.alpha != 0)
												trol.reset();
										});
									}
								});
							}

						if (SONG.song.toLowerCase() == 'unknown suffering' && health > 0.05)
							{
								health -= 0.03;
							}

						if (dad.curCharacter == 'selever_angry'/*SONG.song.toLowerCase() == 'attack'*/ && health > 0.05)
							{
								if (daNote.isSustainNote)
									{
										health -= 0.005;
									}
									else
										health -= 0.025;
							}

						if(curSong.toLowerCase() == 'unknown suffering')
							{
								FlxG.camera.shake(0.005, 0.1);
								camHUD.shake(0.005, 0.1);
								camNotes.shake(0.005, 0.1);
							}

						if(dad.curCharacter == 'bambi-3d')
							{
								FlxG.camera.shake(0.0075, 0.1);
								camHUD.shake(0.0045, 0.1);
								camNotes.shake(0.0045, 0.1);
							}

						if (daNote.alt || daNote.exealt)
							altAnim = '-alt';


									switch (swaggyOptim)
									{
										case 3:
											switch (curTiming)
											{
												case 0:
													if (!slashThingie)
														dad.playAnim('sing' + sDir[daNote.noteData] + altAnim, true);
												case 1:
													if (!slashThingie)
														dad.playAnim('sing' + sDir[daNote.noteData] + '-alt', true);
											}
										default:
											dad.playAnim('sing' + sDir[daNote.noteData] + altAnim, true);
									}
						/*if (daNote.isSustainNote)
						{
							health -= SONG.noteValues[0] / 3;
						}
						else
							health -= SONG.noteValues[0];
						*/

						if (FlxG.save.data.enemyDrain && curSong.toLowerCase() != 'honorbound' && curSong.toLowerCase() != 'unknown suffering' && dad.curCharacter != 'taki' && dad.curCharacter != 'selever_angry' && dad.curCharacter != 'neomonster' && dad.curCharacter != 'hellron' && health > 0.05){
							if (daNote.isSustainNote)
								{
									health -= 0.0125;
								}
							else
								if (curSong.toLowerCase() == 'no villains' && curStep == 1664)
									health -= 0.1;
								else
									health -= 0.05;
						}
						switch(dad.curCharacter)
							{
								case 'tricky': // 20% chance
									if (FlxG.random.bool(20) && !spookyRendered && !daNote.isSustainNote) // create spooky text :flushed:
										{
											createSpookyText(TrickyLinesSing[FlxG.random.int(0,TrickyLinesSing.length)]);
										}
								case 'extricky': // 60% chance
									if (FlxG.random.bool(60) && !spookyRendered && !daNote.isSustainNote) // create spooky text :flushed:
										{
											createSpookyText(ExTrickyLinesSing[FlxG.random.int(0,ExTrickyLinesSing.length)]);
										}
								case 'taki':
									health -= 0.02;
									gf.playAnim('scared');		
							}
						if (dad.curCharacter == 'neomonster')
							{
								FlxG.camera.shake(0.015, 0.1);
								camHUD.shake(0.005, 0.1);
								camNotes.shake(0.005, 0.1);
							}

						//shakes the fuck out of your screen and hud -ekical
						//now it drains your health because fuck you -ekical
						if (dad.curCharacter == 'hellron')
							{
								FlxG.camera.shake(0.025, 0.1);
								camHUD.shake(0.0055, 0.15);
								camNotes.shake(0.0055, 0.15);
								health -= 0.005;
							}

						if (FlxG.save.data.cpuStrums)
						{
							cpuStrums.forEach(function(spr:FlxSprite)
							{
								if (Math.abs(daNote.noteData) == spr.ID)
								{
									spr.animation.play('confirm', true);
								}
								if (spr.animation.curAnim.name == 'confirm' && !curStage.startsWith('school'))
								{
									spr.centerOffsets();

									switch(mania)
									{
										case 0: 
											spr.offset.x -= 13;
											spr.offset.y -= 13;
										case 1: 
											if (SONG.noteStyle == 'pixel'){
												spr.offset.x -= 0;
												spr.offset.y -= 0;
											}
											else{
												spr.offset.x -= 16;
												spr.offset.y -= 16;
											}
										case 2: 
											spr.offset.x -= 22;
											spr.offset.y -= 22;
										case 3: 
											spr.offset.x -= 15;
											spr.offset.y -= 15;
										case 4: 
											spr.offset.x -= 18;
											spr.offset.y -= 18;
										case 5: 
											spr.offset.x -= 20;
											spr.offset.y -= 20;
										case 6: 
											spr.offset.x -= 13;
											spr.offset.y -= 13;
										case 7: 
											spr.offset.x -= 13;
											spr.offset.y -= 13;
										case 8:
											spr.offset.x -= 13;
											spr.offset.y -= 13;
									}
								}
								else
									spr.centerOffsets();
							});
						}
	
						#if windows
						if (luaModchart != null)
							luaModchart.executeState('playerTwoSing', [Math.abs(daNote.noteData), Conductor.songPosition]);
						#end

						switch (SONG.song.toLowerCase())
						{
							case 'cheating':
								health -= healthtolower;
							/*default:
								if (FlxG.save.data.healthdrain && health > 0.2)
								{
									if (daNote.noteData >= 0)
										health -= 0.01725;
									else
										health -= 0.003;
									if (health < 0.2)
										health = 0.2;
								}*/
						}
						
						dad.holdTimer = 0;
						if (SONG.needsVoices)
							vocals.volume = 1;
	
						daNote.active = false;


						daNote.kill();
						notes.remove(daNote, true);
						daNote.destroy();
					}

					if (daNote.mustPress && !daNote.modifiedByLua)
						{
							daNote.visible = playerStrums.members[Math.floor(Math.abs(daNote.noteData))].visible;
							daNote.x = playerStrums.members[Math.floor(Math.abs(daNote.noteData))].x;
							if (!daNote.isSustainNote)
								daNote.modAngle = playerStrums.members[Math.floor(Math.abs(daNote.noteData))].angle;
							if (daNote.sustainActive)
							{
								if (executeModchart && !FlxG.save.data.ghostNotes && SONG.song.toLowerCase() != 'infiltrator')
									daNote.alpha = playerStrums.members[Math.floor(Math.abs(daNote.noteData))].alpha;
							}
							daNote.modAngle = playerStrums.members[Math.floor(Math.abs(daNote.noteData))].angle;
						}
						else if (!daNote.wasGoodHit && !daNote.modifiedByLua)
						{
							daNote.visible = strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].visible;
							daNote.x = strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].x;
							if (!daNote.isSustainNote)
								daNote.modAngle = strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].angle;
							if (daNote.sustainActive)
							{
								if (executeModchart && !FlxG.save.data.ghostNotes && SONG.song.toLowerCase() != 'infiltrator')
									daNote.alpha = playerStrums.members[Math.floor(Math.abs(daNote.noteData))].alpha;
							}
							daNote.modAngle = strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].angle;
						}
		
						if (daNote.isSustainNote)
						{
							daNote.x += daNote.width / 2 + 20;
							if (SONG.noteStyle == 'pixel')
								daNote.x -= 11;
						}
					
						if (FlxG.save.data.invisibleNotes){
							daNote.alpha = 0;
						}

						switch (SONG.song.toLowerCase())
						{
							case 'algebra' | 'unknown suffering':
								if (FlxG.save.data.downscroll)
									daNote.y = (strumLine.y - (Conductor.songPosition - daNote.strumTime) * (-0.45 * FlxMath.roundDecimal(swagSpeed * daNote.LocalScrollSpeed, 2)));
								else
									daNote.y = (strumLine.y - (Conductor.songPosition - daNote.strumTime) * (0.45 * FlxMath.roundDecimal(swagSpeed * daNote.LocalScrollSpeed, 2)));
						}
					//trace(daNote.y);
					// WIP interpolation shit? Need to fix the pause issue
					// daNote.y = (strumLine.y - (songTime - daNote.strumTime) * (0.45 * PlayState.SONG.speed));
	
					if (daNote.isSustainNote && daNote.wasGoodHit && Conductor.songPosition >= daNote.strumTime)
						{
							daNote.kill();
							notes.remove(daNote, true);
							daNote.destroy();
						}
					else if ((daNote.mustPress && daNote.tooLate && !PlayStateChangeables.useDownscroll || daNote.mustPress && daNote.tooLate
						&& PlayStateChangeables.useDownscroll)
						&& daNote.mustPress)
					{

							switch (daNote.noteType)
							{
						
								case 0: //normal
								{
									if (daNote.isSustainNote && daNote.wasGoodHit)
										{
											daNote.kill();
											notes.remove(daNote, true);
										}
										else
										{
											if (loadRep && daNote.isSustainNote && isRing && daNote.noteData != 3)
											{
												// im tired and lazy this sucks I know i'm dumb
												if (findByTime(daNote.strumTime) != null)
													totalNotesHit += 1;
												else
												{
													vocals.volume = 0;
													if (theFunne && !daNote.isSustainNote)
													{
														noteMiss(daNote.noteData, daNote);
													}
													if (daNote.isParent)
													{
														health -= 0.15; // give a health punishment for failing a LN
														trace("hold fell over at the start");
														for (i in daNote.children)
														{
															i.alpha = 0.3;
															i.sustainActive = false;
														}
													}
													else
													{
														if (!daNote.wasGoodHit
															&& daNote.isSustainNote
															&& daNote.sustainActive
															&& daNote.spotInLine != daNote.parent.children.length)
														{
															health -= 0.2; // give a health punishment for failing a LN
															trace("hold fell over at " + daNote.spotInLine);
															for (i in daNote.parent.children)
															{
																i.alpha = 0.3;
																i.sustainActive = false;
															}
															if (daNote.parent.wasGoodHit)
																misses++;
															updateAccuracy();
														}
														else if (!daNote.wasGoodHit
															&& !daNote.isSustainNote)
														{
															health -= 0.15;
														}
													}
												}
											}
											else if (isRing && daNote.noteData != 3)
											{
												vocals.volume = 0;
												if (theFunne && !daNote.isSustainNote)
												{
													if (PlayStateChangeables.botPlay)
													{
														daNote.rating = "bad";
														goodNoteHit(daNote);
													}
													else
														noteMiss(daNote.noteData, daNote);
												}
				
												if (daNote.isParent)
												{
													health -= 0.15; // give a health punishment for failing a LN
													trace("hold fell over at the start");
													for (i in daNote.children)
													{
														i.alpha = 0.3;
														i.sustainActive = false;
														trace(i.alpha);
													}
												}
												else
												{
													if (!daNote.wasGoodHit
														&& daNote.isSustainNote
														&& daNote.sustainActive
														&& daNote.spotInLine != daNote.parent.children.length)
													{
														health -= 0.25; // give a health punishment for failing a LN
														trace("hold fell over at " + daNote.spotInLine);
														for (i in daNote.parent.children)
														{
															i.alpha = 0.3;
															i.sustainActive = false;
															trace(i.alpha);
														}
														if (daNote.parent.wasGoodHit)
															misses++;
														updateAccuracy();
													}
													else if (!daNote.wasGoodHit
														&& !daNote.isSustainNote)
													{
														health -= 0.15;
													}
												}
											}
											else if (loadRep && daNote.isSustainNote && !isRing)
											{
												// im tired and lazy this sucks I know i'm dumb
												if (findByTime(daNote.strumTime) != null)
													totalNotesHit += 1;
												else
												{
													vocals.volume = 0;
													if (theFunne && !daNote.isSustainNote)
													{
														noteMiss(daNote.noteData, daNote);
													}
													if (daNote.isParent)
													{
														health -= 0.15; // give a health punishment for failing a LN
														trace("hold fell over at the start");
														for (i in daNote.children)
														{
															i.alpha = 0.3;
															i.sustainActive = false;
														}
													}
													else
													{
														if (!daNote.wasGoodHit
															&& daNote.isSustainNote
															&& daNote.sustainActive
															&& daNote.spotInLine != daNote.parent.children.length)
														{
															health -= 0.2; // give a health punishment for failing a LN
															trace("hold fell over at " + daNote.spotInLine);
															for (i in daNote.parent.children)
															{
																i.alpha = 0.3;
																i.sustainActive = false;
															}
															if (daNote.parent.wasGoodHit)
																misses++;
															updateAccuracy();
														}
														else if (!daNote.wasGoodHit
															&& !daNote.isSustainNote)
														{
															health -= 0.15;
														}
													}
												}
											}
											else if (!isRing)
											{
												vocals.volume = 0;
												if (theFunne && !daNote.isSustainNote)
												{
													if (PlayStateChangeables.botPlay)
													{
														daNote.rating = "bad";
														goodNoteHit(daNote);
													}
													else
														noteMiss(daNote.noteData, daNote);
												}
				
												if (daNote.isParent)
												{
													health -= 0.15; // give a health punishment for failing a LN
													trace("hold fell over at the start");
													for (i in daNote.children)
													{
														i.alpha = 0.3;
														i.sustainActive = false;
														trace(i.alpha);
													}
												}
												else
												{
													if (!daNote.wasGoodHit
														&& daNote.isSustainNote
														&& daNote.sustainActive
														&& daNote.spotInLine != daNote.parent.children.length)
													{
														health -= 0.25; // give a health punishment for failing a LN
														trace("hold fell over at " + daNote.spotInLine);
														for (i in daNote.parent.children)
														{
															i.alpha = 0.3;
															i.sustainActive = false;
															trace(i.alpha);
														}
														if (daNote.parent.wasGoodHit)
															misses++;
														updateAccuracy();
													}
													else if (!daNote.wasGoodHit
														&& !daNote.isSustainNote)
													{
														health -= 0.15;
													}
												}
											}
										}
				
										daNote.visible = false;
										daNote.kill();
										notes.remove(daNote, true);
								}
								case 1: //fire notes - makes missing them not count as one
								{
									daNote.kill();
									notes.remove(daNote, true);
									daNote.destroy();
								}
								case 2: //halo notes, same as fire
								{
									daNote.kill();
									notes.remove(daNote, true);
									daNote.destroy();
								}
								case 3:  //warning notes, removes half health and then removed so it doesn't repeatedly deal damage
								{
									health -= 1;
									vocals.volume = 0;
									badNoteHit();
									daNote.kill();
									notes.remove(daNote, true);
									daNote.destroy();
								}
								case 4: //angel notes
								{
									daNote.kill();
									notes.remove(daNote, true);
									daNote.destroy();
								}
								case 6:  //bob notes
								{
									daNote.kill();
									notes.remove(daNote, true);
									daNote.destroy();
								}
								case 7: //gltich notes
								{
									HealthDrain();
									daNote.kill();
									notes.remove(daNote, true);
									daNote.destroy();
								}
								case 8 | 18:  //exe mod's static notes
								{
									if (cNum == 0)
										health -= 0.3;
									vocals.volume = 0;
									staticHitMiss();
									FlxG.sound.play(Paths.sound('ring'), .7);
									badNoteHit();
									daNote.kill();
									notes.remove(daNote, true);
									daNote.destroy();
									noteMiss(daNote.noteData, daNote);
								}
								case 9:  //bsod notes
								{
									daNote.kill();
									notes.remove(daNote, true);
									daNote.destroy();
								}
								case 10:  //markov notes
								{
									daNote.kill();
									notes.remove(daNote, true);
									daNote.destroy();
									vocals.volume = 1;
								}
								case 11:  //katana notes
								{
									health += -0.8;
									boyfriend.playAnim('hit', true);
									daNote.kill();
									notes.remove(daNote, true);
									daNote.destroy();
								}
								case 12:  //mouse notes
								{
									daNote.kill();
									notes.remove(daNote, true);
									daNote.destroy();
								}
								case 19:  // sage notes
								{
									doSpam();
									badNoteHit();
									daNote.kill();
									notes.remove(daNote, true);
									daNote.destroy();
									noteMiss(daNote.noteData, daNote);
								}
								case 22:  // drunk notes
								{
									tweenCam(1.55, 1);
									shakeCam = true;
									FlxG.sound.play(Paths.sound('A'));
									health -= 1;
									boyfriend.playAnim('hit', true);
					
									new FlxTimer().start(2, function(tmr:FlxTimer)
										{
											shakeCam = false;
											tweenCam(defaultCamZoom, 0.8);
										});

									badNoteHit();
									daNote.kill();
									notes.remove(daNote, true);
									daNote.destroy();
								}
							}
						}
						if(PlayStateChangeables.useDownscroll && daNote.y > strumLine.y ||
							!PlayStateChangeables.useDownscroll && daNote.y < strumLine.y)
							{
									// Force good note hit regardless if it's too late to hit it or not as a fail safe
									if(PlayStateChangeables.botPlay && daNote.canBeHit && daNote.mustPress ||
									PlayStateChangeables.botPlay && daNote.tooLate && daNote.mustPress)
									{
										if(loadRep)
										{
											//trace('ReplayNote ' + tmpRepNote.strumtime + ' | ' + tmpRepNote.direction);
											var n = findByTime(daNote.strumTime);
											trace(n);
											if(n != null)
											{
												goodNoteHit(daNote);
												boyfriend.holdTimer = daNote.sustainLength;
											}
										}else {
											if (!daNote.burning && !daNote.death && !daNote.bob && !daNote.bsod && !daNote.markov && !daNote.ebola && !daNote.disguise)
												{
													goodNoteHit(daNote);
													boyfriend.holdTimer = daNote.sustainLength;
													if (FlxG.save.data.cpuStrums)
														{
															playerStrums.forEach(function(spr:FlxSprite)
															{
																if (Math.abs(daNote.noteData) == spr.ID)
																{
																	spr.animation.play('confirm', true);
																}
																if(spr.animation.curAnim.name == 'confirm' && curStage.startsWith('bonus') && curStep >= 1797 && !FlxG.save.data.noTriggerFlip)						
																	{	
																		spr.offset.x = 5;
																		spr.offset.y = 5;
																	}
																else if (spr.animation.curAnim.name == 'confirm')
																{
																	spr.centerOffsets();
																	switch(mania)
																	{
																		case 0: 
																			spr.offset.x -= 13;
																			spr.offset.y -= 13;
																		case 1: 
																			if (SONG.noteStyle == 'pixel'){
																				spr.offset.x -= 0;
																				spr.offset.y -= 0;
																			}
																			else{
																				spr.offset.x -= 16;
																				spr.offset.y -= 16;
																			}
																		case 2: 
																			spr.offset.x -= 22;
																			spr.offset.y -= 22;
																		case 3: 
																			spr.offset.x -= 15;
																			spr.offset.y -= 15;
																		case 4: 
																			spr.offset.x -= 18;
																			spr.offset.y -= 18;
																		case 5: 
																			spr.offset.x -= 20;
																			spr.offset.y -= 20;
																		case 6: 
																			spr.offset.x -= 13;
																			spr.offset.y -= 13;
																		case 7: 
																			spr.offset.x -= 13;
																			spr.offset.y -= 13;
																		case 8:
																			spr.offset.x -= 13;
																			spr.offset.y -= 13;
																	}
																}
																else
																	spr.centerOffsets();
															});
														}
												}
											}
											
									}
							}
								
					
				});
				
			}

		if (FlxG.save.data.cpuStrums)
		{
			cpuStrums.forEach(function(spr:FlxSprite)
			{
				if (spr.animation.finished)
				{
					spr.animation.play('static');
					spr.centerOffsets();
				}
			});
			if (PlayStateChangeables.botPlay)
				{
					playerStrums.forEach(function(spr:FlxSprite)
						{
							if (spr.animation.finished)
							{
								spr.animation.play('static');
								spr.centerOffsets();
							}
						});
				}
		}

		if (!inCutscene && songStarted)
			keyShit();


		#if debug
		if (FlxG.keys.justPressed.ONE)
			endSong();
		#end
	}

	function createSpookyText(text:String, x:Float = -1111111111111, y:Float = -1111111111111):Void
		{
			spookySteps = curStep;
			spookyRendered = true;
			tstatic.alpha = 0.5;
			FlxG.sound.play(Paths.sound('staticSound'));
			spookyText = new FlxText((x == -1111111111111 ? FlxG.random.float(dad.x + 40,dad.x + 120) : x), (y == -1111111111111 ? FlxG.random.float(dad.y + 200, dad.y + 300) : y));
			spookyText.setFormat("Impact", 128, FlxColor.RED);
			spookyText.bold = true;
			spookyText.text = text;
			add(spookyText);
		}

	function endSong():Void
	{
		FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN,handleInput);
		FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP, releaseInput);
		if (useVideo)
			{
				GlobalVideo.get().stop();
				FlxG.stage.window.onFocusOut.remove(focusOut);
				FlxG.stage.window.onFocusIn.remove(focusIn);
				PlayState.instance.remove(PlayState.instance.videoSprite);
			}

		if (isStoryMode)
			campaignMisses = misses;
		
		if (!loadRep)
			rep.SaveReplay(saveNotes, saveJudge, replayAna);
		else
		{
			PlayStateChangeables.botPlay = false;
			PlayStateChangeables.scrollSpeed = 1;
			PlayStateChangeables.useDownscroll = false;
		}

		if (FlxG.save.data.fpsCap > 290)
			(cast (Lib.current.getChildAt(0), Main)).setFPSCap(290);

		#if windows
		if (luaModchart != null)
		{
			luaModchart.die();
			luaModchart = null;
		}
		#end

		canPause = false;
		FlxG.sound.music.volume = 0;
		vocals.volume = 0;
		FlxG.sound.music.pause();
		vocals.pause();

		var FUCKYOU:Bool = false;
		if (curSong == 'Skill Issue')
		{
			FUCKYOU = true;
			camHUD.visible = false;
			cpuStrums.forEach(function(spr:FlxSprite)
				{
					spr.alpha = 0;
				});
			playerStrums.forEach(function(spr:FlxSprite)
				{
					spr.alpha = 0;
				});
			camFollow.setPosition(dad.getMidpoint().x + 150, dad.getMidpoint().y - 100);
			new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					dad.debugMode = true;
					dad.playAnim('shot', true);
					new FlxTimer().start(0.13, function(tmr:FlxTimer)
						{
							health -= 10000000000000000; //skill issue! https://www.urbandictionary.com/define.php?term=skill%20issue
						});
				});

		}

		if (SONG.validScore)
		{
			// adjusting the highscore song name to be compatible
			// would read original scores if we didn't change packages
			var songHighscore = StringTools.replace(PlayState.SONG.song, " ", "-");
			switch (songHighscore) {
				case 'Dad-Battle': songHighscore = 'Dadbattle';
				case 'Philly-Nice': songHighscore = 'Philly';
			}

			#if !switch
			Highscore.saveScore(songHighscore, Math.round(songScore), storyDifficulty);
			Highscore.saveCombo(songHighscore, Ratings.GenerateLetterRank(accuracy), storyDifficulty);
			#end
		}

		if (offsetTesting && !FUCKYOU)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
			offsetTesting = false;
			LoadingState.loadAndSwitchState(new OptionsMenu());
			FlxG.save.data.offset = offsetTest;
		}
		else if (!FUCKYOU)
		{
			if (isStoryMode)
			{
				campaignScore += Math.round(songScore);

				storyPlaylist.remove(storyPlaylist[0]);

				if (storyPlaylist.length <= 0)
				{
					transIn = FlxTransitionableState.defaultTransIn;
					transOut = FlxTransitionableState.defaultTransOut;

					paused = true;

					FlxG.sound.music.stop();
					vocals.stop();
					if (FlxG.save.data.scoreScreen)
						openSubState(new ResultsScreen());
					else
					{
						FlxG.sound.playMusic(Paths.music('freakyMenu'));
						FlxG.switchState(new MainMenuState());
					}

					#if windows
					if (luaModchart != null)
					{
						luaModchart.die();
						luaModchart = null;
					}
					#end

					// if ()
					StoryMenuState.weekUnlocked[Std.int(Math.min(storyWeek + 1, StoryMenuState.weekUnlocked.length - 1))] = true;

					if (SONG.validScore)
					{
						NGio.unlockMedal(60961);
						Highscore.saveWeekScore(storyWeek, campaignScore, storyDifficulty);
					}

					FlxG.save.data.weekUnlocked = StoryMenuState.weekUnlocked;
					FlxG.save.flush();
				}
				else
				{
					
					// adjusting the song name to be compatible
					var songFormat = StringTools.replace(PlayState.storyPlaylist[0], " ", "-");
					switch (songFormat) {
						case 'Dad-Battle': songFormat = 'Dadbattle';
						case 'Philly-Nice': songFormat = 'Philly';
					}

					var poop:String = Highscore.formatSong(songFormat, storyDifficulty);

					trace('LOADING NEXT SONG');
					trace(poop);

					if (StringTools.replace(PlayState.storyPlaylist[0], " ", "-").toLowerCase() == 'eggnog')
					{
						var blackShit:FlxSprite = new FlxSprite(-FlxG.width * FlxG.camera.zoom,
							-FlxG.height * FlxG.camera.zoom).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
						blackShit.scrollFactor.set();
						add(blackShit);
						camHUD.visible = false;
						camNotes.visible = false;

						FlxG.sound.play(Paths.sound('Lights_Shut_off'));
					}

					FlxTransitionableState.skipNextTransIn = true;
					FlxTransitionableState.skipNextTransOut = true;
					prevCamFollow = camFollow;


					PlayState.SONG = Song.loadFromJson(poop, PlayState.storyPlaylist[0]);
					FlxG.sound.music.stop();

					LoadingState.loadAndSwitchState(new PlayState());

				}
			}
			else
			{
				trace('WENT BACK TO FREEPLAY??');

				paused = true;

				FlxG.sound.music.stop();
				vocals.stop();

				if (FlxG.save.data.scoreScreen)
					openSubState(new ResultsScreen());
				else
					FlxG.switchState(new FreeplayState());
			}
		}
	}


	var endingSong:Bool = false;

	var hits:Array<Float> = [];
	var offsetTest:Float = 0;

	var timeShown = 0;
	var currentTimingShown:FlxText = null;

	private function popUpScore(daNote:Note):Void
		{
			var noteDiff:Float = -(daNote.strumTime - Conductor.songPosition);
			var wife:Float = EtternaFunctions.wife3(-noteDiff, Conductor.timeScale);
			// boyfriend.playAnim('hey');
			vocals.volume = 1;
			var placement:String = Std.string(combo);
	
			var coolText:FlxText = new FlxText(0, 0, 0, placement, 32);
			coolText.screenCenter();
			coolText.x = FlxG.width * 0.55;
			coolText.y -= 350;
			coolText.cameras = [camHUD];
			//
	
			var rating:FlxSprite = new FlxSprite();
			var score:Float = 350;

			if (FlxG.save.data.accuracyMod == 1)
				totalNotesHit += wife;

			var daRating = daNote.rating;

			switch(daRating)
			{
				case 'shit':
					score = -300;
					combo = 0;
					misses++;
					if (FlxG.save.data.noHealthGain)
						health += 0;
					else if (FlxG.save.data.halvedHealthGain)
						health -= 0.4;
					else if (FlxG.save.data.sickOnly)
						health = 0;
					else if (FlxG.save.data.doubleHealthGain)
						health -= 0.1;
					else
						health -= 0.2;
					ss = false;
					shits++;
					if (FlxG.save.data.accuracyMod == 0)
						totalNotesHit -= 1;
				case 'bad':
					daRating = 'bad';
					score = 0;
					if (FlxG.save.data.noHealthGain)
						health += 0;
					else if (FlxG.save.data.halvedHealthGain)
						health -= 0.03;
					else if (FlxG.save.data.doubleHealthGain)
						health -= 0.12;
					else if (FlxG.save.data.sickOnly)
						health = 0;
					else if (!FlxG.save.data.sickOnly)
						health -= 0.06;
					ss = false;
					bads++;
					if (FlxG.save.data.accuracyMod == 0)
						totalNotesHit += 0.50;
				case 'good':
					daRating = 'good';
					score = 200;
					ss = false;
					goods++;
					if (FlxG.save.data.noHealthGain)
						health += 0;
					else if (FlxG.save.data.halvedHealthGain)
						health += 0.02;
					else if (FlxG.save.data.doubleHealthGain)
						health += 0.08;
					else if (FlxG.save.data.sickOnly)
						health = 0;
					else if (FlxG.save.data.painfulGood)
						health -= 0.06;
					else if (health < 2 && !grabbed && !FlxG.save.data.sickOnly)
						health += 0.04;
					if (FlxG.save.data.accuracyMod == 0)
						totalNotesHit += 0.75;
				case 'sick':
					if (FlxG.save.data.noHealthGain)
						health += 0;
					else if (FlxG.save.data.halvedHealthGain)
						health += 0.05;
					else if (FlxG.save.data.doubleHealthGain)
						health += 0.2;
					else if (health < 2 && !grabbed)
						health += 0.1;
					if (FlxG.save.data.accuracyMod == 0)
						totalNotesHit += 1;
					sicks++;
			}

			// trace('Wife accuracy loss: ' + wife + ' | Rating: ' + daRating + ' | Score: ' + score + ' | Weight: ' + (1 - wife));

			if (daRating != 'shit' || daRating != 'bad')
				{
	
	
			songScore += Math.round(score);
			songScoreDef += Math.round(ConvertScore.convertScore(noteDiff));
	
			/* if (combo > 60)
					daRating = 'sick';
				else if (combo > 12)
					daRating = 'good'
				else if (combo > 4)
					daRating = 'bad';
			 */
	
			var pixelShitPart1:String = "";
			var pixelShitPart2:String = '';
	
			if (curStage.startsWith('school'))
			{
				pixelShitPart1 = 'weeb/pixelUI/';
				pixelShitPart2 = '-pixel';
			}
	
			rating.loadGraphic(Paths.image(pixelShitPart1 + daRating + pixelShitPart2));
			rating.screenCenter();
			rating.y -= 50;
			rating.x = coolText.x - 125;
			
			if (FlxG.save.data.changedHit)
			{
				rating.x = FlxG.save.data.changedHitX;
				rating.y = FlxG.save.data.changedHitY;
			}
			rating.acceleration.y = 550;
			rating.velocity.y -= FlxG.random.int(140, 175);
			rating.velocity.x -= FlxG.random.int(0, 10);
			
			var msTiming = HelperFunctions.truncateFloat(noteDiff, 3);
			if(PlayStateChangeables.botPlay && !loadRep) msTiming = 0;		
			
			if (loadRep)
				msTiming = HelperFunctions.truncateFloat(findByTime(daNote.strumTime)[3], 3);

			if (currentTimingShown != null)
				remove(currentTimingShown);

			currentTimingShown = new FlxText(0,0,0,"0ms");
			timeShown = 0;
			switch(daRating)
			{
				case 'shit' | 'bad':
					currentTimingShown.color = FlxColor.RED;
				case 'good':
					currentTimingShown.color = FlxColor.GREEN;
				case 'sick':
					currentTimingShown.color = FlxColor.CYAN;
			}
			currentTimingShown.borderStyle = OUTLINE;
			currentTimingShown.borderSize = 1;
			currentTimingShown.borderColor = FlxColor.BLACK;
			currentTimingShown.text = msTiming + "ms";
			currentTimingShown.size = 20;

			if (msTiming >= 0.03 && offsetTesting)
			{
				//Remove Outliers
				hits.shift();
				hits.shift();
				hits.shift();
				hits.pop();
				hits.pop();
				hits.pop();
				hits.push(msTiming);

				var total = 0.0;

				for(i in hits)
					total += i;
				

				
				offsetTest = HelperFunctions.truncateFloat(total / hits.length,2);
			}

			if (currentTimingShown.alpha != 1)
				currentTimingShown.alpha = 1;

			if(!PlayStateChangeables.botPlay || loadRep) add(currentTimingShown);
			
			var comboSpr:FlxSprite = new FlxSprite().loadGraphic(Paths.image(pixelShitPart1 + 'combo' + pixelShitPart2));
			comboSpr.screenCenter();
			comboSpr.x = rating.x;
			comboSpr.y = rating.y + 100;
			comboSpr.acceleration.y = 600;
			comboSpr.velocity.y -= 150;

			currentTimingShown.screenCenter();
			currentTimingShown.x = comboSpr.x + 100;
			currentTimingShown.y = rating.y + 100;
			currentTimingShown.acceleration.y = 600;
			currentTimingShown.velocity.y -= 150;
	
			comboSpr.velocity.x += FlxG.random.int(1, 10);
			currentTimingShown.velocity.x += comboSpr.velocity.x;
			if(!PlayStateChangeables.botPlay || loadRep) add(rating);
	
			if (!curStage.startsWith('school'))
			{
				rating.setGraphicSize(Std.int(rating.width * 0.7));
				rating.antialiasing = FlxG.save.data.antialiasing;
				comboSpr.setGraphicSize(Std.int(comboSpr.width * 0.7));
				comboSpr.antialiasing = FlxG.save.data.antialiasing;
			}
			else
			{
				rating.setGraphicSize(Std.int(rating.width * daPixelZoom * 0.7));
				comboSpr.setGraphicSize(Std.int(comboSpr.width * daPixelZoom * 0.7));
			}
	
			currentTimingShown.updateHitbox();
			comboSpr.updateHitbox();
			rating.updateHitbox();
	
			currentTimingShown.cameras = [camHUD];
			comboSpr.cameras = [camHUD];
			rating.cameras = [camHUD];

			var seperatedScore:Array<Int> = [];
	
			var comboSplit:Array<String> = (combo + "").split('');

			if (combo > highestCombo)
				highestCombo = combo;

			// make sure we have 3 digits to display (looks weird otherwise lol)
			if (comboSplit.length == 1)
			{
				seperatedScore.push(0);
				seperatedScore.push(0);
			}
			else if (comboSplit.length == 2)
				seperatedScore.push(0);

			for(i in 0...comboSplit.length)
			{
				var str:String = comboSplit[i];
				seperatedScore.push(Std.parseInt(str));
			}
	
			var daLoop:Int = 0;
			for (i in seperatedScore)
			{
				var numScore:FlxSprite = new FlxSprite().loadGraphic(Paths.image(pixelShitPart1 + 'num' + Std.int(i) + pixelShitPart2));
				numScore.screenCenter();
				numScore.x = rating.x + (43 * daLoop) - 50;
				numScore.y = rating.y + 100;
				numScore.cameras = [camHUD];

				if (!curStage.startsWith('school'))
				{
					numScore.antialiasing = FlxG.save.data.antialiasing;
					numScore.setGraphicSize(Std.int(numScore.width * 0.5));
				}
				else
				{
					numScore.setGraphicSize(Std.int(numScore.width * daPixelZoom));
				}
				numScore.updateHitbox();
	
				numScore.acceleration.y = FlxG.random.int(200, 300);
				numScore.velocity.y -= FlxG.random.int(140, 160);
				numScore.velocity.x = FlxG.random.float(-5, 5);
	
				add(numScore);

				visibleCombos.push(numScore);

				FlxTween.tween(numScore, {alpha: 0}, 0.2, {
					onComplete: function(tween:FlxTween)
					{
						visibleCombos.remove(numScore);
						numScore.destroy();
					},
					onUpdate: function (tween:FlxTween)
					{
						if (!visibleCombos.contains(numScore))
						{
							tween.cancel();
							numScore.destroy();
						}
					},
					startDelay: Conductor.crochet * 0.002
				});

				if (visibleCombos.length > seperatedScore.length + 20)
				{
					for(i in 0...seperatedScore.length - 1)
					{
						visibleCombos.remove(visibleCombos[visibleCombos.length - 1]);
					}
				}
	
				daLoop++;
			}
			/* 
				trace(combo);
				trace(seperatedScore);
			 */
	
			coolText.text = Std.string(seperatedScore);
			// add(coolText);
	
			FlxTween.tween(rating, {alpha: 0}, 0.2, {
				startDelay: Conductor.crochet * 0.001,
				onUpdate: function(tween:FlxTween)
				{
					if (currentTimingShown != null)
						currentTimingShown.alpha -= 0.02;
					timeShown++;
				}
			});

			FlxTween.tween(comboSpr, {alpha: 0}, 0.2, {
				onComplete: function(tween:FlxTween)
				{
					coolText.destroy();
					comboSpr.destroy();
					if (currentTimingShown != null && timeShown >= 20)
					{
						remove(currentTimingShown);
						currentTimingShown = null;
					}
					rating.destroy();
				},
				startDelay: Conductor.crochet * 0.001
			});
	
			curSection += 1;
			}
		}

	public function NearlyEquals(value1:Float, value2:Float, unimportantDifference:Float = 10):Bool
		{
			return Math.abs(FlxMath.roundDecimal(value1, 1) - FlxMath.roundDecimal(value2, 1)) < unimportantDifference;
		}

		var upHold:Bool = false;
		var downHold:Bool = false;
		var rightHold:Bool = false;
		var leftHold:Bool = false;
		var l1Hold:Bool = false;
		var uHold:Bool = false;
		var r1Hold:Bool = false;
		var l2Hold:Bool = false;
		var dHold:Bool = false;
		var r2Hold:Bool = false;
	
		var n0Hold:Bool = false;
		var n1Hold:Bool = false;
		var n2Hold:Bool = false;
		var n3Hold:Bool = false;
		var n4Hold:Bool = false;
		var n5Hold:Bool = false;
		var n6Hold:Bool = false;
		var n7Hold:Bool = false;
		var n8Hold:Bool = false;
		// THIS FUNCTION JUST FUCKS WIT HELD NOTES AND BOTPLAY/REPLAY (also gamepad shit)

		private function keyShit():Void // I've invested in emma stocks
			{
				// control arrays, order L D R U
				var holdArray:Array<Bool> = [controls.LEFT, controls.DOWN, controls.UP, controls.RIGHT];
				var pressArray:Array<Bool> = [
					controls.LEFT_P,
					controls.DOWN_P,
					controls.UP_P,
					controls.RIGHT_P

				];
				var releaseArray:Array<Bool> = [
					controls.LEFT_R,
					controls.DOWN_R,
					controls.UP_R,
					controls.RIGHT_R
				];
				switch(mania)
				{
					case 0: 
						holdArray = [controls.LEFT, controls.DOWN, controls.UP, controls.RIGHT];
						pressArray = [
							controls.LEFT_P,
							controls.DOWN_P,
							controls.UP_P,
							controls.RIGHT_P
						];
						releaseArray = [
							controls.LEFT_R,
							controls.DOWN_R,
							controls.UP_R,
							controls.RIGHT_R
						];
					case 1: 
						holdArray = [controls.L1, controls.U1, controls.R1, controls.L2, controls.D1, controls.R2];
						pressArray = [
							controls.L1_P,
							controls.U1_P,
							controls.R1_P,
							controls.L2_P,
							controls.D1_P,
							controls.R2_P
						];
						releaseArray = [
							controls.L1_R,
							controls.U1_R,
							controls.R1_R,
							controls.L2_R,
							controls.D1_R,
							controls.R2_R
						];
					case 2: 
						holdArray = [controls.N0, controls.N1, controls.N2, controls.N3, controls.N4, controls.N5, controls.N6, controls.N7, controls.N8];
						pressArray = [
							controls.N0_P,
							controls.N1_P,
							controls.N2_P,
							controls.N3_P,
							controls.N4_P,
							controls.N5_P,
							controls.N6_P,
							controls.N7_P,
							controls.N8_P
						];
						releaseArray = [
							controls.N0_R,
							controls.N1_R,
							controls.N2_R,
							controls.N3_R,
							controls.N4_R,
							controls.N5_R,
							controls.N6_R,
							controls.N7_R,
							controls.N8_R
						];
					case 3: 
						holdArray = [controls.LEFT, controls.DOWN, controls.N4, controls.UP, controls.RIGHT];
						pressArray = [
							controls.LEFT_P,
							controls.DOWN_P,
							controls.N4_P,
							controls.UP_P,
							controls.RIGHT_P
						];
						releaseArray = [
							controls.LEFT_R,
							controls.DOWN_R,
							controls.N4_R,
							controls.UP_R,
							controls.RIGHT_R
						];
					case 4: 
						holdArray = [controls.L1, controls.U1, controls.R1, controls.N4, controls.L2, controls.D1, controls.R2];
						pressArray = [
							controls.L1_P,
							controls.U1_P,
							controls.R1_P,
							controls.N4_P,
							controls.L2_P,
							controls.D1_P,
							controls.R2_P
						];
						releaseArray = [
							controls.L1_R,
							controls.U1_R,
							controls.R1_R,
							controls.N4_R,
							controls.L2_R,
							controls.D1_R,
							controls.R2_R
						];
					case 5: 
						holdArray = [controls.N0, controls.N1, controls.N2, controls.N3, controls.N5, controls.N6, controls.N7, controls.N8];
						pressArray = [
							controls.N0_P,
							controls.N1_P,
							controls.N2_P,
							controls.N3_P,
							controls.N5_P,
							controls.N6_P,
							controls.N7_P,
							controls.N8_P
						];
						releaseArray = [
							controls.N0_R,
							controls.N1_R,
							controls.N2_R,
							controls.N3_R,
							controls.N5_R,
							controls.N6_R,
							controls.N7_R,
							controls.N8_R
						];
					case 6: 
						holdArray = [controls.N4];
						pressArray = [
							controls.N4_P
						];
						releaseArray = [
							controls.N4_R
						];
					case 7: 
						holdArray = [controls.LEFT, controls.RIGHT];
						pressArray = [
							controls.LEFT_P,
							controls.RIGHT_P
						];
						releaseArray = [
							controls.LEFT_R,
							controls.RIGHT_R
						];
					case 8:
						holdArray = [controls.LEFT, controls.N4, controls.RIGHT];
						pressArray = [
							controls.LEFT_P,
							controls.N4_P,
							controls.RIGHT_P
						];
						releaseArray = [
							controls.LEFT_R,
							controls.N4_R,
							controls.RIGHT_R
						];
				}
				#if windows
				if (luaModchart != null)
				{
					for (i in 0...pressArray.length) {
						if (pressArray[i] == true) {
						luaModchart.executeState('keyPressed', [sDir[i].toLowerCase()]);
						}
					};
					
					for (i in 0...releaseArray.length) {
						if (releaseArray[i] == true) {
						luaModchart.executeState('keyReleased', [sDir[i].toLowerCase()]);
						}
					};
					
				};
				#end
				
		 
				
				// Prevent player input if botplay is on
				if(PlayStateChangeables.botPlay)
				{
					holdArray = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
					pressArray = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
					releaseArray = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
				} 

				var anas:Array<Ana> = [null,null,null,null];
				switch(mania)
				{
					case 0: 
						anas = [null,null,null,null];
					case 1: 
						anas = [null,null,null,null,null,null];
					case 2: 
						anas = [null,null,null,null,null,null,null,null,null];
					case 3: 
						anas = [null,null,null,null,null];
					case 4: 
						anas = [null,null,null,null,null,null,null];
					case 5: 
						anas = [null,null,null,null,null,null,null,null];
					case 6: 
						anas = [null];
					case 7: 
						anas = [null,null];
					case 8: 
						anas = [null,null,null];
				}

				for (i in 0...pressArray.length)
					if (pressArray[i])
						anas[i] = new Ana(Conductor.songPosition, null, false, "miss", i);

				// HOLDS, check for sustain notes
				if (holdArray.contains(true) && /*!boyfriend.stunned && */ generatedMusic)
				{
					notes.forEachAlive(function(daNote:Note)
					{
						if (daNote.isSustainNote && daNote.canBeHit && daNote.mustPress && holdArray[daNote.noteData])
							goodNoteHit(daNote);
					});
				} //gt hero input shit, using old code because i can
				if (controls.GTSTRUM)
				{
					if (pressArray.contains(true) && /*!boyfriend.stunned && */ generatedMusic && FlxG.save.data.gthm || holdArray.contains(true) && /*!boyfriend.stunned && */ generatedMusic && FlxG.save.data.gthm)
						{
							var possibleNotes:Array<Note> = [];

							var ignoreList:Array<Int> = [];
				
							notes.forEachAlive(function(daNote:Note)
							{
								if (daNote.canBeHit && daNote.mustPress && !daNote.tooLate && !daNote.wasGoodHit && !daNote.isSustainNote)
								{
									possibleNotes.push(daNote);
									possibleNotes.sort((a, b) -> Std.int(a.strumTime - b.strumTime));
				
									ignoreList.push(daNote.noteData);
								}
				
							});
				
							if (possibleNotes.length > 0)
							{
								var daNote = possibleNotes[0];
				
								// Jump notes
								if (possibleNotes.length >= 2)
								{
									if (possibleNotes[0].strumTime == possibleNotes[1].strumTime)
									{
										for (coolNote in possibleNotes)
										{
											if (pressArray[coolNote.noteData] || holdArray[coolNote.noteData])
												goodNoteHit(coolNote);
											else
											{
												var inIgnoreList:Bool = false;
												for (shit in 0...ignoreList.length)
												{
													if (holdArray[ignoreList[shit]] || pressArray[ignoreList[shit]])
														inIgnoreList = true;
												}
												if (!inIgnoreList && !FlxG.save.data.ghost)
													noteMiss(1, null);
											}
										}
									}
									else if (possibleNotes[0].noteData == possibleNotes[1].noteData)
									{
										if (pressArray[daNote.noteData] || holdArray[daNote.noteData])
											goodNoteHit(daNote);
									}
									else
									{
										for (coolNote in possibleNotes)
										{
											if (pressArray[coolNote.noteData] || holdArray[coolNote.noteData])
												goodNoteHit(coolNote);
										}
									}
								}
								else // regular notes?
								{
									if (pressArray[daNote.noteData] || holdArray[daNote.noteData])
										goodNoteHit(daNote);
								}
							}
						}

					}
		 
				if (KeyBinds.gamepad && !FlxG.keys.justPressed.ANY)
				{
					// PRESSES, check for note hits
					if (pressArray.contains(true) && generatedMusic)
					{
						boyfriend.holdTimer = 0;
			
						var possibleNotes:Array<Note> = []; // notes that can be hit
						var directionList:Array<Int> = []; // directions that can be hit
						var dumbNotes:Array<Note> = []; // notes to kill later
						var directionsAccounted:Array<Bool> = [false,false,false,false]; // we don't want to do judgments for more than one presses
						
						switch(mania)
						{
							case 0: 
								directionsAccounted = [false, false, false, false];
							case 1: 
								directionsAccounted = [false, false, false, false, false, false];
							case 2: 
								directionsAccounted = [false, false, false, false, false, false, false, false, false];
							case 3: 
								directionsAccounted = [false, false, false, false, false];
							case 4: 
								directionsAccounted = [false, false, false, false, false, false, false];
							case 5: 
								directionsAccounted = [false, false, false, false, false, false, false, false];
							case 6: 
								directionsAccounted = [false];
							case 7: 
								directionsAccounted = [false, false];
							case 8: 
								directionsAccounted = [false, false, false];
						}
						

						notes.forEachAlive(function(daNote:Note)
							{
								if (daNote.canBeHit && daNote.mustPress && !daNote.tooLate && !daNote.wasGoodHit && !directionsAccounted[daNote.noteData])
								{
									if (directionList.contains(daNote.noteData))
										{
											directionsAccounted[daNote.noteData] = true;
											for (coolNote in possibleNotes)
											{
												if (coolNote.noteData == daNote.noteData && Math.abs(daNote.strumTime - coolNote.strumTime) < 10)
												{ // if it's the same note twice at < 10ms distance, just delete it
													// EXCEPT u cant delete it in this loop cuz it fucks with the collection lol
													dumbNotes.push(daNote);
													break;
												}
												else if (coolNote.noteData == daNote.noteData && daNote.strumTime < coolNote.strumTime)
												{ // if daNote is earlier than existing note (coolNote), replace
													possibleNotes.remove(coolNote);
													possibleNotes.push(daNote);
													break;
												}
											}
										}
										else
										{
											directionsAccounted[daNote.noteData] = true;
											possibleNotes.push(daNote);
											directionList.push(daNote.noteData);
										}
								}
						});

						for (note in dumbNotes)
						{
							FlxG.log.add("killing dumb ass note at " + note.strumTime);
							note.kill();
							notes.remove(note, true);
							note.destroy();
						}
			
						possibleNotes.sort((a, b) -> Std.int(a.strumTime - b.strumTime));
						var hit = [false,false,false,false,false,false,false,false,false];
						switch(mania)
						{
							case 0: 
								hit = [false, false, false, false];
							case 1: 
								hit = [false, false, false, false, false, false];
							case 2: 
								hit = [false, false, false, false, false, false, false, false, false];
							case 3: 
								hit = [false, false, false, false, false];
							case 4: 
								hit = [false, false, false, false, false, false, false];
							case 5: 
								hit = [false, false, false, false, false, false, false, false];
							case 6: 
								hit = [false];
							case 7: 
								hit = [false, false];
							case 8: 
								hit = [false, false, false];
						}
						if (perfectMode)
							goodNoteHit(possibleNotes[0]);
						else if (possibleNotes.length > 0)
						{
							if (!FlxG.save.data.ghost)
								{
									for (i in 0...pressArray.length)
										{ // if a direction is hit that shouldn't be
											if (pressArray[i] && !directionList.contains(i))
												noteMiss(i, null);
										}
								}
							if (FlxG.save.data.gthm)
							{
	
							}
							else
							{
								for (coolNote in possibleNotes)
									{
										if (pressArray[coolNote.noteData] && !hit[coolNote.noteData])
										{
											if (mashViolations != 0)
												mashViolations--;
											hit[coolNote.noteData] = true;
											scoreTxt.color = FlxColor.WHITE;
											var noteDiff:Float = -(coolNote.strumTime - Conductor.songPosition);
											anas[coolNote.noteData].hit = true;
											anas[coolNote.noteData].hitJudge = Ratings.CalculateRating(noteDiff, Math.floor((PlayStateChangeables.safeFrames / 60) * 1000));
											anas[coolNote.noteData].nearestNote = [coolNote.strumTime,coolNote.noteData,coolNote.sustainLength];
											goodNoteHit(coolNote);
										}
									}
							}
							
						};
						if (boyfriend.holdTimer > Conductor.stepCrochet * 4 * 0.001 && (!holdArray.contains(true) || PlayStateChangeables.botPlay))
							{
								if (boyfriend.animation.curAnim.name.startsWith('sing') && !boyfriend.animation.curAnim.name.endsWith('miss') && (boyfriend.animation.curAnim.curFrame >= 10 || boyfriend.animation.curAnim.finished))
									boyfriend.playAnim('idle');
							}
						else if (!FlxG.save.data.ghost)
							{
								for (shit in 0...keyAmmo[mania])
									if (pressArray[shit])
										noteMiss(shit, null);
							}
					}

					if (!loadRep)
						for (i in anas)
							if (i != null)
								replayAna.anaArray.push(i); // put em all there
				}
					
				
				if (boyfriend.holdTimer > Conductor.stepCrochet * 4 * 0.001 && (!holdArray.contains(true) || PlayStateChangeables.botPlay))
				{
					if (boyfriend.animation.curAnim.name.startsWith('sing') && !boyfriend.animation.curAnim.name.endsWith('miss'))
						boyfriend.playAnim('idle');
				}
		 
				if (!PlayStateChangeables.botPlay)
				{
					playerStrums.forEach(function(spr:FlxSprite)
					{
						if (keys[spr.ID] && spr.animation.curAnim.name != 'confirm' && spr.animation.curAnim.name != 'pressed')
							spr.animation.play('pressed', false);
						if (!keys[spr.ID])
							spr.animation.play('static', false);
			
						if (spr.animation.curAnim.name == 'confirm' && !curStage.startsWith('school'))
						{
							spr.centerOffsets();
							switch(mania)
							{
								case 0: 
									spr.offset.x -= 13;
									spr.offset.y -= 13;
								case 1: 
									if (SONG.noteStyle == 'pixel'){
										spr.offset.x -= 0;
										spr.offset.y -= 0;
									}
									else{
										spr.offset.x -= 16;
										spr.offset.y -= 16;
									}
								case 2: 
									spr.offset.x -= 22;
									spr.offset.y -= 22;
								case 3: 
									spr.offset.x -= 15;
									spr.offset.y -= 15;
								case 4: 
									spr.offset.x -= 18;
									spr.offset.y -= 18;
								case 5: 
									spr.offset.x -= 20;
									spr.offset.y -= 20;
								case 6: 
									spr.offset.x -= 13;
									spr.offset.y -= 13;
								case 7: 
									spr.offset.x -= 13;
									spr.offset.y -= 13;
								case 8:
									spr.offset.x -= 13;
									spr.offset.y -= 13;
							}
						}
						else
							spr.centerOffsets();
					});
				}
			}

			public function findByTime(time:Float):Array<Dynamic>
				{
					for (i in rep.replay.songNotes)
					{
						//trace('checking ' + Math.round(i[0]) + ' against ' + Math.round(time));
						if (i[0] == time)
							return i;
					}
					return null;
				}

			public function findByTimeIndex(time:Float):Int
				{
					for (i in 0...rep.replay.songNotes.length)
					{
						//trace('checking ' + Math.round(i[0]) + ' against ' + Math.round(time));
						if (rep.replay.songNotes[i][0] == time)
							return i;
					}
					return -1;
				}

			public var fuckingVolume:Float = 1;
			public var useVideo = false;

			public static var webmHandler:WebmHandler;

			public var playingDathing = false;

			public var videoSprite:FlxSprite;

			public function focusOut() {
				if (paused)
					return;
				persistentUpdate = false;
				persistentDraw = true;
				paused = true;
		
					if (FlxG.sound.music != null)
					{
						FlxG.sound.music.pause();
						vocals.pause();
					}
		
				openSubState(new PauseSubState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
			}
			public function focusIn() 
			{ 
				// nada 
			}


			public function backgroundVideo(source:String) // for background videos
				{
					#if cpp
					useVideo = true;
			
					FlxG.stage.window.onFocusOut.add(focusOut);
					FlxG.stage.window.onFocusIn.add(focusIn);

					var ourSource:String = "assets/videos/daWeirdVid/dontDelete.webm";
					//WebmPlayer.SKIP_STEP_LIMIT = 90;
					var str1:String = "WEBM SHIT"; 
					webmHandler = new WebmHandler();
					webmHandler.source(ourSource);
					webmHandler.makePlayer();
					webmHandler.webm.name = str1;
			
					GlobalVideo.setWebm(webmHandler);

					GlobalVideo.get().source(source);
					GlobalVideo.get().clearPause();
					if (GlobalVideo.isWebm)
					{
						GlobalVideo.get().updatePlayer();
					}
					GlobalVideo.get().show();
			
					if (GlobalVideo.isWebm)
					{
						GlobalVideo.get().restart();
					} else {
						GlobalVideo.get().play();
					}
					
					var data = webmHandler.webm.bitmapData;
			
					videoSprite = new FlxSprite(-470,-30).loadGraphic(data);
			
					videoSprite.setGraphicSize(Std.int(videoSprite.width * 1.2));
			
					remove(gf);
					remove(boyfriend);
					remove(dad);
					add(videoSprite);
					add(gf);
					add(boyfriend);
					add(dad);
			
					trace('poggers');
			
					if (!songStarted)
						webmHandler.pause();
					else
						webmHandler.resume();
					#end
				}

	var staticthings:Float = 0;

	function doSpam():Void
		{
			nuts(noo);	
			noo++;
			health -= 0.095;
			vocals.volume = 0;					
		}

	function noteMiss(direction:Int = 1, daNote:Note):Void
	{
		if (!boyfriend.stunned)
		{
			if (cNum == 0)
				{
					health -= 0.04;
				}
				else
					cNum -= 1;
			if (combo > 5 && gf.animOffsets.exists('sad'))
			{
				gf.playAnim('sad');
			}
			combo = 0;
			misses++;

			if (daNote != null)
			{
				if (!loadRep)
				{
					saveNotes.push([daNote.strumTime,0,direction,166 * Math.floor((PlayState.rep.replay.sf / 60) * 1000) / 166]);
					saveJudge.push("miss");
				}
			}
			else
				if (!loadRep)
				{
					saveNotes.push([Conductor.songPosition,0,direction,166 * Math.floor((PlayState.rep.replay.sf / 60) * 1000) / 166]);
					saveJudge.push("miss");
				}

			//var noteDiff:Float = Math.abs(daNote.strumTime - Conductor.songPosition);
			//var wife:Float = EtternaFunctions.wife3(noteDiff, FlxG.save.data.etternaMode ? 1 : 1.7);

			if (FlxG.save.data.accuracyMod == 1)
				totalNotesHit -= 1;

			songScore -= 10;

			FlxG.sound.play(Paths.soundRandom('missnote', 1, 3), FlxG.random.float(0.1, 0.2));
			// FlxG.sound.play(Paths.sound('missnote1'), 1, false);
			// FlxG.log.add('played imss note');

			if (dad.curCharacter.toLowerCase().contains("tricky") && FlxG.random.bool(dad.curCharacter == "tricky" ? 10 : 4) && !spookyRendered && curStage == "nevada") // create spooky text :flushed:
				createSpookyText(TrickyLinesMiss[FlxG.random.int(0,TrickyLinesMiss.length)]);

			boyfriend.playAnim('sing' + sDir[direction] + 'miss', true);

			#if windows
			if (luaModchart != null)
				luaModchart.executeState('playerOneMiss', [direction, Conductor.songPosition]);
			#end


			updateAccuracy();
		}
	}

	/*function badNoteCheck()
		{
			// just double pasting this shit cuz fuk u
			// REDO THIS SYSTEM!
			var upP = controls.UP_P;
			var rightP = controls.RIGHT_P;
			var downP = controls.DOWN_P;
			var leftP = controls.LEFT_P;
	
			if (leftP)
				noteMiss(0);
			if (upP)
				noteMiss(2);
			if (rightP)
				noteMiss(3);
			if (downP)
				noteMiss(1);
			updateAccuracy();
		}
	*/
	function updateAccuracy() 
		{
			totalPlayed += 1;
			accuracy = Math.max(0,totalNotesHit / totalPlayed * 100);
			accuracyDefault = Math.max(0, totalNotesHitDefault / totalPlayed * 100);
		}


	function getKeyPresses(note:Note):Int
	{
		var possibleNotes:Array<Note> = []; // copypasted but you already know that

		notes.forEachAlive(function(daNote:Note)
		{
			if (daNote.canBeHit && daNote.mustPress)
			{
				possibleNotes.push(daNote);
				possibleNotes.sort((a, b) -> Std.int(a.strumTime - b.strumTime));
			}
		});
		if (possibleNotes.length == 1)
			return possibleNotes.length + 1;
		return possibleNotes.length;
	}
	
	var mashing:Int = 0;
	var mashViolations:Int = 0;

	var etternaModeScore:Int = 0;

	function noteCheck(controlArray:Array<Bool>, note:Note):Void // sorry lol
		{
			var noteDiff:Float = -(note.strumTime - Conductor.songPosition);

			note.rating = Ratings.CalculateRating(noteDiff, Math.floor((PlayStateChangeables.safeFrames / 60) * 1000));

			/* if (loadRep)
			{
				if (controlArray[note.noteData])
					goodNoteHit(note, false);
				else if (rep.replay.keyPresses.length > repPresses && !controlArray[note.noteData])
				{
					if (NearlyEquals(note.strumTime,rep.replay.keyPresses[repPresses].time, 4))
					{
						goodNoteHit(note, false);
					}
				}
			} */
			
			if (controlArray[note.noteData])
			{
				goodNoteHit(note, (mashing > getKeyPresses(note)));
				
				/*if (mashing > getKeyPresses(note) && mashViolations <= 2)
				{
					mashViolations++;

					goodNoteHit(note, (mashing > getKeyPresses(note)));
				}
				else if (mashViolations > 2)
				{
					// this is bad but fuck you
					playerStrums.members[0].animation.play('static');
					playerStrums.members[1].animation.play('static');
					playerStrums.members[2].animation.play('static');
					playerStrums.members[3].animation.play('static');
					health -= 0.4;
					trace('mash ' + mashing);
					if (mashing != 0)
						mashing = 0;
				}
				else
					goodNoteHit(note, false);*/

			}
		}

		function goodNoteHit(note:Note, resetMashViolation = true):Void
			{
				if (isRing && note.noteData == 3 && !note.isSustainNote)
					{
						FlxG.sound.play(Paths.sound('RingReal', 'shared'));
						cNum += 1;
					}
				if (note.phantom)
					{
						var fuckyou:Int = 0;
						heatlhDrop += 0.00025;
						if (heatlhDrop == 0.00025)
						{
							new FlxTimer().start(0.1, function(sex:FlxTimer)
							{
								fuckyou += 1;
			
								if (fuckyou >= 100)
									heatlhDrop = 0;
			
								if (!paused && fuckyou < 100)
									sex.reset();
							});
						}
						else
							fuckyou = 0;
					}

				if (mashing != 0)
					mashing = 0;

				var noteDiff:Float = -(note.strumTime - Conductor.songPosition);

				if(loadRep)
				{
					noteDiff = findByTime(note.strumTime)[3];
					note.rating = rep.replay.songJudgements[findByTimeIndex(note.strumTime)];
				}
				else
					note.rating = Ratings.CalculateRating(noteDiff);

				if (note.rating == "miss")
					return;	


				// add newest note to front of notesHitArray
				// the oldest notes are at the end and are removed first
				if (!note.isSustainNote)
					notesHitArray.unshift(Date.now());

				if (!resetMashViolation && mashViolations >= 1)
					mashViolations--;

				if (mashViolations < 0)
					mashViolations = 0;

				if (!note.wasGoodHit)
				{
					if (!note.isSustainNote)
						{
							if (isRing && note.noteData != 3 && !note.phantom)
							{
								if (popup)
									popUpScore(note);
								combo += 1;
							}
							else if (!isRing && !note.phantom)
							{
								if (popup)
									popUpScore(note);
								combo += 1;
							}
						}
					else
						totalNotesHit += 1;

					var altAnim:String = "";
					
					if (note.alt || note.exealt)
						altAnim = '-alt';

					if (note.dad1)
						boyfriend.playAnim('dodge', true);
					else if (note.dad2)
						boyfriend.playAnim('hey', true);
					else if (!boyfriend.animation.curAnim.name.startsWith('dodge') && boyfriend.animation.curAnim.name != null && !note.noanimation)
						boyfriend.playAnim('sing' + sDir[note.noteData] + altAnim, true);



					boyfriend.holdTimer = 0;

		
					#if windows
					if (luaModchart != null)
						luaModchart.executeState('playerOneSing', [note.noteData, Conductor.songPosition]);
					#end

					if (note.burning) //fire note
						{
							badNoteHit();
							health -= 0.45;
							interupt = true;
						}

					else if (note.death) //halo note
						{
							badNoteHit();
							health = 0;
						}
					else if (note.angel) //angel note
						{
							switch(note.rating)
							{
								case "shit": 
									badNoteHit();
									health -= 2;
								case "bad": 
									badNoteHit();
									health -= 0.5;
								case "good": 
									if (FlxG.save.data.noHealthGain)
										health += 0;
									else if (FlxG.save.data.painfulGood)
										health -= 0.5;
									else
										health += 0.5;
								case "sick": 
									if (FlxG.save.data.noHealthGain)
										health += 0;
									else
										health += 1;

							}
						}
					else if (note.bob) //bob note
						{
							HealthDrain();
						}
					else if (note.bsod) //bsod note
						{
							crashLol();
						}
					else if (note.markov) //markov note
						{
							if (curSong.toLowerCase() == 'epiphany')
								{
									if (FlxG.random.bool(5))
										GameOverSubstate.crashdeath = true;
								}
							health = 0;
						}
					else if (note.katana) //katana note
						{
							slashThingie = true;
							if (curTiming == 0)
								dad.playAnim('slash', true);
							else if (curTiming == 1)
								dad.playAnim('slash-alt', true);
	
							new FlxTimer().start(0.8, function(tmr:FlxTimer)
								{
									slashThingie = false;
									//dad.playAnim('idle', true);
								});
	
							boyfriend.playAnim('dodge');
						}
					else if (note.mouse) //mouse note
						{
							swagSpeed += 0.1;
							totalMouseNotesHit += 1;
							switch(note.rating)
							{
								case "shit": 
									badNoteHit();
									boyfriend.playAnim('at', true);
									health -= 0.2;
								case "bad": 
									badNoteHit();
									boyfriend.playAnim('at', true);
									health -= 0.06;
								case "good": 
									badNoteHit();
									boyfriend.playAnim('at', true);
									if (FlxG.save.data.noHealthGain)
										health += 0;
									else if (FlxG.save.data.painfulGood)
										health -= 0.06;
									else
										health += 0.04;
								case "sick": 
									badNoteHit();
									boyfriend.playAnim('at', true);
									if (FlxG.save.data.noHealthGain)
										health += 0;
									else
										health += 0.1;
							}
						}
					else if (note.snoiper) //snoiper note
						{
							dad.playAnim('shot', true);
							trace("GOOD SHOT MATE!");
						}
					else if (note.ebola) //ebola note
						{
							ebolachan();
							totalEbolaNotesHit += 1;
							healthBar.createFilledBar(FlxColor.fromString('#' + dad.iconColor), FlxColor.fromRGB(255, 0, 167));
							combo = 0;
							misses++;
							var choosesprite = FlxG.random.int(1,4);//what laf do i want hmmm
							switch (choosesprite)
							{
							  case 1	:FlxG.sound.play(Paths.sound('cancer/laugh1'));
							  case 2	:FlxG.sound.play(Paths.sound('cancer/laugh2'));
							  case 3	:FlxG.sound.play(Paths.sound('cancer/laugh3'));
							  case 4	:FlxG.sound.play(Paths.sound('cancer/laugh4'));
							}	
								new FlxTimer().start(0.001, function(tmr:FlxTimer)
								{
											health -= 0.001;
								}, 9000000);
						}
					else if (note.disguise) {//disguise
								instaKill(true);
					}
					else if (note.drunk) // drunk
						{
							FlxG.sound.play(Paths.sound('burp'));

							if (health < 2)
						    health += 0.3;
						}
	
					if(!loadRep && note.mustPress)
					{
						var array = [note.strumTime,note.sustainLength,note.noteData,noteDiff];
						if (note.isSustainNote)
							array[1] = -1;
						saveNotes.push(array);
						saveJudge.push(note.rating);
					}
					
					playerStrums.forEach(function(spr:FlxSprite)
					{
						if (Math.abs(note.noteData) == spr.ID)
						{
							spr.animation.play('confirm', true);
						}
					});
					
		
					if (!note.isSustainNote)
						{
							if (note.rating == "sick")
								doNoteSplash(note.x, note.y, note.noteData);

							note.kill();
							notes.remove(note, true);
							note.destroy();

						}
						else
						{
							note.wasGoodHit = true;
						}
					
					updateAccuracy();

					if (FlxG.save.data.gracetmr)
						{
							grace = true;
							new FlxTimer().start(0.15, function(tmr:FlxTimer)
							{
								grace = false;
							});
						}
					
				}
			}
		

	var fastCarCanDrive:Bool = true;

	function resetFastCar():Void
	{
		if(FlxG.save.data.distractions){
			fastCar.x = -12600;
			fastCar.y = FlxG.random.int(140, 250);
			fastCar.velocity.x = 0;
			fastCarCanDrive = true;
		}
	}

	function fastCarDrive()
	{
		if(FlxG.save.data.distractions){
			FlxG.sound.play(Paths.soundRandom('carPass', 0, 1), 0.7);

			fastCar.velocity.x = (FlxG.random.int(170, 220) / FlxG.elapsed) * 3;
			fastCarCanDrive = false;
			new FlxTimer().start(2, function(tmr:FlxTimer)
			{
				resetFastCar();
			});
		}
	}

	function doNoteSplash(noteX:Float, noteY:Float, nData:Int)
		{
			var recycledNote = noteSplashes.recycle(NoteSplash);
			recycledNote.makeSplash(playerStrums.members[nData].x, playerStrums.members[nData].y, nData);
			noteSplashes.add(recycledNote);
			
		}

	function HealthDrain():Void //code from vs bob
		{
			badNoteHit();
			new FlxTimer().start(0.01, function(tmr:FlxTimer)
			{
				health -= 0.005;
			}, 300);
		}
	function instaKill(instant:Bool = true):Void
		{
			if (instant){health -= 100;}
			else{new FlxTimer().start(0.01, function(tmr:FlxTimer){health -= 0.01;}, 300);}
		}
	function ghostNote(note:Note)
		{
			 if (!note.alreadyTweened)
				  FlxTween.tween(note, {alpha: 0}, (1.3 /SONG.speed), {ease:FlxEase.quadInOut}); 
		}
	function addText(txtDuration:Float = 3):Void // hi
		{
			chatUsername = randomUsername[FlxG.random.int(0, randomUsername.length -1)] + ":";
			chatText = randomText[FlxG.random.int(0, randomText.length -1)];
		
			usernameTxt.color = FlxG.random.bool(50) ? 0x6495ED : FlxColor.RED;
			usernameTxt.text = chatUsername;
			chatTxt.text = chatText;
		
			usernameTxt.alpha = 1; 
			chatTxt.alpha = 1;
		
			new FlxTimer().start(3, function(tmr:FlxTimer)
				{
					FlxTween.tween(usernameTxt, {alpha:0}, 0.5);
					FlxTween.tween(chatTxt, {alpha:0}, 0.5);
				});
			}

	function badNoteHit():Void
		{
			boyfriend.playAnim('hit', true);
			FlxG.sound.play(Paths.soundRandom('badnoise', 1, 3), FlxG.random.float(0.7, 1));
		}

	function switchMania(oldMania:Int, newMania:Int) //this is unfinished and will prob crash game if run!
	{
		mania = newMania;

		/*cpuStrums.forEach(function(spr:FlxSprite)
		{					
			spr.kill();
			cpuStrums.remove(spr, true);
			spr.destroy();
		});
		playerStrums.forEach(function(spr:FlxSprite)
		{					
			spr.kill();
			playerStrums.remove(spr, true);
			spr.destroy();
		});
		strumLineNotes.forEach(function(spr:FlxSprite)
		{					
			spr.kill();
			strumLineNotes.remove(spr, true);
			spr.destroy();
		});*/

		switch(mania) 
		{
			case 0: 
				keys = [false, false, false, false];
				Note.swagWidth = 160 * 0.7;
				Note.noteScale = 0.7;
				Note.pixelnoteScale = 1;
				Note.mania = 0;
			case 1: 
				keys = [false, false, false, false, false, false];
				Note.swagWidth = 120 * 0.7;
				Note.noteScale = 0.6;
				Note.pixelnoteScale = 0.83;
				Note.mania = 1;
			case 2: 
				keys = [false, false, false, false, false, false, false, false, false];
				Note.swagWidth = 95 * 0.7;
				Note.noteScale = 0.5;
				Note.pixelnoteScale = 0.7;
				Note.mania = 2;
			case 3: 
				keys = [false, false, false, false, false];
				Note.swagWidth = 130 * 0.7;
				Note.noteScale = 0.65;
				Note.pixelnoteScale = 0.9;
				Note.mania = 3;
			case 4: 
				keys = [false, false, false, false, false, false, false];
				Note.swagWidth = 110 * 0.7;
				Note.noteScale = 0.58;
				Note.pixelnoteScale = 0.78;
				Note.mania = 4;
			case 5: 
				keys = [false, false, false, false, false, false, false, false];
				Note.swagWidth = 100 * 0.7;
				Note.noteScale = 0.55;
				Note.pixelnoteScale = 0.74;
				Note.mania = 5;
			case 6: 
				keys = [false];
				Note.swagWidth = 200 * 0.7;
				Note.noteScale = 0.7;
				Note.pixelnoteScale = 1;
				Note.mania = 6;
			case 7: 
				keys = [false, false];
				Note.swagWidth = 180 * 0.7;
				Note.noteScale = 0.7;
				Note.pixelnoteScale = 0.9;
				Note.mania = 7;
			case 8: 
				keys = [false, false, false];
				Note.swagWidth = 170 * 0.7;
				Note.noteScale = 0.7;
				Note.pixelnoteScale = 1;
				Note.mania = 8;
		}

		generateStaticArrows(0);
		generateStaticArrows(1);

		maniaChanged = true;

		


		//maniaSwitch(newMania);




	}

	var isbobmad:Bool = true;
	var appearscreen:Bool = true;
	function shakescreen()
	{
		new FlxTimer().start(0.01, function(tmr:FlxTimer)
		{
			Lib.application.window.move(Lib.application.window.x + FlxG.random.int( -10, 10),Lib.application.window.y + FlxG.random.int( -8, 8));
		}, 50);
	}
	function WindowGoBack()
		{
			new FlxTimer().start(0.01, function(tmr:FlxTimer)
			{
				var xLerp:Float = FlxMath.lerp(windowX, Lib.application.window.x, 0.95);
				var yLerp:Float = FlxMath.lerp(windowY, Lib.application.window.y, 0.95);
				Lib.application.window.move(Std.int(xLerp),Std.int(yLerp));
			}, 20);
		}
	function resetBobismad():Void
		{
			camHUD.visible = true;
			camNotes.visible = true;
			bobsound.pause();
			bobmadshake.visible = false;
			bobsound.volume = 0;
			isbobmad = true;
		}

	function Bobismad()
		{
			camHUD.visible = false;
			camNotes.visible = false;
			bobmadshake.visible = true;
			bobsound.play();
			bobsound.volume = 1;
			isbobmad = false;
			shakescreen();
			new FlxTimer().start(0.5 , function(tmr:FlxTimer)
			{
				resetBobismad();
			});
		}

	var trainMoving:Bool = false;
	var trainFrameTiming:Float = 0;

	var trainCars:Int = 8;
	var trainFinishing:Bool = false;
	var trainCooldown:Int = 0;

	function trainStart():Void
	{
		if(FlxG.save.data.distractions){
			trainMoving = true;
			if (!trainSound.playing)
				trainSound.play(true);
		}
	}

	var startedMoving:Bool = false;

	function updateTrainPos():Void
	{
		if(FlxG.save.data.distractions){
			if (trainSound.time >= 4700)
				{
					startedMoving = true;
					gf.playAnim('hairBlow');
				}
		
				if (startedMoving)
				{
					phillyTrain.x -= 400;
		
					if (phillyTrain.x < -2000 && !trainFinishing)
					{
						phillyTrain.x = -1150;
						trainCars -= 1;
		
						if (trainCars <= 0)
							trainFinishing = true;
					}
		
					if (phillyTrain.x < -4000 && trainFinishing)
						trainReset();
				}
		}

	}
	public function nuts(n:Int):Void 
		{
		   // n = baits;
			
			
			
			var bait1:FlxSprite = new FlxSprite(981,181).loadGraphic(Paths.image('V/bait/pic1','shared'));
			var bait2:FlxSprite = new FlxSprite(662,405).loadGraphic(Paths.image('V/bait/pic2','shared'));
			var bait3:FlxSprite = new FlxSprite(985,500).loadGraphic(Paths.image('V/bait/pic3','shared'));
			var bait4:FlxSprite = new FlxSprite(680,8).loadGraphic(Paths.image('V/bait/pic4','shared'));
			var bait5:FlxSprite = new FlxSprite(800,335).loadGraphic(Paths.image('V/bait/pic5','shared'));
			var bait6:FlxSprite = new FlxSprite(959,10).loadGraphic(Paths.image('V/bait/pic6','shared'));
			var bait7:FlxSprite = new FlxSprite(630,235).loadGraphic(Paths.image('V/bait/pic7','shared'));
			var bait8:FlxSprite = new FlxSprite(722,500).loadGraphic(Paths.image('V/bait/pic8','shared'));
			if(FlxG.save.data.middlescroll){
				bait1.x -= 300;
				bait2.x -= 300;
				bait3.x -= 300;
				bait4.x -= 300;
				bait5.x -= 300;
				bait6.x -= 300;
				bait7.x -= 300;
				bait8.x -= 300;
			}
		    bait1.cameras = [camNotes];
			bait2.cameras = [camNotes];
			bait3.cameras = [camNotes];
			bait4.cameras = [camNotes];
			bait5.cameras = [camNotes];
			bait6.cameras = [camNotes];
			bait7.cameras = [camNotes];
			bait8.cameras = [camNotes];
			
			switch (n)
			{
				case 1 : add(bait1); 
				case 2 : add(bait2); 
				case 3 : add(bait3); 
				case 4 : add(bait4); 
				case 5 : add(bait5); 
				case 6 : add(bait6); 
				case 7 : add(bait7); 
				case 8 : add(bait8); 
			}
		   
		
		}
	public function ebolachan():Void
		{
			var lefunnyhead = Paths.getSparrowAtlas('bonus/mec/head','shared');
					ebolabitch.frames = lefunnyhead;
					ebolabitch.animation.addByPrefix('laugh', 'ebolagrl' ,24,false);
					ebolabitch.animation.play('laugh');
					ebolabitch.scale.set(1.5,1.5);
					ebolabitch.screenCenter();	
					add(ebolabitch);
					ebolabitch.animation.finishCallback = function(youwilldieandyouwilllikeit:String)
						{							
							remove(ebolabitch);								
						}				
		}
	function trainReset():Void
	{
		if(FlxG.save.data.distractions){
			gf.playAnim('hairFall');
			phillyTrain.x = FlxG.width + 200;
			trainMoving = false;
			// trainSound.stop();
			// trainSound.time = 0;
			trainCars = 8;
			trainFinishing = false;
			startedMoving = false;
		}
	}

	function lightningStrikeShit():Void
	{
		FlxG.sound.play(Paths.soundRandom('thunder_', 1, 2));
		halloweenBG.animation.play('lightning');

		lightningStrikeBeat = curBeat;
		lightningOffset = FlxG.random.int(8, 24);

		boyfriend.playAnim('scared', true);
		gf.playAnim('scared', true);
	}

	function bonusanims():Void
		{			
			if (curSong.toLowerCase() == 'infitrigger') 
				{
					switch (curBeat)
					{
						case 10 : 
							scaredyo.animation.play('aaaa');
							scaredyo.animation.finishCallback = function(whitewhitty:String)
								{									
									scaredyo.destroy(); ///for opt
								}	
						
						case 68:
							r9k.visible=true;	
						
						        r9k.animation.play('ded');					   
								r9k.animation.finishCallback = function(whitewhitty:String)
								{									
								r9k.destroy();
								}	
						case 150:
							
							blackguy.visible=true;
							
							blackguy.animation.play('ded');	
							blackguy.animation.finishCallback = function(whitewhitty:String)
								{									
									blackguy.destroy();					
								}				
						case 260:
								unsmile.visible=true;

								unsmile.animation.play('ded');	
								unsmile.animation.finishCallback = function(whitewhitty:String)
									{									
										unsmile.destroy();							
									}			

						case 352:
							cat.visible=true;				
							cat.animation.play('ded');
								cat.animation.finishCallback = function(whitewhitty:String)
									{										
									unsmile.destroy();							
														
									}		
						
				}					
			
		   }
		}

		function doFlip():Void
			{
			trace('flip em!!!!');  
				blackboi = new FlxSprite(536,-140);
				blackboi.frames = Paths.getSparrowAtlas('bonus/mec/fnotes','shared');
				blackboi.animation.addByPrefix('flipem','black',24,false);
				blackboi.scale.set(0.7,0.7);				
				blackboi.cameras = [camNotes];	
				if(FlxG.save.data.downscroll)
					{
				blackboi.flipX = true;
				blackboi.flipY = true;
				blackboi.y =  326;
				blackboi.x =  525;
					}			
					//beat 449
					//step 1797
				add(blackboi);
				blackboi.animation.play("flipem");		
				blackboi.animation.finishCallback = function(donefliping:String)
					{									
						remove(blackboi);						
					}				
			}
			
			function vScream():Void
				{
				
					trace('FUUUUUUCK');	
					FUCK.setPosition(dad.x,dad.y);
					remove(dad);
					add(FUCK);	
					FUCK.animation.play('FFFFUU');	
					FlxG.camera.shake(0.009,3000);
				}
	var resetSpookyText:Bool = true;

	function resetSpookyTextManual():Void
	{
		trace('reset spooky');
		spookySteps = curStep;
		spookyRendered = true;
		tstatic.alpha = 0.5;
		FlxG.sound.play(Paths.sound('staticSound'));
		resetSpookyText = true;
	}

	function manuallymanuallyresetspookytextmanual()
	{
		remove(spookyText);
		spookyRendered = false;
		tstatic.alpha = 0;
	}

	function chantownanims():Void
		{
			if (curSong == 'Sage')
				{
					switch(curStep)
					{
						case 344 :xtan.animation.play("peakan");	
						case 366 :trv.animation.play("walkan");											
					}
				}
		}

	var danced:Bool = false;

	var stepOfLast = 0;

	override function stepHit()
	{
		super.stepHit();
		if (FlxG.sound.music.time > Conductor.songPosition + 1 || FlxG.sound.music.time < Conductor.songPosition - 1)
		{
			resyncVocals();
		}

		// gamejolt trophies
		if (SONG.song.toLowerCase() == 'defeat' && !FlxG.save.data.botplay && curStep == 2009)
			{
				GameJoltAPI.getTrophy(155519);
			}			
		if (SONG.song.toLowerCase() == 'run' && !FlxG.save.data.botplay && curStep == 866)
			{
				GameJoltAPI.getTrophy(155497);
			}			
		if (SONG.song.toLowerCase() == 'bloodshed' && FlxG.save.data.noMiss && !FlxG.save.data.botplay && curStep == 1150 || SONG.song.toLowerCase() == 'bloodshed' && !FlxG.save.data.bloodshedfc && FlxG.save.data.sickOnly && !FlxG.save.data.botplay && curStep == 1150)
			{
				GameJoltAPI.getTrophy(155500);
			}
		if (SONG.song.toLowerCase() == 'sporting' && FlxG.save.data.noMiss && !FlxG.save.data.botplay && curStep == 3073 || SONG.song.toLowerCase() == 'sporting' && !FlxG.save.data.sportingfc && FlxG.save.data.sickOnly && !FlxG.save.data.botplay && curStep == 3073)
			{
				GameJoltAPI.getTrophy(155541);
			}
		if (SONG.song.toLowerCase() == 'expurgation' && FlxG.save.data.noMiss && !FlxG.save.data.botplay && curStep == 2960 || SONG.song.toLowerCase() == 'expurgation' && !FlxG.save.data.expurgationfc && FlxG.save.data.sickOnly && !FlxG.save.data.botplay && curStep == 2960)
			{
				GameJoltAPI.getTrophy(155540);
			}
		if (SONG.song.toLowerCase() == 'attack' && FlxG.save.data.noMiss && !FlxG.save.data.botplay && curStep == 1383 || SONG.song.toLowerCase() == 'attack' && !FlxG.save.data.attackfc && FlxG.save.data.sickOnly && !FlxG.save.data.botplay && curStep == 1383)
			{
				GameJoltAPI.getTrophy(155542);
			}	
		if (SONG.song.toLowerCase() == 'epiphany' && FlxG.save.data.noMiss && !FlxG.save.data.botplay && curStep == 3336 || SONG.song.toLowerCase() == 'epiphany' && !FlxG.save.data.epiphanyfc && FlxG.save.data.sickOnly && !FlxG.save.data.botplay && curStep == 3336)
			{
				GameJoltAPI.getTrophy(155533);
			}
		if (SONG.song.toLowerCase() == 'no villains' && FlxG.save.data.noMiss && !FlxG.save.data.botplay && curStep == 2200 || SONG.song.toLowerCase() == 'no villains' && !FlxG.save.data.novilliansfc && FlxG.save.data.sickOnly && !FlxG.save.data.botplay && curStep == 2200)
			{
				GameJoltAPI.getTrophy(155530);
			}
		if (SONG.song.toLowerCase() == 'honorbound' && FlxG.save.data.noMiss && !FlxG.save.data.botplay && curStep == 1696 || SONG.song.toLowerCase() == 'honorbound' && !FlxG.save.data.honorboundfc && FlxG.save.data.sickOnly && !FlxG.save.data.botplay && curStep == 1696)
			{
				GameJoltAPI.getTrophy(155534);
			}
		if (SONG.song.toLowerCase() == 'alegbra' && FlxG.save.data.noMiss && !FlxG.save.data.botplay && curStep == 8747 || SONG.song.toLowerCase() == 'alegbra' && !FlxG.save.data.alegbra && FlxG.save.data.sickOnly && !FlxG.save.data.botplay && curStep == 8747)
			{
				GameJoltAPI.getTrophy(155537);
			}
		if (SONG.song.toLowerCase() == 'piracy' && FlxG.save.data.noMiss && !FlxG.save.data.botplay && curStep == 2376 || SONG.song.toLowerCase() == 'piracy' && !FlxG.save.data.piracyfc && FlxG.save.data.sickOnly && !FlxG.save.data.botplay && curStep == 2376)
			{
				GameJoltAPI.getTrophy(155538);
			}
		if (SONG.song.toLowerCase() == 'onslaught' && FlxG.save.data.noMiss && !FlxG.save.data.botplay && curStep == 1600 || SONG.song.toLowerCase() == 'onslaught' && !FlxG.save.data.onslaughtfc && FlxG.save.data.sickOnly && !FlxG.save.data.botplay && curStep == 1600)
			{
				GameJoltAPI.getTrophy(155617);
			}
		if (SONG.song.toLowerCase() == 'foolhardy' && FlxG.save.data.noMiss && !FlxG.save.data.botplay && curStep == 2992 || SONG.song.toLowerCase() == 'foolhardy' && !FlxG.save.data.foolhardyfc && FlxG.save.data.sickOnly && !FlxG.save.data.botplay && curStep == 2992)
			{
				GameJoltAPI.getTrophy(155621);
			}
		if (SONG.song.toLowerCase() == 'no villains' && FlxG.save.data.enemyDrain && !FlxG.save.data.botplay && curStep == 2200)
			{
				GameJoltAPI.getTrophy(155717);
			}
		if (SONG.song.toLowerCase() == 'unknown suffering' && FlxG.save.data.noMiss && !FlxG.save.data.botplay && curStep == 1728 || SONG.song.toLowerCase() == 'unknown suffering' && FlxG.save.data.sickOnly && !FlxG.save.data.botplay && curStep == 1728)
			{
				GameJoltAPI.getTrophy(157976);
			}
		if (SONG.song.toLowerCase() == 'happiness' && FlxG.save.data.noMiss && !FlxG.save.data.botplay && curStep == 2640 || SONG.song.toLowerCase() == 'happiness' && FlxG.save.data.sickOnly && !FlxG.save.data.botplay && curStep == 2640)
			{
				GameJoltAPI.getTrophy(157977);
			}
		if (SONG.song.toLowerCase() == 'strongmann' && FlxG.save.data.noMiss && !FlxG.save.data.botplay && curStep == 29920 || SONG.song.toLowerCase() == 'strongmann' && FlxG.save.data.sickOnly && !FlxG.save.data.botplay && curStep == 29920)
			{
				GameJoltAPI.getTrophy(157978);
			}
		if (SONG.song.toLowerCase() == 'danger' && FlxG.save.data.noMiss && !FlxG.save.data.botplay && curStep == 2895 || SONG.song.toLowerCase() == 'danger' && FlxG.save.data.sickOnly && !FlxG.save.data.botplay && curStep == 2895)
			{
				GameJoltAPI.getTrophy(157975);
			}
		if (SONG.song.toLowerCase() == 'cheating' && !FlxG.save.data.botplay && curStep == 1591)
			{
				GameJoltAPI.getTrophy(157975);
			}
		if (SONG.song.toLowerCase() == 'unknown suffering' && !FlxG.save.data.botplay && curStep == 1728 && totalMouseNotesHit >= 25)
			{
				GameJoltAPI.getTrophy(158099);
			}
		if (SONG.song.toLowerCase() == 'infitrigger' && !FlxG.save.data.noTriggerFlip && FlxG.save.data.noMiss && !FlxG.save.data.botplay && curStep == 2869 || SONG.song.toLowerCase() == 'infitrigger' && !FlxG.save.data.noTriggerFlip && FlxG.save.data.sickOnly && !FlxG.save.data.botplay && curStep == 2869)
			{
				GameJoltAPI.getTrophy(159474);
			}
		if (SONG.song.toLowerCase() == 'phantasm' && FlxG.save.data.noMiss && !FlxG.save.data.botplay && curStep == 1972 || SONG.song.toLowerCase() == 'phantasm' && FlxG.save.data.sickOnly && !FlxG.save.data.botplay && curStep == 1972)
			{
				GameJoltAPI.getTrophy(159475);
			}
		if (SONG.song.toLowerCase() == 'infitrigger' && !FlxG.save.data.botplay && curStep == 2869 && totalEbolaNotesHit >= 1)
			{
				GameJoltAPI.getTrophy(159473);
			}

		if (FlxG.save.data.ghostNotes){
			ghostNotes = true;
		}

		if (curSong.toLowerCase() == 'infiltrator') 
			{
				switch (curStep)
				{
					case 32:
						camHUD.visible = true;
						camNotes.visible = true;
					case 509:
						//FlxG.sound.play(Paths.sound('cloak'), 1);
						FlxTween.tween(camHUD, {alpha: 0},2, 
							{
								ease: FlxEase.cubeInOut,
							});
						FlxTween.tween(camNotes, {alpha: 0},2, 
							{
								ease: FlxEase.cubeInOut,
							});
					case 537:
						if (!FlxG.save.data.ghostNotes || !FlxG.save.data.invisibleNotes)
							ghostNotes = true; //Ghost notes + middle scroll
						if (!FlxG.save.data.middlescroll){
							cpuStrums.forEach(function(spr:FlxSprite)
								{
									FlxTween.tween(spr, {x: spr.x -= 600}, 0.1, {ease: FlxEase.linear});
									trace('hi');
								});
							playerStrums.forEach(function(spr:FlxSprite)
								{
									FlxTween.tween(spr, {x: spr.x -= 325}, 0.1, {ease: FlxEase.linear});
									// spr.x -= 600;
								});
							// playerStrums.forEach(function(spr:FlxSprite){spr.x -= 325; trace('hi');});
							// cpuStrums.forEach(function(spr:FlxSprite){spr.x -= 600;});
						}
					case 539:
						FlxTween.tween(camHUD, {alpha: 100},2, 
							{
								ease: FlxEase.cubeInOut,
							});
						FlxTween.tween(camNotes, {alpha: 100},2, 
							{
								ease: FlxEase.cubeInOut,
							});
					case 895:
						//FlxG.sound.play(Paths.sound('cloak'), 1);
						FlxTween.tween(camHUD, {alpha: 0},2, 
							{
								ease: FlxEase.cubeInOut,
							});
						FlxTween.tween(camNotes, {alpha: 0},2, 
							{
								ease: FlxEase.cubeInOut,
							});
					case 930:
						if (!FlxG.save.data.ghostNotes || !FlxG.save.data.invisibleNotes)
							ghostNotes = false; 
						if (!FlxG.save.data.middlescroll){
							cpuStrums.forEach(function(spr:FlxSprite)
								{
									FlxTween.tween(spr, {x: spr.x += 600}, 0.1, {ease: FlxEase.linear});
								});
							playerStrums.forEach(function(spr:FlxSprite)
								{
									FlxTween.tween(spr, {x: spr.x += 325}, 0.1, {ease: FlxEase.linear});
								});
							// cpuStrums.forEach(function(spr:FlxSprite){spr.x += 600;});
							// playerStrums.forEach(function(spr:FlxSprite){spr.x += 325;});
						}
					case 933:
						FlxTween.tween(camHUD, {alpha: 100},3, 
							{
								ease: FlxEase.cubeInOut,
							});
						FlxTween.tween(camNotes, {alpha: 100},3, 
							{
								ease: FlxEase.cubeInOut,
							});
				}
			}

		if (curSong.toLowerCase() == 'phantasm')
			{
				switch(curStep)
				{
					case 384|768|1151|1172|1276|1282|1304|1536|1922|1937|1943|1956:
						fleetON();
					case 640|1024|1154|1176|1279|1300|1408|1792|1926|1940|1946|1960:
						fleetOFF();
				}				
			}

		if (curSong.toLowerCase() == 'infitrigger' && !FlxG.save.data.noTriggerFlip)
			{
				switch(curStep)
				{
					case 1794:
						playerStrums.forEach(function(spr:FlxSprite)
							{
								FlxTween.tween(spr, {alpha: 0}, (0.1), {ease:FlxEase.quadInOut}); 
							});
					case 1818:
						FlxTween.tween(blackboi, {alpha: 0}, (0.1), {ease:FlxEase.quadInOut}); 
					case 1820:
						playerStrums.forEach(function(spr:FlxSprite)
							{
								FlxTween.tween(spr, {alpha: 1}, (0.1), {ease:FlxEase.quadInOut}); 
							});
				}				
			}
		if (SONG.song.toLowerCase() == 'unknown suffering')
			{
				switch (curStep)
				{
					case 3:
						swagSpeed = 2.4;
					case 28 | 30 | 60 | 62 | 92 | 94 | 124 | 126:
						FlxG.camera.zoom += 0.01;
						camHUD.zoom += 0.3;
						camNotes.zoom += 0.3;
					case 384:
						if (FlxG.save.data.flashing){
						FlxG.camera.flash(FlxColor.BLACK, 1, null, true);}
						remove(dad);
						dad = new Character (600, 425, 'suicide');
						add(dad);
						swagSpeed = SONG.speed;
					case 404 | 421 | 437 | 467 | 484 | 673 | 1059 | 1075 | 1330 | 1457 | 1493 | 1508 | 1528 | 1544 | 1558 | 1575 | 1591:
						dad.playAnim('dodge', true);
						dad.nonanimated = true;
					case 407 | 424 | 440 | 470 | 487 | 676 | 1062 | 1078 | 1333 | 1460 | 1496 | 1511 | 1531 | 1547 | 1561 | 1578 | 1594:
						dad.nonanimated = false;
					case 406 | 423 | 439 | 469 | 486 | 676 | 1061 | 1078 | 1333 | 1459 | 1496 | 1511 | 1531 | 1548 | 1561 | 1578 | 1594:
						boyfriend.playAnim('dodge', true);
						boyfriend.nonanimated = true;
					case 409 | 426 | 442 | 472 | 489 | 679 | 1064 | 1081 | 1336 | 1462 | 1499 | 1514 | 1534 | 1551 | 1564 | 1581 | 1597:
						boyfriend.nonanimated = false;
					case 648 | 1480:
						if (FlxG.save.data.flashing){
						FlxG.camera.flash(FlxColor.WHITE, 1, null, true);}
					case 1608:
						dad.alpha = 0;
						boyfriend.alpha = 0;
						bg.alpha = 0;
						popup = false;
						kadeEngineWatermark.alpha = 0;
						healthBarBG.alpha = 0;
						healthBar.alpha = 0;
						overhealthBar.alpha = 0;
						botPlayState.alpha = 0;
						iconP1.alpha = 0;
						iconP2.alpha = 0;
						scoreTxt.alpha = 0;
						cpuStrums.forEach(function(spr:FlxSprite)
						{
							spr.alpha = 0;
						});
						playerStrums.forEach(function(spr:FlxSprite)
						{
							spr.alpha = 0;
						});
				}
			}
		if (SONG.song.toLowerCase() == 'danger')
			{
				if (curStep == 2817 && FlxG.save.data.flashing)
					doRGB = false;
			}
	
		if (curSong.toLowerCase() == 'honorbound')
			{
				switch (curStep)
				{
					case 1264:
						songIsWeird = true;
						camZooming = false;
						tweenCam(1.3, 1);
					case 1280:
						soldierShake = true;
						curTiming = 1;
					case 1536:
						songIsWeird = false;
						soldierShake = false;
						camZooming = true;
						curTiming = 0;
						tweenCam(0.9, 1);
				}
			}
		if (SONG.song.toLowerCase() == 'spookpostor')
			{
				if (curStep == 64)
					FlxTween.tween(FlxG.camera, {zoom: 0.9}, 0.9, {ease: FlxEase.quadInOut});
					defaultCamZoom = 0.9;
			}
		if (SONG.song.toLowerCase() == 'no villains')
			{
				//modchart doesn't work for this engine so i have to hardcode it :(
				switch (curStep)
				{
					case 844:
					remove(dad);
					dad = new Character (20, 295, 'sonic-mad');
					add(dad);
					remove(iconP2);
					iconP2 = new HealthIcon('sonic-mad', false);
					iconP2.y = healthBar.y - (iconP2.height / 2);
					add(iconP2);
					iconP2.cameras = [camHUD];
					case 880:
					remove(dad);
					dad = new Character (20, 295, 'sonic-tgt');
					add(dad);
					remove(iconP2);
					iconP2 = new HealthIcon('sonic-tgt', false);
					iconP2.y = healthBar.y - (iconP2.height / 2);
					add(iconP2);
					iconP2.cameras = [camHUD];
					case 1152:
					remove(dad);
					dad = new Character (20, 295, 'sonic-mad');
					add(dad);
					remove(iconP2);
					iconP2 = new HealthIcon('sonic-mad', false);
					iconP2.y = healthBar.y - (iconP2.height / 2);
					add(iconP2);
					iconP2.cameras = [camHUD];
					case 1408:
					remove(dad);
					dad = new Character (20, 295, 'sonic-forced');
					add(dad);
					remove(iconP2);
					iconP2 = new HealthIcon('sonic-forced', false);
					iconP2.y = healthBar.y - (iconP2.height / 2);
					add(iconP2);
					iconP2.cameras = [camHUD];
					case 1664:
					remove(dad);
					dad = new Character (20, 295, 'sonic-mad');
					add(dad);
					remove(iconP2);
					iconP2 = new HealthIcon('sonic-mad', false);
					iconP2.y = healthBar.y - (iconP2.height / 2);
					add(iconP2);
					iconP2.cameras = [camHUD];
					FlxTween.tween(FlxG.camera, {zoom: 1.6}, 1.5, {ease: FlxEase.quadInOut});
					defaultCamZoom = 1.6;
					if (FlxG.save.data.enemyDrain)
						{
							FlxTween.tween(stageCurtains, {alpha: 0}, 1, {ease: FlxEase.sineOut});
							FlxTween.tween(bg, {alpha: 0}, 1, {ease: FlxEase.sineOut});
							FlxTween.tween(stageFront, {alpha: 0}, 1, {ease: FlxEase.sineOut});
						}
					case 1920:
					FlxTween.tween(FlxG.camera, {zoom: 1}, 1.5, {ease: FlxEase.quadInOut});
					defaultCamZoom = 1;
					if (FlxG.save.data.enemyDrain)
						{
							FlxTween.tween(stageCurtains, {alpha: 1}, 1, {ease: FlxEase.sineOut});
							FlxTween.tween(bg, {alpha: 1}, 1, {ease: FlxEase.sineOut});
							FlxTween.tween(stageFront, {alpha: 1}, 1, {ease: FlxEase.sineOut});
						}
				}
			}	
			if (curStage == 'zardy')
				{
					switch (curStep)
					{
						case 2427:
						FlxTween.tween(dad, {alpha: 0.8}, 0.4);
						case 2943:
						FlxTween.tween(dad, {alpha: 0}, 0.4);
					}
				}

				if (SONG.song.toLowerCase() == 'sunshine')
					{
						if (curStep == 64)
							tailscircle = 'hovering';
						if (curStep == 128 || curStep == 319 || curStep == 866)
							tailscircle = 'circling';
						if (curStep == 256 || curStep == 575) // this is to return tails to it's original positions (me very smart B))
						{
							FlxTween.tween(dad, {x: -150, y: 330}, 0.2, {
								onComplete: function(twn:FlxTween)
								{
									dad.setPosition(-150, 330);
									tailscircle = 'hovering';
									floaty = 41.82;
								}
							});
						}
						if (curStep == 588) // kill me 588
						{
							playerStrums.forEach(function(spr:FlxSprite)
							{
								if (!FlxG.save.data.middlescroll)
									{
										spr.x -= 300;
									}

							});
							popup = false;
							boyfriend.alpha = 0;
							bgspec.alpha = 0;
							kadeEngineWatermark.alpha = 0;
							healthBarBG.alpha = 0;
							healthBar.alpha = 0;
							botPlayState.alpha = 0;
							iconP1.alpha = 0;
							iconP2.alpha = 0;
							scoreTxt.alpha = 0;
							canPause = false;
			
							remove(dad);
							dad = new Character(-150, 330, 'TDollAlt');
							add(dad);
							cpuStrums.forEach(function(spr:FlxSprite)
								{
									if (!FlxG.save.data.middlescroll)
										spr.x -= 300;
								});
							playerStrums.forEach(function(spr:FlxSprite)
							{
								spr.alpha = 0;
							});
						}
						if (curStep == 860) // kill me
						{
							playerStrums.forEach(function(spr:FlxSprite)
							{
								if (!FlxG.save.data.middlescroll)
									{
										spr.x += 300;
									}	
							});
							popup = true;
							boyfriend.alpha = 1;
							bgspec.alpha = 1;
							kadeEngineWatermark.alpha = 1;
							botPlayState.alpha = 1;
							healthBarBG.alpha = 1;
							healthBar.alpha = 1;
							iconP1.alpha = 1;
							iconP2.alpha = 1;
							scoreTxt.alpha = 1;
							canPause = true;
							remove(dad);
							dad = new Character(-150, 330, 'TDoll');
							add(dad);
							ezTrail = new FlxTrail(dad, null, 2, 5, 0.3, 0.04);
							tailscircle = '';
							cpuStrums.forEach(function(spr:FlxSprite)
								{
									if (!FlxG.save.data.middlescroll)
										spr.x += 300;
								});
							playerStrums.forEach(function(spr:FlxSprite)
							{
								spr.alpha = 1;
							});
						}
						if (curStep == 1120)
						{
							FlxTween.tween(dad, {x: -150, y: 330}, 0.2, {
								onComplete: function(twn:FlxTween)
								{
									dad.setPosition(-150, 330);
									tailscircle = '';
									remove(ezTrail);
								}
							});
						}
					}

					if (curSong.toLowerCase() == 'chaos')
						{
							if (curStep == 15)
							{
								dad.playAnim('fastanim', true);
								dad.nonanimated = true;
								FlxTween.tween(dad, {x: 61.15, y: -94.75}, 2, {ease: FlxEase.cubeOut});
							}
							else if (curStep == 9)
							{
								dad.visible = true;
								FlxTween.tween(dad, {y: dad.y - 500}, 0.5, {ease: FlxEase.cubeOut});
							}
							else if (curStep == 64)
							{
								dad.nonanimated = false;
								tailscircle = 'hovering';
								camHUD.visible = true;
								camHUD.alpha = 0;
								camNotes.visible = true;
								camNotes.alpha = 0;
								FlxTween.tween(camHUD, {alpha: 1}, 0.2, {ease: FlxEase.cubeOut});
								FlxTween.tween(camNotes, {alpha: 1}, 0.2, {ease: FlxEase.cubeOut});
							}
							switch (curStep)
							{
								case 256:
									laserThingy(true);
				
								case 399, 528, 656, 784, 1040, 1168, 1296, 1552, 1680, 1808, 1952:
									remove(dad);
									dad = new Character(61.15, -94.75, 'fleetway');
									add(dad);
									tailscircle = 'hovering';
				
								case 1008:
									remove(boyfriend);
									boyfriend = new Boyfriend(2040.55 - 200, 685.6 - 130 - 46, 'bf-super');
									add(boyfriend);
				
									FlxG.camera.shake(0.02, 0.2);
									if (FlxG.save.data.flashing){
									FlxG.camera.flash(FlxColor.YELLOW, 0.2);}
				
									FlxG.sound.play(Paths.sound('SUPERBF', 'shared'));
				
									boyfriend.scrollFactor.set(1.1, 1);
				
									boyfriend.addOffset('idle', 56, 11);
									boyfriend.addOffset("singUP", 51, 40);
									boyfriend.addOffset("singRIGHT", 0, 9);
									boyfriend.addOffset("singLEFT", 74, 14);
									boyfriend.addOffset("singDOWN", 60, -71);
									boyfriend.addOffset("singUPmiss", 48, 36);
									boyfriend.addOffset("singRIGHTmiss", 3, 11);
									boyfriend.addOffset("singLEFTmiss", 55, 13);
									boyfriend.addOffset("singDOWNmiss", 56, -72);
				
								case 1261, 1543, 1672, 1792, 1936:
									remove(dad);
									dad = new Character(61.15, -94.75, 'fleetway-extras2');
									add(dad);
									switch (curStep)
									{
										case 1261:
											dad.playAnim('a', true);
				
										case 1543:
											dad.playAnim('b', true);
				
										case 1672:
											dad.playAnim('c', true);
				
										case 1792:
											dad.playAnim('d', true);
				
										case 1936:
											dad.playAnim('e', true);
									}
								case 383, 512, 640, 776, 1036, 1152:
									remove(dad);
									dad = new Character(61.15, -94.75, 'fleetway-extras');
									add(dad);
									switch (curStep)
									{
										case 383:
											dad.playAnim('a', true);
				
										case 512:
											dad.playAnim('b', true);
				
										case 640:
											dad.playAnim('c', true);
				
										case 776:
											dad.playAnim('d', true);
				
										case 1036:
											dad.playAnim('e', true);
				
										case 1152:
											dad.playAnim('f', true);
									}
								case 380, 509, 637, 773, 1033, 1149, 1261, 1543, 1672, 1792, 1936:
									tailscircle = '';
									FlxTween.tween(dad, {x: 61.15, y: -94.75}, 0.2);
									dad.setPosition(61.15, -94.75);
							}
						}

				if (SONG.song.toLowerCase() == 'milk')
					{
						if (curStep == 538 || curStep == 2273)
						{
							var sponge:FlxSprite = new FlxSprite(dad.getGraphicMidpoint().x - 200,
								dad.getGraphicMidpoint().y - 120).loadGraphic(Paths.image('SpingeBinge', 'shared'));
			
							add(sponge);
			
							dad.visible = false;
			
							new FlxTimer().start(0.7, function(tmr:FlxTimer)
							{
								remove(sponge);
								dad.visible = true;
							});
						}
						if (curStep == 69) // holy fuck niceeee
						{
							FlxTween.tween(FlxG.camera, {zoom: 2.2}, 4);
						}
						if (curStep == 96) // holy fuck niceeee
						{
							FlxTween.cancelTweensOf(FlxG.camera);
							FlxG.camera.zoom = defaultCamZoom;
						}
					}
				if (SONG.song.toLowerCase() == 'cycles')
					{
						switch (curStep)
						{
							case 320:
								FlxTween.tween(FlxG.camera, {zoom: .9}, 2, {ease: FlxEase.cubeOut});
								defaultCamZoom = .9;
							case 1103:
								FlxTween.tween(FlxG.camera, {zoom: .8}, 2, {ease: FlxEase.cubeOut});
								defaultCamZoom = .8;
						}
					}	
					if (SONG.song.toLowerCase() == 'you cant run')
						{
							var vg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('RedVG', 'shared'));
							vg.alpha = 0;
							vg.cameras = [camNotes];
							add(vg);
				
							var amongus:Bool = true;

							if (ycrspinArray.contains(curStep))
								{
									strumLineNotes.forEach(function(tospin:FlxSprite)
									{
										FlxTween.angle(tospin, 0, 360, 0.2, {ease: FlxEase.quintOut});
									});
								}
				
							switch (curStep) //alt anims are easier
							{
								/*case 128, 328, 1288:
									dad.playAnim('laugh');
									dad.nonanimated = true;
								case 130, 132, 134, 136, 138, 140, 330, 332, 334, 1290, 1292, 1294:
									dad.nonanimated = false;
									dad.playAnim('laugh');
									dad.nonanimated = true;
								case 142, 336, 1296:
									dad.nonanimated = false;*/
							}
				
							if (curStep == 528) // PIXEL MOMENT LAWLALWALAWL
							{
								doStaticSign(0, false);
								SONG.noteStyle = 'pixel';
								removeStatics();
								generateStaticArrows(0);
								generateStaticArrows(1);
				
								remove(dad);
								dad = new Character(100, 100 + 300 - 50, 'sonic.exe alt');
								add(dad);
				
								iconP2.animation.play('sonic.exe alt');
				
								remove(gf);
								gf = new Character(400, 130, 'gf-pixel-alt');
								add(gf);
				
								remove(boyfriend);
								boyfriend = new Boyfriend(770, 450, 'bf-pixel-alt');
								boyfriend.setPosition(530 + 100, 170 + 200);
								add(boyfriend);
				
								remove(iconP1);
								iconP1 = new HealthIcon('bf-pixel-alt', true);
								iconP1.y = healthBar.y - (iconP1.height / 2);
								add(iconP1);
								iconP1.cameras = [camHUD];
				
								bgspec.visible = true;
							}
							else if (curStep == 784) // BACK TO NORMAL MF!!!
							{
								doStaticSign(0, false);
								SONG.noteStyle = 'normal';
								removeStatics();
								generateStaticArrows(0);
								generateStaticArrows(1);
				
								remove(dad);
								dad = new Character(116 - 20, 107, 'sonic.exe');
								add(dad);
				
								iconP2.animation.play('sonic.exe');
				
								dad.y -= 125;
								dad.scrollFactor.set(1.37, 1);
				
								remove(gf);
								gf = new Character(635.5 - 50 - 100, 265.1 - 250, 'gf');
								add(gf);
				
								remove(boyfriend);
								boyfriend = new Boyfriend(1036 - 100, 300, 'bf');
								add(boyfriend);
				
								remove(iconP1);
								iconP1 = new HealthIcon('bf', true);
								iconP1.y = healthBar.y - (iconP1.height / 2);
								add(iconP1);
								iconP1.cameras = [camHUD];
				
								dad.scrollFactor.set(1.3, 1);
								boyfriend.scrollFactor.set(1.3, 1);
								gf.scrollFactor.set(1.25, 1);
				
								bgspec.visible = false;
							}
							else if (curStep == 521 && curStep == 1160)
							{
								camGame.shake(0.03, 1.5);
								camHUD.shake(0.05, 1);
							}
							else if (curStep == 80 || curStep == 785)
							{
								new FlxTimer().start(.085, function(sex:FlxTimer)
								{
									if (curStep >= 528 && curStep <= 784)
										vg.visible = false;
									else
										vg.visible = true;
				
									if (!paused)
										vg.alpha += 0.1;
									if (vg.alpha < 1)
									{
										sex.reset();
									}
									if (vg.alpha == 1)
									{
										new FlxTimer().start(.085, function(sex2:FlxTimer)
										{
											if (!paused)
												vg.alpha -= 0.1;
											if (vg.alpha > 0)
											{
												sex2.reset();
											}
											if (vg.alpha == 0)
												sex.reset();
										});
									}
								});
							}
						}	
			if (curStage == 'SONICstage')
				{
					switch (curStep)
					{
						case 765:
							shakeCam = true;
							if (FlxG.save.data.flashing)
								FlxG.camera.flash(FlxColor.RED, 4);
						case 1305:
							FlxTween.tween(camHUD, {alpha: 0}, 0.3);
							FlxTween.tween(camNotes, {alpha: 0}, 0.3);
							dad.playAnim('iamgod', true);
							dad.nonanimated = true;
						case 1362:
							FlxTween.tween(camHUD, {alpha: 0}, 0.3);
							FlxTween.tween(camNotes, {alpha: 0}, 0.3);
							FlxG.camera.shake(0.002, 0.6);
							camHUD.camera.shake(0.002, 0.6);
							camNotes.camera.shake(0.002, 0.6);
						case 1432:
							FlxTween.tween(camHUD, {alpha: 1}, 0.3);
							FlxTween.tween(camNotes, {alpha: 1}, 0.3);
							FlxTween.tween(camHUD2, {alpha: 1}, 0.3);
							dad.nonanimated = false;
					}
				}
		
				if (dad.curCharacter == 'sonicfun' && SONG.song.toLowerCase() == 'endless')
					{
						switch (curStep)
						{
							case 10:
								FlxG.sound.play(Paths.sound('laugh1', 'shared'), 0.7);
						}
						if (spinArray.contains(curStep))
						{
							strumLineNotes.forEach(function(tospin:FlxSprite)
							{
								FlxTween.angle(tospin, 0, 360, 0.2, {ease: FlxEase.quintOut});
							});
						}
					}

			if (dad.curCharacter == 'oldsonicfun' && SONG.song.toLowerCase() == 'old endless')
				{
					switch (curStep)
					{
						case 10:
							FlxG.sound.play(Paths.sound('laugh1', 'shared'), 0.7);
					}
					if (oldspinArray.contains(curStep))
						{
							strumLineNotes.forEach(function(tospin:FlxSprite)
							{
								FlxTween.angle(tospin, 0, 360, 0.2, {ease: FlxEase.quintOut});
							});
						}
				}	

		if (curStage == 'SONICstage' && curStep == 791)
		{
			shakeCam = false;
			shakeCam2 = false;
		}	

		if (curStage == 'sonicFUNSTAGE' && curStep != stepOfLast)
			{
				switch (curStep)
				{
					case 888:
						camLocked = false;
						camFollow.setPosition(GameDimensions.width / 2 + 50, GameDimensions.height / 4 * 3 + 280);
						FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom + 0.3}, 0.7, {ease: FlxEase.cubeInOut});
						three();
					case 891:
						FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom + 0.3}, 0.7, {ease: FlxEase.cubeInOut});
						two();
					case 896:
						FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom + 0.3}, 0.7, {ease: FlxEase.cubeInOut});
						one();
					case 899:
						camLocked = true;
						FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 0.7, {ease: FlxEase.cubeInOut});
						gofun();
						SONG.noteStyle = 'majinNOTES';
						removeStatics();
						generateStaticArrows(0);
						generateStaticArrows(1);
				}
			}

		if (curStage == 'OldsonicFUNSTAGE' && curStep != stepOfLast)
			{
				switch(curStep)
				{
					case 909:
					camLocked = false;
					camFollow.setPosition(GameDimensions.width / 2 + 100, GameDimensions.height / 4 * 3 + 400);
					FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom + 0.3}, 0.7, {ease: FlxEase.cubeInOut});
					three();
					case 914:
					FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom + 0.3}, 0.7, {ease: FlxEase.cubeInOut});
					two();
					case 918:
					FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom + 0.3}, 0.7, {ease: FlxEase.cubeInOut});
					one();
					case 923:
					camLocked = true;
					FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 0.7, {ease: FlxEase.cubeInOut});
					gofun();
					SONG.noteStyle = 'majinNOTES';
					removeStatics();
					generateStaticArrows(0);
					generateStaticArrows(1);
				}
			}

			if (curStage == 'SONICstage' && curStep != stepOfLast && FlxG.save.data.jumpscares)
				{
					switch (curStep)
					{
						case 27:
							doStaticSign(0);
						case 130:
							doStaticSign(0);
						case 265:
							doStaticSign(0);
						case 450:
							doStaticSign(0);
						case 645:
							doStaticSign(0);
						case 800:
							doStaticSign(0);
						case 855:
							doStaticSign(0);
						case 889:
							doStaticSign(0);
						case 921:
							doSimpleJump();
						case 938:
							doStaticSign(0);
						case 981:
							doStaticSign(0);
						case 1030:
							doStaticSign(0);
						case 1065:
							doStaticSign(0);
						case 1105:
							doStaticSign(0);
						case 1123:
							doStaticSign(0);
						case 1178:
							doSimpleJump();
						case 1245:
							doStaticSign(0);
						case 1337:
							doSimpleJump();
						case 1345:
							doStaticSign(0);
						case 1432:
							doStaticSign(0);
						case 1454:
							doStaticSign(0);
						case 1495:
							doStaticSign(0);
						case 1521:
							doStaticSign(0);
						case 1558:
							doStaticSign(0);
						case 1578:
							doStaticSign(0);
						case 1599:
							doStaticSign(0);
						case 1618:
							doStaticSign(0);
						case 1647:
							doStaticSign(0);
						case 1657:
							doStaticSign(0);
						case 1692:
							doStaticSign(0);
						case 1713:
							doStaticSign(0);
						case 1723:
							doJumpscare();
							daJumpscare.cameras = [camHUD2];
						case 1738:
							doStaticSign(0);
						case 1747:
							doStaticSign(0);
						case 1761:
							doStaticSign(0);
						case 1785:
							doStaticSign(0);
						case 1806:
							doStaticSign(0);
						case 1816:
							doStaticSign(0);
						case 1832:
							doStaticSign(0);
						case 1849:
							doStaticSign(0);
						case 1868:
							doStaticSign(0);
						case 1887:
							doStaticSign(0);
						case 1909:
							doStaticSign(0);
					}
					stepOfLast = curStep;
				}
				
		// EX TRICKY HARD CODED EVENTS

		if (curStage == 'auditorHell' && curStep != stepOfLast)
			{
				switch(curStep)
				{
					case 384:
						doStopSign(0);
					case 511:
						doStopSign(2);
						doStopSign(0);
					case 610:
						doStopSign(3);
					case 720:
						doStopSign(2);
					case 991:
						doStopSign(3);
					case 1184:
						doStopSign(2);
					case 1218:
						doStopSign(0);
					case 1235:
						doStopSign(0, true);
					case 1200:
						doStopSign(3);
					case 1328:
						doStopSign(0, true);
						doStopSign(2);
					case 1439:
						doStopSign(3, true);
					case 1567:
						doStopSign(0);
					case 1584:
						doStopSign(0, true);
					case 1600:
						doStopSign(2);
					case 1706:
						doStopSign(3);
					case 1917:
						doStopSign(0);
					case 1923:
						doStopSign(0, true);
					case 1927:
						doStopSign(0);
					case 1932:
						doStopSign(0, true);
					case 2032:
						doStopSign(2);
						doStopSign(0);
					case 2036:
						doStopSign(0, true);
					case 2128:
						if (dad.animOffsets.exists('Hank'))
							dad.playAnim('Hank', true);
					case 2144:
						dad.playAnim('idle', true);
					case 2162:
						doStopSign(2);
						doStopSign(3);
					case 2193:
						doStopSign(0);
					case 2202:
						doStopSign(0,true);
					case 2239:
						doStopSign(2,true);
					case 2258:
						doStopSign(0, true);
					case 2304:
						doStopSign(0, true);
						doStopSign(0);	
					case 2326:
						doStopSign(0, true);
					case 2336:
						doStopSign(3);
					case 2447:
						doStopSign(2);
						doStopSign(0, true);
						doStopSign(0);	
					case 2480:
						doStopSign(0, true);
						doStopSign(0);	
					case 2512:
						doStopSign(2);
						doStopSign(0, true);
						doStopSign(0);
					case 2544:
						doStopSign(0, true);
						doStopSign(0);	
					case 2575:
						doStopSign(2);
						doStopSign(0, true);
						doStopSign(0);
					case 2608:
						doStopSign(0, true);
						doStopSign(0);	
					case 2604:
						doStopSign(0, true);
					case 2655:
						doGremlin(20,13,true);
				}
				stepOfLast = curStep;
			}
		
		// the ending cutscenes are weird so we need this -tob
		if (stupidAHHHH && !inCutscene)
			{
				switch (curSong.toLowerCase())
				{
					case 'honorbound':
						if (health >= 0.1)
							health += -0.005;
				}
			}

		if (curSong.toLowerCase() == 'triple trouble')
		{

			if (ttspinArray.contains(curStep))
				{
					strumLineNotes.forEach(function(tospin:FlxSprite)
					{
						FlxTween.angle(tospin, 0, 360, 0.2, {ease: FlxEase.quintOut});
					});
				}
			switch (curStep)
			{
				case 1:
					doP3Static(); // cool static
					FlxTween.tween(FlxG.camera, {zoom: 1.1}, 2, {ease: FlxEase.cubeOut});
					defaultCamZoom = 1.1;
				case 144:
					doP3JumpTAILS();
				case 1024, 1088, 1216, 1280, 2305, 2810, 3199, 3455, 4096, 5119:
					doP3Static();
				case 1040: // switch to sonic facing right

					FlxTween.tween(FlxG.camera, {zoom: 0.9}, 2, {ease: FlxEase.cubeOut});
					defaultCamZoom = 0.9;

					healthBar.createFilledBar(FlxColor.fromRGB(182, 0, 205), FlxColor.fromRGB(49, 176, 209));

					p3staticbg.visible = true;

					remove(dad);
					dad = new Character(20 - 200, -94.75 + 100, 'beast');
					add(dad);

					dad.addOffset('idle', -18, 70); // BEAST SONIC LOOKING RIGHT
					dad.addOffset("singUP", 22, 143);
					dad.addOffset("singRIGHT", -260, 11);
					dad.addOffset("singLEFT", 177, -24);
					dad.addOffset("singDOWN", -15, -57);
					dad.addOffset("laugh", -78, -128);

					iconP2.animation.play('beast');

					remove(boyfriend);
					boyfriend = new Boyfriend(502.45 + 200, 370.45, 'bf-perspective-flipped');
					add(boyfriend);

				case 1296: // switch to knuckles facing left facing right and bf facing right, and cool static

					FlxTween.tween(FlxG.camera, {zoom: 1.1}, 2, {ease: FlxEase.cubeOut});
					defaultCamZoom = 1.1;

					p3staticbg.visible = false;

					remove(dad);
					dad = new Character(1300 + 100 - 206, 260 + 44, 'knucks');
					add(dad);
					healthBar.createFilledBar(FlxColor.fromRGB(150, 0, 0), FlxColor.fromRGB(49, 176, 209));

					iconP2.animation.play('knucks');
					iconP1.animation.play('bf');

					cpuStrums.forEach(function(spr:FlxSprite)
						{
							if (!FlxG.save.data.middlescroll)
								spr.x += (FlxG.width / 2);
						});
						playerStrums.forEach(function(spr:FlxSprite)
						{
							if (!FlxG.save.data.middlescroll)
								spr.x -= (FlxG.width / 2);
						});

					dad.addOffset("singRIGHT", -59, -65);
					dad.addOffset("singLEFT", 124, -59);
					dad.addOffset("singUP", 29, 49);
					dad.addOffset("singDOWN", 26, -95);

					dad.flipX = true;

					remove(boyfriend);
					boyfriend = new Boyfriend(466.1, 685.6 - 300, 'bf-flipped-for-cam');
					add(boyfriend);

					boyfriend.flipX = true;

					boyfriend.addOffset('idle', 0, -2); // flipped offsets for flipped normal bf
					boyfriend.addOffset("singUP", 10, 27);
					boyfriend.addOffset("singRIGHT", 44, -7);
					boyfriend.addOffset("singLEFT", -22, -7);
					boyfriend.addOffset("singDOWN", -13, -52);
					boyfriend.addOffset("singUPmiss", 13, 24);
					boyfriend.addOffset("singRIGHTmiss", 44, 20);
					boyfriend.addOffset("singLEFTmiss", -26, 15);
					boyfriend.addOffset("singDOWNmiss", -11, -20);

					doP3JumpKNUCKLES();

				case 2320:
					FlxTween.tween(FlxG.camera, {zoom: 0.9}, 2, {ease: FlxEase.cubeOut});
					defaultCamZoom = 0.9;

					p3staticbg.visible = true;

					remove(dad);
					dad = new Character(1300 - 250, -94.75 + 100, 'beast-cam-fix');
					add(dad);

					dad.addOffset('idle', -13, 79); // cam fix BEAST SONIC LOOKING LEFT OFFSETS
					dad.addOffset("singUP", 11, 156);
					dad.addOffset("singRIGHT", 451, 24);
					dad.addOffset("singLEFT", 174, -13);
					dad.addOffset("singDOWN", 4, -15);
					dad.addOffset("laugh", 103, -144);

					// dad.camFollow.y = dad.getMidpoint().y - 100;
					// dad.camFollow.x = dad.getMidpoint().x - 500;

					healthBar.createFilledBar(FlxColor.fromRGB(182, 0, 205), FlxColor.fromRGB(49, 176, 209));

					iconP2.animation.play('beast');

					remove(boyfriend);
					boyfriend = new Boyfriend(502.45 - 350, 370.45, 'bf-perspective');
					add(boyfriend);

					boyfriend.flipX = false;

					boyfriend.addOffset('idle', 5, 4);
					boyfriend.addOffset("singUP", 23, 63);
					boyfriend.addOffset("singLEFT", 31, 9);
					boyfriend.addOffset("singRIGHT", -75, -15);
					boyfriend.addOffset("singDOWN", -51, -1);
					boyfriend.addOffset("singUPmiss", 20, 135);
					boyfriend.addOffset("singLEFTmiss", 10, 92);
					boyfriend.addOffset("singRIGHTmiss", -70, 85);
					boyfriend.addOffset("singDOWNmiss", -53, 10);

					dad.flipX = true;

				case 2823:
					doP3JumpEGGMAN();

					FlxTween.tween(FlxG.camera, {zoom: 1}, 2, {ease: FlxEase.cubeOut});
					defaultCamZoom = 1;

					p3staticbg.visible = false;

					remove(dad);
					dad = new Character(20 - 200, 30 + 200, 'eggdickface');
					add(dad);

					// dad.camFollow.y = dad.getMidpoint().y;
					// dad.camFollow.x = dad.getMidpoint().x + 300;

					healthBar.createFilledBar(FlxColor.fromRGB(194, 80, 0), FlxColor.fromRGB(49, 176, 209));

					iconP2.animation.play('eggdickface');

					dad.flipX = false;

					if (!FlxG.save.data.middlescroll){
						for (i in 0...PlayState.strumLineNotes.length) {
							var member = PlayState.strumLineNotes.members[i];
							var theValue = Note.swagWidth * (i % 7);
							if (i <= 6) {
								FlxTween.tween(member, {x: 50 + theValue}, 0.1, {ease: FlxEase.linear});
							} else {
								FlxTween.tween(member, {x: (50 + (FlxG.width / 2)) + theValue}, 0.1, {ease: FlxEase.linear});
							}
						}
					}
					// cpuStrums.forEach(function(spr:FlxSprite)
					// 	{
					// 		//	FlxTween.tween(spr, {x: spr.x -= 650, y: spr.y}, 5, {ease: FlxEase.quartOut});
					// 		if (!FlxG.save.data.middlescroll)
					// 			spr.x -= 300/*(FlxG.width / 2)*/;
					// 	});
					// playerStrums.forEach(function(spr:FlxSprite)
					// 	{
					// 		//	FlxTween.tween(spr, {x: spr.x += 650, y: spr.y}, 5, {ease: FlxEase.quartOut});
					// 		if (!FlxG.save.data.middlescroll)
					// 			spr.x += 300/*(FlxG.width / 2)*/;
					// 	});

					dad.addOffset('idle', -5, 5);
					dad.addOffset("singUP", 110, 231);
					dad.addOffset("singRIGHT", 40, 174);
					dad.addOffset("singLEFT", 237, 97);
					dad.addOffset("singDOWN", 49, -95);
					dad.addOffset('laugh', -10, 210);

					remove(boyfriend);
					boyfriend = new Boyfriend(466.1 + 200, 685.6 - 250, 'bf');
					add(boyfriend);

					boyfriend.addOffset('idle', -5);
					boyfriend.addOffset("singUP", -29, 27);
					boyfriend.addOffset("singRIGHT", -38, -7);
					boyfriend.addOffset("singLEFT", 12, -6);
					boyfriend.addOffset("singDOWN", -10, -50);
					boyfriend.addOffset("singUPmiss", -29, 27);
					boyfriend.addOffset("singRIGHTmiss", -30, 21);
					boyfriend.addOffset("singLEFTmiss", 12, 24);
					boyfriend.addOffset("singDOWNmiss", -11, -19);

				case 2887, 3015, 4039:
					dad.playAnim('laugh', true);
					dad.nonanimated = true;
				case 2895, 3023, 4048:
					dad.nonanimated = false;

				case 4111:
					p3staticbg.visible = true;
					remove(dad);
					dad = new Character(20 - 200, -94.75 + 100, 'beast');
					add(dad);

					dad.addOffset('idle', -18, 70); // BEAST SONIC LOOKING RIGHT
					dad.addOffset("singUP", 22, 143);
					dad.addOffset("singRIGHT", -260, 11);
					dad.addOffset("singLEFT", 177, -24);
					dad.addOffset("singDOWN", -15, -57);
					dad.addOffset("laugh", -78, -128);

					healthBar.createFilledBar(FlxColor.fromRGB(182, 0, 205), FlxColor.fromRGB(49, 176, 209));

					iconP2.animation.play('beast');

					remove(boyfriend);
					boyfriend = new Boyfriend(502.45, 370.45, 'bf-perspective-flipped');
					add(boyfriend);
			}
		}

		#if windows
		if (executeModchart && luaModchart != null)
		{
			luaModchart.setVar('curStep',curStep);
			luaModchart.executeState('stepHit',[curStep]);
		}
		#end

		if (maniaChanged) //may change to beat hit if too laggy
		{
			var frameN:Array<String> = ['purple', 'blue', 'green', 'red'];
			switch (mania)
			{
				case 1: 
					frameN = ['purple', 'green', 'red', 'yellow', 'blue', 'dark'];
				case 2: 
					frameN = ['purple', 'blue', 'green', 'red', 'white', 'yellow', 'violet', 'black', 'dark'];
				case 3: 
					frameN = ['purple', 'blue', 'white', 'green', 'red'];
				case 4: 
					frameN = ['purple', 'green', 'red', 'white', 'yellow', 'blue', 'dark'];
				case 5: 
					frameN = ['purple', 'blue', 'green', 'red', 'yellow', 'violet', 'black', 'dark'];
				case 6: 
					frameN = ['white'];
				case 7: 
					frameN = ['purple', 'red'];
				case 8: 
					frameN = ['purple', 'white', 'red'];
	
			}
			notes.forEachAlive(function(daNote:Note) //so the animation changes but then it doesnt work lol
			{
				daNote.animation.play(frameN[daNote.noteData] + 'Scroll');
				if (daNote.isSustainNote && daNote.prevNote != null)
					{
			
						daNote.animation.play(frameN[daNote.noteData] + 'holdend');
			
		
			
						if (daNote.prevNote.isSustainNote)
						{
			
							daNote.prevNote.animation.play(frameN[daNote.prevNote.noteData] + 'hold');
							//prevNote.updateHitbox();
						}
					}
			});
			
		}
		if (SONG.song.toLowerCase() == "eggnog" && curStep != stepOfLast) //song events
			{
				switch(curStep)
				{
					case 289: 
						//switchMania(mania, 0);
				}
			}

		// yes this updates every step.
		// yes this is bad
		// but i'm doing it to update misses and accuracy
		#if windows
		// Song duration in a float, useful for the time left feature
		songLength = FlxG.sound.music.length;

		// Updating Discord Rich Presence (with Time Left)
		DiscordClient.changePresence(detailsText + " " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), "Acc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC, true,  songLength - Conductor.songPosition);
		#end

		if (spookyRendered && spookySteps + 3 < curStep)
			{
				if (resetSpookyText)
				{
					remove(spookyText);
					spookyRendered = false;
				}
				tstatic.alpha = 0;
				if (curStage == 'auditorHell')
					tstatic.alpha = 0.1;
			}

	}

	var lightningStrikeBeat:Int = 0;
	var lightningOffset:Int = 8;

	var beatOfFuck:Int = 0;

	override function beatHit()
	{
		super.beatHit();

		if (generatedMusic)
		{
			notes.sort(FlxSort.byY, (PlayStateChangeables.useDownscroll ? FlxSort.ASCENDING : FlxSort.DESCENDING));
		}

		#if windows
		if (executeModchart && luaModchart != null)
		{
			luaModchart.setVar('curBeat',curBeat);
			luaModchart.executeState('beatHit',[curBeat]);
		}
		#end

		if (curSong.toLowerCase() == 'infitrigger')
			{
				switch(curBeat)
				{
					case 446 :canScream();
					case 449 :if (!FlxG.save.data.noTriggerFlip)doFlip();
					
				}				
			}

		if(SONG.song.toLowerCase() == 'danger')
			camGame.shake(0.004, 0.2);

		if(SONG.song.toLowerCase() == 'danger' && curBeat == 512)
			doRGB = true;

		if(doRGB && SONG.song.toLowerCase() == 'danger') // new gayia
		{
			FlxG.camera.zoom += 0.06;
			camHUD.zoom += 0.04;
			camNotes.zoom += 0.04;
			skyBeat(1.5);
			var shit:Int = lastrgb;
			shit++;
			if (shit >= Global.gay.length)
				shit = 0;

			sky.color = FlxColor.fromRGB(Global.gay[shit][0], Global.gay[shit][1], Global.gay[shit][2]);
			woods.color = FlxColor.fromRGB(Global.gay[shit][0] + 100, Global.gay[shit][1] + 100, Global.gay[shit][2] + 100);
			dad.color = FlxColor.fromRGB(Global.gay[shit][0] + 100, Global.gay[shit][1] + 100, Global.gay[shit][2] + 100);
			boyfriend.color = FlxColor.fromRGB(Global.gay[shit][0] + 45, Global.gay[shit][1] + 45, Global.gay[shit][2] + 45);
			gf.color = FlxColor.fromRGB(Global.gay[shit][0] + 45, Global.gay[shit][1] + 45, Global.gay[shit][2] + 45);

			lastrgb = shit;
		}
		else if (SONG.song.toLowerCase() == 'danger')
		{
			skyBeat(0.5);
			sky.color = FlxColor.WHITE;
			woods.color = FlxColor.WHITE;
			dad.color = FlxColor.WHITE;
			gf.color = FlxColor.fromRGB(200, 200, 200);
			boyfriend.color = FlxColor.fromRGB(200, 200, 200);
		}

		if (curSong == 'Tutorial' && dad.curCharacter == 'gf') {
			if (curBeat % 2 == 1 && dad.animOffsets.exists('danceLeft'))
				dad.playAnim('danceLeft');
			if (curBeat % 2 == 0 && dad.animOffsets.exists('danceRight'))
				dad.playAnim('danceRight');
		}

		if (dad.curCharacter.startsWith('neomonster') && !FlxG.save.data.enemyDrain) {
			if (curBeat % 2 == 1)
				health -= 0.0175;
		}

		if (SONG.notes[Math.floor(curStep / 16)] != null)
		{
			if (curBeat % 25 == 0 && !inCutscene)
				{
					switch (curSong)
					{
						case 'Skill Issue':
							addText(1.2);
						case 'Honorbound'|'Strongmann'|'Infiltrator':
							addText();
					}
					
				}
				
			if (SONG.notes[Math.floor(curStep / 16)].changeBPM)
			{
				Conductor.changeBPM(SONG.notes[Math.floor(curStep / 16)].bpm);
				FlxG.log.add('CHANGED BPM!');
			}
			// else
			// Conductor.changeBPM(SONG.bpm);

			// Dad doesnt interupt his own notes
			if (SONG.notes[Math.floor(curStep / 16)].mustHitSection && dad.curCharacter != 'gf')
			{
				if (tailscircle == 'circling' && dad.curCharacter == 'TDoll')
					remove(ezTrail);
				dad.dance();
				camX = 0;
				camY = 0;
			}

			if (curBeat % 2 == 0)
				{
					switch (swaggyOptim)
					{
						case 1:
							{
								//if (SONG.notes[Math.floor(curStep / 16)].mustHitSection)
									//{
											switch (curTiming)
											{
												case 0:
													dad.playAnim('idle');
											}
									//}
							}
						case 2:
							{
								dad.dance();
							}
						case 3:
							{
								if (SONG.notes[Math.floor(curStep / 16)].mustHitSection)
									{
										switch (curTiming)
										{
											case 0:
												dad.playAnim('idle');
											case 1:
												dad.playAnim('idle-alt');
										}
									}
							}
						case 5:
							{
								switch (curTiming)
								{
									case 0:
										dad.playAnim('idle');
								}
							}
						default:
							{
								if (dad.animation.curAnim.name != null && !dad.animation.curAnim.name.startsWith("sing"))
									{
										if (!dad.animation.curAnim.name.startsWith('shit') && !dad.animation.curAnim.name.startsWith('spawn'))
											dad.playAnim('idle');
									}
								else if (dad.animation.curAnim.name != null && !dad.curCharacter.startsWith('gf') && !dad.animation.curAnim.name.startsWith("sing"))
									{
										if (!dad.animation.curAnim.name.startsWith('shit') && !dad.animation.curAnim.name.startsWith('spawn'))
											dad.playAnim('idle');
									}
							}
		
					}
				}
		}
		// FlxG.log.add('change bpm' + SONG.notes[Std.int(curStep / 16)].changeBPM);
		wiggleShit.update(Conductor.crochet);

		if (FlxG.save.data.camzoom)
		{
			// HARDCODING FOR MILF ZOOMS!
			if (curSong.toLowerCase() == 'milf' && curBeat >= 168 && curBeat < 200 && camZooming && FlxG.camera.zoom < 1.35)
			{
				FlxG.camera.zoom += 0.015;
				camHUD.zoom += 0.03;
				camNotes.zoom += 0.03;
			}

			if (curSong.toLowerCase() == 'sage' && curStep >= 1408)
				{
					FlxG.camera.zoom = 1.01;				
				}

			if (curSong.toLowerCase() == 'onslaught' && curBeat >= 0 && curBeat < 64 && camZooming && FlxG.camera.zoom < 1.35)
				{
					FlxG.camera.zoom += 0.015;
					camHUD.zoom += 0.03;
					camNotes.zoom += 0.03;
				}
			else if (curSong.toLowerCase() == 'onslaught' && curBeat >= 96 && curBeat < 224 && camZooming && FlxG.camera.zoom < 1.35)
				{
					FlxG.camera.zoom += 0.015;
					camHUD.zoom += 0.03;
					camNotes.zoom += 0.03;
				}
			else if (curSong.toLowerCase() == 'onslaught' && curBeat >= 240 && curBeat < 352 && camZooming && FlxG.camera.zoom < 1.35)
				{
					FlxG.camera.zoom += 0.015;
					camHUD.zoom += 0.03;
					camNotes.zoom += 0.03;
				}

			if (camZooming && FlxG.camera.zoom < 1.35 && curBeat % 4 == 0)
			{
				FlxG.camera.zoom += 0.015;
				camHUD.zoom += 0.03;
				camNotes.zoom += 0.03;
			}
	
		}

				if (curSong.toLowerCase() == 'epiphany')
				{
					switch (curBeat)
					{
						case 648:
							dokipopup.visible = true;
							dokipopup.animation.play('idle', true);
						case 776:
							dad.playAnim('lastNOTE');
							dad.nonanimated = true;
						case 788:
							new FlxTimer().start(0.05, function(tmr:FlxTimer)
							{
								if (!paused)
									iconP2.alpha -= 0.15;
	
								if (iconP2.alpha > 0)
									tmr.reset(0.05);
								else
									iconP2.visible = false;
							});
						case 790:
							FlxG.camera.fade(FlxColor.BLACK, .7, false);
					}
				}

		switch (curSong.toLowerCase())
		{
			case 'algebra':
				switch(curBeat)
				{
					case 288 | 452 | 464 | 1352 | 1566 | 1694:
						gfSpeed = 2;
					case 460 | 1452 | 1598 | 1868:
						gfSpeed = 1;
					//STANDER POSITIONING IS INCOMPLETE, FIX LATER
					case 160:
						if (!FlxG.save.data.modchart)
							swagSpeed = SONG.speed - 0.5;
						//GARRETT TURN 1!!
						swapDad('garrett');
						healthBar.createFilledBar(FlxColor.fromString('#' + dad.iconColor), FlxColor.fromString('#' + boyfriend.iconColor));
						algebraStander('og-dave', daveStand, 250, 100);
						daveJunk.visible = true;
						if(iconP2.animation.getByName(dad.curCharacter) != null)
							iconP2.animation.play(dad.curCharacter);
					case 416: // 
						gfSpeed = 1;
						//HAPPY DAVE TURN 2!!
						swapDad('og-dave');
						healthBar.createFilledBar(FlxColor.fromString('#' + dad.iconColor), FlxColor.fromString('#' + boyfriend.iconColor));
						daveJunk.visible = false;
						garrettJunk.visible = true;
						if (!FlxG.save.data.modchart)
							swagSpeed = SONG.speed - 0.3;
						for(member in standersGroup.members)
						{
							member.destroy();
						}
						algebraStander('garrett', garrettStand, 500, 225);
						if(iconP2.animation.getByName(dad.curCharacter) != null)
							iconP2.animation.play(dad.curCharacter);
					case 536:
						//GARRETT TURN 2
						swapDad('garrett');
						healthBar.createFilledBar(FlxColor.fromString('#' + dad.iconColor), FlxColor.fromString('#' + boyfriend.iconColor));
						davePiss.visible = true;
						garrettJunk.visible = false;
						for(member in standersGroup.members)
						{
							member.destroy();
						}
						algebraStander('og-dave-angey', daveStand, 250, 100);
						if(iconP2.animation.getByName(dad.curCharacter) != null)
							iconP2.animation.play(dad.curCharacter);
					case 552:
						//ANGEY DAVE TURN 1!!
						swapDad('og-dave-angey');
						healthBar.createFilledBar(FlxColor.fromString('#' + dad.iconColor), FlxColor.fromString('#' + boyfriend.iconColor));
						davePiss.visible = false;
						garrettJunk.visible = true;
						for(member in standersGroup.members)
						{
							member.destroy();
						}
						algebraStander('garrett', garrettStand, 500, 225, true);
						if(iconP2.animation.getByName(dad.curCharacter) != null)
							iconP2.animation.play(dad.curCharacter);
					case 696:
						//HALL MONITOR TURN
						//UNCOMMENT THIS WHEN HALL MONITOR SPRITES ARE DONE AND IN
						swapDad('hall-monitor');
						healthBar.createFilledBar(FlxColor.fromString('#' + dad.iconColor), FlxColor.fromString('#' + boyfriend.iconColor));
						davePiss.visible = true;
						diamondJunk.visible = true;
						if (!FlxG.save.data.modchart)
							swagSpeed = 2;
						for(member in standersGroup.members)
						{
							member.destroy();
						}
						algebraStander('garrett', garrettStand, 500, 225, true);
						algebraStander('og-dave-angey', daveStand, 250, 100);
						if(iconP2.animation.getByName(dad.curCharacter) != null)
							iconP2.animation.play(dad.curCharacter);
					case 1344:
						gfSpeed = 4;
						//DIAMOND MAN TURN
						swapDad('diamond-man');
						healthBar.createFilledBar(FlxColor.fromString('#' + dad.iconColor), FlxColor.fromString('#' + boyfriend.iconColor));
						monitorJunk.visible = true;
						diamondJunk.visible = false;
						if (!FlxG.save.data.modchart)
							swagSpeed = SONG.speed;
						for(member in standersGroup.members)
						{
							member.destroy();
						}
						algebraStander('garrett', garrettStand, 500, 225, true);
						//UNCOMMENT THIS WHEN HALL MONITOR SPRITES ARE DONE AND IN
						algebraStander('hall-monitor', hallMonitorStand, 0, 100);
						algebraStander('og-dave-angey', daveStand, 250, 100);
						if(iconP2.animation.getByName(dad.curCharacter) != null)
							iconP2.animation.play(dad.curCharacter);
					case 1644:
						//PLAYROBOT TURN
						swapDad('playrobot');
						healthBar.createFilledBar(FlxColor.fromString('#' + dad.iconColor), FlxColor.fromString('#' + boyfriend.iconColor));
						if (!FlxG.save.data.modchart)
							swagSpeed = 1.6;
						if(iconP2.animation.getByName(dad.curCharacter) != null)
							iconP2.animation.play(dad.curCharacter);
					case 1802:
						gfSpeed = 4;
						FlxTween.tween(davePiss, {x: davePiss.x - 250}, 0.5, {ease:FlxEase.quadOut});
						davePiss.animation.play('d');
					case 1804:
						gfSpeed = 2;
						//SCARY PLAYROBOT TURN
						swapDad('playrobot-crazy');
						healthBar.createFilledBar(FlxColor.fromString('#' + dad.iconColor), FlxColor.fromString('#' + boyfriend.iconColor));
						swagSpeed = SONG.speed;
						if(iconP2.animation.getByName(dad.curCharacter) != null)
							iconP2.animation.play(dad.curCharacter);
					case 1944:
						//ANGEY DAVE TURN 2!!
						swapDad('og-dave-angey');
						healthBar.createFilledBar(FlxColor.fromString('#' + dad.iconColor), FlxColor.fromString('#' + boyfriend.iconColor));
						robotJunk.visible = true;
						davePiss.visible = false;
						for(member in standersGroup.members)
						{
							member.destroy();
						}
						algebraStander('playrobot-scary', playRobotStand, 750, 100, false, true);
						algebraStander('garrett', garrettStand, 500, 225, true);
						//UNCOMMENT THIS WHEN HALL MONITOR SPRITES ARE DONE AND IN
						algebraStander('hall-monitor', hallMonitorStand, 0, 100);
						if(iconP2.animation.getByName(dad.curCharacter) != null)
							iconP2.animation.play(dad.curCharacter);
					case 2102:
						if (!FlxG.save.data.modchart)
							swagSpeed = SONG.speed + 0.9;
					
				}
		}

		if (curStage == 'auditorHell')
			{
				if (curBeat % 8 == 4 && beatOfFuck != curBeat)
				{
					beatOfFuck = curBeat;
					doClone(FlxG.random.int(0,1));
				}
			}

		iconP1.setGraphicSize(Std.int(iconP1.width + 30));
		iconP2.setGraphicSize(Std.int(iconP2.width + 30));
			
		iconP1.updateHitbox();
		iconP2.updateHitbox();
	
		if (curBeat % gfSpeed == 0 && curStage == 'hellstage' && !FlxG.save.data.shakingscreen)
		{
			camHUD.shake(0.02, 0.2);
			camNotes.shake(0.02, 0.2);
			FlxG.camera.shake(0.005, 0.2);
			//FlxTween.tween(camHUD, {angle: 0},0.5, {ease: FlxEase.elasticOut});
		}

		if (curBeat % gfSpeed == 0)
		{
			gf.dance();
		}

		if (!boyfriend.animation.curAnim.name.startsWith("sing"))
		{
			boyfriend.playAnim('idle');
		}
		

		if (curBeat % 8 == 7 && curSong == 'Bopeebo')
		{
			boyfriend.playAnim('hey', true);
		}

		if (curBeat % 16 == 15 && SONG.song == 'Tutorial' && dad.curCharacter == 'gf' && curBeat > 16 && curBeat < 48)
			{
				boyfriend.playAnim('hey', true);
				dad.playAnim('cheer', true);
			}

		if (curSong == 'Sage')
			{			
				switch (curBeat)
				{
					case 415 : vScream();
				}
			}
		if (curBeat == 64 && SONG.song.toLowerCase() == 'genesis'){
			FlxTween.tween(camOverlay, {alpha: 1}, (Conductor.stepCrochet * 8)/1000);
		}
		if (curBeat == 264 && SONG.song.toLowerCase() == 'genesis')
		{
				camZooming = false;
				autoCam = false;
				boyfriend.playAnim('bigYell', true);
				boyfriend.nonanimated = true;
				vocals.volume = 1;
				camFollow.x = boyfriend.getMidpoint().x;
				camFollow.y = boyfriend.getMidpoint().y + 20;
				FlxTween.tween(camGame, {zoom: 1.3}, 0.3, {ease: FlxEase.quintOut});
				FlxTween.tween(camHUD, {alpha: 0}, 0.3);
				FlxTween.tween(camHUD2, {alpha: 0}, 0.3);
				FlxTween.tween(camNotes, {alpha: 0}, 0.3);
				camGame.shake(0.005, (Conductor.stepCrochet * 32)/1000);

		}

		if (curBeat > 264 && curBeat < 268 && SONG.song.toLowerCase() == 'genesis'){ health = 2;}

		if (curBeat == 271 && SONG.song.toLowerCase() == 'genesis')
		{
				camZooming = true;
				autoCam = true;
				FlxTween.tween(camHUD, {alpha: 1}, 0.3);
				FlxTween.tween(camHUD2, {alpha: 1}, 0.3);
				FlxTween.tween(camNotes, {alpha: 1}, 0.3);
				boyfriend.nonanimated = false;

		}

		if (curBeat == 344 && SONG.song.toLowerCase() == 'genesis')
		{
				//boyfriend.playAnim('sadSmile', true);
				FlxTween.tween(camOverlay, {alpha: 0}, 15, {onComplete: function(twn:FlxTween){
					dreamscape.destroy();
					dreamscapeOuter.destroy();
				}});
				FlxTween.tween(dad, {alpha: 0}, 23, {ease: FlxEase.quintIn});
				FlxTween.tween(iconP2, {alpha: 0}, 23, {ease: FlxEase.quintIn});

				cpuStrums.forEach(function(spr:FlxSprite)
				{
					FlxTween.tween(spr, {alpha: 0}, 23, {ease: FlxEase.quintIn});
				});

		}

		if (curSong.toLowerCase() == 'onslaught' && curBeat >= 128 && curBeat <= 352 )
			{
				var amount = curBeat/20;
				if (FlxG.random.bool(amount) && appearscreen)
				{
					var randomthing:FlxSprite = new FlxSprite(FlxG.random.int(300, 1077), FlxG.random.int(0, 622));
					FlxG.sound.play(Paths.sound("pop_up"), 1);
					randomthing.loadGraphic(Paths.image('PopUps/popup' + FlxG.random.int(1,11), 'shared'));
					randomthing.updateHitbox();
					randomthing.alpha = 0;
					randomthing.antialiasing = FlxG.save.data.antialiasing;
					add(randomthing);
					randomthing.cameras = [camHUD2];
					appearscreen = false;
					FlxTween.tween(randomthing, {width: 1, alpha: 1}, 0.2, {ease: FlxEase.sineOut});
					
					new FlxTimer().start(1.5 , function(tmr:FlxTimer)
					{
						appearscreen = true;
					});
					new FlxTimer().start(2 , function(tmr:FlxTimer)
					{
						remove(randomthing);
					});
				}
			}
		if (curSong.toLowerCase() == 'onslaught' && curBeat == 96 )
		{
			FlxG.sound.play(Paths.sound('Meow'));
			cpuStrums.forEach(function(spr:FlxSprite)
			{
				spr.alpha = 0;
			});
			playerStrums.forEach(function(spr:FlxSprite)
			{
				spr.alpha = 0;
			});
		}
		if (curSong.toLowerCase() == 'onslaught' && curBeat == 128 )
		{
			windowX = Lib.application.window.x;
			windowY = Lib.application.window.y;
			IsNoteSpinning = true;
			FlxG.sound.play(Paths.sound('woeM'));
			cpuStrums.forEach(function(spr:FlxSprite)
			{
				spr.alpha = 1;
			});
			playerStrums.forEach(function(spr:FlxSprite)
			{
				spr.alpha = 1;
			});
		}
		if (curSong.toLowerCase() == 'onslaught' && curBeat == 240 )
		{
			FlxG.sound.play(Paths.sound('Meow'));
			cpuStrums.forEach(function(spr:FlxSprite)
			{
				spr.alpha = 0;
			});
			playerStrums.forEach(function(spr:FlxSprite)
			{
				spr.alpha = 0;
			});
		}
		if (curSong.toLowerCase() == 'onslaught' && curBeat == 352 )
		{
			IsNoteSpinning = false;
			if (!FlxG.save.data.shakingscreen)
				WindowGoBack();
			FlxG.sound.play(Paths.sound('woeM'));
			cpuStrums.forEach(function(spr:FlxSprite)
			{
				spr.alpha = 1;
			});
			playerStrums.forEach(function(spr:FlxSprite)
			{
				spr.alpha = 1;
			});
			for (str in playerStrums){
				str.angle = str.health;
			}
		}

		switch (curStage)
		{
			case 'chantown':
				if(FlxG.save.data.distractions){
					chinkMoot.forEach(function(dancer:FakeMoot)
						{
							dancer.dance();
						});}
					chantownanims();
			case 'bonus':
				bonusanims();
			case 'issue', 'issue-two', 'issue-three':
				if (FlxG.save.data.distractions)
				{
					bottomBoppers.animation.play('lol', true);
				}
			case 'vecindario':
				if (FlxG.save.data.distractions)
				{
					pantalla.animation.play('oldpantalla');
				}
			case 'chamber':
				if (FlxG.save.data.distractions)
				{
					porker.animation.play('porkerbop');
				}
			case 'stageSpook':
				if (FlxG.save.data.distractions)
				{
					if (curBeat % 4 == 0)
						{
							theGuys.animation.play('TheGuys', true);
						}
				}
			case 'sonicFUNSTAGE':
				if (FlxG.save.data.distractions)
				{
					funpillarts1ANIM.animation.play('bumpypillar', true);
					funpillarts2ANIM.animation.play('bumpypillar', true);
					funboppers1ANIM.animation.play('bumpypillar', true);
					funboppers2ANIM.animation.play('bumpypillar', true);
				}
			case 'hellstage':
				
				if (FlxG.random.bool(10) && isbobmad && curSong.toLowerCase() == 'run' && !FlxG.save.data.jumpscare)
					Bobismad();
			case 'zardy':
				zardyBackground.animation.play('Maze');
			case 'OldsonicFUNSTAGE':
				if(FlxG.save.data.distractions){
					funpillarts1ANIM.animation.play('bumpypillar', true);
				}
			case 'OldLordXStage':
				if(FlxG.save.data.distractions){
					hands.animation.play('handss', true);
					tree.animation.play('treeanimation', true);
					eyeflower.animation.play('animatedeye', true);
				}
			case 'illusion':
				mouth.animation.play('mouthh', true);
				tvL.animation.play('spoopyTV1', true);
				tvR.animation.play('spoopyTV2', true);
			case 'school':
				if(FlxG.save.data.distractions){
					bgGirls.dance();
				}

			case 'mall':
				if(FlxG.save.data.distractions){
					upperBoppers.animation.play('bop', true);
					bottomBoppers.animation.play('bop', true);
					santa.animation.play('idle', true);
				}

			case 'limo':
				if(FlxG.save.data.distractions){
					grpLimoDancers.forEach(function(dancer:BackgroundDancer)
						{
							dancer.dance();
						});
		
						if (FlxG.random.bool(10) && fastCarCanDrive)
							fastCarDrive();
				}
			case "philly":
				if(FlxG.save.data.distractions){
					if (!trainMoving)
						trainCooldown += 1;
	
					if (curBeat % 4 == 0)
					{
						phillyCityLights.forEach(function(light:FlxSprite)
						{
							light.visible = false;
						});
	
						curLight = FlxG.random.int(0, phillyCityLights.length - 1);
	
						phillyCityLights.members[curLight].visible = true;
						// phillyCityLights.members[curLight].alpha = 1;
			
				}

				}

				if (curBeat % 8 == 4 && FlxG.random.bool(30) && !trainMoving && trainCooldown > 8)
				{
					if(FlxG.save.data.distractions){
						trainCooldown = FlxG.random.int(-4, 0);
						trainStart();
					}
				}
		}

		if (isHalloween && FlxG.random.bool(10) && curBeat > lightningStrikeBeat + lightningOffset)
		{
			if(FlxG.save.data.distractions){
				lightningStrikeShit();
			}
		}
	}

	public function skyBeat(modifier:Float = 1)
	{
		sky.scale.x = 1.5 + (0.1 * modifier);
		sky.scale.y = 1.5 + (0.1 * modifier);
		FlxTween.tween(sky.scale, {y: 1.5, x: 1.5}, 0.1);
	}

	var curLight:Int = 0;

	function swapDad(char:String, x:Float = 100, y:Float = 100, flash:Bool = true)
		{
			if(dad != null)
				remove(dad);
				trace('remove dad');
			dad = new Character(x, y, char, false);
			trace('set dad');
			repositionDad();
			trace('repositioned dad');
			add(dad);
			trace('added dad');
			if(flash)
				if (FlxG.save.data.flashing){
					FlxG.camera.flash(FlxColor.WHITE, 1, null, true);}
				trace('flashed');
		}

	function repositionDad() {
		switch (dad.curCharacter)
			{
				case 'garrett':
					dad.y += 65;
				case 'diamond-man':
					dad.y += 25;
				case 'og-dave' | 'og-dave-angey':
					dad.x -= 190;
				case 'hall-monitor':
					dad.x += 45;
					dad.y += 185;
				case 'playrobot':
					dad.y += 265;
					dad.x += 150;
				case 'playrobot-crazy':
					dad.y += 365;
					dad.x += 165;
			}
		}

	function algebraStander(char:String, physChar:Character, x:Float = 100, y:Float = 100, startScared:Bool = false, idleAsStand:Bool = false)
		{
			return;
			if(physChar != null)
			{
				if(standersGroup.members.contains(physChar))
					standersGroup.remove(physChar);
					trace('remove physstander from group');
				remove(physChar);
				trace('remove physstander entirely');
			}
			physChar = new Character(x, y, char, false);
			trace('new physstander');
			standersGroup.add(physChar);
			trace('physstander in group');
			if(startScared)
			{
				physChar.playAnim('scared', true);
				trace('scaredy');
				new FlxTimer().start(Conductor.crochet / 1000, function(dick:FlxTimer){
					physChar.playAnim('stand', true);
					trace('standy');
				});
			}
			else
			{
				if(idleAsStand)
					physChar.playAnim('idle', true);
				else
					physChar.playAnim('stand', true);
				trace('standy');
			}
		}

	function crashLol() {
		resyncingVocals = false;
		persistentUpdate = false;
		persistentDraw = true;
		paused = true;

		if (FlxG.sound.music != null)
		{
			FlxG.sound.music.pause();
			vocals.pause();
		}
		notes.clear();
		//openSubState(new PauseSubState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
		//openSubState(new PauseSubState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
		var screencap = new FlxSprite(0, 0, FlxScreenGrab.grab().bitmapData);
		screencap.cameras = [camHUD2];
		add(screencap);
		
		var theCrash = FlxG.sound.play(Paths.sound('crash', 'shared'), 1);
		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			theCrash.stop();
			LoadingState.loadAndSwitchState(new CreditsState());
		});
		
		trace('note is hit');
	}
}