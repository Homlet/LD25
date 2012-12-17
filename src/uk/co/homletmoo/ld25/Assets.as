package uk.co.homletmoo.ld25 
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import net.flashpunk.FP;
	
	
	public class Assets 
	{
		public static function scaleImg( img:*, factor:int ):BitmapData
		{
			factor = Math.abs( factor );
			
			var bit:BitmapData = FP.getBitmap( img );
			
			var width :int = ( bit.width  * factor ) || 1;
			var height:int = ( bit.height * factor ) || 1;
			
			var result:BitmapData = new BitmapData( width, height, true, 0 );
			var matrix:Matrix = new Matrix();
			matrix.scale( factor, factor );
			result.draw( bit, matrix );
			
			return result;
		}
		
		// Ship sprite sheets.
		[Embed (source = "res/player.png")] public static const PLAYER:Class;
		[Embed (source = "res/enemy.png")]  public static const ENEMY:Class;
		
		// Y-repeatable background image.
		[Embed (source = "res/bg.png")] public static const BG:Class;
		
		// Y-repeatable clouds.
		[Embed (source = "res/clouds.png")] public static const BG_CLOUDS:Class;
		
		// Water sheen.
		[Embed (source = "res/sheen.png")] public static const BG_SHEEN:Class;
		
		// HUD components
		[Embed (source = "res/hud.png")]    public static const HUD_PANEL:Class;
		[Embed (source = "res/info.png")]   public static const HUD_INFO_BAR:Class;
		[Embed (source = "res/button.png")] public static const HUD_BUTTON:Class;
		
		// Cursor graphics
		[Embed (source = "res/cursor.png")]    public static const CURSOR:Class;
		[Embed (source = "res/crosshair.png")] public static const CROSSHAIR:Class;
		
		// GUI components
		[Embed (source = "res/backdrop.png")]    public static const GUI_BACKDROP:Class;
		[Embed (source = "res/menu_button.png")] public static const GUI_BUTTON:Class;
		
		[Embed (source = "res/flashpunk.png")]   public static const FP_LOGO:Class;
		[Embed (source = "res/HM.png")]          public static const HM_LOGO:Class;
		
		// Sound clips.
		[Embed (source = "res/plr_shoot.mp3")]   public static const SND_PLAYER_SHOOT:Class;
		[Embed (source = "res/plr_hurt.mp3")]    public static const SND_PLAYER_HURT:Class;
		[Embed (source = "res/enmy_shoot.mp3")]  public static const SND_ENEMY_SHOOT:Class;
		[Embed (source = "res/enmy_hurt.mp3")]   public static const SND_ENEMY_HURT:Class;
		[Embed (source = "res/enmy_add.mp3")]    public static const SND_ENEMY_ADDED:Class;
		[Embed (source = "res/kill.mp3")]        public static const SND_KILL:Class;
		[Embed (source = "res/menu_button.mp3")] public static const SND_MENU_BUTTON:Class;
		
		[Embed (source = "res/music.mp3")] public static const SND_MUSIC:Class;
	}

}
