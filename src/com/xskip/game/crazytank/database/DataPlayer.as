package com.xskip.game.crazytank.database 
{
	/**
	 * ...
	 * @author JamesXie
	 */
	public class DataPlayer
	{
		private var _id:int;
		
		private var _exp:int;
		
		private var _name:String;
		private var _level:int;
		
		private var _gold:int;
		
		private var _hp:int;
		
		//暂时无用
		private var _hpMax:int;
		
		private var _mp:int;
		private var _act:int;
		private var _def:int;
		private var _mgc:int;
		private var _mgcdef:int;
		
		public function DataPlayer() 
		{
			init();
		}
		
		private function init():void {
			_name = "黑旗统领";
			_level = 0;
			
			_hp = 100;
			_hpMax = 100;
			_mp = 50;
			_act = 30;
			_def = 10;
			_mgc = 50;
			_mgcdef = 0;
			
			_exp = 0;
		}
		
		public function set id(num:int):void {
			_id = num;
		}
		
		public function get id():int {
			return _id;
		}
		
		public function set exp(num:int):void {
			_exp = num;
		}
		
		public function get exp():int {
			return _exp;
		}
		
		public function set name(str:String):void {
			_name = str;
		}
		
		public function get name():String {
			return _name;
		}
		
		public function set level(num:int):void {
			_level = num;
		}
		
		public function get level():int {
			return _level;
		}
		
		public function set gold(num:int):void {
			_gold = num;
		}
		
		public function get gold():int {
			return _gold;
		}
		
		public function set hp(num:int):void {
			_hp = num;
		}
		
		public function get hp():int {
			return _hp;
		}
		
		public function set hpMax(num:int):void {
			_hpMax = num;
		}
		
		public function get hpMax():int {
			return _hpMax;
		}
		
		public function set mp(num:int):void {
			_mp = num;
		}
		
		public function get mp():int {
			return _hp;
		}
		
		public function set act(num:int):void {
			_act = num;
		}
		
		public function get act():int {
			return _act;
		}
		
		public function set def(num:int):void {
			_def = num;
		}
		
		public function get def():int {
			return _def;
		}
		
		public function set mgc(num:int):void {
			_mgc = num;
		}
		
		public function get mgc():int {
			return _mgc;
		}
		
		public function set mgcdef(num:int):void {
			_mgcdef = num;
		}
		
		public function get mgcdef():int {
			return _mgcdef;
		}
		
		
	}

}