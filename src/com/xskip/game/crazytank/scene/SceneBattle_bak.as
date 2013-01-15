package com.xskip.game.crazytank.scene
{
	import com.xskip.game.crazytank.asset.AssetCenter;
	import com.xskip.game.crazytank.asset.AssetList;
	import com.xskip.game.crazytank.database.BattleInfo;
	import com.xskip.game.crazytank.database.DataPlayer;
	import com.xskip.game.crazytank.display.DisplayManage;
	import com.xskip.game.crazytank.player.ShotBase;
	import com.xskip.game.crazytank.player.Tank001;
	import com.yxg.display.StageInfo;
	import com.yxg.log4f.Logger;
	import com.yxg.utils.PixelCollisionDetection;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import gear.utils.GBDUtil;
	import pixelblitz.core.Renderer2D;
	import pixelblitz.elements.PixelSprite;
	import pixelblitz.layers.RenderLayer;
	
	/**
	 * ...
	 * @author XIEJ
	 */
	public class SceneBattle implements IScene
	{
		private var _battleInfo:BattleInfo;
		
		private var _renderer:Renderer2D;
		
		private var _arrEnemy:Array;
		
		private var _background:Bitmap;
		private var _backgroundFront:Bitmap;
		
		private var _credits:Bitmap;
		
		private var _hole_Matrix:Matrix;
		
		private var _player001:Tank001;
		
		private var _timerMouseDown:Timer;
		
		private var _onEnterGunUp:Boolean;
		private var _onEnterGunDown:Boolean;
		private var _onEnterGunPower:Boolean;
		
		private var _onEnterGunLeft:Boolean;
		private var _onEnterGunRight:Boolean;
		
		private var _onReadying:Boolean;
		
		private var _allowFix:int;
		
		public function SceneBattle()
		{
			init();
		}
		
		private function init():void
		{
			Logger.INFO(this, "SceneBattle init");
			
			initData();
		}
		
		private function initData():void {
			
			_allowFix = 40;
			
			_onReadying = true;
			
			_battleInfo = new BattleInfo();
			
			gunReset();
			
			_timerMouseDown = new Timer(20);
			_timerMouseDown.addEventListener(TimerEvent.TIMER, onBattleTimerRunHandler);
		}
		
		private function gunReset():void {
			_onEnterGunUp = false;
			_onEnterGunDown = false;
			_onEnterGunPower = false;
			
			_onEnterGunLeft = false;
			_onEnterGunRight = false;
		}
		
		private function onBattleTimerRunHandler(e:TimerEvent):void {
			if (_onReadying) {
				if (tankPhysical()) {
					_onReadying = false;
				}
				return;
			}else {
				if (_allowFix > 0) {
					_allowFix--;
					tankPhysical();
				}
			}
			
			trace("_allowFix = "+_allowFix+" _onReadying = " + _onReadying + " _onEnterGunLeft = " + _onEnterGunLeft + " _onEnterGunRight " + _onEnterGunRight + "  _player001.rotation " + _player001.rotation);
			
			if (_onEnterGunLeft) {
				//trace("_player001.rotation = "+_player001.rotation);
				
				//允许爬坡角度
				if (_player001.rotation >= 50) {
					return;
				}
				
				_allowFix = 20;
				_player001.x -= 2;
			}
			
			if (_onEnterGunRight) {
				//trace("_player001.rotation = "+_player001.rotation);
				
				//允许爬坡角度
				if (_player001.rotation <= -50) {
					return;
				}
				
				_allowFix = 20;
				_player001.x += 2;
			}
			
			
			if (_onEnterGunUp){
				_player001.gunAngle(true);
			}
			
			if (_onEnterGunDown){
				_player001.gunAngle(false);
			}
			
			if (_onEnterGunPower){
				_player001.gunPower();
			}
			
		}
		
		private function tankPhysical():Boolean {
			var fBlnHit:Boolean = false;
			//var fHitPoint:Point = new Point(_player001.x, _player001.y);
			if (PixelCollisionDetection.isColliding(_backgroundFront, _player001, DisplayManage.get_WAR(), true)) {
				
				var fHitPoint:Point = PixelCollisionDetection.getCollisionPoint(_backgroundFront, _player001, DisplayManage.get_WAR(), true);
				
				//全局点
				//trace("fHitPoint = " + fHitPoint);
				
				var fRect:Rectangle;
				
				if ((fHitPoint.x-_player001.x) < 0) {
					
					//trace("LEFT = " + PixelCollisionDetection.isColliding(_backgroundFront, _player001._hitBaseLeft, DisplayManage.get_WAR(), true));
					//trace("RIGHT = " + PixelCollisionDetection.isColliding(_backgroundFront, _player001._hitBaseRight, DisplayManage.get_WAR(), true));
					
					fRect = PixelCollisionDetection.getCollisionRect(_backgroundFront, _player001._hitBaseRight, DisplayManage.get_WAR(), true);
					
					if (fRect) {
						fBlnHit = true;
						if (fRect.width > 2) {
							_player001.y -= 2;
						}
						
						_player001.rotation += 1;
					}
					
					
					
					//极限情况
					if (_player001.rotation > 50) {
						_player001.rotation = 50;
					}
				}
				if ((fHitPoint.x - _player001.x) > 0) {
					fRect = PixelCollisionDetection.getCollisionRect(_backgroundFront, _player001._hitBaseLeft, DisplayManage.get_WAR(), true);
					
					if (fRect) {
						fBlnHit = true;
						if (fRect.width > 2) {
							_player001.y -= 2;
						}
						
						_player001.rotation -= 1;
					}
					
					
					
					//极限情况
					if (_player001.rotation < -50) {
						_player001.rotation = -50;
					}
				}
				
				//fBlnHit = true;
				
				/*if (int(fHitPoint.x) == 0) {
					fBlnHit = true;
				}*/
			}else {
				_player001.y += 2;
			}
			
			return fBlnHit;
		}
		
		public function play():void
		{
			//test 
			var fEnemy:DataPlayer = new DataPlayer();
			var fEnemy1:DataPlayer = new DataPlayer();
			_battleInfo.addEnemy(fEnemy);
			_battleInfo.addEnemy(fEnemy1);
			
			refreshBattleScene();
			
			StageInfo.STAGE.addEventListener(KeyboardEvent.KEY_DOWN, onKeyBoardDownHandler);
			StageInfo.STAGE.addEventListener(KeyboardEvent.KEY_UP, onKeyBoardUpHandler);
		}
		
		public function shotCallBack(str:String = ""):void {
			trace("shotEnd = " + str);
		}
		
		private function onKeyBoardDownHandler(e:KeyboardEvent):void {
			if (_onReadying) {
				return;
			}
			
			//trace("e.Code = " + e.keyCode);
			if (e.keyCode==32) {
				_onEnterGunPower = true;
			}
			
			if (e.keyCode==37) {
				_onEnterGunLeft = true;
			}
			if (e.keyCode==38) {
				_onEnterGunUp = true;
			}
			if (e.keyCode==39) {
				_onEnterGunRight = true;
			}
			if (e.keyCode==40) {
				_onEnterGunDown = true;
			}
		}
		
		private function onKeyBoardUpHandler(e:KeyboardEvent):void {
			if (_onReadying) {
				if (e.keyCode == 32) {
					//TEST TEMP test temp
					var fShot:ShotBase = new ShotBase(_player001,shotCallBack);
					fShot.x = _player001.x+24;
					fShot.y = _player001.y - 50;
					DisplayManage.get_WAR().addChild(fShot);
				}
			}
			
			gunReset();
		}
		
		private function refreshBattleScene():void {
			create2DWorld();
			
			createPlayer();
			
			_timerMouseDown.start();
		}
		
		private function createPlayer():void {
			_player001 = new Tank001();
			_player001.x = 100;
			_player001.y = 100;
			DisplayManage.get_WAR().addChild(_player001);
		}
		
		
		private function create2DWorld():void {
			_background = new Bitmap();
			_backgroundFront = new Bitmap();
			
			_background.bitmapData = BitmapData(AssetCenter.getValues(AssetList.BACKGROUND_BACK_001));
			_backgroundFront.bitmapData = BitmapData(AssetCenter.getValues(AssetList.BACKGROUND_FRONT_002)).clone();
			
			DisplayManage.get_WAR().addChild(_background);
			DisplayManage.get_WAR().addChild(_backgroundFront);
			
			//边缘灼烧
			//burnBorder();
			
			trace("go one");
			
			StageInfo.STAGE.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			
		}
		
		private function mouseUpHandler(e:MouseEvent):void {
			
			var hitTest:Boolean = false;
			
			var fHitPoint:Sprite = new Sprite();
			
			fHitPoint.graphics.beginFill(0xFFFF00);
			fHitPoint.graphics.drawRect(0, 0, 2, 2);
			fHitPoint.graphics.endFill();
			
			fHitPoint.x = StageInfo.STAGE.mouseX;
			fHitPoint.y = StageInfo.STAGE.mouseY;
			
			DisplayManage.get_WAR().addChild(fHitPoint);
			
			hitTest = PixelCollisionDetection.isColliding(_backgroundFront, fHitPoint, DisplayManage.get_WAR(), true);
			
			//trace("hitTest = " + hitTest);
			
			if (hitTest) {
				//挖坑方法（关键）
				_hole_Matrix = new Matrix();
				_hole_Matrix.translate(fHitPoint.x - _backgroundFront.x, fHitPoint.y - _backgroundFront.y);

				var randomSize:int = Math.floor(Math.random() * 30) + 5;
				
				var hole:Sprite = new Sprite();
				hole.graphics.beginFill(0x000000);
				hole.graphics.drawCircle(0, 0, randomSize);
				hole.graphics.endFill();
				
				_backgroundFront.bitmapData.draw(hole, _hole_Matrix, null, BlendMode.ERASE);
				
				//边缘灼烧
				var fBigSize:Number = randomSize * 2 + Math.floor(randomSize/2);
				var fBMDMask:BitmapData = BitmapData(AssetCenter.getValues(AssetList.BOOM_BORDER_COLOR)).clone();
				var fBmpData:BitmapData =  GBDUtil.getResizeBD(fBMDMask, fBigSize, fBigSize);
				
				//边缘灼烧
				var fPointFix:Point = new Point(_hole_Matrix.tx - fBmpData.width / 2, _hole_Matrix.ty - fBmpData.height / 2);
				_backgroundFront.bitmapData.copyPixels(fBmpData, fBmpData.rect, fPointFix, _backgroundFront.bitmapData, fPointFix, true);
				
				fBMDMask.dispose();
			}
			
			DisplayManage.get_WAR().removeChild(fHitPoint);
			
		}
		
		//已经作废的方法
		private function burnBorder():void {
			//边缘灼烧状态
				var filter:BitmapFilter = getBitmapFilter();
				//var myFilters:Array = new Array();
				//myFilters.push(filter);
				_backgroundFront.filters = [filter];
		}
		
		private function getBitmapFilter():BitmapFilter {
            //var color:Number = 0x33CCFF;
			var color:Number = 0x000000;
            var alpha:Number = 0.8;
            var blurX:Number = 20;
            var blurY:Number = 20;
            var strength:Number = 2;
            var inner:Boolean = true;
            var knockout:Boolean = false;
            var quality:Number = BitmapFilterQuality.LOW;

            return new GlowFilter(color,
                                  alpha,
                                  blurX,
                                  blurY,
                                  strength,
                                  quality,
                                  inner,
                                  knockout);
        }
		
		public function next():void
		{
			
		}
	
	}

}