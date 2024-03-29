package uk.co.homletmoo.ld25
{
	import flash.geom.Rectangle;
	public class CDisplay
	{
		// SWF size and center.
		public static const WIDTH    :int = 480;
		public static const HEIGHT   :int = 640;
		public static const H_WIDTH  :int = WIDTH / 2;
		public static const H_HEIGHT :int = HEIGHT / 2;
		
		// Global sprite scale factor.
		public static const SCALE :int = 4;
		
		// Screen areas.
		public static const MOVING_AREA   :Rectangle = new Rectangle(
			0,   0,
			480, 300
		);
		public static const SHOOTING_AREA :Rectangle = new Rectangle(
			0,   300,
			480, 300
		);
		public static const BUTTON_AREA   :Rectangle = new Rectangle(
			400, 4,
			19 * SCALE, 10 * SCALE
		);
		
		// Time related settings.
		public static const FRAME_RATE :Number = 60.0;
		public static const FIXED_TIME :Boolean = false;
	}

}
