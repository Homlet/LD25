package uk.co.homletmoo.ld25 
{
	public class Globals
	{
		// Difficulty constants.
		public static const EASY   :int = 0;
		public static const NORMAL :int = 1;
		public static const HARD   :int = 2;
		
		// Current difficulty.
		public var DIFFICULTY:int;
		
		// Speed of all bullets.
		public var BULLET_SPEED:Number = 500.0;
		
		// Enemy firing cooldown in seconds.
		public var FIRE_COOLDOWN:Number = 0.5;
		
		// Speed of all player bullets.
		public var PLAYER_BULLET_SPEED:Number = 600.0;
		
		// Player firing cooldown in seconds.
		public var PLAYER_FIRE_COOLDOWN:Number = 0.3;
		
		// Is the fleet firing?
		public var IS_FIRING:Boolean = false;
		
		// Number of enemy ships remaining in storage.
		public var N_ENEMY:int = 5;
		
		// Number of enemy ships active.
		public var N_ENEMY_ACTIVE:int = 3;
		
		// Maximum number of enemy ships active.
		public var N_ENEMY_ACTIVE_MAX:int = 4;
		
		// Number of player lives left.
		public var N_LIVES:int = 3;
		
		// Enemy maximum health.
		public var ENEMY_HEALTH_MAX:int = 3;
		
		// Points gained for each remaining enemy in storage at end of game.
		public var ENEMY_SCORE_MULT:int = 10;
		
		// Player maximum health.
		public var HEALTH_MAX:int = 30;
		
		// Fleet score.
		public var SCORE:uint = 50;
		
		public function setDifficulty( difficulty:int ):void
		{
			DIFFICULTY = difficulty;
			
			switch ( DIFFICULTY )
			{
				case EASY:
					BULLET_SPEED = 600.0;
					FIRE_COOLDOWN = 0.4;
					
					PLAYER_BULLET_SPEED 500.0;
					PLAYER_FIRE_COOLDOWN = 0.4;
					
					N_ENEMY = 6;
					N_ENEMY_ACTIVE = 4;
					N_ENEMY_ACTIVE_MAX = 5;
					
					ENEMY_SCORE_MULT = 8;
					
					SCORE = 25;
				break;
				
				case NORMAL:
				break;
				
				case HARD:
					BULLET_SPEED = 450.0;
					FIRE_COOLDOWN = 0.65;
					
					PLAYER_BULLET_SPEED 750.0;
					PLAYER_FIRE_COOLDOWN = 0.15;
					
					N_ENEMY = 4;
					N_ENEMY_ACTIVE = 2;
					N_ENEMY_ACTIVE_MAX = 3;
					
					ENEMY_SCORE_MULT = 15;
					
					SCORE = 75;
				break;
				
				default:
					trace( "INVALID DIFFICULTY LEVEL, BAD HOMLETMOO, FIX CODES" );
				break;
			}
		}
	}

}
