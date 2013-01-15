package com.yxg.utils {
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.utils.getQualifiedClassName;		

	/**
	 * @author com
	 * @version Version 1.00
	 * Date	2008-10-01
	 */
	public class NameUtil extends Sprite {
		private static var _counter : int = 0;

		public static function createUniqueName(object : Object) : String {
			var name : String = getQualifiedClassName(object);
			var index : int = name.indexOf("::");
			if (index != -1)name = name.substr(index + 2);
			var charCode : int = name.charCodeAt(name.length - 1);
			if(charCode >= 48 && charCode <= 57)name += "_";
			return name + _counter++;
		}

		//获取本文件名称
		public static function getFileName(myStage : Stage) : String {
			var fStr : String;
			fStr = myStage.loaderInfo.url;
			return fStr;
		}
	}
}