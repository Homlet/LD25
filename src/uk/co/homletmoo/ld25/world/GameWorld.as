package uk.co.homletmoo.ld25.world 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
	import uk.co.homletmoo.ld25.Bullet;
	import uk.co.homletmoo.ld25.CPlayer;
	import uk.co.homletmoo.ld25.entity.Enemy;
	import uk.co.homletmoo.ld25.entity.Level;
	import uk.co.homletmoo.ld25.entity.Player;
	import uk.co.homletmoo.ld25.Globals;
	
	
	public class GameWorld extends World
	{
		public static var globals:Globals;
		
		private var _position:Number;
		
		private var _level:Level;
		
		private var _player:Player;
		private var _enemyList:Vector.<Enemy>;
		
		public function GameWorld()
		{
			_position = 0;
			
			// Reset globals
			globals = new Globals();
			
			// Setup level entity.
			_level = new Level();
			
			// Setup player.
			_player = new Player();
			
			// Setup enemy list and push enemies to it.
			_enemyList = new Vector.<Enemy>;
			for ( var i:int = 0; i < 5; i++ )
				_enemyList.push( new Enemy() );
		}
		
		override public function begin():void
		{
			add( _level );
			add( _player );
			addList( _enemyList );
		}
		
		override public function update():void
		{
			// Handle scrolling of all objects:
			_position += FP.elapsed * CPlayer.FWD;
			FP.camera.y = -_position;
			
			_player.scroll( FP.elapsed * CPlayer.FWD );
			
			for each ( var e:Enemy in _enemyList )
				e.scroll( FP.elapsed * CPlayer.FWD );
			
			if ( Input.mousePressed )
				for each ( e in _enemyList )
				{
					var direction:Point = new Point(
						Input.mouseFlashX - e.x + FP.camera.x,
						Input.mouseFlashY - e.y + FP.camera.y
					);
					direction.normalize( 1 );
					e.shoot( direction, 20 );
				}
			
			super.update();
		}
		
	}

}
