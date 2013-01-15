package com.xskip.game.crazytank.scene 
{
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.xskip.game.crazytank.database.GameInfo;
	import com.xskip.game.crazytank.display.DisplayManage;
	import com.yxg.display.StageInfo;
	import com.yxg.log4f.Logger;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author XIEJ
	 */
	public class SceneWelcome  implements IScene
	{
		private var _txtGameTitle:Label;
		private var _txtGameSubTitle:Label;
		private var _btnStartGame:PushButton;
		
		public function SceneWelcome() 
		{
			init();
		}
		
		private function init():void {
			Logger.INFO(this, "SceneWelcome init");
			
			_txtGameTitle = new Label(DisplayManage.get_Welcome(), 0, 0, "Crazy Tank");
			_txtGameTitle.x = StageInfo.STAGE.stageWidth / 2 - 90;
			_txtGameTitle.y = StageInfo.STAGE.stageHeight / 2 - 150;
			
			var format:TextFormat = new TextFormat();
			format.color = 0x00FF00;
			format.size = 30;
			
			_txtGameTitle.textField.defaultTextFormat = format;
			
			_txtGameSubTitle = new Label(DisplayManage.get_Welcome(), StageInfo.STAGE.stageWidth / 2 +30, StageInfo.STAGE.stageHeight / 2 - 100, "DEMO v 0.0.1");
			
			createBtnStart();
		}
		
		private function createBtnStart():void {
			_btnStartGame = new PushButton();
			_btnStartGame.label = "Game Start";
			_btnStartGame.height = 30;
			
			_btnStartGame.x = StageInfo.STAGE.stageWidth / 2 - _btnStartGame.width / 2;
			_btnStartGame.y = StageInfo.STAGE.stageHeight / 2;
			
			_btnStartGame.addEventListener(MouseEvent.CLICK, onClickHandler);
			
			DisplayManage.get_Welcome().addChild(_btnStartGame);
			
		}
		
		private function onClickHandler(e:MouseEvent):void {
			SceneManage.play(GameInfo.STEP_LOADING);
		}
		
		
		private function show(pBln:Boolean = true):void {
			DisplayManage.get_Welcome().visible = pBln;
			
		}
		
		public function play():void {
			show(true);
		}
		
		public function next():void {
			show(false);
		}
		
	}

}