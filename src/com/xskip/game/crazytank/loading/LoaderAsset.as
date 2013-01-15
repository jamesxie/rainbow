package com.xskip.game.crazytank.loading
{
	import com.xskip.game.crazytank.asset.AssetCenter;
	import com.xskip.game.crazytank.asset.AssetList;
	import com.xskip.game.crazytank.database.GameInfo;
	import com.xskip.game.crazytank.display.DisplayManage;
	import com.xskip.game.crazytank.scene.IScene;
	import com.xskip.game.crazytank.scene.SceneManage;
	import com.yxg.display.StageInfo;
	import com.yxg.log4f.Logger;
	import com.yxg.net.PNGLoader;
	import com.yxg.net.RESGroup;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	
	/**
	 * 读取素材
	 * @author JamesXie
	 */
	public class LoaderAsset implements IScene
	{
		private var _assetGroup:RESGroup;
		
		private var _pngLoaderBg001:PNGLoader;
		private var _pngLoaderFrontBg001:PNGLoader;
		private var _pngLoaderFrontBg002:PNGLoader;
		
		private var _pngLoaderTank001:PNGLoader;
		private var _pngLoaderTank002:PNGLoader;
		
		private var _pngLoaderBoomBorderColor:PNGLoader;
		
		public function LoaderAsset()
		{
			Logger.DEBUG(this, "LoaderAsset");
			init();
		}
		
		private function init2():void {
			Logger.DEBUG(this, "LoaderAsset init");
		}
		
		private function init():void
		{
			_assetGroup = new RESGroup();
			
			//load地图背景
			
			_pngLoaderBg001 = new PNGLoader(AssetList.ASSET_PATH + AssetList.BACKGROUND_BACK_001);
			_pngLoaderFrontBg001 = new PNGLoader(AssetList.ASSET_PATH + AssetList.BACKGROUND_FRONT_001);
			_pngLoaderFrontBg002 = new PNGLoader(AssetList.ASSET_PATH + AssetList.BACKGROUND_FRONT_002);
			
			_pngLoaderTank001 = new PNGLoader(AssetList.ASSET_PATH + AssetList.TANK_001);
			_pngLoaderTank002 = new PNGLoader(AssetList.ASSET_PATH + AssetList.TANK_002);
			
			_pngLoaderBoomBorderColor = new PNGLoader(AssetList.ASSET_PATH + AssetList.BOOM_BORDER_COLOR);
			
			_assetGroup.add(_pngLoaderBg001);
			_assetGroup.add(_pngLoaderFrontBg001);
			_assetGroup.add(_pngLoaderFrontBg002);
			
			_assetGroup.add(_pngLoaderTank001);
			_assetGroup.add(_pngLoaderTank002);
			
			_assetGroup.add(_pngLoaderBoomBorderColor);
			
			_pngLoaderBg001.addEventListener(Event.COMPLETE, onPNG001CompleteHandler);
			
			_pngLoaderFrontBg001.addEventListener(Event.COMPLETE, onPNG002CompleteHandler);
			_pngLoaderFrontBg002.addEventListener(Event.COMPLETE, onPNG003CompleteHandler);
			
			_pngLoaderTank001.addEventListener(Event.COMPLETE, onPNG004CompleteHandler);
			_pngLoaderTank002.addEventListener(Event.COMPLETE, onPNG005CompleteHandler);
			
			_pngLoaderBoomBorderColor.addEventListener(Event.COMPLETE, onPNG006CompleteHandler);
			
			_assetGroup.addEventListener(Event.COMPLETE, onALLCompleteHandler);
		}
		
		private function onPNG001CompleteHandler(e:Event):void
		{
			if (_pngLoaderBg001.hasEventListener(Event.COMPLETE)) {
					_pngLoaderBg001.removeEventListener(Event.COMPLETE, onPNG001CompleteHandler);
			}
			AssetCenter.put(AssetList.BACKGROUND_BACK_001, _pngLoaderBg001.getBitmapData());
			
			/*var bmd_src:BitmapData = _pngLoaderBg001.getBitmapData();
			
			var bm:Bitmap = new Bitmap();
			
			bm.bitmapData = bmd_src;
			
			DisplayManage.get_FRONT_UI().addChild(bm);*/
		}
		
		private function onPNG002CompleteHandler(e:Event):void
		{
			if (_pngLoaderFrontBg001.hasEventListener(Event.COMPLETE)) {
					_pngLoaderFrontBg001.removeEventListener(Event.COMPLETE, onPNG002CompleteHandler);
			}
			AssetCenter.put(AssetList.BACKGROUND_FRONT_001, _pngLoaderFrontBg001.getBitmapData());
		}
		
		private function onPNG003CompleteHandler(e:Event):void
		{
			if (_pngLoaderFrontBg002.hasEventListener(Event.COMPLETE)) {
					_pngLoaderFrontBg002.removeEventListener(Event.COMPLETE, onPNG003CompleteHandler);
			}
			AssetCenter.put(AssetList.BACKGROUND_FRONT_002, _pngLoaderFrontBg002.getBitmapData());
		}
		
		private function onPNG004CompleteHandler(e:Event):void
		{
			if (_pngLoaderTank001.hasEventListener(Event.COMPLETE)) {
					_pngLoaderTank001.removeEventListener(Event.COMPLETE, onPNG004CompleteHandler);
			}
			AssetCenter.put(AssetList.TANK_001, _pngLoaderTank001.getBitmapData());
		}
		
		private function onPNG005CompleteHandler(e:Event):void
		{
			if (_pngLoaderTank002.hasEventListener(Event.COMPLETE)) {
					_pngLoaderTank002.removeEventListener(Event.COMPLETE, onPNG005CompleteHandler);
			}
			AssetCenter.put(AssetList.TANK_002, _pngLoaderTank002.getBitmapData());
		}
		
		private function onPNG006CompleteHandler(e:Event):void
		{
			if (_pngLoaderBoomBorderColor.hasEventListener(Event.COMPLETE)) {
					_pngLoaderBoomBorderColor.removeEventListener(Event.COMPLETE, onPNG006CompleteHandler);
			}
			AssetCenter.put(AssetList.BOOM_BORDER_COLOR, _pngLoaderBoomBorderColor.getBitmapData());
		}
		
		private function onALLCompleteHandler(e:Event):void
		{
			Logger.DEBUG(this, "_assetGroup onALLCompleteHandler");
			SceneManage.play(GameInfo.STEP_MAIN);
		}
		
		public function play():void
		{
			_assetGroup.load();
		}
		
		public function next():void
		{
			
		}
	}

}