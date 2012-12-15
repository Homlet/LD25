package uk.co.homletmoo.ld25.entity 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import uk.co.homletmoo.ld25.Bullet;
	import uk.co.homletmoo.ld25.CDisplay;
	import uk.co.homletmoo.ld25.world.GameWorld;
	
	
	public class Enemy extends Entity
	{
		private var _velocity:Point;
		
		public function Enemy() 
		{
			var img:Image = Image.createRect( 11, 9, 0x00FF00, 1 );
			img.scale = CDisplay.SCALE;
			graphic = img;
			
			setOrigin( 22, 18 );
			
			x = Math.random() * 480;
			y = Math.random() * 300;
		}
		
		override public function update():void
		{
			super.update();
		}
		
		public function scroll( position:Number ):void
		{
			y -= position;
		}
		
		public  function shoot( direction:Point, accuracy:Number ):void
		{
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
			
			FP.world.add( new Bullet( x, y, vel ) );
		}
		
	}

}
