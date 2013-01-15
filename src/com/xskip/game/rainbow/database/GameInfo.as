package com.xskip.game.rainbow.database 
{
	/**
	 * 游戏信息
	 * @author XIEJ
	 */
	public class GameInfo 
	{
		//Login
		public static const STEP_WELCOME:String = 'WELCOME';
		//loading base asset
		public static const STEP_LOADING:String = 'LOADING';
		
		//Main 场景
		public static const STEP_TOWN:String = 'TOWN';
		//家里 Avatar 装饰
		public static const STEP_HOME:String = 'HOME';
		
		public static const STEP_WORK:String = 'WORK';
		public static const STEP_SHOP:String = 'SHOP';
		
		//冒险 PVE
		public static const STEP_PVE:String = 'STEP_PVE';
		//冒险 PVP
		public static const STEP_PVP:String = 'STEP_PVP';
		
		//战斗结算
		public static const STEP_WIN:String = 'WIN';
	
		public function GameInfo() 
		{
			init();
		}
		
		public function init():void {

		}
		
	}

}