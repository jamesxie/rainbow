package com.yxg.net {
	import com.yxg.log4f.Logger;
	import com.yxg.utils.DictionaryUtil;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	/**
	 * @author com
	 * @version Version 1.00
	 * Date	2008-10-01
	 */
	public class RESGroup extends EventDispatcher {
		private var _name : String = "";

		private var _resManager : RESManager;//

		private var _list : Array;

		private var _keys : Array;

		private var _wait : Dictionary;

		private function onRESLoaderComplete(event : Event) : void {
			var resLoader : IRESLoader = IRESLoader(event.currentTarget);
			resLoader.removeEventListener(Event.COMPLETE, this.onRESLoaderComplete);
			delete this._wait[resLoader.getKey()];
			this._resManager.setLoaded(resLoader);
			if(DictionaryUtil.isEmpty(this._wait)) {
				Logger.INFO(this, "RESGroup load done.");
				this.dispatchEvent(new Event(Event.COMPLETE));
			}
		}

		public function RESGroup(name : String = "") {
			this._name = name;
			this._resManager = RESManager.getInstance();
			this._keys = new Array();
			this._list = new Array();
			this._wait = new Dictionary();
		}

		public function add(resLoader : IRESLoader) : void {
			if(!this._resManager.add(resLoader))return;
			this._keys.push(resLoader.getKey());
			this._list.push(resLoader);
			this._wait[resLoader.getKey()] = resLoader;
		}

		public function addList(list : Array) : void {
			for each(var resLoader:IRESLoader in list) {
				this.add(resLoader);
			}
		}

		public function get name() : String {
			return this._name;
		}

		public function getTotal() : uint {
			return this._list.length;
		}
		
		public function getKeys() : Array {
			return this._keys;
		}
		
		public function load() : void {
			if(this._list.length == 0)return;
			for each(var resLoader:IRESLoader in this._list) {
				resLoader.addEventListener(Event.COMPLETE, this.onRESLoaderComplete);
			}
			this._resManager.load();
		}
	}
}