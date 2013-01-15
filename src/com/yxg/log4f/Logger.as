package com.yxg.log4f {
	import com.yxg.log4f.LogCookie;
	import com.yxg.utils.NameUtil;
	import com.yxg.utils.StringUtil;

	/**
	 * @author James
	 * @example
	 * import com.jonas.log4f.Logger;<br>
	 * import com.jonas.log4f.Level;<br>
	 * var logger:Logger = new Logger();<br>
	 * logger.setName("example.as");<br>
	 * logger.setLevel(Level.ALL);<br>
	 * logger.debug("this is a debug!");<br>
	 * logger.info("this is a info!");<br>
	 * logger.warn("this is a warn!");<br>
	 * logger.error("this is a error!");<br>
	 * logger.fatal("this is a fatal!");<br>
	 */
	public class Logger {
		private static var _instance : Logger;
		private var _name : String = 'NoName';
		private var _level : Level = Level.ALL;

		/**是否支持调试器*/
		private var _debugTools : Boolean = false;

		//private var _debugTools : Boolean = true;

		/**
		 * FunctionName 构造函数
		 * @param 
		 * @return 
		 */
		public function Logger() {
			//Logger.instantiation();
		}

		/**
		 * FunctionName 设置名称
		 * @param 
		 * @return 
		 */
		public function setName(name : String) : void {
			this._name = name;
		}

		/**
		 * FunctionName 设置级别
		 * @param 
		 * @return 
		 */
		public function setLevel(level : Level) : void {
			this._level = level;
		}

		/**
		 * FunctionName 设置是否支持Cookies Debug工具
		 * @param bln1:Boolean	是否支持
		 */
		public function setDebugTools(bln1 : Boolean) : void {
			this._debugTools = bln1;
		}

		private function forcedLog(level : Level,message : Object) : void {
			if(level.compareTo(this._level))return;
			this.printMsg(level, message);
		}

		/**
		 * FunctionName 显示信息
		 * @param obj1:Object信息内容
		 * @param str2:String提示级别
		 */
		private function printMsg(level : Level, message : Object) : void {
			var strMessage : String = "";
			var nowFormat : String = StringUtil.GetFullTime("-", " ", ":");
			strMessage = "[" + this._name + "] [" + level.toString() + "] " + message + " [" + nowFormat + "]";
			
			if (this._debugTools) {
				trace(strMessage);
				LogCookie.addLog(level, strMessage);
			} else {
				trace(strMessage);
			}
		}

		private static function getInstance(obj : Object = null) : void {
			var strClassName : String;
			if(Logger._instance == null) {
				Logger._instance = new Logger();
				if (obj == null) {
					obj = Logger._instance;
				}
				strClassName = NameUtil.createUniqueName(obj) + ".as";
				//strClassName = String(String(obj).substr(1, String(obj).length - 2).split(" ")[1]) + ".as";
				Logger._instance.setName(strClassName);
			}
		}

		public static function DEBUG(obj : Object,message : Object) : void {
			Logger.getInstance(obj);
			Logger._instance.debug(message);
		}

		public static function INFO(obj : Object,message : Object) : void {
			Logger.getInstance(obj);
			Logger._instance.info(message);
		}

		public static function WARN(obj : Object,message : Object) : void {
			Logger.getInstance(obj);
			Logger._instance.warn(message);
		}

		public static function ERROR(obj : Object,message : Object) : void {
			Logger.getInstance(obj);
			Logger._instance.error(message);
		}

		public static function FATAL(obj : Object,message : Object) : void {
			Logger.getInstance(obj);
			Logger._instance.fatal(message);
		}

		public function fatal(message : Object) : void {
			this.forcedLog(Level.FATAL, message);
		}

		public function error(message : Object) : void {
			this.forcedLog(Level.ERROR, message);
		}

		public function warn(message : Object) : void {
			this.forcedLog(Level.WARN, message);
		}

		public function info(message : Object) : void {
			this.forcedLog(Level.INFO, message);
		}

		public function debug(message : Object) : void {
			this.forcedLog(Level.DEBUG, message);
		}
	}
}
