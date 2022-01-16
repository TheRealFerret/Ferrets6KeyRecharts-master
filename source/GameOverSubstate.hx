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
	var majinBf:Boyfriend;
	var countdown:FlxText;
	var timer:Int = 10;
	var coolcamera:FlxCamera;
	var coolcamera2:FlxCamera;
	var holdup:Bool = true;
	var islol:Bool = true;
	var toolateurfucked:Bool = false;
	var bluevg:FlxSprite;
	var topMajins:FlxSprite;
	var bottomMajins:FlxSprite;
	var actuallynotfuckd:Bool = false;
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

		if (PlayState.SONG.song.toLowerCase() == 'endless')
			{
				majinBf = new Boyfriend(x, y, 'bf-blue');
				majinBf.visible = false;
				majinBf.antialiasing = true;
				add(majinBf);
			}
			
		if (PlayState.SONG.song.toLowerCase() == 'too slow' || PlayState.SONG.song.toLowerCase() == 'execution')
			{
				sonicDEATH = new SonicDeathAnimation(Std.int(bf.x) - 80, Std.int(bf.y) - 350);
	
				sonicDEATH.scale.x = 2;
				sonicDEATH.scale.y = 2;
	
				sonicDEATH.antialiasing = true;
				sonicDEATH.playAnim('firstDEATH');
				add(sonicDEATH);
			}

		if (PlayState.SONG.song.toLowerCase() == 'endless')
			{
				countdown = new FlxText(614, 118 - 30, 100, '10', 40);
				countdown.setFormat('Sonic CD Menu Font Regular', 40, FlxColor.WHITE);
				countdown.setBorderStyle(SHADOW, FlxColor.BLACK, 4, 1);
				add(countdown);
				countdown.alpha = 0;
				countdown.visible = true;
				countdown.cameras = [coolcamera];
			}

		if (PlayState.SONG.song.toLowerCase() == 'chaos')
			{
				bf.alpha = 0;
				bfdeathshit = new FlxSprite(x - 400, y - 200);
				bfdeathshit.frames = Paths.getSparrowAtlas('characters/fleetway_death_BF');
				bfdeathshit.animation.addByPrefix('bru', 'fleetway death BF dies', 14, false);
				FlxG.sound.play(Paths.sound('laser_moment', 'shared'), .5);
				bfdeathshit.animation.addByPrefix('h', 'fleetway death BF Dead Loop', 4, true);
				add(bfdeathshit);
			}

		if (PlayState.SONG.song.toLowerCase() == 'endless')
			{
				bottomMajins = new FlxSprite(bf.x - 50 - 200 - 200, bf.y - 300).loadGraphic(Paths.image('bottomMajins'));
				bottomMajins.scale.x = 1.1;
				bottomMajins.scale.y = 1.1;
		
				bottomMajins.alpha = 0;
				add(bottomMajins);
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
		else if (PlayState.SONG.song.toLowerCase() == 'black sun')
			{
				bf.alpha = 0;
				bfdeathshit.frames = Paths.getSparrowAtlas('exedeath');
				bfdeathshit.setGraphicSize(Std.int(bfdeathshit.width * 1.9));
				bfdeathshit.setPosition(-673, -378);
				bfdeathshit.animation.addByPrefix('die', 'DieLmao', 24, false);
				bfdeathshit.cameras = [coolcamera];
				bfdeathshit.screenCenter();
				bfdeathshit.animation.play('die');
				bfdeathshit.animation.paused = true;
				bfdeathshit.animation.curAnim.curFrame = 0;
				bfdeathshit.antialiasing = true;
				add(bfdeathshit);
			}	

		if (PlayState.SONG.song.toLowerCase() == 'endless')
			{
				topMajins = new FlxSprite(bf.x - 50 - 200 - 200, bf.y - 300).loadGraphic(Paths.image('topMajins'));
				topMajins.scale.x = 1.1;
				topMajins.scale.y = 1.1;
				topMajins.alpha = 0;
				add(topMajins);
			}

		camFollow = new FlxObject(bf.getGraphicMidpoint().x, bf.getGraphicMidpoint().y - 100, 1, 1);
		if(inSecret)
			camFollow = new FlxObject(bf.getGraphicMidpoint().x, bf.getGraphicMidpoint().y, 1, 1);
		add(camFollow);

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'black sun':

			case 'chaos':
				bfdeathshit.animation.play('bru');
			
			default:
			FlxG.sound.play(Paths.sound('fnf_loss_sfx' + stageSuffix));
		}
		Conductor.changeBPM(100);

		// FlxG.camera.followLerp = 1;
		// FlxG.camera.focusOn(FlxPoint.get(FlxG.width / 2, FlxG.height / 2));
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		bf.playAnim('firstDeath');
	}
	var startVibin:Bool = false;

	function startCountdown():Void
		{
			if (islol)
			{
				holdup = false;
				switch (PlayState.SONG.song.toLowerCase())
				{
					case 'endless':
						add(bluevg);
						FlxTween.tween(countdown, {alpha: 1}, 1);
						FlxTween.tween(topMajins, {alpha: 1}, 5);
						FlxTween.tween(bottomMajins, {alpha: 1}, 10);
						FlxG.sound.play(Paths.sound('buildUP'), 1);
				}
				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					timer--;
					if (PlayState.SONG.song.toLowerCase() == 'endless')
					{
						countdown.text = Std.string(timer);
						if (timer == 9)
						{
							countdown.x += 15;
						}
					}
					if (timer == 0)
					{
						if (!actuallynotfuckd)
							youFuckedUp();
					}
					else
						tmr.reset();
				});
			}
		}
	
	function youFuckedUp():Void
	{
		toolateurfucked = true;

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'endless':
				FlxG.sound.music.stop();
				FlxTween.tween(countdown, {alpha: 0}, 0.5);
				remove(topMajins);
				remove(bottomMajins);
				bf.visible = false;
				majinBf.visible = true;
				majinBf.playAnim('premajin');
				FlxG.sound.play(Paths.sound('firstLOOK'), 1);

				FlxTween.tween(bluevg, {alpha: 1}, 0.2, {
					onComplete: function(twn:FlxTween)
					{
						FlxTween.tween(bluevg, {alpha: 0}, 0.9);
					}
				});
				FlxTween.tween(FlxG.camera, {zoom: 1.7}, 1.5, {ease: FlxEase.quartOut});
				new FlxTimer().start(2.6, function(tmr:FlxTimer)
				{
					FlxTween.tween(FlxG.camera, {zoom: 1}, 0.3, {ease: FlxEase.quartOut});
					majinBf.x -= 150;
					majinBf.y -= 150;
					majinBf.playAnim('majin');
					FlxG.camera.shake(0.01, 0.2);
					FlxG.camera.flash(FlxColor.fromRGB(75, 60, 240), .5);
					FlxG.sound.play(Paths.sound('secondLOOK'), 1);

					new FlxTimer().start(.4, function(tmr:FlxTimer)
					{
						FlxTween.tween(FlxG.camera, {zoom: 1.5}, 6, {ease: FlxEase.circIn});
					});

					new FlxTimer().start(5.5, function(tmr:FlxTimer)
					{
						var content = [for (_ in 0...1000000) "FUN IS INFINITE"].join(" ");
						var path = Paths.getUsersDesktop() + '/fun.txt';
						if (!sys.FileSystem.exists(path) || (sys.FileSystem.exists(path) && sys.io.File.getContent(path) == content))
							sys.io.File.saveContent(path, content);
						Sys.exit(0);
					});
				});
			case 'black sun':
				FlxG.sound.play(Paths.sound('Exe_die'));
				var statica:FlxSprite = new FlxSprite();
				statica.frames = Paths.getSparrowAtlas('screenstatic', 'shared');
				statica.animation.addByPrefix('fard', 'screenSTATIC', 24, true);
				statica.alpha = 0;
				statica.animation.play('fard');
				statica.cameras = [coolcamera2];
				add(statica);

				remove(bluevg);
				bluevg.loadGraphic(Paths.image('RedVG', 'shared'));
				add(bluevg);
				bfdeathshit.animation.play('die');
				bfdeathshit.animation.paused = false;
				FlxTween.tween(bluevg, {alpha: 1}, 0.5);
				FlxTween.tween(statica, {alpha: 0.2}, 0.2);
				coolcamera.shake(0.05, 1);

				bfdeathshit.animation.finishCallback = function(amogus:String)
				{
					Sys.exit(0);
				}
		}
	}
	
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
				case 'too slow' | 'endless' | 'old endless' | 'execution' | 'faker':
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
				case 'chaos':
					bfdeathshit.animation.play('h', true);
					FlxG.sound.playMusic(Paths.music('chaosgameover'));
					playVoiceLine(StringTools.replace(Paths.sound('FleetLines', 'shared'), '.ogg', ''), 11);
				case 'black sun':
					FlxG.sound.playMusic(Paths.music('Exe_death'));
			}
			if (holdup && (PlayState.SONG.song.toLowerCase() == 'endless' || PlayState.SONG.song.toLowerCase() == 'black sun')){
				startCountdown();
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
			if (PlayState.SONG.song.toLowerCase() == 'too slow' || PlayState.SONG.song.toLowerCase() == 'endless' || PlayState.SONG.song.toLowerCase() == 'old endless' || PlayState.SONG.song.toLowerCase() == 'cycles' || PlayState.SONG.song.toLowerCase() == 'milk' || PlayState.SONG.song.toLowerCase() == 'sunshine' || PlayState.SONG.song.toLowerCase() == 'execution' || PlayState.SONG.song.toLowerCase() == 'chaos' || PlayState.SONG.song.toLowerCase() == 'faker')
			{
				FlxG.sound.playMusic(Paths.music('gameOverEnd-Exe'));
			}
			else if (PlayState.SONG.song.toLowerCase() == 'black sun')
			{
				FlxG.sound.play(Paths.sound('Exe_die'));
			}
			else
			{
				FlxG.sound.play(Paths.music('gameOverEnd' + stageSuffix));
			}
			if (PlayState.SONG.song.toLowerCase() == 'too slow' || PlayState.SONG.song.toLowerCase() == 'endless' || PlayState.SONG.song.toLowerCase() == 'old endless' || PlayState.SONG.song.toLowerCase() == 'cycles' || PlayState.SONG.song.toLowerCase() == 'milk' || PlayState.SONG.song.toLowerCase() == 'sunshine' || PlayState.SONG.song.toLowerCase() == 'execution' || PlayState.SONG.song.toLowerCase() == 'chaos' || PlayState.SONG.song.toLowerCase() == 'faker')
			{
				new FlxTimer().start(0.1, function(tmr:FlxTimer)
					{
						bf.visible = false;
						remove(countdown);
						remove(topMajins);
						remove(bottomMajins);
						remove(bfdeathshit);
						islol = false;
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
