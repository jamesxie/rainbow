package com.xskip.game.rainbow.database 
{
	import starling.core.Starling;
	/**
	 * ...
	 * @author XIEJ
	 */
	public class GlobalData 
	{
		//游戏信息
		public static var GAME_INFO:GameInfo;
		//游戏暂停
		public static var GAME_PAUSE:Boolean = false;
		
		//starling 
		public static var GAME_WORLD:Starling;
		
		public static const WIDTH:Number = 1000;
		public static const HEIGHT:Number = 600;
		
	}

}