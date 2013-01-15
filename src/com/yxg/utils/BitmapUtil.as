package com.yxg.utils 
{
	/**
	 * ...
	 * @author XIEJ
	 */
	public class BitmapUtil 
	{
		
		public function BitmapUtil() 
		{
			
		}
		
		public static function getBitmapData(pClass:Object) : BitmapData {
			var bitmap : Bitmap = pClass as Bitmap;
			return (bitmap == null) ? null : bitmap.bitmapData;
		}
		
	}

}