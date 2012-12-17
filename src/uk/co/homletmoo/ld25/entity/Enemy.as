package uk.co.homletmoo.ld25.entity 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import uk.co.homletmoo.ld25.Assets;
	import uk.co.homletmoo.ld25.CDisplay;
	import uk.co.homletmoo.ld25.CEnemy;
	import uk.co.homletmoo.ld25.CSound;
	import uk.co.homletmoo.ld25.CType;
	import uk.co.homletmoo.ld25.entity.Bullet;
	import uk.co.homletmoo.ld25.world.GameWorld;
	
	
	public class Enemy extends Entity
	{
		private var _isMoving:Boolean;
		
		private var _health:int;
		
		private var _shotTimer:Number;
		
		private var _velocity:Point;
		private var _offset:Point;
		
		private var _bounds:Rectangle;
		
		private var _img:Spritemap;
		
		public function Enemy( position:Point = null ) 
		{
			_isMoving = false;
			
			_health = GameWorld.globals.ENEMY_HEALTH_MAX;
			
			_shotTimer = 0.0;
			
			_velocity = new Point( 0 );
			_offset = new Point( Math.random() * 160 - 80, Math.random() * 160 - 80 );
			
			// Create spritemap with player image data.
			_img = new Spritemap( Assets.ENEMY, CEnemy.SPR_WIDTH, CEnemy.SPR_HEIGHT );
			_img.scale = CDisplay.SCALE;
			graphic = _img;
			
			setHitbox( CEnemy.WIDTH, CEnemy.HEIGHT, 0, 0 );
			
			// Set animation frames.
			_img.add( CEnemy.A_FWD,   [0, 1, 2], 10 );
			_img.add( CEnemy.A_RIGHT, [3, 4, 5], 10 );
			_img.add( CEnemy.A_LEFT,  [6, 7, 8], 10 );
			_img.play( CEnemy.A_FWD );
			
			if ( position == null )
				_bounds = new Rectangle( 10, 0, 470, 300 );
			else
				_bounds = new Rectangle( 10, -position.y, 470, 300 );
			
			x = _bounds.x + _bounds.width / 2 + _offset.x;
			y = _bounds.y + _bounds.height / 2 + _offset.y;
			type = CType.ENEMY;
		}
		
		override public function update():void
		{
			if ( _health < 0 )
			{
				CSound.KILL.play();
				GameWorld.globals.N_ENEMY_ACTIVE--;
				FP.world.remove( this );
			}
			
			_velocity = new Point( 0 );
			
			_shotTimer -= FP.elapsed * Math.random();
			if ( Input.mouseDown )
			{
				var isInButtonArea:Boolean = CDisplay.BUTTON_AREA.contains( Input.mouseX, Input.mouseY ) && GameWorld.globals.N_ENEMY_ACTIVE < GameWorld.globals.N_ENEMY_ACTIVE_MAX;
				
				if ( CDisplay.MOVING_AREA.contains( Input.mouseX, Input.mouseY ) && !isInButtonArea )
				{
					if ( !_isMoving )
						_offset = new Point( Math.random() * 200 - 100, Math.random() * 200 - 100 );
					_isMoving = true;
					
					GameWorld.globals.IS_FIRING = false;
					
					var mouseDir:Point = new Point (
						Input.mouseX + FP.camera.x - x - _offset.x - 18,
						Input.mouseY + FP.camera.y - y - _offset.y - 18
					);
					
					if ( mouseDir.length > 2 )
					{
						mouseDir.normalize( 1 );
						
						var vel:Point = new Point( mouseDir.x * CEnemy.SPEED, mouseDir.y * CEnemy.SPEED );
						_velocity = _velocity.add( vel );
					}
				} else if ( CDisplay.SHOOTING_AREA.contains( Input.mouseX, Input.mouseY ) )
				{
					_isMoving = false;
					
					GameWorld.globals.IS_FIRING = true;
					
					if ( _shotTimer <= 0 )
					{
						_shotTimer = GameWorld.globals.FIRE_COOLDOWN;
						var direction:Point = new Point(
							Input.mouseX + FP.camera.x - x,
							Input.mouseY + FP.camera.y - y
						);
						direction.normalize( 1 );
						shoot( direction, 5 );
					}
				} else
				{
					_isMoving = false;
					GameWorld.globals.IS_FIRING = false;
				}
			} else
			{
				_isMoving = false;
				GameWorld.globals.IS_FIRING = false;
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
			CSound.ENEMY_HURT.play();
			_health -= amount;
		}
		
		private function setAnimation():void
		{
			if ( _velocity.x > CEnemy.A_TURN_VELOCITY )
				_img.play( CEnemy.A_RIGHT );
			else if ( _velocity.x < -CEnemy.A_TURN_VELOCITY )
				_img.play( CEnemy.A_LEFT );
			else
				_img.play( CEnemy.A_FWD );
		}
		
		private function bindPosition():void
		{
			if ( x < _bounds.left )
				x = _bounds.left;
			else if ( x + CEnemy.WIDTH > _bounds.right )
				x = _bounds.right - CEnemy.WIDTH;
			
			if ( y < _bounds.top )
				y = _bounds.top
			else if ( y + CEnemy.HEIGHT > _bounds.bottom )
				y = _bounds.bottom - CEnemy.HEIGHT;
		}
		
		private function shoot( direction:Point, accuracy:Number ):void
		{
			CSound.ENEMY_SHOOT.play();
			
			if ( accuracy > 0 )
			{
				var angle:Number = Math.atan2( direction.y, direction.x );
				angle += ( Math.random() - 0.5 ) * ( accuracy / 180 * Math.PI );
				direction = new Point(
					Math.cos( angle ),
					Math.sin( angle )
				);
			}
			
			var vel:Point = new Point(
				direction.x * GameWorld.globals.BULLET_SPEED,
				direction.y * GameWorld.globals.BULLET_SPEED
			);
			
			FP.world.add( new Bullet( x + CEnemy.H_WIDTH, y + CEnemy.HEIGHT, vel, CType.BULLET_ENEMY ) );
		}
		
	}

}
