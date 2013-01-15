package com.yxg.log4f {
	import com.yxg.utils.StringUtil;
	
	import flash.net.SharedObject;
	import flash.utils.getTimer;		

	/**
	 * @author JamesXie
	 * @version 1.0
	 * @date 2009-3-10
	 * @name ClassName
	 */
	public class LogCookie {
		private var _so : SharedObject;

		public static var _Instance : LogCookie;

		public function LogCookie(e : Enforce) : void {
			if ( e == null ) {
				throw new Error("Enforce! Please use LogCookie._Instance");
			}
		}

		//单例模式构造
		public static function get Instance() : LogCookie {
			if ( LogCookie._Instance == null ) {
				LogCookie._Instance = new LogCookie(new Enforce());
			}
			return LogCookie._Instance;
		}

		private function refreshSO() : void {
			_so = SharedObject.getLocal("JamesLogCookie", "/");
		}

		private function closeSO() : void {
			_so.close();
			_so = null;
		}

		public static function addLog(lv : Level,obj : Object = null) : void {
			LogCookie.Instance.setValue(lv, obj);
		}

		public static function getLog() : Array {
			var fArr : Array = new Array();
			LogCookie.Instance.refreshSO();
			fArr[0] = LogCookie.Instance.getUpdateDate();
			fArr[1] = LogCookie.Instance.getLevel();
			fArr[2] = LogCookie.Instance.getLogger();
			LogCookie.Instance.closeSO();
			return fArr;
		}

		private function setValue(lv : Level,obj : Object = null) : void {
			refreshSO();
			_so.data["updateDate"] = String(StringUtil.GetFullTime("-", " ", ":") + " " + getTimer());
			_so.data["level"] = int(lv.getValue());
			_so.data["logger"] = obj;
			_so.flush(50 * 1024);
			closeSO();
		}

		private function getUpdateDate() : String {
			return _so.data["updateDate"];
		}

		private function getLevel() : int {
			return _so.data["level"];
		}

		private function getLogger() : Object {
			return _so.data["logger"];
		}
	}
}

class Enforce {
}