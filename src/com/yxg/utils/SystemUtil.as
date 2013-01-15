package com.yxg.utils 
{
	import flash.system.Capabilities;
	/**
	 * 获取系统变量类
	 * @author JamesXie
	 */
	public class SystemUtil
	{
		
		public function SystemUtil() 
		{
			
		}
		
		/**
		 * 系统版本号(只返回版本数据)<br>
		 * 例如:<br>
		 * "WIN 10,0,33,7"<br>
		 * "MAC 10,0,33,7"<br>
		 * "UNIX 10,0,33,7"<br>
		 * 返回<br>
		 * 10.0<br>
		 */
		public static function version() :int{
			var fFirstSpace:int = 0;
			var fVersion:int = 0;
			
			var fFullVersion:String = Capabilities.version;
			
			fFirstSpace = String(fFullVersion).indexOf(' ');
			
			var fTempVersion:String = fFullVersion.substring(fFirstSpace + 1, fFullVersion.length);
			var fTempArr:Array = fTempVersion.split(',');
			if (fTempArr.length >= 2) {
				fVersion = int(fTempArr[0]) + (int(fTempArr[1]) / 10);
			}
			return fVersion;
		}
		
	}

}