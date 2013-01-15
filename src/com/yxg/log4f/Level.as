package com.yxg.log4f {

	/**
	 * @author James
	 * @version 1.0
	 * @date 2008-11-06
	 * @name 设置提示级别
	 * @param num1:Number
	 * <br>0 ALL 显示临时信息(显示所有信息)
	 * <br>1 DEBUG 显示测试信息(显示DEBUG,INFO,WARN,ERROR,FATAL信息)
	 * <br>2 INFO 显示提示信息(显示INFO,WARN,ERROR,FATAL信息)
	 * <br>3 WARN 显示警告信息(显示WARN,ERROR,FATAL信息)
	 * <br>4 ERROR 显示错误信息(显示ERROR,FATAL信息)
	 * <br>5 FATAL 显示致命错误(只显示FATAL信息)
	 * <br>6 NONE (不显示任何信息)
	 * @return
	 */
	public class Level
	{
		private var _levelValue:int;
		
		private var _levelName:String;
		
		public static var ALL:Level=new Level(0,"ALL");
		
		public static var DEBUG:Level=new Level(1,"DEBUG");
		
		public static var INFO:Level=new Level(2,"INFO");
		
		public static var WARN:Level=new Level(3,"WARN");
		
		public static var ERROR:Level=new Level(4,"ERROR");
		
		public static var FATAL:Level=new Level(5,"FATAL");
		
		public static var OFF:Level=new Level(6,"OFF");

		public function Level(levelValue:int=1,levelName:String="DEBUG")
		{
			this._levelValue=levelValue;
			this._levelName=levelName;
		}
		
		public final function getValue():int{
			return this._levelValue;
		}
		
		public function compareTo(level:Level):Boolean{
			return this._levelValue<level.getValue();
		}
		
		public final function toString():String{
			return this._levelName;
		}
	}
}
