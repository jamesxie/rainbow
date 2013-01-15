package com.yxg.net {
	import com.yxg.events.LoaderProgressEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;	

	/**
	 * @author com
	 * @version Version 1.00
	 * Date	2008-10-01
	 */
	public class LoadingModel extends EventDispatcher {
		public static const MAX : int = 5;

		private var _list : Array;

		private function progressHandler(event : ProgressEvent) : void {
			var resLoader : RESLoader = RESLoader(event.currentTarget);
			var index : uint = this._list.indexOf(resLoader);
			var label : String = "loading " + resLoader.getLabel() + "... ";
			label += int(event.bytesLoaded / 1024) + "KB/" + int(event.bytesTotal / 1024) + "KB";
			var progress : uint = Math.round(event.bytesLoaded / event.bytesTotal * 100);
			this.dispatchEvent(new LoaderProgressEvent(LoaderProgressEvent.PROGRESS, index, label, progress));
		}

		public function LoadingModel() {
			this._list = new Array();
		}

		public function hasFree() : Boolean {
			return this._list.length < MAX;
		}

		public function add(resLoader : IRESLoader) : void {
			if(this._list.length == MAX)return;
			var index : uint = this._list.push(resLoader) - 1;
			resLoader.addEventListener(ProgressEvent.PROGRESS, this.progressHandler);
			var label : String = "loading " + resLoader.getLabel() + "... ";
			this.dispatchEvent(new LoaderProgressEvent(LoaderProgressEvent.ADDED, index, label));
		}

		public function remove(resLoader : IRESLoader) : void {
			resLoader.removeEventListener(ProgressEvent.PROGRESS, this.progressHandler);
			var index : uint = this._list.indexOf(resLoader);
			this._list.splice(index, 1);
			this.dispatchEvent(new LoaderProgressEvent(LoaderProgressEvent.REMOVED, index));
		}
	}
}