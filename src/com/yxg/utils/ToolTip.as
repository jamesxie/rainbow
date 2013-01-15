package com.yxg.utils {

	/**
	 * JamesXie
	 * @date 2008-12-18
	 * @version 1.0
	 */
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.text.*;
	import flash.utils.Timer;		

	public class ToolTip extends Sprite {

		private static var _instance : ToolTip;
		private static var _DELAY_TIME : Number = 500;

		private var _label : TextField;
		private var _delayTimer : Timer;
		private var _showMessage : String;

		public function ToolTip(base : DisplayObjectContainer = null) {
			super();
			_label = new TextField();
			_label.autoSize = TextFieldAutoSize.LEFT;
			_label.textColor = 0x333333;
			_label.text = " ";
			_label.selectable = false;
			_label.x = 3;
			_label.y = 2;
			_label.mouseEnabled = false;
			this.addChild(_label);
			filters = [getBitmapFilter()];
			this.alpha = 0.9;
			if (base != null) {
				base.addChild(this);
			}else {
				stage.addChild(this);
			}
			_instance = this;
			_hide();
		}

		public static function show(str : String) : void {
			if (_instance == null) {
				return;
			}
			
			_instance._showMessage = str;
			/*_instance._delayTimer = new Timer(_DELAY_TIME, 1);
			_instance._delayTimer.addEventListener(TimerEvent.TIMER, delayTimerHandler);
			_instance._delayTimer.start();*/

			_instance._show(_instance._showMessage);
		}

		//其中进行了范围限制
		public static function  delayTimerHandler(e : TimerEvent) : void {
			_instance._show(_instance._showMessage);
		}

		public function _show(lbl : String) : void {
			visible = true;
			//_label.htmlText = lbl;
			_label.text = lbl;
			updateShape();
		}

		public static function hide() : void {
			if (_instance == null) {
				return;
			}
			/*_instance._delayTimer.removeEventListener(TimerEvent.TIMER, delayTimerHandler);
			_instance._delayTimer.stop();*/
			_instance._hide();
		}	

		public function _hide() : void {
			visible = false;
		}

		public static function move(x : Number, y : Number) : void {
			if (_instance == null) {
				return;
			}
			_instance._move(x, y);
		}

		public function _move(x : Number, y : Number) : void {
			this.x = (x + this.width > stage.stageWidth) ? stage.stageWidth - this.width : x;
			this.y = y - this.height;
		}

		/**
		 * 设置延迟时间
		 * @param time 时间间隔
		 */
		public static function setDelayTime(time : Number) : void {
			_instance._delayTimer.delay = _DELAY_TIME = time;
		}

		public function changeHandler(event : Event) : void {
			updateShape();
		}

		private function updateShape() : void {
			var w : Number = _label.textWidth + 8;			
			var h : Number = 23;
			graphics.clear();
			graphics.beginFill(0x333333);
			graphics.drawRoundRect(0, 0, w, h, 7, 7);
			graphics.endFill();
			graphics.beginFill(0xFFFFE1);
			graphics.drawRoundRect(1, 1, w - 2, h - 2, 7, 7);
			graphics.endFill();
		}

		private function getBitmapFilter() : BitmapFilter {
			var color : Number = 0x333333;
			var alpha : Number = 0.3;
			var blurX : Number = 5;
			var blurY : Number = 5;
			var strength : Number = 2;
			var inner : Boolean = false;
			var knockout : Boolean = false;
			var quality : Number = BitmapFilterQuality.HIGH;

			return new GlowFilter(color, alpha, blurX, blurY, strength, quality, inner, knockout);
		}	
	}
}