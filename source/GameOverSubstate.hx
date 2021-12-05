package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class GameOverSubstate extends MusicBeatSubstate
{
	var bf:Boyfriend;
	var bfdeathshit:FlxSprite;
	var camFollow:FlxObject;
	var sonicDEATH:SonicDeathAnimation;
	var coolcamera:FlxCamera;
	var coolcamera2:FlxCamera;
	var bluevg:FlxSprite;
	var voiceline:FlxSound;

	var inSecret:Bool = false;

	var stageSuffix:String = "";

	public function new(x:Float, y:Float)
	{
		var red:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.WHITE);
		red.scrollFactor.set();
		var daStage = PlayState.curStage;
		var daBf:String = '';
		switch (PlayState.SONG.player1)
		{
			case 'bf-pixel':
				stageSuffix = '-pixel';
				daBf = 'bf-pixel-dead';
			case 'bf-salty':
				stageSuffix = '-salty';
				daBf = 'bf-salty';	
			case 'bfdemoncesar':
				stageSuffix = '-fever';
				daBf = 'bfdemoncesar';
			case 'bf-bob':
				stageSuffix = '-bob';
				daBf = 'bf-bob';
			case 'bf-paldo':
				daBf = 'bf-paldo';
			default:
				daBf = 'bf';
		}
		switch (PlayState.SONG.player2)
		{
			case 'tricky' | 'extricky':
			{
				stageSuffix = '-clown';
				daBf = 'bf-signDeath';
			}
			case 'cheekygun':
			{
				daBf = 'bf-gundeath';
			}
			case 'black':
			{
				if(FlxG.random.bool(5))	
				{
					stageSuffix = '-noballs';
					daBf = 'bf-defeat-secret';
					inSecret = true;
				}
				else
					stageSuffix = '-defeat';
					daBf = 'bf-defeat-death';
			}
			case 'hellbob':
				{
					stageSuffix = '-HELLBOB';
					daBf = 'bf-spiked';
				}
		}
		super();

		Conductor.songPosition = 0;

		bluevg = new FlxSprite();
		bluevg.loadGraphic(Paths.image('blueVg'));
		bluevg.alpha = 0;
		add(bluevg);

		coolcamera = new FlxCamera();
		coolcamera.bgColor.alpha = 0;
		FlxG.cameras.add(coolcamera);
		coolcamera2 = new FlxCamera();
		coolcamera2.bgColor.alpha = 0;
		FlxG.cameras.add(coolcamera2);

		bluevg.cameras = [coolcamera2];

		voiceline = new FlxSound();

		bfdeathshit = new FlxSprite(x - 105, y - 20);

		if (PlayState.SONG.song.toLowerCase() == 'milk')
			{
				bfdeathshit.frames = Paths.getSparrowAtlas('Bf_dancin');
				bfdeathshit.animation.addByPrefix('dance', 'Dance', 24, true);
				bfdeathshit.animation.play('dance', true);
	
				bfdeathshit.alpha = 0;
			}

		if (daStage == 'hellstage')
			{
				add(red);
			}

		if(PlayState.SONG.player2 == 'black')
			{
				var defeatBG:FlxSprite = new FlxSprite(-70, -70).makeGraphic(5000, 5000, 0xFF1a182e);
				defeatBG.screenCenter();
				add(defeatBG);
			}

		bf = new Boyfriend(x, y, daBf);

		if (PlayState.SONG.song.toLowerCase() == 'too slow' || PlayState.SONG.song.toLowerCase() == 'execution')
			{
				sonicDEATH = new SonicDeathAnimation(Std.int(bf.x) - 80, Std.int(bf.y) - 350);
	
				sonicDEATH.scale.x = 2;
				sonicDEATH.scale.y = 2;
	
				sonicDEATH.antialiasing = true;
				sonicDEATH.playAnim('firstDEATH');
				add(sonicDEATH);
			}

		add(bf);

		if (PlayState.SONG.song.toLowerCase() == 'milk')
			{
				bf.alpha = 0;
				add(bfdeathshit);
			}
		else if (PlayState.SONG.song.toLowerCase() == 'sunshine')
		{
			bf.alpha = 0;
			bfdeathshit.frames = Paths.getSparrowAtlas('3DGOpng');
			bfdeathshit.setGraphicSize(720, 720);
			bfdeathshit.animation.addByPrefix('firstdeath', 'DeathAnim', 24, false);
			bfdeathshit.cameras = [coolcamera];
			bfdeathshit.screenCenter();
			bfdeathshit.animation.play('firstdeath');
			add(bfdeathshit);
		}	

		camFollow = new FlxObject(bf.getGraphicMidpoint().x, bf.getGraphicMidpoint().y - 100, 1, 1);
		if(inSecret)
			camFollow = new FlxObject(bf.getGraphicMidpoint().x, bf.getGraphicMidpoint().y, 1, 1);
		add(camFollow);

		FlxG.sound.play(Paths.sound('fnf_loss_sfx' + stageSuffix));
		Conductor.changeBPM(100);

		// FlxG.camera.followLerp = 1;
		// FlxG.camera.focusOn(FlxPoint.get(FlxG.width / 2, FlxG.height / 2));
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		bf.playAnim('firstDeath');
	}
	var startVibin:Bool = false;
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT)
		{
			endBullshit();
		}

		if(FlxG.save.data.InstantRespawn)
			{
				LoadingState.loadAndSwitchState(new PlayState());
			}

		if (controls.BACK)
		{
			FlxG.sound.music.stop();

			if (PlayState.isStoryMode)
				FlxG.switchState(new StoryMenuState());
			else
				FlxG.switchState(new FreeplayState());
			PlayState.loadRep = false;
		}

		if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.curFrame == 12)
		{
			FlxG.camera.follow(camFollow, LOCKON, 0.01);
		}

		if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.finished)
		{
			FlxG.sound.playMusic(Paths.music('gameOver' + stageSuffix));
			switch (PlayState.SONG.song.toLowerCase())
			{
				case 'too slow' | 'endless' | 'old endless' | 'execution':
					FlxG.sound.playMusic(Paths.music('gameOver-Exe'));
				case 'milk':
					FlxTween.tween(bfdeathshit, {alpha: 1}, 1);
					FlxG.sound.music.stop();
					FlxG.sound.playMusic(Paths.music('Sunky_death'));
				case 'sunshine':
					FlxG.sound.playMusic(Paths.music('sunshinegameover'));
				case 'cycles':
					FlxG.sound.playMusic(Paths.music('gameOver-Exe'));
					playVoiceLine(StringTools.replace(Paths.sound('XLines', 'shared'), '.ogg', ''), 5);
			}
			startVibin = true;
		}

		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
	}

	function playVoiceLine(path:String,
		num:Int = 0) // FOR FUCKS SAKE OKAY LISTEN UP SO WHAT I TRIED IS TO SIMPLY MAKE IT LOOK TROUGH ALL THE FILES IN THE FOLDER BUT FOR SOME REASON IT WOULDN'T STOP BREAKING SO I HAD TO MAKE A FUCKING PARAMETER BASED ON THE NUMBER OF VOICLINES SO NOTHING FUCKS UP.
{
	FlxTween.tween(FlxG.sound.music, {volume: 0.4}, 0.3);

	var rng = Std.string(FlxG.random.int(1, num));

	voiceline.loadEmbedded(path + '/' + rng + '.ogg');
	voiceline.play();
	voiceline.onComplete = function()
	{
		FlxTween.tween(FlxG.sound.music, {volume: 1}, 0.3);
	}
	FlxG.sound.list.add(voiceline);
}

	override function beatHit()
	{
		super.beatHit();

		if (startVibin && !isEnding)
		{
			bf.playAnim('deathLoop', true);
		}

		FlxG.log.add('beat');
	}

	var isEnding:Bool = false;

	function endBullshit():Void
	{
		if (!isEnding)
		{
			isEnding = true;
			voiceline.volume = 0;
			bf.playAnim('deathConfirm', true);
			if (PlayState.SONG.song.toLowerCase() == 'too slow' || PlayState.SONG.song.toLowerCase() == 'execution')
				sonicDEATH.playAnim('retry', true);
			FlxG.sound.music.stop();
			if (PlayState.SONG.song.toLowerCase() == 'too slow' || PlayState.SONG.song.toLowerCase() == 'endless' || PlayState.SONG.song.toLowerCase() == 'old endless' || PlayState.SONG.song.toLowerCase() == 'cycles' || PlayState.SONG.song.toLowerCase() == 'milk' || PlayState.SONG.song.toLowerCase() == 'execution')
			{
				FlxG.sound.playMusic(Paths.music('gameOverEnd-Exe'));
			}
			else
			{
				FlxG.sound.play(Paths.music('gameOverEnd' + stageSuffix));
			}
			if (PlayState.SONG.song.toLowerCase() == 'too slow' || PlayState.SONG.song.toLowerCase() == 'endless' || PlayState.SONG.song.toLowerCase() == 'old endless' || PlayState.SONG.song.toLowerCase() == 'cycles' || PlayState.SONG.song.toLowerCase() == 'milk' || PlayState.SONG.song.toLowerCase() == 'sunshine' || PlayState.SONG.song.toLowerCase() == 'execution')
			{
				new FlxTimer().start(0.1, function(tmr:FlxTimer)
					{
						bf.visible = false;
						remove(bfdeathshit);
						FlxG.camera.flash(FlxColor.RED, 4, function()
						{
							LoadingState.loadAndSwitchState(new PlayState());
						});
					});
			}
			else
			{
				new FlxTimer().start(0.7, function(tmr:FlxTimer)
				{
					FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
					{
						LoadingState.loadAndSwitchState(new PlayState());
					});
				});
			}
		}
	}
}
