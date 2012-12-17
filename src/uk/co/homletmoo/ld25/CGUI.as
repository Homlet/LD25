package uk.co.homletmoo.ld25 
{
	public class CGUI 
	{
		// Dimensions of the backdrop sprite frame.
		public static const BACKDROP_SPR_WIDTH  :int = 120;
		public static const BACKDROP_SPR_HEIGHT :int = 160;
		
		// Backdrop size and center after scaling.
		public static const BACKDROP_WIDTH    :int = BACKDROP_SPR_WIDTH * CDisplay.SCALE;
		public static const BACKDROP_HEIGHT   :int = BACKDROP_SPR_HEIGHT * CDisplay.SCALE;
		public static const BACKDROP_H_WIDTH  :int = BACKDROP_WIDTH / 2;
		public static const BACKDROP_H_HEIGHT :int = BACKDROP_HEIGHT / 2;
		
		// Backdrop frame handles.
		public static const BACKDROP_A_GAME_OVER      :String = '0';
		public static const BACKDROP_A_LEVEL_COMPLETE :String = '1';
		public static const BACKDROP_A_TITLE_CARD     :String = '2';
		
		
		// Dimensions of the button sprite frame.
		public static const BUTTON_SPR_WIDTH  :int = 51;
		public static const BUTTON_SPR_HEIGHT :int = 16;
		
		// Button frame size and center after scaling.
		public static const BUTTON_WIDTH    :int = BUTTON_SPR_WIDTH * CDisplay.SCALE;
		public static const BUTTON_HEIGHT   :int = BUTTON_SPR_HEIGHT * CDisplay.SCALE;
		public static const BUTTON_H_WIDTH  :int = BUTTON_WIDTH / 2;
		public static const BUTTON_H_HEIGHT :int = BUTTON_HEIGHT / 2;
		
		// Animation handles.
		public static const BUTTON_REST    :String = '0';
		public static const BUTTON_HOVER   :String = '1';
		public static const BUTTON_DEPRESS :String = '2';
	}

}