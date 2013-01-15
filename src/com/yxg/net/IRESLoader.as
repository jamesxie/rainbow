package com.yxg.net {
	import flash.events.IEventDispatcher;	

	/**
	 * @author com
	 * @version Version 1.00
	 * Date	2008-10-01
	 */
	public interface IRESLoader extends IEventDispatcher{
		function getKey():String;
		function getLabel():String;
		function load():void;
		function get isLoaded():Boolean;
	}
}