package 
{
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
	
	/**
	 * ...
	 * @author XIEJ
	 */
	public class Main extends Sprite 
	{
		
		private var _timer:Timer;
		
		public function Main():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
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
			
			try
			{
				//手机版本屏幕旋转
				stage.setOrientation(StageOrientation.ROTATED_RIGHT);
			}
			catch (e:Error)
			{
				//浏览器版本
				trace("浏览器版本 无屏幕旋转事件");
			}
			
			trace("Hello World");
			var fSP:Sprite = new Sprite();
			fSP.graphics.beginFill(0xFF0000);
			fSP.graphics.drawRect(0, 0, 50, 10);
			fSP.graphics.endFill();
			fSP.x = 10;
			fSP.y = 10;
			this.addChild(fSP);
		}
		
		private function next(e:TimerEvent):void
		{
			if (_timer.hasEventListener(TimerEvent.TIMER))
			{
				_timer.removeEventListener(TimerEvent.TIMER, next);
			}
			if (_timer.running)
			{
				_timer.stop();
			}
			_timer = null;
			
			startStarling();
		}
		
		private function stageResize(e:Event):void
		{
			removeEventListener(Event.RESIZE, stageResize);
			
			trace("RESIZE EVENT");
			trace("After resize stage.fullScreenWidth " + stage.fullScreenWidth + " stage.fullScreenHeight " + stage.fullScreenHeight);
			trace("After resize stage.stageWidth " + stage.stageWidth + " stage.stageHeight " + stage.stageHeight);
			
			//StageInfo.WIDTH = stage.stageWidth;
			//StageInfo.HEIGHT = stage.stageHeight;
		
		}
		
		private function startStarling():void {
			trace("startStarling");
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
			}
			catch (e:Error)
			{
				//浏览器版本
				trace("浏览器版本 关闭事件");
			}
		}
		
	}
	
}