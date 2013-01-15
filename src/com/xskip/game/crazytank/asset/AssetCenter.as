package com.xskip.game.crazytank.asset 
{
	import com.yxg.utils.HashMap;
	
	/**
	 * ...
	 * @author JamesXie
	 */
	public class AssetCenter
	{
		private static var __Instance : AssetCenter;
		
		//{String 素材索引,MovieClip 素材}
		private var _all_asset:HashMap;
		
		public function AssetCenter(e : Enforce) {
			if ( e == null ) {
				throw new Error("This is singleton instance class,please use getInstance()!");
			}
			init();
		}
		
		private static function getInstance():AssetCenter {
			if(AssetCenter.__Instance == null) {
				AssetCenter.__Instance = new AssetCenter(new Enforce());
			}
			return AssetCenter.__Instance;
		}
		
		private function init():void {
			_all_asset = new HashMap();
		}
		
		public static function AllAsset():HashMap {
			return AssetCenter.getInstance()._all_asset;
		}
		
		public static function put(keys:String, values:Object):void {
			AssetCenter.getInstance()._all_asset.put(keys, values);
		}
		
		public static function getValues(keys:String):Object {
			return AssetCenter.getInstance()._all_asset.getValue(keys);
		}
		
	}
}

class Enforce {
}