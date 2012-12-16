package uk.co.homletmoo.ld25 
{
	public class Globals
	{
		// Speed of all bullets.
		public var BULLET_SPEED:Number = 400.0;
		
		// Enemy firing cooldown in seconds.
		public var FIRE_COOLDOWN:Number = 0.5;
		
		// Is the fleet firing?
		public var IS_FIRING:Boolean = false;
		
		// Number of enemy ships remaining in storage.
		public var N_ENEMY:int = 10;
		
		// Number of enemy ships active.
		public var N_ENEMY_ACTIVE:int = 3;
		
		// Maximum number of enemy ships active.
		public var N_ENEMY_ACTIVE_MAX:int = 5;
		
		// Number of player lives left.
		public var N_LIVES:int = 3;
		
		// Enemy maximum health.
		public var ENEMY_HEALTH_MAX:int = 5;
		
		// Player maximum health.
		public var HEALTH_MAX:int = 40;
		
		// Fleet score.
		public var SCORE:uint = 0;
	}

}
