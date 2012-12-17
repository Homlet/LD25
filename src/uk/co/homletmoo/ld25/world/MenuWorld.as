package uk.co.homletmoo.ld25.world 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.World;
	import uk.co.homletmoo.ld25.CDisplay;
	import uk.co.homletmoo.ld25.CGUI;
	import uk.co.homletmoo.ld25.CSound;
	import uk.co.homletmoo.ld25.CType;
	import uk.co.homletmoo.ld25.entity.Button;
	import uk.co.homletmoo.ld25.entity.Cursor;
	import uk.co.homletmoo.ld25.entity.UIBackdrop;
	import uk.co.homletmoo.ld25.Globals;
	
	
	public class MenuWorld extends World
	{
		private var _backdrop:UIBackdrop;
		private var _buttonEasy:Button;
		private var _buttonNormal:Button;
		private var _buttonHard:Button;
		private var _cursor:Cursor;
		
		private var _fader:NumTween;
		private var _fadeImage:Image;
		private var _fadeEntity:Entity;
		
		public function MenuWorld()
		{
			_backdrop = new UIBackdrop( CGUI.BACKDROP_A_TITLE_CARD );
			
			_buttonEasy   = new Button( 160, 360, "Play Easy",  callback_easy );
			_buttonNormal = new Button( 225, 440, "Play Norm.", callback_normal );
			_buttonHard   = new Button( 260, 520, "Play Hard",  callback_hard );
			
			_cursor = new Cursor( CType.CURSOR_MENU );
			
			_fader = new NumTween();
			_fadeImage = Image.createRect( CDisplay.WIDTH, CDisplay.HEIGHT, 0xFF000000 );
			_fadeEntity = new Entity( 0, 0, _fadeImage );
			_fadeEntity.layer = -3;
			fadeIn();
		}
		
		override public function begin():void
		{
			add( _backdrop );
			add( _buttonEasy );
			add( _buttonNormal );
			add( _buttonHard );
			add( _cursor );
			
			add( _fadeEntity );
			addTween( _fader );
		}
		
		override public function update():void
		{
			// Handle fading.
			_fadeImage.alpha = _fader.value;
			
			super.update();
		}
		
		private function fadeIn():void
		{
			_fader.tween( 1, 0, 1, Ease.cubeOut );
		}
		
		private function callback_easy():void
		{
			CSound.MENU_BUTTON.play();
			FP.world = new GameWorld( Globals.EASY );
		}
		
		private function callback_normal():void
		{
			CSound.MENU_BUTTON.play();
			FP.world = new GameWorld( Globals.NORMAL );
		}
		
		private function callback_hard():void
		{
			CSound.MENU_BUTTON.play();
			FP.world = new GameWorld( Globals.HARD );
		}
		
	}

}