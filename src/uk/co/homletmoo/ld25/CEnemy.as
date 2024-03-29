package uk.co.homletmoo.ld25 
{
	public class CEnemy 
	{
		// Size before scaling.
		public static const SPR_WIDTH  :int = 9;
		public static const SPR_HEIGHT :int = 9;
		
		// Size and center after scaling.
		public static const WIDTH    :int = SPR_WIDTH * CDisplay.SCALE;
		public static const HEIGHT   :int = SPR_HEIGHT * CDisplay.SCALE;
		public static const H_WIDTH  :int = WIDTH / 2;
		public static const H_HEIGHT :int = HEIGHT / 2;
		
		// Ship omnidirectional speed.
		public static const SPEED :Number = 180.0;
		
		// Animation handles.
		public static const A_FWD   :String = '0';
		public static const A_RIGHT :String = '1';
		public static const A_LEFT  :String = '2';
		
		// Sideways velocity minimum to trigger turning animation
		public static const A_TURN_VELOCITY :Number = 30.0;
	}

}