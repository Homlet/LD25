package uk.co.homletmoo.ld25.entity 
{
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import uk.co.homletmoo.ld25.Assets;
	import uk.co.homletmoo.ld25.CDisplay;
	
	
	public class Level extends Entity
	{		
		public function Level() 
		{		
			var clouds_bit:BitmapData = Assets.scaleImg( Assets.BG_CLOUDS, CDisplay.SCALE );
			var clouds:Backdrop = new Backdrop( clouds_bit, false, true );
			clouds.scrollY = 0.6;
			
			var sheen:Image = new Image( Assets.BG_SHEEN );
			sheen.scale = CDisplay.SCALE;
			sheen.scrollY = 0;
			sheen.blend = BlendMode.ADD;
			
			var ocean_bit:BitmapData = Assets.scaleImg( Assets.BG, CDisplay.SCALE );
			var ocean:Backdrop = new Backdrop( ocean_bit, false, true );
			ocean.scrollY = 0.2;
			
			graphic = new Graphiclist( ocean, sheen, clouds );
		}
		
		override public function update():void
		{			
			super.update();
		}
		
	}

}
