package com.xskip.game.crazytank.database 
{
	import com.yxg.utils.HashMap;
	/**
	 * ...
	 * @author XIEJ
	 */
	public class BattleInfo 
	{
		public static var ID_ENEMY:int;
		
		private var _hmEnemy:HashMap;
		
		public function BattleInfo() 
		{
			init();
		}
		
		private function init():void {
			ID_ENEMY = 1;
			_hmEnemy = new HashMap();
			
		}
		
		public function addEnemy(pDataPlayer:DataPlayer):void {
			var fID:int = ID_ENEMY++;
			trace("fID = "+fID);
			pDataPlayer.id = fID;
			_hmEnemy.put(fID, pDataPlayer);
		}
		
		public function clear():void {
			ID_ENEMY = 1;
			_hmEnemy.clear();
		}
		
	}

}