package com.xskip.game.crazytank.database 
{
	/**
	 * 游戏信息
	 * @author XIEJ
	 */
	public class GameInfo 
	{
		public static const STEP_WELCOME:String = 'WELCOME';
		public static const STEP_LOADING:String = 'LOADING';
		public static const STEP_MAIN:String = 'MAIN';
		public static const STEP_WORK:String = 'WORK';
		public static const STEP_SHOP:String = 'SHOP';
		public static const STEP_BATTLE:String = 'BATTLE';
		public static const STEP_WIN:String = 'WIN';
		public static const STEP_GAMEOVER:String = 'GAMEOVER';
	
		public function GameInfo() 
		{
			init();
		}
		
		public function init():void {

		}
		
		/*
		public function set map(arr:Array):void {
			_arrMap = arr;
		}
		
		public function get map():Array {
			return _arrMap;
		}
		
		
		public function set enemy(arr:Array):void {
			_arrEnemy = arr;
		}
		
		public function get enemy():Array {
			return _arrEnemy;
		}
		
		//从0开始
		public function getEnemyId():String {
			return String(_enemyID++);
		}
		*/
		
	}

}