package com.yxg.net {
	import com.yxg.log4f.Logger;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;		

	/**
	 * @author com
	 * @version Version 1.00
	 * Date	2008-10-01
	 */
	public class RSLLoader extends RESLoader{
		
		private var _loader:Loader;
		
		//James add
		private var _bytes : ByteArray;

		override protected function onComplete():void{
			this._loader=new Loader();
			this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.completeHandler);
			var context:LoaderContext=new LoaderContext(false,ApplicationDomain.currentDomain);
			this._loader.loadBytes(this._bytes,context);
			Logger.INFO(this,"loadBytes "+this._url);
		}
		
		private function completeHandler(event:Event):void{
			Logger.INFO(this,this._url+" load done.");
			this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.completeHandler);
			this._isLoadding=false;
			this._isLoaded=true;
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function RSLLoader(url:String,key:String=null,label:String=null){
			super(url,key,label);
		}
	}
}