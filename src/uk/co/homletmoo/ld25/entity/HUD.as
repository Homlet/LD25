package uk.co.homletmoo.ld25.entity 
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import uk.co.homletmoo.ld25.Assets;
	import uk.co.homletmoo.ld25.CDisplay;
	import uk.co.homletmoo.ld25.CHUD;
	import uk.co.homletmoo.ld25.CSound;
	import uk.co.homletmoo.ld25.world.GameWorld;
	
	
	public class HUD extends Entity
	{
		private var _scoreOld:int;
		private var _scoreText:Text;
		
		private var _enemyOld:int;
		private var _enemyText:Text;
		
		private var _playerOld:int;
		private var _playerText:Text;
		
		private var _button:Spritemap;
		
		public function HUD() 
		{
			var info:Image = new Image( Assets.HUD_INFO_BAR );
			info.scale = CDisplay.SCALE;
			
			var panel:Image = new Image( Assets.HUD_PANEL );
			panel.scale = CDisplay.SCALE;
			panel.y = 600;
			
			_scoreOld = GameWorld.globals.SCORE;
			_scoreText = new Text( "Score: " + _scoreOld, 2, 598 );
			_scoreText.size = 8;
			_scoreText.scale = CDisplay.SCALE;
			
			_enemyOld = GameWorld.globals.N_ENEMY;
			_enemyText = new Text( 'x' + _enemyOld, 245, 598 );
			_enemyText.size = 8;
			_enemyText.scale = CDisplay.SCALE;
			
			_playerOld = GameWorld.globals.N_LIVES;
			_playerText = new Text( 'x' + _playerOld, 405, 598 );
			_playerText.size = 8;
			_playerText.scale = CDisplay.SCALE;
			
			_button = new Spritemap( Assets.HUD_BUTTON, CHUD.BUTTON_SPR_WIDTH, CHUD.BUTTON_SPR_HEIGHT );
			_button.x = 400;
			_button.y = 4;
			_button.scale = CDisplay.SCALE;
			_button.add( CHUD.BUTTON_REST, [0] );
			_button.add( CHUD.BUTTON_HOVER, [1] );
			_button.add( CHUD.BUTTON_DEPRESS, [2] );
			_button.play( CHUD.BUTTON_REST );
			_button.visible = false;
			
			graphic = new Graphiclist( info, panel, _scoreText, _enemyText, _playerText, _button );
			graphic.scrollX = graphic.scrollY = 0;
			
			layer = -1;
		}
		
		override public function update():void
		{
			if ( GameWorld.globals.SCORE != _scoreOld )
			{
				_scoreOld = GameWorld.globals.SCORE;
				_scoreText.text = "Score: " + _scoreOld;
			}
			
			if ( GameWorld.globals.N_ENEMY != _enemyOld )
			{
				_enemyOld = GameWorld.globals.N_ENEMY;
				_enemyText.text = 'x' + _enemyOld;
			}
			
			if ( GameWorld.globals.N_LIVES != _playerOld )
			{
				_playerOld = GameWorld.globals.N_LIVES;
				_playerText.text = 'x' + _playerOld;
			}
			
			if ( GameWorld.globals.N_ENEMY_ACTIVE < GameWorld.globals.N_ENEMY_ACTIVE_MAX && GameWorld.globals.N_ENEMY > 0 )
			{
				_button.visible = true;
				
				if ( CDisplay.BUTTON_AREA.contains( Input.mouseX, Input.mouseY ) )
				{
					if ( Input.mouseDown )
						_button.play( CHUD.BUTTON_DEPRESS );
					else
						_button.play( CHUD.BUTTON_HOVER );
					
					if ( Input.mouseReleased )
					{
						CSound.ENEMY_ADDED.play();
						GameWorld.globals.N_ENEMY_ACTIVE++;
						GameWorld.globals.N_ENEMY--;
					}
				}
				else
					_button.play( CHUD.BUTTON_REST );
			}
			else
				_button.visible = false;
			
			super.update();
		}
		
	}

}