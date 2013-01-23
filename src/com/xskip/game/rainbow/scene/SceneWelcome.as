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
		private var q3:Sprite;
		
		private var q4:Sprite;
		
		private var _man:HeroView;
		
		
		public function SceneWelcome() 
		{
			init();
		}
		
		private function init():void {
			//Logger.INFO(this, "SceneWelcome init");
			
			createBtnStart();
		}
		
		private function createBtnStart():void {
			
		}
		
		private function show(pBln:Boolean = true):void {
			DisplayManage.get_Welcome().visible = pBln;
		}
		
		public function play():void {
			show(true);
			
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
			
			q3 = new Sprite();
			var quadQ1:Quad=new Quad(1024, 16);
			quadQ1.setVertexColor(0, 0x000000);
			quadQ1.setVertexColor(1, 0xAA0000);
			quadQ1.setVertexColor(2, 0x00FF00);
			quadQ1.setVertexColor(3, 0x0000FF);
			quadQ1.y = 380;
			
			var quadQ2:Quad=new Quad(300, 16);
			quadQ2.setVertexColor(0, 0x000000);
			quadQ2.setVertexColor(1, 0xAA0000);
			quadQ2.setVertexColor(2, 0x00FF00);
			quadQ2.setVertexColor(3, 0x0000FF);
			quadQ2.x = 424;
			quadQ2.y = 280;
			
			var quadQ3:Quad = new Quad(60, 50);
			quadQ3.setVertexColor(0, 0x000000);
			quadQ3.setVertexColor(1, 0xAA0000);
			quadQ3.setVertexColor(2, 0x00FF00);
			quadQ3.setVertexColor(3, 0x0000FF);
			quadQ3.x = 530;
			quadQ3.y = 320;
			
			var quadQ4:Quad = new Quad(120, 40);
			quadQ4.setVertexColor(0, 0x000000);
			quadQ4.setVertexColor(1, 0xAA0000);
			quadQ4.setVertexColor(2, 0x00FF00);
			quadQ4.setVertexColor(3, 0x0000FF);
			quadQ4.x = 260;
			quadQ4.y = 340;
			
			
			var quadQ5:Quad=new Quad(150, 16);
			quadQ5.setVertexColor(0, 0x000000);
			quadQ5.setVertexColor(1, 0xAA0000);
			quadQ5.setVertexColor(2, 0x00FF00);
			quadQ5.setVertexColor(3, 0x0000FF);
			quadQ5.x = 200;
			quadQ5.y = 220;
			
			q3.addChild(quadQ1);
			q3.addChild(quadQ2);
			q3.addChild(quadQ3);
			q3.addChild(quadQ4);
			q3.addChild(quadQ5);
			
			GlobalData.GAME_WORLD.stage.addChild(q1);
			GlobalData.GAME_WORLD.stage.addChild(q2);
			GlobalData.GAME_WORLD.stage.addChild(q3);
			
			q1.y = 0;
			
			//q3居中
			q1.x = GlobalData.GAME_WORLD.stage.stageWidth - q1.width >> 1;
			q1.y = GlobalData.GAME_WORLD.stage.stageHeight - q1.height >> 1;
			
			
			
			
			//Ladder
			q4 = new Sprite();
			
			var quadQ6:Quad = new Quad(20, 100);
			quadQ6.setVertexColor(0, 0xFF9900);
			quadQ6.setVertexColor(1, 0xFF9900);
			quadQ6.setVertexColor(2, 0xFF9900);
			quadQ6.setVertexColor(3, 0xFF9900);
			
			quadQ6.x = 660;
			quadQ6.y = 280;
			
			var quadQ7:Quad = new Quad(20, 100);
			quadQ7.setVertexColor(0, 0xFF9900);
			quadQ7.setVertexColor(1, 0xFF9900);
			quadQ7.setVertexColor(2, 0xFF9900);
			quadQ7.setVertexColor(3, 0xFF9900);
			
			quadQ7.x = 200;
			quadQ7.y = 220;
			
			q4.addChild(quadQ6);
			q4.addChild(quadQ7);
			
			GlobalData.GAME_WORLD.stage.addChild(q4);
			
			
			//Hero
			var fBitmap:Bitmap = new assetHero() as Bitmap;
			
			_man = new HeroView(Texture.fromBitmap(fBitmap), fBitmap);
			//缩放
			
			
			
			_man.x = 100;
			_man.y = 100;
			
			GlobalData.GAME_WORLD.stage.addChild(_man);
			
			
			var pbg:ParallaxBackground = new ParallaxBackground(q1, q2, q3, _man, q4);
			
			
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