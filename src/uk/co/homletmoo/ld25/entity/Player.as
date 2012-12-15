package uk.co.homletmoo.ld25.entity
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import uk.co.homletmoo.ld25.Bullet;
	import uk.co.homletmoo.ld25.CDisplay;
	import uk.co.homletmoo.ld25.CPlayer;
	import uk.co.homletmoo.ld25.Assets;
	import uk.co.homletmoo.ld25.CType;
	import uk.co.homletmoo.ld25.world.GameWorld;
	
	
	public class Player extends Entity
	{
		private var _health:int = 100;
		
		private var _img:Spritemap;
		
		public function Player()
		{
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
			
			FP.console.log( _health );
		}
		
		override public function update():void
		{
			if ( _health < 0 )
				FP.world = new GameWorld();
			
			super.update();
		}
		
		public function scroll( position:Number ):void
		{
			y -= position;
		}
		
		public function damage( amount:int ):void
		{
			_health -= amount;
		}
		
	}

}
