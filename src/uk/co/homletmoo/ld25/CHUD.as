package uk.co.homletmoo.ld25 
{
	public class CHUD 
	{
		// Dimensions of the button frame
		public static const BUTTON_SPR_WIDTH  :int = 19;
		public static const BUTTON_SPR_HEIGHT :int = 10;
		
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