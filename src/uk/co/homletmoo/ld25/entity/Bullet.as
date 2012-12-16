package uk.co.homletmoo.ld25.entity 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import uk.co.homletmoo.ld25.CDisplay;
	import uk.co.homletmoo.ld25.CType;
	import uk.co.homletmoo.ld25.entity.Player;
	import uk.co.homletmoo.ld25.world.GameWorld;
	
	
	public class Bullet extends Entity
	{
		private var _velocity:Point;
		
		public function Bullet( x:int, y:int, velocity:Point )
		{
			this.x = x;
			this.y = y;
			
			_velocity = velocity;
			
			graphic = Image.createCircle( 4, 0, 1 );
			setHitbox( 8, 8, 0, 0 );
		}
		
		override public function update():void
		{
			x += _velocity.x * FP.elapsed;
			y += _velocity.y * FP.elapsed;
			
			var player:Player = collide( CType.PLAYER, x, y ) as Player;
			if ( player != null )
			{
				player.damage( 1 );
				GameWorld.globals.SCORE++;
				FP.world.remove( this );
			}
			
			if ( x - FP.camera.x > CDisplay.WIDTH ||
				x - FP.camera.x < 0 ||
				y - FP.camera.y > CDisplay.HEIGHT ||
				y - FP.camera.y < 0
			)
				FP.world.remove( this );
			
			super.update();
		}
		
		public function scroll( position:Number ):void
		{
			y -= position;
		}
		
	}

}
