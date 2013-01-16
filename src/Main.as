package 
{
	import com.xskip.game.rainbow.StarlingMain;
	import flash.desktop.NativeApplication;
	import flash.display.StageOrientation;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.TimerEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.getDefinitionByName;
	import flash.utils.Timer;
	
	import com.yxg.display.StageInfo;
	
	/**
	 * 2013-01-14
	 * @author XIEJ
	 */
	//[SWF(width="1024",height="512",frameRate="60",backgroundColor="#2f2f2f")]
	public class Main extends Sprite 
	{
		
		private var _timer:Timer;
		
		public function Main():void 
		{
			if (stage) {
				start();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, start);
			}
		}
		
		private function start(e:Event = null):void {
			if (hasEventListener(Event.ADDED_TO_STAGE)) {
				removeEventListener(Event.ADDED_TO_STAGE, init);
			}
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			//关闭程序
			//stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			StageInfo.STAGE = stage;
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// entry point
			// new to AIR? please read *carefully* the readme.txt files!
			
			init();
			
			_timer = new Timer(1000, 1);
			_timer.addEventListener(TimerEvent.TIMER, next);
			_timer.start();
		}
		
		private function init():void
		{
			//stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			trace("Before Event stage.fullScreenWidth " + stage.fullScreenWidth + " stage.fullScreenHeight " + stage.fullScreenHeight);
			trace("Before Event stage.stageWidth " + stage.stageWidth + " stage.stageHeight " + stage.stageHeight);
			stage.addEventListener(Event.RESIZE, stageResize);
			
			try {
				//手机版本屏幕旋转
				stage.setOrientation(StageOrientation.ROTATED_RIGHT);
			}catch (e:Error) {
				//浏览器版本
				trace("浏览器版本 无屏幕旋转事件");
			}
			
			trace("Hello World");
			var fSP:Sprite = new Sprite();
			fSP.graphics.beginFill(0xFF0000);
			fSP.graphics.drawRect(0, 0, 10, 1);
			fSP.graphics.endFill();
			fSP.x = 0;
			fSP.y = 0;
			this.addChild(fSP);
		}
		
		private function next(e:TimerEvent):void
		{
			if (_timer.hasEventListener(TimerEvent.TIMER)) {
				_timer.removeEventListener(TimerEvent.TIMER, next);
			}
			if (_timer.running) {
				_timer.stop();
			}
			_timer = null;
			
			startStarling();
		}
		
		private function stageResize(e:Event):void
		{
			removeEventListener(Event.RESIZE, stageResize);
			
			trace("RESIZE EVENT --");
			//trace("After resize stage.fullScreenWidth " + stage.fullScreenWidth + " stage.fullScreenHeight " + stage.fullScreenHeight);
			//trace("After resize stage.stageWidth " + stage.stageWidth + " stage.stageHeight " + stage.stageHeight);
			
			StageInfo.WIDTH = stage.stageWidth;
			StageInfo.HEIGHT = stage.stageHeight;
			
			//game.rander();
		}
		
		private function startStarling():void {
			trace("startStarling");
			
			var fStarlingMain:StarlingMain = new StarlingMain();
		}
		
		private function deactivate(e:Event):void 
		{
			// auto-close
			//NativeApplication.nativeApplication.exit();
			try
			{
				//AIR版本
				var myClass:Class = getDefinitionByName("flash.desktop.NativeApplication") as Class;
				myClass.nativeApplication.exit();
				//nativeApplication.addEventListener(Event.DEACTIVATE, deactivateHandler);
				//nativeApplication.addEventListener(Event.ACTIVATE, activateHandler);	
				//nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			}catch (e:Error) {
				//浏览器版本
				trace("浏览器版本 关闭事件");
			}
		}
		
	}
	
}