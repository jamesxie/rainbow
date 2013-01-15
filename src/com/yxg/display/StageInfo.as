package com.yxg.display {
	import com.yxg.log4f.Logger;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Rectangle;	

	/**
	 * @author JamesXie
	 * @version 1.0
	 * @date Dec 16, 2009
	 * @name StageInfo 
	 */
	public class StageInfo {

		public static const PW:int = 1000;
		public static const PH:int = 600;
		
		public static var WIDTH : int = 1000;
		public static var HEIGHT : int = 600;
		
		public static var _stage : Stage;
		private static var _root:Sprite;
		
		public static function set STAGE(sta:Stage):void {
			_stage = sta;
			if (_root) {
				Logger.ERROR(StageInfo, "found STAGE error, _root exist");
			}else {
				_root = new Sprite();
				_stage.addChild(_root);
			}
		}
		
		public static function get STAGE():Stage {
			return _stage;
		}
		
		public static function set ROOT(sp:Sprite):void {
			_root = sp;
		}
		
		public static function get ROOT():Sprite {
			if (!_root) {
				Logger.ERROR(StageInfo, "found ROOT error, _root exist");
			}
			return _root;
		}
		
		public static function get STAGERECT():Rectangle {
			
			return new Rectangle(0, 0, WIDTH, HEIGHT)
			
		}
		
		public static function getOffsetWidth():int {
			
			return WIDTH - PW;
			
		}
		public static function getOffsetHeight():int {
			
			return HEIGHT - PH;
			
		}

		//public static var STAGERECT : Rectangle = new Rectangle(0, 0, WIDTH, HEIGHT);
	}
}