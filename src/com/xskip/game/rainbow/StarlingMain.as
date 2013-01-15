package com.xskip.game.rainbow 
{
	import com.xskip.game.rainbow.database.GlobalData;
	import com.yxg.display.StageInfo;
	import starling.core.Starling;
	/**
	 * ...
	 * @author XIEJ
	 */
	public class StarlingMain 
	{
		private var _starling:Starling;
		
		public function StarlingMain() 
		{
			_starling = new Starling(MainRainbow, StageInfo.STAGE);
			_starling.antiAliasing = 2;
			_starling.enableErrorChecking = false;
			_starling.showStats = true;
			
			GlobalData.GAME_WORLD = _starling;
			
			_starling.start();
		}
		
	}

}