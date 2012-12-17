package uk.co.homletmoo.ld25.entity 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import uk.co.homletmoo.ld25.Assets;
	import uk.co.homletmoo.ld25.CDisplay;
	import uk.co.homletmoo.ld25.CGUI;
	
	
	public class UIBackdrop extends Entity
	{
		public function UIBackdrop( frame:String ) 
		{
			var img:Spritemap = new Spritemap( Assets.GUI_BACKDROP, CGUI.BACKDROP_SPR_WIDTH, CGUI.BACKDROP_SPR_HEIGHT );
			img.scale = CDisplay.SCALE;
			img.add( CGUI.BACKDROP_A_GAME_OVER, [0] );
			img.add( CGUI.BACKDROP_A_LEVEL_COMPLETE, [1] );
			img.add( CGUI.BACKDROP_A_TITLE_CARD, [2] );
			img.play( frame );
			
			graphic = img;
		}
		
	}

}