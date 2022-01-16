package;

import flixel.FlxG;
import openfl.display.BitmapData;
import lime.utils.Assets;
import flixel.graphics.FlxGraphic;
import flixel.addons.transition.FlxTransitionableState;

using StringTools;

class CoolUtil
{
	public static var difficultyArray:Array<String> = ['Easy', "6 KEY", "Hard"];

	public static function difficultyFromInt(difficulty:Int):String
	{
		return difficultyArray[difficulty];
	}

	public static function coolTextFile(path:String):Array<String>
	{
		var daList:Array<String> = Assets.getText(path).trim().split('\n');

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}

		return daList;
	}
	
	public static function coolStringFile(path:String):Array<String>
		{
			var daList:Array<String> = path.trim().split('\n');
	
			for (i in 0...daList.length)
			{
				daList[i] = daList[i].trim();
			}
	
			return daList;
		}

	public static function numberArray(max:Int, ?min = 0):Array<Int>
	{
		var dumbArray:Array<Int> = [];
		for (i in min...max)
		{
			dumbArray.push(i);
		}
		return dumbArray;
	}

	public static function crash()
		{
			#if FEATURE_FILESYSTEM
			Sys.exit(0);
			#else
			FlxTransitionableState.skipNextTransOut = true;
			FlxTransitionableState.skipNextTransIn = true;
			FlxG.switchState(new CrashState());
			#end
		}
}
