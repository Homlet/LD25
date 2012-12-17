package uk.co.homletmoo.ld25.world 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
	import uk.co.homletmoo.ld25.CDisplay;
	import uk.co.homletmoo.ld25.CPlayer;
	import uk.co.homletmoo.ld25.CSound;
	import uk.co.homletmoo.ld25.CType;
	import uk.co.homletmoo.ld25.entity.Bullet;
	import uk.co.homletmoo.ld25.entity.Cursor;
	import uk.co.homletmoo.ld25.entity.Enemy;
	import uk.co.homletmoo.ld25.entity.HUD;
	import uk.co.homletmoo.ld25.entity.Level;
	import uk.co.homletmoo.ld25.entity.Player;
	import uk.co.homletmoo.ld25.Globals;
	
	
	public class GameWorld extends World
	{
		public static var globals:Globals;
		
		private var _position:Number;
		
		private var _level:Level;
		private var _player:Player;
		private var _HUD:HUD;
		private var _cursor:Cursor;
		
		public function GameWorld( difficulty:int )
		{
			_position = 0;
			
			// Reset globals
			globals = new Globals();
			globals.setDifficulty( difficulty );
			
			// Setup level entity.
			_level = new Level();
			
			// Setup player.
			_player = new Player();
			
			// Setup HUD.
			_HUD = new HUD();
			
			// Setup cursor.
			_cursor = new Cursor( CType.CURSOR_INGAME );
		}
		
		override public function begin():void
		{
			CSound.MUSIC.loop();
			
			add( _level );
			add( _player );
			add( _HUD );
			add( _cursor );
			
			for ( var i:int = 0; i < globals.N_ENEMY_ACTIVE; i++ )
				add( new Enemy() );
		}
		
		override public function update():void
		{
			// Handle scrolling of all objects:
			var scrolled:Number = FP.elapsed * CPlayer.FWD;
			_position += scrolled;
			FP.camera.y = -_position;
			
			_player.scroll( scrolled );
			
			var enemies:Vector.<Enemy> = new Vector.<Enemy>;
			getClass( Enemy, enemies );
			for each ( var e:Enemy in enemies )
				e.scroll( scrolled );
			
			var bullets:Vector.<Bullet> = new Vector.<Bullet>;
			getClass( Bullet, bullets );
			for each ( var b:Bullet in bullets )
				b.scroll( scrolled );
			
			// Top up enemy list
			var nEnemies:uint = enemies.length;
			while ( nEnemies < globals.N_ENEMY_ACTIVE )
			{
				nEnemies++;
				var pos:Point = new Point(
					0,
					_position
				);
				var e1:Enemy = new Enemy( pos );
				add( e1 );
			}
			
			if ( globals.N_ENEMY_ACTIVE == 0 )
			{
				globals.SCORE += 10 * GameWorld.globals.N_ENEMY;
				FP.world = new EndWorld( CType.END_LEVEL_COMPLETE, globals.SCORE, globals.DIFFICULTY );
			}
			
			super.update();
		}
		
		override public function end():void
		{
			CSound.MUSIC.stop();
		}
		
	}

}
