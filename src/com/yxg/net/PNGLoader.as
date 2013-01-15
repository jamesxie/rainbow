package com.yxg.net {
	import com.yxg.log4f.Logger;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;	

	/**
	 * @author com
	 * @version Version 1.00
	 * Date	2008-10-01
	 */
	public class PNGLoader extends RESLoader {
		private var _loader : Loader;

		//private var _pngDecoder : PNGDecoder;

		override protected function onComplete() : void {
			//var lc:LoaderContext = new LoaderContext(false);
			this._loader = new Loader();
			this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.completeHandler);
			this._loader.loadBytes(this._byteArray);
		}

		private function completeHandler(event : Event) : void {
			Logger.INFO(this, this._url + " load done.");
			this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.completeHandler);
			this._isLoadding = false;
			this._isLoaded = true;
			this.dispatchEvent(new Event(Event.COMPLETE));
		}

		public function PNGLoader(url : String,key : String = null,label : String = null) {
			super(url, key, label);
		}

		public function getLoader() : Loader {
			return this._loader;
		}

		public function getBitmapData() : BitmapData {
			var bitmap : Bitmap = this._loader.contentLoaderInfo.content as Bitmap;
			return (bitmap == null) ? null : bitmap.bitmapData;
		}
	}
}