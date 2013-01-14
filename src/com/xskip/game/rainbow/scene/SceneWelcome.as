package com.xskip.game.rainbow.scene 
{
	import com.xskip.game.rainbow.algorithm.ParallaxBackground;
	import com.xskip.game.rainbow.database.GlobalData;
	import com.xskip.game.rainbow.display.DisplayManage;
	import com.xskip.game.rainbow.player.HeroView;
	import com.yxg.log4f.Logger;
	import com.yxg.utils.BitmapUtil;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.setTimeout;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author XIEJ
	 */
	public class SceneWelcome  extends Sprite  implements IScene
	{
		
		 [Embed(source="../../../../../../asset/man.png")]
        private static var assetHero:Class;
		
		private var q1:Quad;
		private var q2:Quad;
		private var q3:Quad;
		
		private var _man:HeroView;
		
		
		public function SceneWelcome() 
		{
			init();
		}
		
		private function init():void {
			Logger.INFO(this, "SceneWelcome init");
			
			createBtnStart();
		}
		
		private function createBtnStart():void {
			
		}
		
		private function show(pBln:Boolean = true):void {
			DisplayManage.get_Welcome().visible = pBln;
		}
		
		public function play():void {
			show(true);
			trace("SceneWelcome play");
			
			q1 = new Quad(512,512);

			q1.setVertexColor(0, 0x000000); 
			q1.setVertexColor(1, 0xAA0000); 
			q1.setVertexColor(2, 0x00FF00); 
			q1.setVertexColor(3, 0x0000FF);
			
			q2 = new Quad(256, 256);
			q2.setVertexColor(0, 0x000000); 
			q2.setVertexColor(1, 0xAA0000); 
			q2.setVertexColor(2, 0x00FF00); 
			q2.setVertexColor(3, 0x0000FF);
			
			q3 = new Quad(1024, 16);
			q3.setVertexColor(0, 0x000000); 
			q3.setVertexColor(1, 0xAA0000); 
			q3.setVertexColor(2, 0x00FF00); 
			q3.setVertexColor(3, 0x0000FF);
			
			q3.y = 480;
			
			
			GlobalData.GAME_WORLD.stage.addChild(q1);
			GlobalData.GAME_WORLD.stage.addChild(q2);
			GlobalData.GAME_WORLD.stage.addChild(q3);
			
			q1.y = 0;
			
			//q3居中
			q1.x = GlobalData.GAME_WORLD.stage.stageWidth - q1.width >> 1; 
			q1.y = GlobalData.GAME_WORLD.stage.stageHeight - q1.height >> 1;
			
			q1.bounds.containsPoint();
			
			var fBitmap:Bitmap = new assetHero() as Bitmap;
			
			_man = new HeroView(Texture.fromBitmap(fBitmap),fBitmap);
			//缩放
			
			
			_man.x = 100;
			_man.y = 100;
			
			GlobalData.GAME_WORLD.stage.addChild(_man);
			
			var pbg:ParallaxBackground = new ParallaxBackground(q1, q2, q3,_man);
			
			
			//销毁主角
			//var fuint:uint = setTimeout(onEvent,10000);
		}
		
		//销毁主角
		public function onEvent():void {
			_man.dispose();
		}
		
		public function next():void {
			show(false);
		}
		
	}

}