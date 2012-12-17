package uk.co.homletmoo.ld25 
{
	import net.flashpunk.Sfx;
	public class CSound 
	{
		public static var PLAYER_SHOOT:Sfx;
		public static var PLAYER_HURT:Sfx;
		public static var ENEMY_SHOOT:Sfx;
		public static var ENEMY_HURT:Sfx;
		public static var ENEMY_ADDED:Sfx;
		public static var KILL:Sfx;
		public static var MENU_BUTTON:Sfx;
		
		public static var MUSIC:Sfx;
		
		public static function setup():void
		{
			PLAYER_SHOOT = new Sfx( Assets.SND_PLAYER_SHOOT );
			PLAYER_HURT = new Sfx( Assets.SND_PLAYER_HURT );
			ENEMY_SHOOT = new Sfx( Assets.SND_ENEMY_SHOOT );
			ENEMY_HURT = new Sfx( Assets.SND_ENEMY_HURT );
			ENEMY_ADDED = new Sfx( Assets.SND_ENEMY_ADDED );
			KILL = new Sfx( Assets.SND_KILL );
			MENU_BUTTON = new Sfx( Assets.SND_MENU_BUTTON );
			
			MUSIC = new Sfx( Assets.SND_MUSIC );
		}
	}

}
