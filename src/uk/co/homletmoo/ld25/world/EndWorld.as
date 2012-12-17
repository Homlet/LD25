package uk.co.homletmoo.ld25.world 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import uk.co.homletmoo.ld25.CDisplay;
	import uk.co.homletmoo.ld25.CGUI;
	import uk.co.homletmoo.ld25.CSound;
	import uk.co.homletmoo.ld25.CType;
	import uk.co.homletmoo.ld25.entity.Button;
	import uk.co.homletmoo.ld25.entity.Cursor;
	import uk.co.homletmoo.ld25.entity.UIBackdrop;
	
	
	public class EndWorld extends World
	{
		private var _backdrop:UIBackdrop;
		private var _buttonPlayAgain:Button;
		private var _buttonMenu:Button;
		private var _score:Entity;
		private var _cursor:Cursor;
		
		private var _lastDifficulty:int;
		
		public function EndWorld( type:String, score:int, lastDifficulty:int ) 
		{
			_cursor = new Cursor( CType.CURSOR_MENU );
			
			_score = new Entity();
			var scoreText:Text = new Text( "Final Score: " + score, 12, 540 ); 
			scoreText.size = 48;
			scoreText.align = "center";
			scoreText.width = CDisplay.WIDTH;
			_score.graphic = scoreText;
			_score.layer = -1;
			
			switch ( type )
			{
				case CType.END_GAME_OVER:
					_backdrop = new UIBackdrop( CGUI.BACKDROP_A_GAME_OVER );
					_buttonPlayAgain = new Button( 60, 290, "Play Again", callback_playAgain );
					_buttonMenu = new Button( 24, 378, "Goto Menu", callback_menu );
				break;
				
				case CType.END_LEVEL_COMPLETE:
					_backdrop = new UIBackdrop( CGUI.BACKDROP_A_LEVEL_COMPLETE );
					_buttonPlayAgain = new Button( 60, 290, "Try Again", callback_playAgain );
					_buttonMenu = new Button( 24, 378, "Give Up", callback_menu );
				break;
				
				default:
					trace( "INVALID ENDGAME OUTCOME, BAD HOMLETMOO, FIX CODES" );
				break;
			}
			
			_lastDifficulty = lastDifficulty;
		}
		
		override public function begin():void
		{
			add( _buttonPlayAgain );
			add( _buttonMenu );
			add( _score );
			add( _backdrop );
			add( _cursor );
		}
		
		private function callback_playAgain():void
		{
			CSound.MENU_BUTTON.play();
			FP.world = new GameWorld( _lastDifficulty );
		}
		
		private function callback_menu():void
		{
			CSound.MENU_BUTTON.play();
			FP.world = new MenuWorld();
		}
		
	}

}