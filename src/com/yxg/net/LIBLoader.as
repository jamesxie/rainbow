package com.yxg.net {
	import com.yxg.lib.LIBDecoder;
	
	import flash.events.Event;	

	/**
	 * @author com
	 * @version Version 1.00
	 * Date	2008-10-01
	 */
	public class LIBLoader extends RESLoader
	{
		private var _libDecoder:LIBDecoder;
		
		override protected function onComplete():void{
			this._libDecoder=new LIBDecoder(this._byteArray);
			this._libDecoder.addEventListener(Event.COMPLETE,this.onLIBDecoderComplete);
		}
		
		private function onLIBDecoderComplete(event:Event):void{
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function LIBLoader(url:String,key:String=null,label:String=null){
			super(url,key,label);
		}
		
		public function getDecoder():LIBDecoder{
			return this._libDecoder;
		}
	}
}