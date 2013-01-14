package com.xskip.game.rainbow 
{
	import com.xskip.game.rainbow.database.GameInfo;
	import com.xskip.game.rainbow.database.GlobalData;
	import com.xskip.game.rainbow.display.DisplayManage;
	import com.xskip.game.rainbow.scene.SceneManage;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author XIEJ
	 */
	public class MainRainbow extends Sprite
	{
		
		public function MainRainbow() 
		{
			trace("MainRainbow!");
			init();
		}
		
		private function init():void {

			
			
			GlobalData.GAME_WORLD.stage.color = 0x333333;
			
			DisplayManage.run();
			
			SceneManage.play(GameInfo.STEP_WELCOME);
		}
		
	}

}