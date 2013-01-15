package com.xskip.game.crazytank.scene 
{
	import com.bit101.components.PushButton;
	import com.bit101.components.Window;
	import com.xskip.game.crazytank.database.GameInfo;
	import com.xskip.game.crazytank.display.DisplayManage;
	import com.yxg.log4f.Logger;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author XIEJ
	 */
	public class SceneMain implements IScene
	{
		private var _fWin:Window;
		
		
		public function SceneMain() 
		{
			init();
		}
		
		private function init():void {
			Logger.INFO(this, "SceneMain init");
			
			_fWin = new Window(DisplayManage.get_Main(), 50, 50, "Battle Select");
			_fWin.width = 160;
			_fWin.height = 180;
			
			var fBtn1:PushButton = new PushButton(_fWin.content, 10, 10, "[VS Monkey] Fight");
			var fBtn2:PushButton = new PushButton(_fWin.content, 10, 45, "[VS Senior] Fight");
			var fBtn3:PushButton = new PushButton(_fWin.content, 10, 80, "[VS Boss] Fight");
			var fBtn4:PushButton = new PushButton(_fWin.content, 10, 115, "[VS PVE] Fight");
			
			//暂时影藏其他关卡
			fBtn2.visible = false;
			fBtn3.visible = false;
			fBtn4.visible = false;
			
			
			fBtn1.width = 120;
			fBtn1.height = 30;
			fBtn2.width = 120;
			fBtn2.height = 30;
			fBtn3.width = 120;
			fBtn3.height = 30;
			fBtn4.width = 120;
			fBtn4.height = 30;
			
			fBtn1.addEventListener(MouseEvent.CLICK, onBtn01Handler);
			fBtn2.addEventListener(MouseEvent.CLICK, onBtn02Handler);
			fBtn3.addEventListener(MouseEvent.CLICK, onBtn03Handler);
			fBtn4.addEventListener(MouseEvent.CLICK, onBtn04Handler);
			
		}
		
		private function onBtn01Handler(e:MouseEvent):void {
			Logger.INFO(this, "Fight 001");
			
			//准备战斗数据
			
			SceneManage.play(GameInfo.STEP_BATTLE);
		}
		
		private function onBtn02Handler(e:MouseEvent):void {
			Logger.INFO(this, "Fight 002");
		}
		
		private function onBtn03Handler(e:MouseEvent):void {
			Logger.INFO(this, "Fight 003");
		}
		
		private function onBtn04Handler(e:MouseEvent):void {
			Logger.INFO(this, "Fight 004");
		}
		
		private function show(pBln:Boolean = true):void {
			DisplayManage.get_Main().visible = pBln;
		}
		
		public function play():void {
			show(true);
		}
		
		public function next():void {
			show(false);
		}
		
	}

}