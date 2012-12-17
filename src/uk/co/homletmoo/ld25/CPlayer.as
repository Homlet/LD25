package uk.co.homletmoo.ld25 
{
	public class CPlayer 
	{
		// Size before scaling.
		public static const SPR_WIDTH  :int = 9;
		public static const SPR_HEIGHT :int = 11;
		
		// Size and center after scaling.
		public static const WIDTH    :int = SPR_WIDTH * CDisplay.SCALE;
		public static const HEIGHT   :int = SPR_HEIGHT * CDisplay.SCALE;
		public static const H_WIDTH  :int = WIDTH / 2;
		public static const H_HEIGHT :int = HEIGHT / 2;
		
		// Ship constant forward speed (only affects level object).
		public static const FWD :Number = 600.0;
		
		// Ship omnidirectional speed.
		public static const SPEED :Number = 180.0;
		
		// Distance from mouse before motion occurs.
		public static const MOVE_THRESHOLD :Number = 320.0;
		
		// Grace period duration in seconds.
		public static const GRACE_DURATION :Number = 3.0;
		
		// Alpha during grace period.
		public static const GRACE_ALPHA :Number = 0.4;
		
		// State handles.
		public static const N_STATES        :int = 2;
		
		public static const STATE_DEFENSIVE :int = 0;
		public static const STATE_OFFENSIVE :int = 1;
		
		// Duration of each offensive / defensive state in seconds.
		public static const STATE_DURATION :Number = 2.5;
		
		// Animation handles.
		public static const A_FWD   :String = '0';
		public static const A_RIGHT :String = '1';
		public static const A_LEFT  :String = '2';
		
		// Sideways velocity minimum to trigger turning animation
		public static const A_TURN_VELOCITY :Number = 30.0;
	}

}
