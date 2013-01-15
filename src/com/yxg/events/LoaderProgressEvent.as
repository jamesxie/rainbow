package com.yxg.events {
	import flash.events.Event;	

	public class LoaderProgressEvent extends Event
	{
		public static const ADDED:String="added";
		
		public static const PROGRESS:String="progress";
		
		public static const REMOVED:String="removed";
		
		public var index:uint;
		
		public var label:String;
		
		public var progress:uint;
				
		public function LoaderProgressEvent(type:String,index:uint,label:String="",progress:uint=0,bubbles:Boolean=false,cancelable:Boolean=false){
			super(type,bubbles,cancelable);
			this.index=index;
			this.label=label;
			this.progress=progress;
		}
		
		override public function clone():Event{
			return new LoaderProgressEvent(this.type,this.index,this.label,this.progress,this.bubbles,this.cancelable);
		}
	}
}