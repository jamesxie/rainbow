﻿package gear.utils {
	public class IntUtil {
		private static var hexChars : String = "0123456789abcdef";

		public static function rol(x : int, n : int) : int {
			return ( x << n ) | ( x >>> ( 32 - n ) );
		}

		public static function ror(x : int, n : int) : uint {
			var nn : int = 32 - n;
			return ( x << nn ) | ( x >>> ( 32 - nn ) );
		}

		public static function toHex(n : int, bigEndian : Boolean = false) : String {
			var s : String = "";
			if ( bigEndian ) {
				for ( var i : int = 0;i < 4; i++ ) {
					s += hexChars.charAt(( n >> ( ( 3 - i ) * 8 + 4 ) ) & 0xF) + hexChars.charAt(( n >> ( ( 3 - i ) * 8 ) ) & 0xF);
				}
			} else {
				for ( var x : int = 0;x < 4; x++ ) {
					s += hexChars.charAt(( n >> ( x * 8 + 4 ) ) & 0xF) + hexChars.charAt(( n >> ( x * 8 ) ) & 0xF);
				}
			}
			return s;
		}
	}
}