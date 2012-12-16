package uk.co.homletmoo.ld25.entity
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import uk.co.homletmoo.ld25.CDisplay;
	import uk.co.homletmoo.ld25.CPlayer;
	import uk.co.homletmoo.ld25.Assets;
	import uk.co.homletmoo.ld25.CType;
	import uk.co.homletmoo.ld25.entity.Bullet;
	import uk.co.homletmoo.ld25.world.GameWorld;
	
	
	public class Player extends Entity
	{
		private var _health:int;
		
		private var _velocity:Point;
		
		private var _bounds:Rectangle;
		
		private var _img:Spritemap;
		
		public function Player()
		{
			_health = 100;
			
			_velocity = new Point( 0.0 );
			
			_bounds = new Rectangle( 10, 300, 470, 300 );
			
			// Create spritemap with player image data.
			_img = new Spritemap( Assets.PLAYER, CPlayer.SPR_WIDTH, CPlayer.SPR_HEIGHT );
			_img.scale = CDisplay.SCALE;
			graphic = _img;
			
			setHitbox( CPlayer.WIDTH, CPlayer.HEIGHT, 0, 0 );
			
			// Set animation frames.
			_img.add( CPlayer.A_FWD,   [0, 1, 2], 10 );
			_img.add( CPlayer.A_RIGHT, [3, 4, 5], 10 );
			_img.add( CPlayer.A_LEFT,  [6, 7, 8], 10 );
			_img.play( CPlayer.A_FWD );
			
			x = CDisplay.H_WIDTH - CPlayer.H_WIDTH;
			y = CDisplay.HEIGHT - 100;
			type = CType.PLAYER;
			
		}
		
		override public function update():void
		{			
			if ( _health < 0 )
				FP.world = new GameWorld();
			
			_velocity = new Point( 0 );
			
			if ( GameWorld.globals.IS_FIRING )
			{
				var mouseDir:Point = new Point(
					Input.mouseX + FP.camera.x - x - CPlayer.H_WIDTH,
					Input.mouseY + FP.camera.y - y - CPlayer.H_HEIGHT
				);
				if ( mouseDir.length <= CPlayer.MOVE_THRESHOLD )
				{
					mouseDir.normalize( 1 );
					var vel:Point = new Point( mouseDir.x * CPlayer.SPEED, mouseDir.y * CPlayer.SPEED );
					_velocity = _velocity.subtract( vel );
				}
			}
			
			setAnimation();
			
			x += _velocity.x * FP.elapsed;
			y += _velocity.y * FP.elapsed;
			
			bindPosition();
			
			super.update();
		}
		
		public function scroll( position:Number ):void
		{
			y -= position;
			
			_bounds.offset( 0, -position );
		}
		
		public function damage( amount:int ):void
		{
			_health -= amount;
			FP.console.log( _health );
		}
		
		private function setAnimation():void
		{
			if ( _velocity.x > CPlayer.A_TURN_VELOCITY )
				_img.play( CPlayer.A_RIGHT );
			else if ( _velocity.x < -CPlayer.A_TURN_VELOCITY )
				_img.play( CPlayer.A_LEFT );
			else
				_img.play( CPlayer.A_FWD );
		}
		
		private function bindPosition():void
		{
			if ( x < _bounds.left )
				x = _bounds.left;
			else if ( x + CPlayer.WIDTH > _bounds.right )
				x = _bounds.right - CPlayer.WIDTH;
			
			if ( y < _bounds.top )
				y = _bounds.top
			else if ( y + CPlayer.HEIGHT > _bounds.bottom )
				y = _bounds.bottom - CPlayer.HEIGHT;
		}
		
	}

}
