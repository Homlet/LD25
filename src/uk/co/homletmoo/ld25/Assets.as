package uk.co.homletmoo.ld25 
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import net.flashpunk.FP;
	
	
	public class Assets 
	{
		public static function scaleImg( img:*, factor:int ):BitmapData
		{
			factor = Math.abs( factor );
			
			var bit:BitmapData = FP.getBitmap( img );
			
			var width :int = ( bit.width  * factor ) || 1;
			var height:int = ( bit.height * factor ) || 1;
			
			var result:BitmapData = new BitmapData( width, height, true, 0 );
			var matrix:Matrix = new Matrix();
			matrix.scale( factor, factor );
			result.draw( bit, matrix );
			
			return result;
		}
		
		// Player sprite sheet.
		[Embed (source = "res/player.png")] public static const PLAYER:Class;
		
		// Y-repeatable background image.
		[Embed (source = "res/bg.png")] public static const BG:Class;
		
		// Y-repeatable clouds.
		[Embed (source = "res/clouds.png")] public static const BG_CLOUDS:Class;
		
		// Water sheen.
		[Embed (source = "res/sheen.png")] public static const BG_SHEEN:Class;
	}

}
