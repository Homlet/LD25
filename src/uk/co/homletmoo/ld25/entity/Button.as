package uk.co.homletmoo.ld25.entity 
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import uk.co.homletmoo.ld25.Assets;
	import uk.co.homletmoo.ld25.CDisplay;
	import uk.co.homletmoo.ld25.CGUI;
	
	
	public class Button extends Entity
	{
		private var _bounds:Rectangle;
		
		private var _img:Spritemap;
		private var _text:Text;
		
		private var _callback:Function;
		
		public function Button( x:int, y:int, text:String, callback:Function ) 
		{
			this.x = x;
			this.y = y;
			
			layer = -1
			
			_bounds = new Rectangle(
				x, y,
				CGUI.BUTTON_WIDTH, CGUI.BUTTON_HEIGHT
			);
			
			_img = new Spritemap( Assets.GUI_BUTTON, CGUI.BUTTON_SPR_WIDTH, CGUI.BUTTON_SPR_HEIGHT );
			_img.scale = CDisplay.SCALE;
			_img.scrollX = _img.scrollY = 0;
			_img.add( CGUI.BUTTON_REST, [0] );
			_img.add( CGUI.BUTTON_HOVER, [1] );
			_img.add( CGUI.BUTTON_DEPRESS, [2] );
			_img.play( CGUI.BUTTON_REST );
			
			_text = new Text( text, 0, 14 );
			_text.size = 8 * CDisplay.SCALE;
			_text.align = "center";
			_text.width = CGUI.BUTTON_WIDTH;
			
			graphic = new Graphiclist( _img, _text );
			
			_callback = callback;
		}
		
		override public function update():void
		{
			if ( _bounds.contains( Input.mouseX, Input.mouseY ) )
			{
				if ( Input.mouseDown )
					_img.play( CGUI.BUTTON_DEPRESS );
				else
					_img.play( CGUI.BUTTON_HOVER );
				
				if ( Input.mouseReleased )
					_callback.call();
			}
			else
				_img.play( CGUI.BUTTON_REST );
				
			super.update();
		}
		
	}

}