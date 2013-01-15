package com.yxg.log4f {
	import fl.controls.Button;
	import fl.controls.CheckBox;
	import fl.controls.ComboBox;
	import fl.controls.TextArea;
	import fl.controls.TextInput;
	import fl.data.SimpleCollectionItem;
	
	import com.yxg.log4f.Level;
	import com.yxg.log4f.LogCookie;
	import com.yxg.log4f.Logger;
	import com.yxg.mgcity.assetcenter.alert.alert;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;	

	/**
	 * @author JamesXie
	 * @version 1.0
	 * @date 2009-3-10
	 * @name ClassName
	 */
	public class LogDebugView extends Sprite {
		private var logger : Logger;

		private var _txtLogger : TextArea;

		private var _selectFilter : ComboBox;

		//private var _btnFilter : Button;

		private var _selectScroll : CheckBox;

		private var _btnClear : Button;

		private var _selectLevel : ComboBox;

		private var _inputLog : TextInput;

		private var _btnAddLog : Button;

		private var _timer : Timer;

		private var _updateDate : String;
		private var _blnScroll : Boolean;

		public function LogDebugView() : void {
			logger = new Logger();
			logger.setName("LogDebugView");
			logger.setLevel(Level.ALL);
			logger.setDebugTools(true);
			init();
		}

		private function init() : void {
			this.addEventListener(Event.ADDED_TO_STAGE, addStageHandler);
		}

		private function addStageHandler(e : Event) : void {
			dataInit();
			configMc();
			autoStart();
		}

		private function dataInit() : void {
			_updateDate = "";
			_blnScroll = false;
		}

		private function configMc() : void {
			_txtLogger = TextArea(this.getChildByName("txtLogger"));
			
			_selectFilter = ComboBox(this.getChildByName("selectFilter"));
			//_btnFilter = Button(this.getChildByName("btnFilter"));
			_selectScroll = CheckBox(this.getChildByName("selectScroll"));
			_btnClear = Button(this.getChildByName("btnClear"));
			
			_selectLevel = ComboBox(this.getChildByName("selectLevel"));
			_inputLog = TextInput(this.getChildByName("inputLog"));
			_btnAddLog = Button(this.getChildByName("btnAddLog"));
			
			_selectScroll.addEventListener(MouseEvent.CLICK, scrollHandler);
			
			
			_btnClear.addEventListener(MouseEvent.CLICK, clearHandler);
			_btnAddLog.addEventListener(MouseEvent.CLICK, AddLogHandler);
			//_selectFilter.addEventListener(Event.CHANGE, selFilterChangeHandler);
		}

		private function scrollHandler(e : MouseEvent) : void {
			//trace(CheckBox(e.target).selected);
			if (CheckBox(e.target).selected) {
				_blnScroll = true;
			}else {
				_blnScroll = false;
			}	
		}

		private function clearHandler(e : MouseEvent) : void {
			_txtLogger.text = "";
		}

		private function AddLogHandler(e : MouseEvent) : void {
			var fStr : String;
			var fMessage : String;
			fMessage = _inputLog.text;
			fStr = SimpleCollectionItem(_selectLevel.selectedItem).data;
			if (fMessage != "") {
				//trace(fStr);
				switch(fStr) {
					case "0":
						logger.debug(fMessage);
						break;
					case "1":
						logger.debug(fMessage);
						break;
					case "2":
						logger.info(fMessage);
						break;
					case "3":
						logger.warn(fMessage);
						break;
					case "4":
						logger.error(fMessage);
						break;
					case "5":
						logger.fatal(fMessage);
						break;
					case "6":
						//alert("[OFF]");
						break;
					default:
				}
				_inputLog.text = "";
				//_txtLogger.text += fMessage + "\n";
				/*if (_blnScroll) {
					_txtLogger.verticalScrollPosition = _txtLogger.maxVerticalScrollPosition;
				}else {
					//_txtLogger.verticalScrollPosition = 1;
				}*/
			}
		}

		/*private function selFilterChangeHandler(e : Event) : void {
			//trace(_selectFilter.selectedItem);
			//trace(_selectFilter.selectedLabel);
		}*/

		public function autoStart() : void {
			//trace("-----------1");
			_timer = new Timer(50);
			_timer.addEventListener(TimerEvent.TIMER, timerHandler);
			_timer.start();
		}

		private function timerHandler(e : TimerEvent) : void {
			var fArr : Array = new Array();
			var fStr : String;
			fStr = SimpleCollectionItem(_selectLevel.selectedItem).data;
			var fBlnAllow : Boolean = false;
			fArr = LogCookie.getLog();
			//trace(_updateDate+" -- "+fArr[0]);
			if (_updateDate != fArr[0]) {
				//trace("----增加内容");
				_updateDate = fArr[0];
				if (int(fArr[1]) >= int(SimpleCollectionItem(_selectFilter.selectedItem).data)) {
					fBlnAllow = true;
				}
				if (fBlnAllow) {
					_txtLogger.text += fArr[2] + "\n";
					if (_blnScroll) {
						_txtLogger.verticalScrollPosition = _txtLogger.maxVerticalScrollPosition;
					}else {
					//_txtLogger.verticalScrollPosition = 1;
					}
				}
			}
		}

		public function configParam() : void {
		}

		public function start() : void {
		}

		public function clear() : void {
		}
	}
}