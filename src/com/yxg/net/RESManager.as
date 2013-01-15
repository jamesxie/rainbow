package com.yxg.net {
	import com.yxg.log4f.LogError;
	import com.yxg.log4f.Logger;
	import com.yxg.utils.DictionaryUtil;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;	

	/**
	 * @author com
	 * @version Version 1.00
	 * Date	2008-10-01
	 */
	public class RESManager extends EventDispatcher {
		private static var _creating : Boolean = false;

		private static var _instance : RESManager;

		private var _list : Array;

		private var _wait : Dictionary;

		private var _loaded : Dictionary;

		private var _loadingModel : LoadingModel;

		private var _startTime : int;

		private function init() : void {
			this._list = new Array();
			this._loaded = new Dictionary();
			this._wait = new Dictionary();
			this._loadingModel = new LoadingModel();
		}

		private function loadNext() : void {
			var resLoader : IRESLoader;
			while(this._loadingModel.hasFree()) {
				if(this._list.length == 0)return;
				resLoader = IRESLoader(this._list.shift());
				this._loadingModel.add(resLoader);
				resLoader.addEventListener(Event.COMPLETE, this.onRESLoaderComplete);
				resLoader.load();
			}
		}

		private function onRESLoaderComplete(event : Event) : void {
			var resLoader : IRESLoader = IRESLoader(event.currentTarget);
			resLoader.removeEventListener(Event.COMPLETE, this.onRESLoaderComplete);
			this._loadingModel.remove(resLoader);
			delete this._wait[resLoader.getKey()];
			if(resLoader.isLoaded)this._loaded[resLoader.getKey()] = resLoader;
			if(this._list.length > 0) {
				this.loadNext();
			}else if (DictionaryUtil.isEmpty(this._wait)) {
				//全部资源加载完毕
				//Logger.INFO(this, "RESManager load done." + String(getTimer() - this._startTime));
				this.dispatchEvent(new Event(Event.COMPLETE));
			}
		}

		public function RESManager() {
			if(!RESManager._creating) {
				throw (new LogError("Class cannot be instantiated.Use getInstance() instead."));
			}
			this.init();
		}

		public static function getInstance() : RESManager {
			if(RESManager._instance == null) {
				RESManager._creating = true;
				RESManager._instance = new RESManager();
				RESManager._creating = false;
			}
			return RESManager._instance;
		}

		public function isLoaded(key : String) : Boolean {
			return this._loaded[key] != null;
		}

		/**
		 * 加入资源加载器到加载队列中
		 * @param resLoader IRESLoader
		 * @return true  加入加载队列成功
		 *         false 加入加载队列失败
		 */
		public function add(resLoader : IRESLoader) : Boolean {
			var key : String = resLoader.getKey();
			if(resLoader.isLoaded) {
				this._loaded[key] = resLoader;
				return false;
			}
			if(this._loaded[key] != null)return false;
			if(this._wait[key] != null)return false;
			this._list.push(resLoader);
			this._wait[key] = resLoader;
			return true;
		}

		public function get model() : LoadingModel {
			return this._loadingModel;
		}

		public function load() : void {
			if(this._list.length == 0)return;
			this._startTime = getTimer();
			this.loadNext();
		}

		public function setLoaded(resLoader : IRESLoader) : void {
			if(!resLoader.isLoaded)return;
			this._loaded[resLoader.getKey()] = resLoader;
		}

		public function getRESLoader(key : String) : RESLoader {
			var resLoader : RESLoader = this._loaded[key] as RESLoader;
			if(resLoader == null)throw new LogError(this, key + " definition not find!");
			return resLoader;
		}

		public function getPNGLoader(key : String) : PNGLoader {
			var pngLoader : PNGLoader = this._loaded[key] as PNGLoader;
			if(pngLoader == null)throw new LogError(this, key + " definition not find!");
			return pngLoader;
		}

		public function getSWFLoader(key : String) : SWFLoader {
			var swfLoader : SWFLoader = this._loaded[key] as SWFLoader;
			if(swfLoader == null)throw new LogError(this, key + " definition not find!");
			return swfLoader;
		}

		public function getLIBLoader(key : String) : LIBLoader {
			var libLoader : LIBLoader = this._loaded[key] as LIBLoader;
			if(libLoader == null)throw new LogError(this, key + " definition not find!");
			return libLoader;
		}
	}
}