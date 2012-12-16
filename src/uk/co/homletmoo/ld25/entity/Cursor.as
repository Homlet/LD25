package uk.co.homletmoo.ld25.entity 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import uk.co.homletmoo.ld25.Assets;
	import uk.co.homletmoo.ld25.CDisplay;
	
	
	public class Cursor extends Entity
	{
		private var _cursor:Image;
		private var _crosshair:Image;
		
		public function Cursor() 
		{
			x = Input.mouseFlashX;
			y = Input.mouseFlashY;
			
			_cursor = new Image( Assets.CURSOR );
			_cursor.scale = CDisplay.SCALE;
			_cursor.scrollX = _cursor.scrollY = 0;
			
			_crosshair = new Image( Assets.CROSSHAIR );
			_crosshair.scale = CDisplay.SCALE;
			_crosshair.scrollX = _crosshair.scrollY = 0;
			_crosshair.centerOrigin();
			
			graphic = _cursor;
			
			layer = -2;
		}
		
		override public function update():void
		{
			x = Input.mouseFlashX;
			y = Input.mouseFlashY;
			
			if ( CDisplay.SHOOTING_AREA.contains( x, y ) )
				graphic = _crosshair;
			else
				graphic = _cursor;
			
			super.update();
		}
		
	}

}