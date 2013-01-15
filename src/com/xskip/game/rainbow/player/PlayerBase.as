package com.xskip.game.rainbow.player 
{
	import starling.display.Sprite;
	/**
	 * ...
	 * @author XIEJ
	 */
	public class PlayerBase extends Sprite
	{
		private var _key:String;
		private var _name:String;
		private var _type:String;
		
		public function PlayerBase() 
		{
			init();
		}
		
		public function init():void {
			
		}
		
		public function set playerKey(p:String):void {
			_key = p;
		}
		
		public function get playerKey():String {
			return _key;
		}
		
		public function set playerName(p:String):void {
			_name = p;
		}
		
		public function get playerName():String {
			return _name;
		}
		
		public function set playerType(p:String):void {
			_type = p;
		}
		
		public function get playerType():String {
			return _type;
		}
		
		public function clear():void {
			
		}
		
	}

}