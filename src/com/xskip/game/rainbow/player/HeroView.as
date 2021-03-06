package com.xskip.game.rainbow.player 
{
	import com.xskip.game.rainbow.database.GlobalData;
	import flash.display.Bitmap;
	import starling.extensions.krecha.PixelHitArea;
	import starling.extensions.krecha.PixelImageTouch;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author XIEJ
	 */
	public class HeroView extends Sprite
	{
		public var _hero:PixelImageTouch;
		public var _down:Quad;
		public var _left:Quad;
		public var _right:Quad;
		public var _coreUp:Quad;
		public var _coreDown:Quad;
		
		public var _onLadder:Boolean;
		
		//public var _bitmapData:BitmapData;
		
		public function HeroView(skin:Texture, pBitmap:Bitmap) 
		{
			_hero = new PixelImageTouch(skin, new PixelHitArea(pBitmap));
			_hero.x = -(_hero.width >> 1);
			_hero.y = -_hero.height;
			
			//_bitmapData = bitmapData;
			
			this.addChild(_hero);
			
			init();
		}
		
		private function init():void {
			/*_down = new Quad(_hero.width, 1, 0xFF0000);
			_down.x = -(_hero.width >> 1);
			_down.y = 0;
			this.addChild(_down);*/
			_down = new Quad(_hero.width-2, 1, 0xFF0000);
			_down.x = -(_hero.width >> 1)+1;
			_down.y = 0;
			this.addChild(_down);
			
			_left = new Quad(1, _hero.height - 3, 0x00FF00);
			_left.x = -(_hero.width >> 1) - 1;
			_left.y = -_hero.height-1;
			this.addChild(_left);
			
			_right = new Quad(1, _hero.height - 3, 0xFFFF00);
			_right.x = (_hero.width >> 1) + 1;
			_right.y = -_hero.height-1;
			this.addChild(_right);
			
			_coreUp = new Quad(20, 2, 0xFF00FF);
			_coreUp.x = -10;
			_coreUp.y = -2;
			this.addChild(_coreUp);
			
			_coreDown = new Quad(20, 2, 0x00FFFF);
			_coreDown.x = -10;
			_coreDown.y = 0;
			this.addChild(_coreDown);
			
			_down.visible = false;
			_left.visible = false;
			_right.visible = false;
			_coreUp.visible = false;
			_coreDown.visible = false;
			
			_onLadder = false;
		}
		
		//覆盖dispose
		 public override function dispose():void {
			 if (this.stage){
				this.parent.removeChild(this);
			 }
			 
			 //_bitmapData.dispose();
			 trace("sprite dispose");
			 
			 _hero.dispose();
			 _down.dispose();
			 _left.dispose();
			 _right.dispose();
			 _coreUp.dispose();
			 _coreDown.dispose();
			 
			 super.dispose();
		}
		
	}

}