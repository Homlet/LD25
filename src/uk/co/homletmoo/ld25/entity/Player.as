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
	import uk.co.homletmoo.ld25.CSound;
	import uk.co.homletmoo.ld25.CType;
	import uk.co.homletmoo.ld25.entity.Bullet;
	import uk.co.homletmoo.ld25.world.EndWorld;
	import uk.co.homletmoo.ld25.world.GameWorld;
	
	
	public class Player extends Entity
	{		
		private var _state:int;
		private var _stateTimer:Number;
		
		private var _graceTimer:Number;
		
		private var _bulletSelected:int;
		private var _enemySelected:int;
		private var _health:int;
		
		private var _shotTimer:Number;
		
		private var _velocity:Point;
		
		private var _bounds:Rectangle;
		
		private var _img:Spritemap;
		
		public function Player()
		{
			_state = CPlayer.STATE_DEFENSIVE;
			_stateTimer = CPlayer.STATE_DURATION;
			
			_bulletSelected = -1;
			_enemySelected = -1;
			_health = GameWorld.globals.HEALTH_MAX;
			
			_shotTimer = 0.0;
			
			_velocity = new Point( 0.0 );
			
			_bounds = new Rectangle( 30, 300, 450, 300 );
			
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
			
			_graceTimer = CPlayer.GRACE_DURATION;
			_img.alpha = CPlayer.GRACE_ALPHA;
			
			x = CDisplay.H_WIDTH - CPlayer.H_WIDTH;
			y = CDisplay.HEIGHT - 100;
			type = CType.PLAYER;
		}
		
		override public function update():void
		{
			if ( _health < 0 )
				if ( GameWorld.globals.N_LIVES > 0 )
					reset();
				else
				{
					CSound.KILL.play();
					GameWorld.globals.SCORE += 10 * GameWorld.globals.N_ENEMY;
					FP.world = new EndWorld( CType.END_GAME_OVER, GameWorld.globals.SCORE, GameWorld.globals.DIFFICULTY );
				}
			
			if ( _graceTimer <= 0 )
				_img.alpha = 1.0;
			else
				_graceTimer -= FP.elapsed;
			
			_velocity = new Point( 0 );
			
			runAI();
			
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
			CSound.PLAYER_HURT.play();
			if ( _graceTimer <= 0 )
				_health -= amount;
		}
		
		private function runAI():void
		{
			_stateTimer -= FP.elapsed;
			
			if ( _stateTimer <= 0 )
			{
				_state++;
				
				if ( _state >= CPlayer.N_STATES )
					_state = 0;
				
				_stateTimer = CPlayer.STATE_DURATION;
			}
			
			switch ( _state )
			{
				case CPlayer.STATE_OFFENSIVE:
					_bulletSelected = -1;
					
					var enemies:Vector.<Enemy> = new Vector.<Enemy>;
					FP.world.getClass( Enemy, enemies );
					
					if ( enemies.length > 0 )
					{
						if ( _enemySelected == -1 || _enemySelected >= enemies.length )
							_enemySelected = Math.round( Math.random() * ( enemies.length - 1 ) );
						
						var e:Enemy = enemies[_enemySelected];
						
						var enemyDir:Point = new Point(
							e.x - x,
							e.y - y
						);
						enemyDir.normalize( 1 );
						var vel:Point = new Point( enemyDir.x * CPlayer.SPEED, enemyDir.y * CPlayer.SPEED / 2.0 );
						_velocity = _velocity.add( vel );
					} else
						_enemySelected = -1;
					
					_shotTimer -= FP.elapsed;
					
					if ( _shotTimer <= 0 )
					{
						_shotTimer = GameWorld.globals.PLAYER_FIRE_COOLDOWN;
						var direction:Point = new Point( 0.0, -1.0 );
						shoot( direction, 3 );
					}
				break;
				
				case CPlayer.STATE_DEFENSIVE:
					_enemySelected = -1;
					
					var bullets:Vector.<Bullet> = new Vector.<Bullet>;
					FP.world.getClass( Bullet, bullets );
					
					if ( bullets.length > 0 )
					{
						if ( _bulletSelected == -1 || _bulletSelected >= bullets.length )
							_bulletSelected = Math.round( Math.random() * ( bullets.length - 1 ) );
						
						var b:Bullet = bullets[_bulletSelected];
						
						var bulletDir:Point = new Point(
							b.x - x - CPlayer.H_WIDTH,
							b.y - y - CPlayer.H_HEIGHT
						);
						if ( bulletDir.length <= CPlayer.MOVE_THRESHOLD )
						{
							bulletDir.normalize( 1 );
							vel = new Point( bulletDir.x * CPlayer.SPEED, bulletDir.y * CPlayer.SPEED );
							_velocity = _velocity.subtract( vel );
						}
					} else
						_bulletSelected = -1;
				break;
				
				default:
					trace( "INVALID PLAYER STATE, BAD HOMLETMOO, FIX CODES" );
				break;
			}
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
		
		private function shoot( direction:Point, accuracy:Number ):void
		{
			CSound.PLAYER_SHOOT.play();
			
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
				direction.x * GameWorld.globals.PLAYER_BULLET_SPEED,
				direction.y * GameWorld.globals.PLAYER_BULLET_SPEED
			);
			
			FP.world.add( new Bullet( x + CPlayer.H_WIDTH, y, vel, CType.BULLET_PLAYER ) );
		}
		
		private function reset():void
		{
			CSound.KILL.play();
			
			GameWorld.globals.N_LIVES--;
			
			_state = CPlayer.STATE_DEFENSIVE;
			_stateTimer = CPlayer.STATE_DURATION;
			
			_bulletSelected = -1;
			_enemySelected = -1;
			_health = GameWorld.globals.HEALTH_MAX;
			
			_shotTimer = 0.0;
			
			_velocity = new Point( 0.0 );
			
			_graceTimer = CPlayer.GRACE_DURATION;
			_img.alpha = CPlayer.GRACE_ALPHA;
		}
		
	}

}
