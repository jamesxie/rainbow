package com.xskip.game.rainbow.display {

	import com.xskip.game.rainbow.database.GlobalData;
	import com.yxg.display.StageInfo;
	import flash.display.Sprite;
	//import net.hires.utils.Stats;

	/**
	 * @author JamesXie
	 * @version 1.0
	 * @date Jul 16, 2009
	 * @name 显示管理
	 */
	public class DisplayManage {
		private static var __Instance : DisplayManage;
		
		//Welcome界面层
		private var _SP_WELCOME : Sprite;
		//载入层
		private var _SP_LOADING : Sprite;
		//主场景层
		//private var _SP_TOWN : Sprite;
		//调试层
		private var _SP_DEBUG : Sprite;
		//鼠标指针层
		private var _SP_MOUSE_CURSOR : Sprite;
		
		
		//地图层索引
		private var _sp_map_index:int;
		
		public function DisplayManage(e : Enforce) : void {
			if ( e == null ) {
				throw new Error("This is singleton instance class,please use getInstance()!");
			}
			init();
		}

		private static function getInstance() : DisplayManage {
			if(DisplayManage.__Instance == null) {
				DisplayManage.__Instance = new DisplayManage(new Enforce());
			}
			return DisplayManage.__Instance;
		}

		private function init() : void {
			
			if (!GlobalData.GAME_WORLD) {
				trace("[ERROR] DisplayManage : Starling stage object undefined");
				return;
			}
			
			dataInit();
		}

		private function dataInit() : void {
			
			_SP_WELCOME = new Sprite();
			_SP_LOADING = new Sprite();
			//_SP_TOWN = new Sprite();
			_SP_DEBUG = new Sprite();
			_SP_MOUSE_CURSOR = new Sprite();
			
			_SP_LOADING.buttonMode = false;
			_SP_LOADING.mouseEnabled = false;
			_SP_LOADING.mouseChildren = false;
			
			_SP_MOUSE_CURSOR.buttonMode = false;
			_SP_MOUSE_CURSOR.mouseEnabled = false;
			_SP_MOUSE_CURSOR.mouseChildren = false;
			
			_sp_map_index = 0;
			
			
			try {
				var fSP:Sprite = new Sprite();
				
				StageInfo.STAGE.addChild(fSP);
				
				StageInfo.ROOT = fSP;
				
				
				//trace("GlobalData.GAME_WORLD.root = " + GlobalData.GAME_WORLD.root);
				
				//GlobalData.GAME_WORLD.root.stage.addChild(_SP_WELCOME);
				
				StageInfo.ROOT.addChild(_SP_WELCOME);
				
				//_sp_map_index = GlobalData.GAME_WORLD.root.stage.getChildIndex(_SP_WELCOME);
			}catch (e : Error) {
				throw new Error(e.message);
			}
			
			//GlobalData.GAME_WORLD.root.stage.addChild(_SP_WELCOME);
			StageInfo.ROOT.addChild(_SP_LOADING);
			//StageInfo.ROOT.addChild(_SP_TOWN);
			StageInfo.ROOT.addChild(_SP_DEBUG);
			StageInfo.ROOT.addChild(_SP_MOUSE_CURSOR);
			
			//StageInfo.ROOT.addChild(new Stats());
			
			/*
			//map tiles begin
			_SP_MAP.addChild(_SP_MAP_TILES);
			//map tiles end
			_SP_MAP.addChild(_SP_BACK_MAP);
			_SP_MAP.addChild(_SP_BACK_EFFECT);
			_SP_MAP.addChild(_SP_HUMAN);
			_SP_MAP.addChild(_SP_EFFECT);
			_SP_MAP.addChild(_SP_EFFECT2);
			_SP_MAP.mouseChildren = true;
			_SP_MAP_TILES.mouseEnabled = true;
			//效果层 没有鼠标事件
			_SP_BACK_EFFECT.mouseChildren = false;
			_SP_BACK_EFFECT.mouseEnabled = false;
			_SP_BACK_EFFECT.buttonMode = false;
			*/
		}
		
		
		private function get_SP_WELCOME() : Sprite {
			return _SP_WELCOME;
		}
		private function get_SP_LOADING() : Sprite {
			return _SP_LOADING;
		}
		
		/*private function get_SP_TOWN() : Sprite {
			return _SP_TOWN;
		}*/
		
		private function get_SP_DEBUG() : Sprite {
			return _SP_DEBUG;
		}
		private function get_SP_MOUSE_CURSOR() : Sprite {
			return _SP_MOUSE_CURSOR;
		}

		/**
		 * 返回 登录或欢迎页面 Sprite
		 */
		public static function get_Welcome() : Sprite {
			return DisplayManage.getInstance().get_SP_WELCOME();
		}
		/**
		 * 返回 载入素材 Sprite
		 */
		public static function get_Loading() : Sprite {
			return DisplayManage.getInstance().get_SP_LOADING();
		}
		
			
		
		/**
		 * 返回 主要界面 Sprite
		 */
		/*public static function get_TOWN() : Sprite {
			return DisplayManage.getInstance().get_SP_TOWN();
		}*/
		
		/**
		 * 返回 Debug Sprite
		 */
		public static function get_Debug() : Sprite {
			return DisplayManage.getInstance().get_SP_DEBUG();
		}
			
		/**
		 * 返回 鼠标指针 Sprite
		 */
		public static function get_Mouse_cursor() : Sprite {
			return DisplayManage.getInstance().get_SP_MOUSE_CURSOR();
		}

		

		//程序初始化
		public static function run():void
		{
			DisplayManage.getInstance();
		}
	}
}

class Enforce {
}