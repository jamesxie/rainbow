package com.yxg.net {
	import com.yxg.log4f.Logger;
	
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;	

	//import flash.display.BitmapData;

	/**
	 * @author com
	 * @version Version 1.00
	 * Date	2008-10-01
	 */
	public class SWFLoader extends RESLoader {
		private var _loader : Loader;
		private var _domain : ApplicationDomain;

		override protected function onComplete() : void {
			this._loader = new Loader();
			var ldrContext : LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			
			//XIEJ for AIR2.0
			ldrContext.allowCodeImport = true;
			
			this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.completeHandler);
			this._loader.loadBytes(this._byteArray, ldrContext);
		}

		public function getApplicationDomain() : ApplicationDomain {
			return LoaderInfo(_loader).applicationDomain;
		}

		private function completeHandler(event : Event) : void {
			//Logger.INFO(this, this._url + " load done.");
			this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.completeHandler);
			this._domain = LoaderInfo(event.currentTarget).applicationDomain;
			this._isLoadding = false;
			this._isLoaded = true;
			this.dispatchEvent(new Event(Event.COMPLETE));
		}

		public function SWFLoader(url : String,key : String = null,label : String = null) {
			//alert("[SWFLoader] url " + url);
			super(url, key, label);
		}

		public function getSWF() : Loader {
			return this._loader;
		}

		public function getLoader() : Loader {
			return this._loader;
		}

		public function getClass(className : String) : Class {
			if(!this._domain.hasDefinition(className)) {
				Logger.ERROR(this, className + " definition not find in " + this._url);
				return null;
			}
			var assetClass : Class = this._domain.getDefinition(className) as Class;
			return assetClass;
		}

		public function getObject(className : String) : Object {
			if(!this._domain.hasDefinition(className)) {
				Logger.ERROR(this, className + " definition not find in " + this._url);
				return null;
			}
			var assetObject : Object = this._domain.getDefinition(className) as Object;
			return assetObject;
		}

		public function getMovieClip(className : String) : MovieClip {
			var assetClass : Class = this.getClass(className);
			if(assetClass == null)return null;
			var mc : MovieClip = new assetClass() as MovieClip;
			if(mc == null)Logger.ERROR(this, className + " isn't a MovieClip in " + this._url);
			return mc;
		}

		public function getSprite(className : String) : Sprite {
			var assetClass : Class = this.getClass(className);
			if(assetClass == null)return null;
			var sp : Sprite = new assetClass() as Sprite;
			if(sp == null)Logger.ERROR(this, className + " isn't a Sprite in " + this._url);
			return sp;
		}

		public function getBitmapData(className : String) : BitmapData {
			var assetClass : Class = this.getClass(className);
			if(assetClass == null)return null;
			var mc : BitmapData = new assetClass(0, 0) as BitmapData;
			if(mc == null)Logger.ERROR(this, className + " isn't a BitmapData in " + this._url);
			return mc;
		}
	}
}