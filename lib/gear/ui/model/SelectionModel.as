﻿package gear.ui.model {
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * SelectionModel 选择模型
	 * 
	 * @author bright
	 * @version 20100114
	 */
	public class SelectionModel extends EventDispatcher {
		private var _index : int;

		public function SelectionModel() {
			_index = -1;
		}

		public function set index(value : int) : void {
			if (_index == value) {
				return;
			}
			_index = value;
			dispatchEvent(new Event(Event.CHANGE));
		}

		public function get index() : int {
			return _index;
		}

		public function get isSelected() : Boolean {
			return _index != -1;
		}
	}
}