package com.xskip.game.rainbow.player 
{
	/**
	 * 2013-01-05
	 * @author XIEJ
	 */
	public class PlayerAI 
	{
		//警戒范围
		private var _guardingArea:int;
		private var _targetPlayer:PlayerBase;
		
		public function PlayerAI() 
		{
			init();
		}
		
		private function init():void {
			_guardingArea = 0;
			
		}
		
		//巡逻范围
		public function set guardingArea(pInt:int):void {
			_guardingArea = pInt;
		}
		
		public function get guardingArea():int {
			return _guardingArea;
		}
		
		//目标
		public function set targetPlayer(pPlayerBase:PlayerBase):void {
			_targetPlayer = pPlayerBase;
		}
		
		public function get targetPlayer():PlayerBase {
			return _targetPlayer;
		}
		
	}

}