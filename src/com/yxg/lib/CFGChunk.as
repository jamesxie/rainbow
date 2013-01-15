package com.yxg.lib {
	import flash.events.Event;
	import flash.utils.ByteArray;	

	public class CFGChunk extends LIBChunk
	{
		private var _list:Array;
		
		public function CFGChunk(key:String){
			super(key,LIBChunk.CFG);
			this._list=new Array();
		}
		
		public function add(item:Object):void{
			this._list.push(item);
		}
		
		public function encode():ByteArray{
			this._data=new ByteArray();
			for each(var item:Object in this._list){
				this._data.writeObject(item);
			}
			this._data.compress();
			return this._data;
		}
		
		override public function decode():void{
			this._list=new Array();
			this._data.uncompress();
			this._data.position=0;
			while(this._data.position<this._data.length){
				this._list.push(this._data.readObject());
			}
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get list():Array{
			return this._list;
		}
	}
}