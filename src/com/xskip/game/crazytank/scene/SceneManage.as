package com.xskip.game.crazytank.scene 
{
	import com.xskip.game.crazytank.database.GameInfo;
	import com.xskip.game.crazytank.loading.LoaderAsset;
	import com.yxg.log4f.Logger;
	/**
	 * ...
	 * @author XIEJ
	 */
	public class SceneManage 
	{
		private static var GAME_RUN:Boolean = false;
		
		public static var NOW_PLAY:String;
		
		public static var NOW_SCENE:IScene;
		
		public static var SCENE_WELCOME:SceneWelcome;
		public static var LOADER_ASSET:LoaderAsset;
		public static var SCENE_MAIN:SceneMain;
		public static var SCENE_BATTLE:SceneBattle;
		
		public function SceneManage() 
		{
			Logger.WARN(SceneManage,"static class!!!");
		}
		
		public static function play(strScene:String = ""):void {
			if (!GAME_RUN) {
				SCENE_WELCOME = new SceneWelcome();
				SCENE_WELCOME.next();
				
				LOADER_ASSET = new LoaderAsset();
				LOADER_ASSET.next();
				
				SCENE_MAIN = new SceneMain();
				SCENE_MAIN.next();
				
				SCENE_BATTLE = new SceneBattle();
				SCENE_BATTLE.next();
				
				GAME_RUN = true;
			}
			
			if (strScene.length == 0) {
				Logger.WARN(SceneManage,"setting scene fail, parameter is invalid");
				return;
			}
			
			if (NOW_PLAY == strScene) {
				Logger.WARN(SceneManage,"setting scene fail, same the current scene");
				return;
			}
			
			NOW_PLAY = strScene;
			if (NOW_SCENE){
				NOW_SCENE.next();
			}
			
			switch(strScene) {
				case GameInfo.STEP_WELCOME:
					NOW_SCENE = SCENE_WELCOME;
					break;
				case GameInfo.STEP_LOADING:
					NOW_SCENE = LOADER_ASSET;
					break;
				case GameInfo.STEP_MAIN:
					NOW_SCENE = SCENE_MAIN;
					break;
				case GameInfo.STEP_BATTLE:
					NOW_SCENE = SCENE_BATTLE;
					break;
				default:
					Logger.WARN(SceneManage, "no defined parameters");
					return;
			}
			
			NOW_SCENE.play();
			
		}
		
	}

}