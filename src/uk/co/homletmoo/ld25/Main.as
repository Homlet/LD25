package uk.co.homletmoo.ld25
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import uk.co.homletmoo.ld25.world.SplashWorld;
	
	
	[SWF (width = "480", height = "640", backgroundColor = "#1A1414")]
	
	public class Main extends Engine
	{		
		public function Main():void
		{
			super(
				CDisplay.WIDTH,
				CDisplay.HEIGHT,
				CDisplay.FRAME_RATE,
				CDisplay.FIXED_TIME
			);
			
			//FP.console.enable();
			//FP.console.toggleKey = Key.TAB;
			
			Input.mouseCursor = "hide";
		}
		
		override public function init():void
		{
			CSound.setup();
			
			FP.world = new SplashWorld();
		}
		
	}
	
}
