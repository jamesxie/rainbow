package com.yxg.utils {
	import flash.utils.Dictionary;	

	/**
	 * @author com
	 * @version Version 1.00
	 * Date	2008-10-01
	 */
	public class DictionaryUtil {

		/**
		 * [study] object 新写法
		 * var obj1={"askdjlksjdf":"asdfadsf"}
		 * var dict:Dictionary=new Dictionary();
		 * dict[obj1]="123";
		 */
		
		public static function isEmpty(dict : Dictionary) : Boolean {
			for each(var value:Object in dict) {
				//XXX
				//return false;
				return Boolean(!value);
			}
			return true;
		}

		public static function getKeys(dict : Dictionary) : Array {
			var keys : Array = new Array();
			for(var key:Object in dict) {
				keys.push(key);
			}
			return keys;
		}

		public static function getValues(dict : Dictionary) : Array {
			var values : Array = new Array();
			for each(var value:Object in dict) {
				values.push(value);
			}
			return values;
		}
	}
}