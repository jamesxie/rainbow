package com.xskip.game.crazytank.display {
	
	import com.yxg.display.StageInfo;
	import flash.display.Sprite;

	/**
	 * @author JamesXie
	 * @version 1.0
	 * @date Jul 16, 2009
	 * @name 显示管理
	 */
	public class DisplayManage {
		private static var __Instance : DisplayManage;
		//载入层
		private var _SP_LOADING : Sprite;
		//Welcome界面层
		private var _SP_WELCOME : Sprite;
		//Welcome主界面层
		private var _SP_MAIN : Sprite;
		//地图层
		private var _SP_MAP : Sprite;
		//地图 区块层
		private var _SP_MAP_TILES : Sprite;
		//地图 背景 效果层
		private var _SP_BACK_EFFECT : Sprite;
		//人物层
		private var _SP_HUMAN : Sprite;
		//UI层
		private var _SP_UI : Sprite;
		//战斗层
		private var _SP_WAR : Sprite;
		//UI层
		private var _SP_FRONT_UI : Sprite;
		//地图 前景 效果层
		private var _SP_EFFECT : Sprite;
		//地图 前景 效果层2 给无需释放的特效层使用 例如 鼠标特效使用
		private var _SP_EFFECT2 : Sprite;
		//框架 效果层 相框云彩等
		private var _SP_FRAME_EFFECT : Sprite;
		//ToolTips层
		private var _SP_TOOLTIPS : Sprite;
		//高级错误提示层
		public static var _SP_ALERT : Sprite = new Sprite;
		//鼠标指针层
		private var _SP_MOUSE_CURSOR : Sprite;
		//调试层
		private var _SP_DEBUG : Sprite;
		//地图背景容器（接受鼠标点击事件）
		private var _SP_BACK_MAP : Sprite;
		//可点透的聊天UI
		public static var _SP_CHAT_UI : Sprite;
		//世界地图层，位于所有UI上层
		private var _SP_MAPWORLD:Sprite;
		
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
			dataInit();
		}

		private function dataInit() : void {
			
			_SP_LOADING = new Sprite();
			
			_SP_WELCOME = new Sprite();
			
			_SP_MAIN = new Sprite();
			
			_SP_MAP = new Sprite();
			
			_SP_MAP_TILES = new Sprite();
			
			_SP_BACK_EFFECT = new Sprite();
			
			_SP_HUMAN = new Sprite();
			
			_SP_UI = new Sprite();
			_SP_WAR = new Sprite();
			_SP_FRONT_UI = new Sprite();
			
			_SP_EFFECT = new Sprite();
			
			_SP_EFFECT.buttonMode = false;
			_SP_EFFECT.mouseEnabled = false;
			_SP_EFFECT.mouseChildren = false;
			
			
			_SP_EFFECT2 = new Sprite();
			
			_SP_EFFECT2.buttonMode = false;
			_SP_EFFECT2.mouseEnabled = false;
			_SP_EFFECT2.mouseChildren = false;
			
			_SP_FRAME_EFFECT = new Sprite();
			_SP_FRAME_EFFECT.buttonMode = false;
			_SP_FRAME_EFFECT.mouseEnabled = false;
			_SP_FRAME_EFFECT.mouseChildren = false;
			
			_SP_TOOLTIPS = new Sprite();
			_SP_TOOLTIPS.buttonMode = false;
			_SP_TOOLTIPS.mouseEnabled = false;
			_SP_TOOLTIPS.mouseChildren = false;
			
			_SP_MOUSE_CURSOR = new Sprite();
			_SP_MOUSE_CURSOR.mouseEnabled = false;
			_SP_MOUSE_CURSOR.mouseChildren = false;
			
			_SP_DEBUG = new Sprite();
			
			_SP_BACK_MAP = new Sprite();
			
			_sp_map_index = 0;
			
			_SP_MAPWORLD = new Sprite();
			//alert(StageInfo.STAGE);
			
			try {
				StageInfo.ROOT.addChild(_SP_MAP);
				
				_sp_map_index = StageInfo.ROOT.getChildIndex(_SP_MAP);
			}catch(e2 : Error) {
				throw new Error(e2.message);
			}
			
			StageInfo.ROOT.addChild(_SP_FRAME_EFFECT);
			
			StageInfo.ROOT.addChild(_SP_MAIN);
			
			StageInfo.ROOT.addChild(_SP_UI);
			
			StageInfo.ROOT.addChild(_SP_WAR);
			
			StageInfo.ROOT.addChild(_SP_FRONT_UI);
			
			StageInfo.ROOT.addChild(_SP_MAPWORLD);
			
			StageInfo.ROOT.addChild(_SP_LOADING);
			
			StageInfo.ROOT.addChild(_SP_WELCOME);
			
			StageInfo.ROOT.addChild(_SP_DEBUG);
			
			StageInfo.STAGE.addChild(_SP_ALERT);
			
			StageInfo.STAGE.addChild(_SP_MOUSE_CURSOR);
			
			//map tiles begin
			_SP_MAP.addChild(_SP_MAP_TILES);
			//map tiles end

			_SP_MAP.addChild(_SP_BACK_MAP);

			_SP_MAP.addChild(_SP_BACK_EFFECT);
			
			_SP_MAP.addChild(_SP_HUMAN);
			
			_SP_MAP.addChild(_SP_EFFECT);
			
			_SP_MAP.addChild(_SP_EFFECT2);
			
			/*_SP_MAP_TILES.graphics.beginFill(0xFF6699);
			_SP_MAP_TILES.graphics.drawRect(0, 0, 10, 10);
			_SP_MAP_TILES.graphics.endFill();*/

			
			
			
			/*_SP_MAP_TILES.mouseChildren = false;
			_SP_MAP_TILES.mouseEnabled = false;
			_SP_MAP_TILES.buttonMode = false;*/

			_SP_MAP.mouseChildren = true;
			
			_SP_MAP_TILES.mouseEnabled = true;
			
			//对矢量资源更加有效
			//_SP_BACK_EFFECT.cacheAsBitmap=true;
			//_SP_EFFECT.cacheAsBitmap=true;
			//_SP_EFFECT2.cacheAsBitmap=true;
			
			
			//导致特效播放有背景色
			//_SP_UI.cacheAsBitmap = true;
			
			//_SP_FRONT_UI.cacheAsBitmap = true;
			
			
			//效果层 没有鼠标事件
			_SP_BACK_EFFECT.mouseChildren = false;
			_SP_BACK_EFFECT.mouseEnabled = false;
			_SP_BACK_EFFECT.buttonMode = false;
		}

		private function get_SP_MAP() : Sprite {
			return _SP_MAP;
		}

		private function get_SP_BACK_EFFECT() : Sprite {
			return _SP_BACK_EFFECT;
		}

		private function get_SP_HUMAN() : Sprite {
			return _SP_HUMAN;
		}

		private function get_SP_FRAME_EFFECT() : Sprite {
			return _SP_FRAME_EFFECT;
		}

		private function get_SP_UI() : Sprite {
			return _SP_UI;
		}

		private function get_SP_WAR() : Sprite {
			return _SP_WAR;
		}

		private function get_SP_FRONT_UI() : Sprite {
			return _SP_FRONT_UI;
		}

		private function get_SP_TOOLTIPS() : Sprite {
			return _SP_TOOLTIPS;
		}

		private function get_SP_LOADING() : Sprite {
			return _SP_LOADING;
		}
		
		private function get_SP_WELCOME() : Sprite {
			return _SP_WELCOME;
		}
		
		private function get_SP_MAIN() : Sprite {
			return _SP_MAIN;
		}

		private function get_SP_EFFECT() : Sprite {
			return _SP_EFFECT;
		}

		private function get_SP_EFFECT2() : Sprite {
			return _SP_EFFECT2;
		}

		private function get_SP_MOUSE_CURSOR() : Sprite {
			return _SP_MOUSE_CURSOR;
		}

		private function get_SP_DEBUG() : Sprite {
			return _SP_DEBUG;
		}

		private function get_SP_BACK_MAP() : Sprite {
			return _SP_BACK_MAP;
		}

		private function get_SP_MAP_TILES() : Sprite {
			return _SP_MAP_TILES;
		}
		
		private function get_SP_MAPWORLD() : Sprite {
			return _SP_MAPWORLD;
		}
		
		/**
		 * 返回 地图 Sprite
		 */
		public static function get_MAP() : Sprite {
			return DisplayManage.getInstance().get_SP_MAP();
		}

		/**
		 * 返回 背景效果图 Sprite
		 */
		public static function get_BACK_EFFECT() : Sprite {
			return DisplayManage.getInstance().get_SP_BACK_EFFECT();
		}

		/**
		 * 返回 人物 Sprite
		 */
		public static function get_HUMAN() : Sprite {
			return DisplayManage.getInstance().get_SP_HUMAN();
		}

		/**
		 * 返回 战斗 Sprite
		 */
		public static function get_FRAME_EFFECT() : Sprite {
			return DisplayManage.getInstance().get_SP_FRAME_EFFECT();
		}

		/**
		 * 返回 界面 Sprite
		 */
		public static function get_UI() : Sprite {
			return DisplayManage.getInstance().get_SP_UI();
		}

		/**
		 * 返回 战斗 Sprite
		 */
		public static function get_WAR() : Sprite {
			return DisplayManage.getInstance().get_SP_WAR();
		}
		
		/**
		 * 返回 界面 Sprite
		 */
		public static function get_FRONT_UI() : Sprite {
			return DisplayManage.getInstance().get_SP_FRONT_UI();
		}
		
		/**
		 * 返回 ToolTips Sprite
		 */
		public static function get_ToolTips() : Sprite {
			return DisplayManage.getInstance().get_SP_TOOLTIPS();
		}

		/**
		 * 返回 载入素材 Sprite
		 */
		public static function get_Loading() : Sprite {
			return DisplayManage.getInstance().get_SP_LOADING();
		}
		
		/**
		 * 返回 welcome界面 Sprite
		 */
		public static function get_Welcome() : Sprite {
			return DisplayManage.getInstance().get_SP_WELCOME();
		}
		
		/**
		 * 返回 主要界面 Sprite
		 */
		public static function get_Main() : Sprite {
			return DisplayManage.getInstance().get_SP_MAIN();
		}

		/**
		 * 返回 效果 Sprite
		 */
		public static function get_FFECT() : Sprite {
			return DisplayManage.getInstance().get_SP_EFFECT();
		}

		/**
		 * 返回 效果2 Sprite
		 */
		public static function get_FFECT2() : Sprite {
			return DisplayManage.getInstance().get_SP_EFFECT2();
		}

		/**
		 * 返回 鼠标指针 Sprite
		 */
		public static function get_MOUSE_CURSOR() : Sprite {
			return DisplayManage.getInstance().get_SP_MOUSE_CURSOR();
		}

		/**
		 * 返回 Debug Sprite
		 */
		public static function get_DEBUG() : Sprite {
			return DisplayManage.getInstance().get_SP_DEBUG();
		}

		/**
		 * 返回 地图数据 Bitmap 接受点击事件
		 */
		public static function get_BACK_MAP() : Sprite {
			return DisplayManage.getInstance().get_SP_BACK_MAP();
		}

		
		/**
		 * 返回 地图区块层
		 */
		public static function get_MAP_TILES() : Sprite {
			return DisplayManage.getInstance().get_SP_MAP_TILES();
		}

		
		
		public static function get_CHAT_BG() : Sprite {
			return DisplayManage._SP_CHAT_UI;
		}

		
		/**
		 * 显示地图层
		 */
		public static function showMap() : void {
			if (!StageInfo.ROOT.contains(get_MAP())) {
				StageInfo.ROOT.addChildAt(get_MAP(), DisplayManage.getInstance()._sp_map_index);
			}
		}

		/**
		 * 影藏地图层
		 */
		public static function HidnMap() : void {
			if (StageInfo.ROOT.contains(get_MAP())) {
				StageInfo.ROOT.removeChild(get_MAP());
			}
		}
		
		public static function get_MAPWORLD():Sprite
		{
			return DisplayManage.getInstance().get_SP_MAPWORLD(); 
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