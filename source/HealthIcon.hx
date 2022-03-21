package;

import flixel.FlxSprite;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;
	public var defaultWidth:Float = 1;
	public var winningIcon:Bool = false;
	
	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		switch(char)
		{
		case 'bf-sonic-chaos':
			loadGraphic(Paths.image('sonic icons'), true, 150, 150);
	
			antialiasing = true;
			animation.add('bf-sonic-chaos', [0, 1], 0, false, isPlayer);
		case 'bf-fleetway-chaos':
			loadGraphic(Paths.image('fleetway icons'), true, 150, 150);
	
			antialiasing = true;
			animation.add('bf-fleetway-chaos', [0, 1], 0, false, isPlayer);
		case 'cancer':
			loadGraphic(Paths.image('icon-cancer'), true, 150, 150);
	
			antialiasing = true;
			animation.add('cancer', [0, 1], 0, false, isPlayer);
		case 'bf-alt':
			loadGraphic(Paths.image('icon-bf-v'), true, 150, 150);
	
			antialiasing = true;
			animation.add('bf-alt', [0, 1], 0, false, isPlayer);
		case 'sonic-forced':
			loadGraphic(Paths.image('sonic-forced'), true, 150, 150);
	
			antialiasing = true;
			animation.add('sonic-forced', [0, 1], 0, false, isPlayer);
		case 'sonic-mad':
			loadGraphic(Paths.image('sonic-mad'), true, 150, 150);

			antialiasing = true;
			animation.add('sonic-mad', [0, 1], 0, false, isPlayer);
		case 'sonic-tgt':
			loadGraphic(Paths.image('sonic-tgt'), true, 150, 150);

			antialiasing = true;
			animation.add('sonic-tgt', [0, 1], 0, false, isPlayer);
		case 'bfbig'|'happy':
			loadGraphic(Paths.image('noticons'), true, 150, 150);

			antialiasing = true;
			animation.add('bfbig', [20, 21], 0, true, isPlayer);
			animation.add('happy', [0, 1], 0, true, isPlayer);
		case 'fairestmonster-christmas'|'bf-christmas3':
			loadGraphic(Paths.image('softiconGrid'), true, 150, 150);

			antialiasing = true;
			animation.add('bf-christmas3', [0, 1], 0, false, isPlayer);
			animation.add('fairestmonster-christmas', [19, 20], 0, false, isPlayer);
		case 'bambi-3d':
			loadGraphic(Paths.image('iconGridDaveBambi'), true, 150, 150);

			antialiasing = false;
			animation.add('bambi-3d', [20, 21], 0, false, isPlayer);
		case 'bambi-old':
			loadGraphic(Paths.image('iconGridDaveBambi'), true, 150, 150);

			antialiasing = true;
			animation.add('bambi-old', [18, 19], 0, false, isPlayer);
		case 'smileeeeer'|'suicide':
			loadGraphic(Paths.image('icon-mouse'), true, 150, 150);

			antialiasing = true;
			animation.add('smileeeeer', [0, 1], 0, false, isPlayer);
			animation.add('suicide', [0, 1], 0, false, isPlayer);
		case 'bf-retro':
			loadGraphic(Paths.image('icon-bf-suicide'), true, 150, 150);

			antialiasing = true;
			animation.add('bf-retro', [0, 1], 0, false, isPlayer);
		case 'herobrine':
			loadGraphic(Paths.image('icon-herobrine'), true, 150, 150);

			antialiasing = true;
			animation.add('herobrine', [0, 1], 0, false, isPlayer);
		case 'soldierai'|'heavy-box'|'snoiper':
			loadGraphic(Paths.image('iconGridtf2'), true, 150, 150);

			antialiasing = true;
			animation.add('soldierai', [52, 53], 0, false, isPlayer);
			animation.add('heavy-box', [50, 51], 0, false, isPlayer);
			animation.add('snoiper', [42, 43], 0, false, isPlayer);
		case 'hellron':
			loadGraphic(Paths.image('iconGridinacoolway'), true, 150, 150);

			antialiasing = true;
			animation.add('hellron', [28, 29], 0, false, isPlayer);		
		case 'bigmonika':
			loadGraphic(Paths.image('icon-bigmonika'), true, 150, 150);
	
			antialiasing = true;
			animation.add('bigmonika', [0, 1], 0, false, isPlayer);	
		case '3d-bf' | 'og-dave' | 'og-dave-angey' | 'garrett' | 'hall-monitor' | 'diamond-man' | 'playrobot' | 'playrobot-crazy':
			loadGraphic(Paths.image('GAiconGrid'), true, 150, 150);

			antialiasing = false;
			animation.add('3d-bf', [34, 35], 0, false, isPlayer);
			animation.add('og-dave', [14, 15], 0, false, isPlayer);	
			animation.add('og-dave-angey', [14, 15], 0, false, isPlayer);	
			animation.add('garrett', [20, 21], 0, false, isPlayer);	
			animation.add('hall-monitor', [42, 43], 0, false, isPlayer);
			animation.add('diamond-man', [40, 41], 0, false, isPlayer);
			animation.add('playrobot', [38, 39], 0, false, isPlayer);
			animation.add('playrobot-crazy', [38, 39], 0, false, isPlayer);
		case 'boo':
			loadGraphic(Paths.image('icon-boo'), true, 150, 150);

			antialiasing = false;
			animation.add('boo', [0, 1], 0, false, isPlayer);	
		case 'bf-loggochristmas':
			loadGraphic(Paths.image('icon-bf-awesome'), true, 150, 150);

			antialiasing = false;
			animation.add('bf-loggochristmas', [0, 1], 0, false, isPlayer);	
		case 'sonic' | 'sonicfun' | 'sonicLordX' | 'sunky' | 'bf-SS' | 'TDoll' | 'fleetway' | 'sanic':
			loadGraphic(Paths.image('iconGridExe'), true, 150, 150);

			antialiasing = true;
			animation.add('sonic', [25, 24], 0, false, isPlayer);
			animation.add('sonicfun', [26, 27], 0, false, isPlayer);
			animation.add('sonicLordX', [28, 29], 0, false, isPlayer);
			animation.add('sunky', [30, 31], 0, false, isPlayer);
			animation.add('bf-SS', [32], 0, false, isPlayer);
			animation.add('TDoll', [33], 0, false, isPlayer);
			animation.add('fleetway', [40, 41], 0, false, isPlayer);
			animation.add('sanic', [38, 39], 0, false, isPlayer);
		case 'selever_angry':
			loadGraphic(Paths.image('icon-Selever_Angry'), true, 150, 150);

			antialiasing = true;
			animation.add('selever_angry', [0, 1], 0, false, isPlayer);	
		case 'redbald':
			loadGraphic(Paths.image('iconGridBaldi'), true, 150, 150);

			antialiasing = true;
			animation.add('redbald', [32, 33], 0, false, isPlayer);
		case 'hellbob'|'glitched-bob':
			loadGraphic(Paths.image('iconGridbob'), true, 150, 150);

			antialiasing = true;
			animation.add('hellbob', [28, 29], 0, false, isPlayer);
			animation.add('glitched-bob', [34, 35], 0, false, isPlayer);
		case 'zardyMyBeloved':
			loadGraphic(Paths.image('icon-zardyMyBeloved'), true, 150, 150);

			antialiasing = true;
			animation.add('zardyMyBeloved', [0, 1], 0, false, isPlayer);	
		case 'agoti':
			loadGraphic(Paths.image('iconGridAgoti'), true, 150, 150);

			antialiasing = true;
			animation.add('agoti', [3, 4], 0, false, isPlayer);		
		case 'bfdemoncesar'|'gf-tea'|'taki':
			loadGraphic(Paths.image('iconGridFever'), true, 150, 150);

			antialiasing = true;
			animation.add('bfdemoncesar', [3, 4], 0, false, isPlayer);
			animation.add('gf-tea', [9, 10], 0, false, isPlayer);
			animation.add('taki', [21, 22], 0, false, isPlayer);	
		case 'mattangry':
			loadGraphic(Paths.image('iconGridWiiSports'), true, 150, 150);

			antialiasing = true;
			animation.add('mattangry', [24, 25], 0, false, isPlayer);		
		case 'nonsense-god':
			loadGraphic(Paths.image('iconGridNonsense'), true, 150, 150);

			antialiasing = true;
			animation.add('nonsense-god', [26], 0, false, isPlayer);		
		case 'bf-salty'|'gf-itsumi'|'opheebop':
			loadGraphic(Paths.image('iconGridSalty'), true, 150, 150);

			antialiasing = true;
			animation.add('bf-salty', [0, 1], 0, false, isPlayer);
			animation.add('gf-itsumi', [16], 0, false, isPlayer);
			animation.add('opheebop', [19, 20], 0, false, isPlayer);
		case 'bf-neoscared'|'neomonster':
			loadGraphic(Paths.image('iconGridNeo'), true, 150, 150);

			antialiasing = true;
			animation.add('bf-neoscared', [0, 1], 0, false, isPlayer);
			animation.add('neomonster', [19, 20], 0, false, isPlayer);	
		case 'henryangry':
			loadGraphic(Paths.image('icons'), true, 150, 150);

			antialiasing = true;
			animation.add('henryangry', [0, 1], 0, false, isPlayer);	
		case 'black':
			loadGraphic(Paths.image('icon-black'), true, 150, 150);

			antialiasing = true;
			animation.add('black', [0, 1], 0, false, isPlayer);	
		case 'oldsonicLordX'|'oldsonicfun':
			loadGraphic(Paths.image('iconGridOldExe'), true, 150, 150);

			antialiasing = true;
			animation.add('oldsonicLordX', [28, 29], 0, false, isPlayer);
			animation.add('oldsonicfun', [26, 27], 0, false, isPlayer);
		case 'tricky':
			loadGraphic(Paths.image('IconGridTricky'), true, 150, 150);

			antialiasing = true;
			animation.add('tricky', [2, 3], 0, false, isPlayer);
		case 'extricky':
			loadGraphic(Paths.image('exTrickyIcons'), true, 150, 150);
			animation.add('extricky', [0, 1], 0, false, isPlayer);			
		default:
			loadGraphic(Paths.image('iconGrid'), true, 150, 150);

			antialiasing = true;
			animation.add('bf', [0, 1], 0, false, isPlayer);
			animation.add('bf-car', [0, 1], 0, false, isPlayer);
			animation.add('bf-christmas', [0, 1], 0, false, isPlayer);
			animation.add('bf-pixel', [21, 21], 0, false, isPlayer);
			animation.add('bf-mii', [0, 1], 0, false, isPlayer);
			animation.add('bf-gundeath', [0, 1], 0, false, isPlayer);
			animation.add('bf-paldo', [0, 1], 0, false, isPlayer);
			animation.add('bf-better', [0, 1], 0, false, isPlayer);
			animation.add('bf-blue', [0, 1], 0, false, isPlayer);
			animation.add('bf-super', [0, 1], 0, false, isPlayer);
			animation.add('bf-tf2', [0, 1], 0, false, isPlayer);
			animation.add('spooky', [2, 3], 0, false, isPlayer);
			animation.add('pico', [4, 5], 0, false, isPlayer);
			animation.add('mom', [6, 7], 0, false, isPlayer);
			animation.add('mom-car', [6, 7], 0, false, isPlayer);
			animation.add('tankman', [8, 9], 0, false, isPlayer);
			animation.add('dad', [12, 13], 0, false, isPlayer);
			animation.add('senpai', [22, 22], 0, false, isPlayer);
			animation.add('senpai-angry', [22, 22], 0, false, isPlayer);
			animation.add('spirit', [23, 23], 0, false, isPlayer);
			animation.add('bf-old', [14, 15], 0, false, isPlayer);
			animation.add('gf', [16], 0, false, isPlayer);
			animation.add('gf-christmas', [16], 0, false, isPlayer);
			animation.add('gf-pixel', [16], 0, false, isPlayer);
			animation.add('gf-tied', [16], 0, false, isPlayer);
			animation.add('gf-mii', [16], 0, false, isPlayer);
			animation.add('gf-rocks', [16], 0, false, isPlayer);
			animation.add('gf-troll', [16], 0, false, isPlayer);
			animation.add('gf-tf2', [16], 0, false, isPlayer);
			animation.add('parents-christmas', [17, 18], 0, false, isPlayer);
			animation.add('monster', [19, 20], 0, false, isPlayer);
			animation.add('monster-christmas', [19, 20], 0, false, isPlayer);
		}	
		animation.play(char);

		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
