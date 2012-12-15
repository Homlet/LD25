package uk.co.homletmoo.ld25
{
	[SWF(width = "1280", height = "720", backgroundColor = "#1A1414")]
	
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	import uk.co.homletmoo.ld25.world.MenuWorld;
	
	
	public class Main extends Engine
	{		
		public function Main():void
		{
			super( CDisplay.WIDTH, CDisplay.HEIGHT, 60, false );
		}
		
		override public function init():void
		{
			FP.world = new MenuWorld();
		}
		
	}
	
}
