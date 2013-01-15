package com.yxg.net {
	import flash.events.Event;	

	/**
	 * @author com
	 * @version Version 1.00
	 * Date	2008-10-01
	 */
	public class XMLLoader extends RESLoader
	{
		private var _xml:XML;
		
		override protected function onComplete():void{
			this._xml=XML(this._byteArray.readUTFBytes(this._byteArray.length));
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function XMLLoader(url:String,key:String=null,label:String=null){
			super(url,key,label);
		}
		
		public function getXML():XML{
			return this._xml;
		}
	}
}