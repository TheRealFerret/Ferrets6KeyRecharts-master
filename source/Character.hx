package;

import flixel.addons.effects.FlxTrail;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';
	public var holdState:Bool = false;

	public var holdTimer:Float = 0;
	public var iconColor:String = "FF82d4f5";

	public var exSpikes:FlxSprite;

	public var nonanimated:Bool = false;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		antialiasing = FlxG.save.data.antialiasing;

		switch (curCharacter)
		{
			case 'gf':
				iconColor = 'FFa5004d';
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/GF_assets');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

			case 'gf-christmas':
				iconColor = 'FFa5004d';
				tex = Paths.getSparrowAtlas('characters/gfChristmas');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

			case 'gf-car':
				iconColor = 'FFa5004d';
				tex = Paths.getSparrowAtlas('characters/gfCar');
				frames = tex;
				animation.addByIndices('singUP', 'GF Dancing Beat Hair blowing CAR', [0], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat Hair blowing CAR', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat Hair blowing CAR', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24,
					false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');

			case 'gf-pixel':
				iconColor = 'FFa5004d';
				tex = Paths.getSparrowAtlas('characters/gfPixel');
				frames = tex;
				animation.addByIndices('singUP', 'GF IDLE', [2], "", 24, false);
				animation.addByIndices('danceLeft', 'GF IDLE', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF IDLE', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();
				antialiasing = false;

			case 'gf-tied':
				iconColor = 'FFa5004d';
				tex = Paths.getSparrowAtlas('characters/EX Tricky GF');
				frames = tex;

				//trace(frames.frames.length);

				animation.addByIndices('danceLeft','GF Ex Tricky',[0,1,2,3,4,5,6,7,8], "", 24, false);
				animation.addByIndices('danceRight','GF Ex Tricky',[9,10,11,12,13,14,15,16,17,18,19], "", 24, false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');

				//trace(animation.curAnim);

			case 'dad':
				iconColor = 'FFaf66ce';
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/DADDY_DEAREST', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);

				playAnim('idle');
			case 'spooky':
				iconColor = 'FFd57e00';
				tex = Paths.getSparrowAtlas('characters/spooky_kids_assets');
				frames = tex;
				animation.addByPrefix('singUP', 'spooky UP NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'spooky DOWN note', 24, false);
				animation.addByPrefix('singLEFT', 'note sing left', 24, false);
				animation.addByPrefix('singRIGHT', 'spooky sing right', 24, false);
				animation.addByIndices('danceLeft', 'spooky dance idle', [0, 2, 6], "", 12, false);
				animation.addByIndices('danceRight', 'spooky dance idle', [8, 10, 12, 14], "", 12, false);

				addOffset('danceLeft');
				addOffset('danceRight');

				addOffset("singUP", -20, 26);
				addOffset("singRIGHT", -130, -14);
				addOffset("singLEFT", 130, -10);
				addOffset("singDOWN", -50, -130);

				playAnim('danceRight');
			case 'mom':
				iconColor = 'FFd8558e';
				tex = Paths.getSparrowAtlas('characters/Mom_Assets');
				frames = tex;

				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				addOffset('idle');
				addOffset("singUP", 14, 71);
				addOffset("singRIGHT", 10, -60);
				addOffset("singLEFT", 250, -23);
				addOffset("singDOWN", 20, -160);

				playAnim('idle');

			case 'mom-car':
				iconColor = 'FFd8558e';
				tex = Paths.getSparrowAtlas('characters/momCar');
				frames = tex;

				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				addOffset('idle');
				addOffset("singUP", 14, 71);
				addOffset("singRIGHT", 10, -60);
				addOffset("singLEFT", 250, -23);
				addOffset("singDOWN", 20, -160);

				playAnim('idle');
			case 'monster':
				iconColor = 'FFf3ff6e';
				tex = Paths.getSparrowAtlas('characters/Monster_Assets');
				frames = tex;
				animation.addByPrefix('idle', 'monster idle', 24, false);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				addOffset('idle');
				addOffset("singUP", -20, 50);
				addOffset("singRIGHT", -51);
				addOffset("singLEFT", -30);
				addOffset("singDOWN", -30, -40);
				playAnim('idle');
			case 'monster-christmas':
				iconColor = 'FFf3ff6e';
				tex = Paths.getSparrowAtlas('characters/monsterChristmas');
				frames = tex;
				animation.addByPrefix('idle', 'monster idle', 24, false);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				addOffset('idle');
				addOffset("singUP", -20, 50);
				addOffset("singRIGHT", -51);
				addOffset("singLEFT", -30);
				addOffset("singDOWN", -40, -94);
				playAnim('idle');
			case 'pico':
				iconColor = 'FFb7d855';
				tex = Paths.getSparrowAtlas('characters/Pico_FNF_assetss');
				frames = tex;
				animation.addByPrefix('idle', "Pico Idle Dance", 24);
				animation.addByPrefix('singUP', 'pico Up note0', 24, false);
				animation.addByPrefix('singDOWN', 'Pico Down Note0', 24, false);
				if (isPlayer)
				{
					animation.addByPrefix('singLEFT', 'Pico NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico Note Right0', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'Pico Note Right Miss', 24, false);
					animation.addByPrefix('singLEFTmiss', 'Pico NOTE LEFT miss', 24, false);
				}
				else
				{
					// Need to be flipped! REDO THIS LATER!
					animation.addByPrefix('singLEFT', 'Pico Note Right0', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'Pico NOTE LEFT miss', 24, false);
					animation.addByPrefix('singLEFTmiss', 'Pico Note Right Miss', 24, false);
				}

				animation.addByPrefix('singUPmiss', 'pico Up note miss', 24);
				animation.addByPrefix('singDOWNmiss', 'Pico Down Note MISS', 24);

				addOffset('idle');
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -68, -7);
				addOffset("singLEFT", 65, 9);
				addOffset("singDOWN", 200, -70);
				addOffset("singUPmiss", -19, 67);
				addOffset("singRIGHTmiss", -60, 41);
				addOffset("singLEFTmiss", 62, 64);
				addOffset("singDOWNmiss", 210, -28);

				playAnim('idle');

				flipX = true;

			case 'bf':
				iconColor = 'FF31b0d1';
				var tex = Paths.getSparrowAtlas('characters/BOYFRIEND', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('TakeDamage', 'BF hit', 24, false);
				addOffset("TakeDamage", 7, 4);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;

			case 'bf-christmas':
				iconColor = 'FF31b0d1';
				var tex = Paths.getSparrowAtlas('characters/bfChristmas');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);

				playAnim('idle');

				flipX = true;
			case 'bf-car':
				iconColor = 'FF31b0d1';
				var tex = Paths.getSparrowAtlas('characters/bfCar');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				playAnim('idle');

				flipX = true;
			case 'bf-pixel':
				iconColor = 'FF7bd6f6';
				frames = Paths.getSparrowAtlas('characters/bfPixel');
				animation.addByPrefix('idle', 'BF IDLE', 24, false);
				animation.addByPrefix('singUP', 'BF UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'BF LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'BF RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'BF DOWN NOTE', 24, false);
				animation.addByPrefix('singUPmiss', 'BF UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF DOWN MISS', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				addOffset("singUPmiss");
				addOffset("singRIGHTmiss");
				addOffset("singLEFTmiss");
				addOffset("singDOWNmiss");

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				width -= 100;
				height -= 100;

				antialiasing = false;

				flipX = true;
			case 'bf-pixel-dead':
				iconColor = 'FF7bd6f6';
				frames = Paths.getSparrowAtlas('characters/bfPixelsDEAD');
				animation.addByPrefix('singUP', "BF Dies pixel", 24, false);
				animation.addByPrefix('firstDeath', "BF Dies pixel", 24, false);
				animation.addByPrefix('deathLoop', "Retry Loop", 24, true);
				animation.addByPrefix('deathConfirm', "RETRY CONFIRM", 24, false);
				animation.play('firstDeath');

				addOffset('firstDeath');
				addOffset('deathLoop', -37);
				addOffset('deathConfirm', -37);
				playAnim('firstDeath');
				// pixel bullshit
				setGraphicSize(Std.int(width * 6));
				updateHitbox();
				antialiasing = false;
				flipX = true;

			case 'senpai':
				iconColor = 'FFffaa6f';
				frames = Paths.getSparrowAtlas('characters/senpai');
				animation.addByPrefix('idle', 'Senpai Idle', 24, false);
				animation.addByPrefix('singUP', 'SENPAI UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'SENPAI LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'SENPAI RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'SENPAI DOWN NOTE', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);

				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;
			case 'senpai-angry':
				iconColor = 'FFffaa6f';
				frames = Paths.getSparrowAtlas('characters/senpai');
				animation.addByPrefix('idle', 'Angry Senpai Idle', 24, false);
				animation.addByPrefix('singUP', 'Angry Senpai UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'Angry Senpai LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'Angry Senpai RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'Angry Senpai DOWN NOTE', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);
				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;

			case 'spirit':
				iconColor = 'FFff3c6e';
				frames = Paths.getPackerAtlas('characters/spirit');
				animation.addByPrefix('idle', "idle spirit_", 24, false);
				animation.addByPrefix('singUP', "up_", 24, false);
				animation.addByPrefix('singRIGHT', "right_", 24, false);
				animation.addByPrefix('singLEFT', "left_", 24, false);
				animation.addByPrefix('singDOWN', "spirit down_", 24, false);

				addOffset('idle', -220, -280);
				addOffset('singUP', -220, -240);
				addOffset("singRIGHT", -220, -280);
				addOffset("singLEFT", -200, -280);
				addOffset("singDOWN", 170, 110);

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				antialiasing = false;

			case 'parents-christmas':
				iconColor = 'FFaf66ce';
				frames = Paths.getSparrowAtlas('characters/mom_dad_christmas_assets');
				animation.addByPrefix('idle', 'Parent Christmas Idle', 24, false);
				animation.addByPrefix('singUP', 'Parent Up Note Dad', 24, false);
				animation.addByPrefix('singDOWN', 'Parent Down Note Dad', 24, false);
				animation.addByPrefix('singLEFT', 'Parent Left Note Dad', 24, false);
				animation.addByPrefix('singRIGHT', 'Parent Right Note Dad', 24, false);

				animation.addByPrefix('singUP-alt', 'Parent Up Note Mom', 24, false);

				animation.addByPrefix('singDOWN-alt', 'Parent Down Note Mom', 24, false);
				animation.addByPrefix('singLEFT-alt', 'Parent Left Note Mom', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'Parent Right Note Mom', 24, false);

				addOffset('idle');
				addOffset("singUP", -47, 24);
				addOffset("singRIGHT", -1, -23);
				addOffset("singLEFT", -30, 16);
				addOffset("singDOWN", -31, -29);
				addOffset("singUP-alt", -47, 24);
				addOffset("singRIGHT-alt", -1, -24);
				addOffset("singLEFT-alt", -30, 15);
				addOffset("singDOWN-alt", -30, -27);

				playAnim('idle');
			case 'tricky':
				iconColor = 'FF185f40';
				tex = Paths.getSparrowAtlas('characters/tricky');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 24);
				animation.addByPrefix('singUP', 'Sing Up', 24);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24);
				animation.addByPrefix('singDOWN', 'Sing Down', 24);
				animation.addByPrefix('singLEFT', 'Sing Left', 24); 
				
				addOffset("idle", 0, -75);
				addOffset("singUP", 93, -76);
				addOffset("singRIGHT", 16, -176);
				addOffset("singLEFT", 103, -72);
				addOffset("singDOWN", 6, -84);

				playAnim('idle');
			
			case 'extricky':
				iconColor = 'FFff1900';
				frames = Paths.getSparrowAtlas('characters/extricky');
				exSpikes = new FlxSprite(x - 350,y - 170);
				exSpikes.frames = Paths.getSparrowAtlas('characters/FloorSpikes','shared');
				exSpikes.visible = false;

				exSpikes.animation.addByPrefix('spike','Floor Spikes', 24, false);
				
				animation.addByPrefix('idle', 'Idle', 24);
				animation.addByPrefix('singUP', 'Sing Up', 24);
				animation.addByPrefix('singLEFT', 'Sing Left', 24);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24);
				animation.addByPrefix('singDOWN', 'Sing Down', 24);
				animation.addByPrefix('Hank', 'Hank', 24, true);

				addOffset('idle');
				addOffset('Hank');
				addOffset("singUP", 0, 100);
				addOffset("singRIGHT", -209,-29);
				addOffset("singLEFT",127,20);
				addOffset("singDOWN",-100,-340);

				playAnim('idle');

			case 'bf-signDeath':
				frames = Paths.getSparrowAtlas('characters/signDeath');
				animation.addByPrefix('firstDeath', 'BF dies', 24, false);
				animation.addByPrefix('deathLoop', 'BF Dead Loop', 24, false);
				animation.addByPrefix('deathConfirm', 'BF Dead confirm', 24, false);
				
				playAnim('firstDeath');

				addOffset('firstDeath');
				addOffset('deathLoop');
				addOffset('deathConfirm', 0, 40);

				animation.pause();

				updateHitbox();
				antialiasing = false;
				flipX = true;	

			case 'cheekygun':
				iconColor = 'FF6eb3cc';
				tex = Paths.getSparrowAtlas('characters/cheekgun');
				frames = tex;
				animation.addByPrefix('idle', 'Cheeky Idle Dance', 24);
				animation.addByPrefix('singUP', 'Cheeky NOTE UP', 24, false);
				animation.addByPrefix('singRIGHT', 'Cheeky NOTE RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'Cheeky NOTE DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'Cheeky NOTE LEFT', 24, false);
				animation.addByPrefix('Shoot', 'Cheeky PEW PEW', 24, false);

				addOffset('idle');
				addOffset("singUP", 0, 26);
				addOffset("singRIGHT", 53, 0);
				addOffset("singLEFT", 304, 0);
				addOffset("singDOWN", 0, 9);
				addOffset("Shoot", -36, 2);

				setGraphicSize(Std.int(width * 2.25));

				playAnim('idle');
			case 'bf-gundeath':
				var tex = Paths.getSparrowAtlas('characters/gundeath');
				frames = tex;
				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);
				addOffset('firstDeath', 37, 22);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);

				flipX = true;

			case 'black':
				iconColor = 'FF2b2b2b';
				tex = Paths.getSparrowAtlas('characters/black');
				frames = tex;
				animation.addByPrefix('idle', 'BLACK IDLE', 24, true);
				animation.addByPrefix('singUP', 'BLACK UP', 24, false);
				animation.addByPrefix('singRIGHT', 'BLACK RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'BLACK DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'BLACK LEFT', 24, false);

				animation.addByPrefix('death', 'BLACK DEATH', 24, false);

				addOffset('idle');
				addOffset("singUP", 46, 104);
				addOffset("singRIGHT", -225, -10);
				addOffset("singLEFT", 116, 12);
				addOffset("singDOWN", -22, -20);
				addOffset("death", 252, 238);

				playAnim('idle');

			case 'bf-defeat-death':
				var tex = Paths.getSparrowAtlas('characters/defeatDeath');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, false);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				addOffset('firstDeath', 392, 87);
				addOffset('deathLoop', 34, 76);
				addOffset('deathConfirm', 34, 76);
	
				flipX = true;	

			case 'bf-defeat-secret':
				var tex = Paths.getSparrowAtlas('characters/noMoreBalls');
				frames = tex;
	
				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, false);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				addOffset('idle', -5);
				addOffset('firstDeath', 989, 87);
				addOffset('deathLoop', 24, 2);
				addOffset('deathConfirm', 24, 66);
	
				flipX = true;

			case 'henryangry':
				iconColor = 'FFe1e1e1';
				tex = Paths.getSparrowAtlas('characters/henryangry', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'spooky dance idle', 24);
				animation.addByPrefix('singUP', 'spooky UP NOTE', 24);
				animation.addByPrefix('singRIGHT', 'spooky sing right', 24);
				animation.addByPrefix('singDOWN', 'spooky DOWN note', 24);
				animation.addByPrefix('singLEFT', 'note sing left', 24);

				addOffset('idle');
				addOffset("singUP", -34, 26);
				addOffset("singRIGHT", -27, -4);
				addOffset("singLEFT", 85, -12);
				addOffset("singDOWN", -91, -128);

				playAnim('idle');

			case 'bf-neoscared':
				iconColor = 'FF53b984';
				var tex = Paths.getSparrowAtlas('characters/bfNeo_scared');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				addOffset('idle', 0, 1);
				addOffset("singUP", -6, 15);
				addOffset("singRIGHT", -12, -8);
				addOffset("singLEFT", 36, -8);
				addOffset("singDOWN", 13, -50);
				addOffset("singUPmiss", -6, 12);
				addOffset("singRIGHTmiss", -6, 4);
				addOffset("singLEFTmiss", 38, 0);
				addOffset("singDOWNmiss", 6, -36);
				addOffset("hey", 7, -1);
				addOffset('passOut', 14, -22);
				addOffset('firstDeath', 57, -13);
				addOffset('deathLoop', 57, -17);
				addOffset('deathConfirm', 83, 51);
				addOffset('scared', -4, 0);

				playAnim('idle');

				flipX = true;

			case 'neomonster':
				iconColor = 'FFc2274e';
				tex = Paths.getSparrowAtlas('characters/neolemon');
				frames = tex;
				animation.addByPrefix('idle', 'Lemon IDLE', 24, false);
				animation.addByPrefix('singUP', 'Lemon UP', 24, false);
				animation.addByPrefix('singDOWN', 'Lemon DOWN', 24, false);
				animation.addByPrefix('singRIGHT', 'Lemon RIGHT', 24, false);
				animation.addByPrefix('singLEFT', 'Lemon LEFT', 24, false);

				addOffset('idle');
				addOffset("singUP", -119, 31);
				addOffset("singRIGHT", 44, -41);
				addOffset("singLEFT", -120, -38);
				addOffset("singDOWN", 92, -63);

				playAnim('idle');
			case 'bf-salty':
				iconColor = 'FFffffff';
				var tex = Paths.getSparrowAtlas('characters/bfSalty');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;

			case 'gf-itsumi':
				iconColor = 'FFffffff';
				tex = Paths.getSparrowAtlas('characters/gfItsumi');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');
	
			case 'opheebop':
				iconColor = 'FF000000';
				tex = Paths.getSparrowAtlas('characters/opheebop');
				frames = tex;
				animation.addByPrefix('idle', 'monster idle', 24, false);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				addOffset('idle');
				addOffset("singUP", -20, 50);
				addOffset("singRIGHT", -51);
				addOffset("singLEFT", -30);
				addOffset("singDOWN", -30, -40);
				playAnim('idle');
				
			case 'oldsonicLordX':
				iconColor = 'FF7877b0';
				frames = Paths.getSparrowAtlas('characters/oldSONIC_X');
				animation.addByPrefix('idle', 'sonicX IDLE', 24, false);
				animation.addByPrefix('singUP', 'sonicx UP', 24, false);
				animation.addByPrefix('singDOWN', 'sonicx DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'sonicx LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'sonicx RIGHT', 24, false);
					
				addOffset('idle');
				addOffset("singUP", 5, 92);
				addOffset("singRIGHT", 24, -38);
				addOffset("singLEFT",51, -15);
				addOffset("singDOWN", 16, -62);
	
				antialiasing = true;

				playAnim('idle');

			case 'nonsense-god':
				iconColor = 'FFfff78f';
				frames = Paths.getSparrowAtlas('characters/Nonsense_God');
				animation.addByPrefix('idle', 'idle god', 24, false);
				animation.addByPrefix('singUP', 'god right', 24, false);
				animation.addByPrefix('singLEFT', 'left god', 24, false);
				animation.addByPrefix('singRIGHT', 'god right', 24, false);
				animation.addByPrefix('singDOWN', 'God down', 24, false);
				animation.addByPrefix('die', 'die god', 24, false);
				animation.addByIndices('singUP-alt', 'god up long note', [0, 2, 3, 4, 5, 6, 7], "", 24, false);
				animation.addByPrefix('singDOWN-alt', 'God down', 24, false);
				animation.addByPrefix('singLEFT-alt', 'left god', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'god right', 24, false);
				addOffset('idle', 1, 1);
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				addOffset("die", 718, 302);
				addOffset("singUP-alt", 0, 6);
				addOffset("singRIGHT-alt");
				addOffset("singLEFT-alt");
				addOffset("singDOWN-alt");
					
				playAnim('idle');

			case 'bf-mii':
				iconColor = 'FF31b0d1';
				var tex = Paths.getSparrowAtlas('characters/BOYFRIENDMII', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('TakeDamage', 'BF hit', 24, false);
				addOffset("TakeDamage", 7, 4);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;

			case 'gf-mii':
				iconColor = 'FFa5004d';
				tex = Paths.getSparrowAtlas('characters/GF_MII_assets');
				frames = tex;
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				playAnim('danceRight');

			case 'mattangry':
				iconColor = 'FFff8c00';
				tex = Paths.getSparrowAtlas('characters/mattangry');
			
				frames = tex;

				animation.addByPrefix('idle', "matt idle", 20, false);
				animation.addByPrefix('singUP', "matt up note", 24, false);
				animation.addByPrefix('singDOWN', "matt down note", 24, false);
				animation.addByPrefix('singLEFT', 'matt left note', 24, false);
				animation.addByPrefix('singRIGHT', 'matt right note', 24, false);

				addOffset('idle');
				addOffset("singUP", -41, 21);
				addOffset("singRIGHT", -10, -14);
				addOffset("singLEFT", 63, -24);
				addOffset("singDOWN", -62, -19);
	
				playAnim('idle');

			case 'bfdemoncesar':
				iconColor = 'FFe353c8';
				var tex = Paths.getSparrowAtlas('characters/demonCesar', 'shared');
				frames = tex;
	
				trace(tex.frames.length);
	
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);
				animation.addByPrefix('dodge', 'boyfriend dodge', 24, false);
				animation.addByPrefix('transition', 'BF Transition', 24, false);
	
				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);
	
				animation.addByPrefix('scared', 'BF idle shaking', 24);
	
				addOffset('idle', -5);
				addOffset('dodge', -5);
				addOffset("singUP", -61, 13);
				addOffset("singRIGHT", -75, -10);
				addOffset("singLEFT", -15, -3);
				addOffset("singDOWN", -39, -84);
				addOffset("singUPmiss", -64, 6);
				addOffset("singRIGHTmiss", -74, -19);
				addOffset("singLEFTmiss", -16, -4);
				addOffset("singDOWNmiss", -36, -84);
				addOffset("hey", -54, 1);
				addOffset("transition", -54, 1);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -54, -12);
	
				playAnim('idle');
	
				flipX = true;
	
			case 'gf-tea':
				iconColor = 'FF99dbf6';
				tex = Paths.getSparrowAtlas('characters/gfTea');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -21);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -13);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 1, -8);
				addOffset('hairFall', 0, -8);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

			case 'taki':
				iconColor = 'FFd34470';
				tex = Paths.getSparrowAtlas('characters/taki_assets');
				frames = tex;
				animation.addByPrefix('idle', 'takiidle', 24, false);
				animation.addByPrefix('singUP', 'takiup', 24, false);
				animation.addByPrefix('singDOWN', 'takidown', 24, false);
				animation.addByPrefix('singLEFT', 'takileft', 24, false);
				animation.addByPrefix('singRIGHT', 'takiright', 24, false);

				addOffset('idle');
				addOffset("singUP", -80, 17);
				addOffset("singRIGHT", -21, -5);
				addOffset("singLEFT", 38, -18);
				addOffset("singDOWN", -30, -210);

				playAnim('idle');

			case 'gf-rocks':
				iconColor = 'FFa5004d';
				tex = Paths.getSparrowAtlas('characters/GF_rock');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');		
			case 'agoti':
				iconColor = 'FFba1e24';
				tex = Paths.getSparrowAtlas('characters/AGOTI');
				frames = tex;
				animation.addByPrefix('idle', 'Agoti_Idle', 24);
				animation.addByPrefix('singUP', 'Agoti_Up', 24);
				animation.addByPrefix('singRIGHT', 'Agoti_Right', 24);
				animation.addByPrefix('singDOWN', 'Agoti_Down', 24);
				animation.addByPrefix('singLEFT', 'Agoti_Left', 24);

				addOffset('idle', 0, 140);
				addOffset("singUP", 90, 220);
				addOffset("singRIGHT", 130, 90);
				addOffset("singLEFT", 240, 170);
				addOffset("singDOWN", 70, -50);

				playAnim('idle');
			case 'sonic':
				iconColor = 'FF001366';
				tex = Paths.getSparrowAtlas('characters/Sonic_EXE_Assets');
				frames = tex;
				animation.addByPrefix('idle', 'SONICmoveIDLE', 24);
				animation.addByPrefix('singUP', 'SONICmoveUP', 24);
				animation.addByPrefix('singRIGHT', 'SONICmoveRIGHT', 24);
				animation.addByPrefix('singDOWN', 'SONICmoveDOWN', 24);
				animation.addByPrefix('singLEFT', 'SONICmoveLEFT', 24);
				animation.addByPrefix('iamgod', 'sonicImmagetya', 24, false);

				animation.addByPrefix('singDOWN-alt', 'SONIClaugh', 24);

				animation.addByPrefix('singLAUGH', 'SONIClaugh', 24);

				addOffset('idle');
				addOffset('iamgod', 127, 10);
				addOffset("singUP", 14, 47);
				addOffset("singRIGHT", 16, 14);
				addOffset("singLEFT", 152, -15);
				addOffset("singDOWN", 77, -12);
				addOffset("singLAUGH", 50, -10);

				addOffset("singDOWN-alt", 50, -10);

				playAnim('idle');
			case 'oldsonicfun':
				iconColor = 'FF0000d7';
				tex = Paths.getSparrowAtlas('characters/oldSonicFunAssets');
				frames = tex;
				animation.addByPrefix('idle', 'SONICFUNIDLE', 24);
				animation.addByPrefix('singUP', 'SONICFUNUP', 24);
				animation.addByPrefix('singRIGHT', 'SONICFUNRIGHT', 24);
				animation.addByPrefix('singDOWN', 'SONICFUNDOWN', 24);
				animation.addByPrefix('singLEFT', 'SONICFUNLEFT', 24);
	
				addOffset('idle', -21, 189);
				addOffset("singUP", 22, 126);
				addOffset("singRIGHT", -80, 43);
				addOffset("singLEFT", 393, -60);
				addOffset("singDOWN", 15, -67);
					
	
				playAnim('idle');
			case 'omen':
				iconColor = 'FF696969'; //nice
				tex = Paths.getSparrowAtlas('characters/omen');
				frames = tex;
				animation.addByPrefix('idle', 'Banjo boy Idle Dance', 24);
				animation.addByPrefix('singUP', 'Banjo boy NOTE UP', 24, false);
				animation.addByPrefix('singRIGHT', 'Banjo boy NOTE RIGHT', 32, false);
				animation.addByPrefix('singDOWN', 'Banjo boy NOTE DOWN', 32, false);
				animation.addByPrefix('singLEFT', 'Banjo boy NOTE LEFT', 24, false);
				animation.addByPrefix('AAAHHHHHH', 'Banjo Boy SCREAM', 24, false);

				addOffset('idle');
				addOffset("singUP", -5, 20);
				addOffset("singRIGHT", -69, -27);
				addOffset("singLEFT", 120, -30);
				addOffset("singDOWN", -10, -50);
				addOffset("AAAHHHHHH", -106, -14);

				setGraphicSize(Std.int(width * 2.35));

				playAnim('idle');	
			case 'zardyMyBeloved':
				iconColor = 'FFba7b42';
				tex = Paths.getSparrowAtlas('characters/Zardy');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 14);
				animation.addByPrefix('singUP', 'Sing Up', 24);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24);
				animation.addByPrefix('singDOWN', 'Sing Down', 24);
				animation.addByPrefix('singLEFT', 'Sing Left', 24);

				addOffset('idle');
				addOffset("singUP", -80, -10);
				addOffset("singRIGHT", -65, 5);
				addOffset("singLEFT", 130, 5);
				addOffset("singDOWN", -2, -26);

				playAnim('idle');
			case 'cheeky-Scared': 
				iconColor = 'FF6eb3cc';
				tex = Paths.getSparrowAtlas('characters/Mad Cheeky');
				frames = tex;
				animation.addByPrefix('idle', 'Cheeky Idle Dance', 24);
				animation.addByPrefix('singUP', 'Cheeky NOTE UP', 24, false);
				animation.addByPrefix('singRIGHT', 'Cheeky NOTE RIGHT', 32, false);
				animation.addByPrefix('singDOWN', 'Cheeky NOTE DOWN', 32, false);
				animation.addByPrefix('singLEFT', 'Cheeky NOTE LEFT', 24, false);

				addOffset('idle');
				addOffset("singUP", 0, 23);
				addOffset("singRIGHT", -37, 0);
				addOffset("singLEFT", 54, 0);
				addOffset("singDOWN", 0, -21);

				setGraphicSize(Std.int(width * 2.25));

				playAnim('idle');
			case 'bf-bob':
				iconColor = 'FFffffff';
				var tex = Paths.getSparrowAtlas('characters/bob_play');
				frames = tex;
				animation.addByPrefix('idle', 'bob_idle', 24, false);
				animation.addByPrefix('singUP', 'bob_UP', 24, false);
				animation.addByPrefix('singLEFT', 'bob_LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'bob_RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'bob_DOWN', 24, false);
				animation.addByPrefix('singUPmiss', 'bob1_UPMiss', 24, false);
				animation.addByPrefix('singLEFTmiss', 'bob1_LEFTMiss', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'bob1_RIGHTMiss', 24, false);
				animation.addByPrefix('singDOWNmiss', 'bob1_DOWNMiss', 24, false);
				animation.addByPrefix('TakeDamage', 'bob_hit', 24, false);

				animation.addByPrefix('firstDeath', "bob_first_death", 24, false);
				animation.addByPrefix('deathLoop', "bob_deadloop", 24, true);
				animation.addByPrefix('deathConfirm', "bob_deadconfirm", 24, false);

				addOffset('idle', 50, 90);
				addOffset("singUP", 55, 85);
				addOffset("singRIGHT", 75, 90);
				addOffset("singLEFT", 77, 85);
				addOffset("singDOWN", 55, 85);
				addOffset("singUPmiss", 67, 85);
				addOffset("singRIGHTmiss", 60, 85);
				addOffset("singLEFTmiss", 50, 85);
				addOffset("singDOWNmiss", 55, 90);
				addOffset('firstDeath', -60, 65);
				addOffset('deathLoop', -110, 60);
				addOffset('deathConfirm', -108, 65);
				addOffset('TakeDamage', -70, 30);

				playAnim('idle');
				flipX = true;	
			case 'hellbob':
				iconColor = 'FF000000';
				if (FlxG.save.data.happybob)
				{
					tex = Paths.getSparrowAtlas('characters/happy/hellbob_assets');
				}
				else
				{
					tex = Paths.getSparrowAtlas('characters/hellbob_assets');
				}
				frames = tex;
				animation.addByPrefix('idle', "bobismad", 24);
				animation.addByPrefix('singUP', 'lol', 24, false);
				animation.addByPrefix('singDOWN', 'lol', 24, false);
				animation.addByPrefix('singUPmiss', 'lol', 24);
				animation.addByPrefix('singDOWNmiss', 'lol', 24);

				//addOffset('idle', 0, 27);

				playAnim('idle');

				flipX = true;	

			case 'bf-spiked':
				frames = Paths.getSparrowAtlas('characters/BfSpiked');
				animation.addByPrefix('firstDeath', "BF idle dance", 24, false);
				animation.addByIndices('deathLoop', "BF idle dance", [44], "", 24, true);
				animation.addByIndices('deathConfirm', "BF idle dance", [44], "", 24, false);
				
				addOffset('firstDeath', 287,79);
				addOffset('deathLoop', 287, 79);
				addOffset('deathConfirm', 287,79);
				//playAnim('firstDeath');
				// pixel bullshit
				updateHitbox();
				antialiasing = false;
				flipX = true;
	
			case 'redbald':
				tex = Paths.getSparrowAtlas('characters/redbald', 'shared');
				frames = tex;
				iconColor = 'FF2300';
	
				animation.addByPrefix('idle', 'idle instance', 24);
				animation.addByPrefix('singUP', 'up instance', 24);
				animation.addByPrefix('singRIGHT', 'right instance', 24);
				animation.addByPrefix('singDOWN', 'down instance', 24);
				animation.addByPrefix('singLEFT', 'left instance', 24);
		
				addOffset('idle');
				addOffset("singUP", -157, 358);
				addOffset("singRIGHT", 38, 314);
				addOffset("singLEFT", 50, 163);
				addOffset("singDOWN", -3, 230);
		
				playAnim('idle');

			case 'bf-paldo':
				iconColor = 'FF31b0d1';
				var tex = Paths.getSparrowAtlas('characters/BOYFRIENDPALDO', 'shared');
				frames = tex;
	
				trace(tex.frames.length);
	
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);
		
				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset('firstDeath', 231, 39);
				addOffset('deathLoop', 102, 52);
				addOffset('deathConfirm', 111, 59);
	
				playAnim('idle');
	
				flipX = true;
			
			case 'bf-better':
				iconColor = 'FF31b0d1';
				var tex = Paths.getSparrowAtlas('characters/BOYFRIEND2','shared');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance instance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP instance', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT instance', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT instance', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN instance', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS instance', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS instance', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS instance', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS instance', 24, false);
				animation.addByPrefix('hey', 'BF HEY instance', 24, false);

				animation.addByPrefix('firstDeath', "BF dies instance", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop instance", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm instance", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking instance', 24);

				addOffset('idle', -5, -50);
				addOffset("singUP", -39, -21);
				addOffset("singRIGHT", -61, -56);
				addOffset("singLEFT", -1, -56);
				addOffset("singDOWN", -30, -86);
				addOffset("singUPmiss", -49, -23);
				addOffset("singRIGHTmiss", -50, -31);
				addOffset("singLEFTmiss", 0, -10);
				addOffset("singDOWNmiss", -21, -59);
				addOffset('hey', -33, -86);
				addOffset('firstDeath', 37, -39);
				addOffset('deathLoop', 37, -45);
				addOffset('deathConfirm', 38, 19);
				addOffset('scared', -4, -50);

				playAnim('idle');

				flipX = true;

			case 'gf-troll':
				iconColor = 'FFa5004d';
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/GFtroll_assets','shared');
				frames = tex;
				animation.addByIndices('danceLeft', 'GF Dancing Beat instance 1', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat instance 1', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				playAnim('danceRight');
			case 'sonic-tgt':
				iconColor = 'FFaa6f';
				frames = Paths.getSparrowAtlas('characters/sonic','shared');
				animation.addByPrefix('idle', "idle", 24, false);
				animation.addByPrefix('singUP', "up", 24, false);
				animation.addByPrefix('singRIGHT', "right", 24, false);
				animation.addByPrefix('singLEFT', "left", 24, false);
				animation.addByPrefix('singDOWN', "down", 24, false);

				addOffset('idle', 0, 148);
				addOffset('singUP', -38, 170);
				addOffset('singRIGHT', -62, 142);
				addOffset('singLEFT', -3, 150);
				addOffset('singDOWN', -21, 122);

				playAnim('idle');
				setGraphicSize(Std.int(width * 0.7));
				updateHitbox();

				antialiasing = true;
			case 'sonic-forced':
				iconColor = 'FFaa6f';
				frames = Paths.getSparrowAtlas('characters/sonic_forced','shared');
				animation.addByPrefix('idle', "idle", 24, false);
				animation.addByPrefix('singUP', "up", 24, false);
				animation.addByPrefix('singRIGHT', "right", 24, false);
				animation.addByPrefix('singLEFT', "left", 24, false);
				animation.addByPrefix('singDOWN', "down", 24, false);

				addOffset('idle', 0, 148);
				addOffset('singUP', -38, 192);
				addOffset('singRIGHT', -62, 148);
				addOffset('singLEFT', 4, 159);
				addOffset('singDOWN', -44, 135);

				playAnim('idle');
				setGraphicSize(Std.int(width * 0.7));
				updateHitbox();

				antialiasing = true;
			case 'sonic-mad':
				iconColor = 'FFaa6f';
				frames = Paths.getSparrowAtlas('characters/sonic_mad','shared');
				animation.addByPrefix('idle', "idle", 24, false);
				animation.addByPrefix('singUP', "up", 24, false);
				animation.addByPrefix('singRIGHT', "right", 24, false);
				animation.addByPrefix('singLEFT', "left", 24, false);
				animation.addByPrefix('singDOWN', "down", 24, false);

				addOffset('idle', 0, 148);
				addOffset('singUP', -28, 155);
				addOffset('singRIGHT', -39, 149);
				addOffset('singLEFT', 6, 149);
				addOffset('singDOWN', -11, 139);

				playAnim('idle');
				setGraphicSize(Std.int(width * 0.65));
				updateHitbox();

				antialiasing = true;
			case 'selever_angry':
				// DAD ANIMATION LOADING CODE
				iconColor = 'FF79143c';
				tex = Paths.getSparrowAtlas('characters/Selever_Angry','shared');
				frames = tex;
				animation.addByPrefix('idle', 'Selever_Angry Idle', 6, false);
				animation.addByPrefix('singUP', 'Selever_Angry Up', 9, false);
				animation.addByPrefix('singRIGHT', 'Selever_Angry Right', 9, false);
				animation.addByPrefix('singDOWN', 'Selever_Angry Down', 9, false);
				animation.addByPrefix('singLEFT', 'Selever_Angry Left', 9, false);

				addOffset('idle', 0, 0);
				addOffset('singUP', 0, 0);
				addOffset('singRIGHT', 0, 0);
				addOffset('singLEFT', 0, 0);
				addOffset('singDOWN', 0, 0);

				playAnim('idle');
				updateHitbox();

				antialiasing = true;

			case 'sonicfun':
				iconColor = 'FF3c008a';
				tex = Paths.getSparrowAtlas('characters/SonicFunAssets');
				frames = tex;
				animation.addByPrefix('idle', 'SONICFUNIDLE', 24);
				animation.addByPrefix('singUP', 'SONICFUNUP', 24);
				animation.addByPrefix('singRIGHT', 'SONICFUNRIGHT', 24);
				animation.addByPrefix('singDOWN', 'SONICFUNDOWN', 24);
				animation.addByPrefix('singLEFT', 'SONICFUNLEFT', 24);

				addOffset('idle', -21, 66);
				addOffset("singUP", 21, 70);
				addOffset("singRIGHT", -86, 15);
				addOffset("singLEFT", 393, -60);
				addOffset("singDOWN", 46, -80);

				playAnim('idle');

			case 'bf-blue':
				iconColor = 'FF31b0d1';
				var tex = Paths.getSparrowAtlas('characters/endless_bf', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('premajin', 'Majin Reveal Windup', 24, false);
				animation.addByPrefix('majin', 'Majin BF Reveal', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset('premajin');
				addOffset('majin');

				playAnim('idle');

				flipX = true;
			case 'sonicLordX':
				iconColor = 'FF7877b0';
				frames = Paths.getSparrowAtlas('characters/SONIC_X');
				animation.addByPrefix('idle', 'X_Idle', 24, false);
				animation.addByPrefix('singUP', 'X_Up', 24, false);
				animation.addByPrefix('singDOWN', 'X_Down', 24, false);
				animation.addByPrefix('singLEFT', 'X_Left', 24, false);
				animation.addByPrefix('singRIGHT', 'X_Right', 24, false);

				addOffset('idle', -18, 0);
				addOffset("singUP", 34, 121);
				addOffset("singRIGHT", -86, 40);
				addOffset("singLEFT", 17, 20);
				addOffset("singDOWN", 77, -21);

				setGraphicSize(Std.int(width * 1.2));

				updateHitbox();	
			case 'sunky':
				iconColor = 'FF001366';
				tex = Paths.getSparrowAtlas('characters/Sunky');
				frames = tex;
				animation.addByPrefix('idle', 'sunkyIDLE instance 1', 24);
				animation.addByPrefix('singUP', 'sunkyUP instance 1', 24);
				animation.addByPrefix('singRIGHT', 'sunkyRIGHT instance 1', 24);
				animation.addByPrefix('singDOWN', 'sunkyDOWN instance 1', 24);
				animation.addByPrefix('singLEFT', 'sunkyLEFT instance 1', 24);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");

				playAnim('idle');
	
			case 'TDoll':
				iconColor = 'FFffa500';
				tex = Paths.getSparrowAtlas('characters/Tails_Doll');
				frames = tex;
				animation.addByPrefix('idle', 'TailsDoll IDLE instance 1', 24);
				animation.addByPrefix('singUP', 'TailsDoll UP instance 1', 24);
				animation.addByPrefix('singRIGHT', 'TailsDoll RIGHT instance 1', 24);
				animation.addByPrefix('singDOWN', 'TailsDoll DOWN instance 1', 24);
				animation.addByPrefix('singLEFT', 'TailsDoll LEFT instance 1', 24);

				addOffset('idle', -21, 189);
				addOffset("singUP", 0, 297);
				addOffset("singRIGHT", -164, 187);
				addOffset("singLEFT", 80, 156);
				addOffset("singDOWN", -34, 70);

				playAnim('idle');

			case 'TDollAlt':
				iconColor = 'FFffa500';
				tex = Paths.getSparrowAtlas('characters/Tails_Doll_Alt');
				frames = tex;
				animation.addByPrefix('idle', 'TailsDoll IDLE instance', 24);
				animation.addByPrefix('singUP', 'TailsDoll UP instance', 24);
				animation.addByPrefix('singRIGHT', 'TailsDoll RIGHT instance', 24);
				animation.addByPrefix('singDOWN', 'TailsDoll DOWN instance', 24);
				animation.addByPrefix('singLEFT', 'TailsDoll LEFT instance', 24);

				addOffset('idle', -21, 189);
				addOffset("singUP", 0, 297);
				addOffset("singRIGHT", -164, 187);
				addOffset("singLEFT", 80, 156);
				addOffset("singDOWN", -34, 70);

				playAnim('idle');

			case 'bf-SS':
				iconColor = 'FF31b0d1';
				tex = Paths.getSparrowAtlas('characters/SSBF_Assets');
				frames = tex;

				animation.addByPrefix('idle', 'SSBF IDLE instance 1', 24);
				animation.addByPrefix('singUP', 'SSBF UP instance 1', 24);
				animation.addByPrefix('singLEFT', 'SSBF LEFT instance 1', 24);
				animation.addByPrefix('singRIGHT', 'SSBF RIGHT instance 1', 24);
				animation.addByPrefix('singDOWN', 'SSBF DOWN instance 1', 24);
				animation.addByPrefix('singUPmiss', 'SSBF UPmiss instance 1', 24);
				animation.addByPrefix('singLEFTmiss', 'SSBF LEFTmiss instance 1', 24);
				animation.addByPrefix('singRIGHTmiss', 'SSBF RIGHTmiss instance 1', 24);
				animation.addByPrefix('singDOWNmiss', 'SSBF DOWNmiss instance 1', 24);

				addOffset('idle', -5);
				addOffset("singUP", -5, 6);
				addOffset("singRIGHT", -12, -1);
				addOffset("singLEFT", 18, 12);
				addOffset("singDOWN", -2, -9);
				addOffset("singUPmiss", -11, 6);
				addOffset("singRIGHTmiss", 3, 11);
				addOffset("singLEFTmiss", 14, 0);
				addOffset("singDOWNmiss", 13, 17);

				playAnim('idle');

				flipX = true;
		}

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	override function update(elapsed:Float)
	{
		if (!curCharacter.startsWith('bf'))
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				trace('dance');
				dance();
				holdTimer = 0;
			}
		}

		switch (curCharacter)
		{
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
		case 'extricky':
				if (exSpikes.animation.frameIndex >= 3 && animation.curAnim.name == 'singUP')
				{
					//trace('paused');
					exSpikes.animation.pause();
				}		
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance()
	{
		if (!debugMode && !nonanimated)
		{
			switch (curCharacter)
			{
				case 'gf'|'gf-christmas'|'gf-car'|'gf-pixel'|'gf-tied'|'gf-itsumi'|'gf-mii'|'gf-tea'|'gf-rocks'|'gf-troll':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}				

				case 'spooky':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');
				default:
					playAnim('idle');
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		if (!nonanimated)
		{
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);

		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}

		if (curCharacter == 'extricky')
			{
				if (AnimName == 'singUP')
				{
					//trace('spikes');
					exSpikes.visible = true;
					if (exSpikes.animation.finished)
						exSpikes.animation.play('spike');
				}
				else if (!exSpikes.animation.finished)
				{
					exSpikes.animation.resume();
					//trace('go back spikes');
					exSpikes.animation.finishCallback = function(pog:String) {
						//trace('finished');
						exSpikes.visible = false;
						exSpikes.animation.finishCallback = null;
					}
				}
			}
		}	
	}

	public function changeHoldState(state:Bool) {
		holdState = state;
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
