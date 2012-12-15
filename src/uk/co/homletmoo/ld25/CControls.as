package uk.co.homletmoo.ld25
{
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key
	
	
	public class CControls 
	{
		public static const UP    :String = '0';
		public static const LEFT  :String = '1';
		public static const DOWN  :String = '2';
		public static const RIGHT :String = '3';
		public static const ENTER :String = '4';
		
		public static function setup( azerty:Boolean ):void
		{
			if ( azerty )
			{
				Input.define( UP,    Key.Z, Key.UP    );
				Input.define( LEFT,  Key.Q, Key.RIGHT );
				Input.define( DOWN,  Key.S, Key.DOWN  );
				Input.define( RIGHT, Key.D, Key.LEFT  );
			} else
			{
				Input.define( UP,    Key.W, Key.UP    );
				Input.define( LEFT,  Key.A, Key.RIGHT );
				Input.define( DOWN,  Key.S, Key.DOWN  );
				Input.define( RIGHT, Key.D, Key.LEFT  );
			}
			
			Input.define( ENTER, Key.SPACE, Key.ENTER, Key.NUMPAD_ENTER );
		}
	}

}
