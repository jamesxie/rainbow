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
	import com.yxg.utils.PointUtil;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.ShaderParameter;
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
	import flash.text.TextField;
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
		
		private var _power:Sprite;
		private var _ruling:Sprite;
		
		private var _txtTankAngle:TextField;
		private var _txtGunAngle:TextField;
		
		private var _txtReadMe:TextField;
		
		private var i:int;
		
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
			
			_power = new Sprite();
			
			_power.graphics.beginFill(0xFF0000);
			_power.graphics.drawRect(0, 0, 400, 8);
			_power.graphics.endFill();
			
			_ruling = new Sprite();
			_ruling.graphics.lineStyle(1,0xFFFF00);
			_ruling.graphics.moveTo(0, 0);
			_ruling.graphics.lineTo(0, 12);
			
			_txtTankAngle = new TextField();
			_txtGunAngle = new TextField();
			_txtReadMe = new TextField();
			
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
				//trace("--------------设置文本");
				_txtReadMe.text = "(1) 键盘 [左]、[右] 控制 坦克移动\n\n(2) 键盘 [上]、[下] 控制 坦克射击角度\n\n(3) 按住[空格键]蓄力，松开[空格键]发射\n\n(4) 鼠标点击地面能直接打洞。";
				_onReadying = false;
			}
			
			_txtTankAngle.text = String(_player001.rotation);
			_txtGunAngle.text = String(_player001.gunAngle());
			
			//trace("_allowFix = "+_allowFix+" _onReadying = " + _onReadying + " _onEnterGunLeft = " + _onEnterGunLeft + " _onEnterGunRight " + _onEnterGunRight + "  _player001.rotation " + _player001.rotation);
			
			tankRotation(_player001);
			
			if (_onEnterGunLeft) {
				if (_player001.rotation > (Tank001.TankAngleLimit - 5)) {
					return;
				}
				
				// W 38 H 30
				for (i = 0; i < 2; i++) {
					if (!PixelCollisionDetection.isColliding(_backgroundFront, _player001._hitLeft, DisplayManage.get_WAR(), true)) {
						
						//trace("_player001.rotation Left = "+_player001.rotation);
						_player001.x--;
						
						while (PixelCollisionDetection.isColliding(_backgroundFront, _player001._hitDown, DisplayManage.get_WAR(), true)) {
							_player001.y--;
						}
					}
				}
			}
			
			if (_onEnterGunRight) {
				if (_player001.rotation < -(Tank001.TankAngleLimit - 5)) {
					return;
				}
				
				for (i = 0; i < 2; i++) {
					if (!PixelCollisionDetection.isColliding(_backgroundFront, _player001._hitRight, DisplayManage.get_WAR(), true)) {
						
						//trace("_player001.rotation Right = "+_player001.rotation);
						_player001.x++;
						
						while (PixelCollisionDetection.isColliding(_backgroundFront, _player001._hitDown, DisplayManage.get_WAR(), true)) {
							_player001.y--;
						}
					}
				}
				
				
			}
			
			_player001._tankSpeed++;
			
			//下落
			if (_player001._tankSpeed > 0) {
				for (i = 0; i < _player001._tankSpeed; i++) {
					if (! PixelCollisionDetection.isColliding(_backgroundFront, _player001._hitDown, DisplayManage.get_WAR(), true)) {
						_player001.y++;
					} else {
						_player001._tankSpeed = 0;
					}
				}
			}
			
			if (_onEnterGunUp){
				_player001.gunAngleChange(true);
			}
			
			if (_onEnterGunDown){
				_player001.gunAngleChange(false);
			}
			
			if (_onEnterGunPower) {
				if (_power.width <= (400 - 4)) {
					_power.width += 4;
				}
			}
		}
		
		
		private function tankRotation(pTank001:Tank001):void {
			var fFinal:int = 0;
			var fBln1:Boolean=PixelCollisionDetection.isColliding(_backgroundFront, pTank001._hitBaseLeft, DisplayManage.get_WAR(), true);
			var fBln2:Boolean=PixelCollisionDetection.isColliding(_backgroundFront, pTank001._hitBaseRight, DisplayManage.get_WAR(), true);
			if (fBln1) {
				fFinal++;
			}
			if (fBln2) {
				fFinal--;
			}
			
			if (fFinal != 0) {
				pTank001.rotation += (fFinal * 3);
				pTank001._tankAngleTrend = fFinal;
				//trace("Left = " + fBln1 + " Right " + fBln2);
			}else {
				if (pTank001._tankAngleTrend != 0) {
					pTank001.rotation += (pTank001._tankAngleTrend * 3);
					pTank001._tankAngleTrend = 0;
				}
			}
			//trace("fFinal = " + fFinal);
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
			//trace("shotCallBack str : " + str);
		}
		
		private function onKeyBoardDownHandler(e:KeyboardEvent):void {
			/*if (_onReadying) {
				return;
			}*/
			
			if (e.keyCode == 32) {
				_onEnterGunPower = true;
			}
			
			if (e.keyCode == 37) {
				_onEnterGunLeft = true;
			}
			
			if (e.keyCode == 38) {
				_onEnterGunUp = true;
			}
			
			if (e.keyCode == 39) {
				_onEnterGunRight = true;
			}
			
			if (e.keyCode == 40) {
				_onEnterGunDown = true;
			}
		}
		
		private function onKeyBoardUpHandler(e:KeyboardEvent):void {
			if (!_onReadying) {
				if (e.keyCode == 32) {
					//TEST TEMP test temp
					
					trace("射击角度 = " + _player001.finalAngle());
					
					_player001.gunPower = int(_power.width / 4);
					
					var fShot:ShotBase = new ShotBase(_player001, hitFloorUseShot, shotCallBack);
					
					//fShot.x = _player001.x + 24;
					//fShot.y = _player001.y - 50;
					fShot.x = _player001.x + 22;
					fShot.y = _player001.y - 28;
					
					DisplayManage.get_WAR().addChild(fShot);
					
					//参考指针
					_ruling.x = _power.x + _power.width;
					//力量归位
					_power.width = 1;
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
			
			DisplayManage.get_WAR().addChild(_power);
			_power.x = 10;
			_power.y = 10;
			_power.width = 1;
			
			DisplayManage.get_WAR().addChild(_ruling);
			_ruling.x = 10;
			_ruling.y = 8;
			
			DisplayManage.get_WAR().addChild(_txtTankAngle);
			_txtTankAngle.x = 10;
			_txtTankAngle.y = 25;
			_txtTankAngle.width = 36;
			_txtTankAngle.height = 14;
			_txtTankAngle.border = true;
			_txtTankAngle.text = "0";
			
			DisplayManage.get_WAR().addChild(_txtGunAngle);
			_txtGunAngle.x = 10;
			_txtGunAngle.y = 50;
			_txtGunAngle.width = 36;
			_txtGunAngle.height = 14;
			_txtGunAngle.border = true;
			_txtGunAngle.text = "0";
			
			DisplayManage.get_WAR().addChild(_txtReadMe);
			_txtReadMe.x = 400;
			_txtReadMe.y = 10;
			_txtReadMe.width = 300;
			_txtReadMe.height = 100;
			_txtReadMe.border = true;
			_txtReadMe.textColor = 0xFFFF00;
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
			hitFloorAndTank(StageInfo.STAGE.mouseX, StageInfo.STAGE.mouseY);
		}
		
		/**
		 * 根据线来命中(炮弹 弹道)
		 * @param	beginP
		 * @param	endP
		 * @return
		 */
		public function hitFloorUseShot(beginP:Point, endP:Point):Boolean {
			var hitTest:Boolean = false;
			
			if (beginP == endP) {
				if (beginP.x == 0 && beginP.y == 0) {
					return false;
				}
				hitTest = hitFloorAndTank(beginP.x, beginP.y);
			}else {
				var fHitLine:Sprite = new Sprite();
				fHitLine.graphics.lineStyle(2, 0xFFFF00);
				fHitLine.graphics.moveTo(beginP.x, beginP.y);
				fHitLine.graphics.lineTo(endP.x, endP.y);
				//fHitLine.x = beginP.x;
				//fHitLine.y = beginP.y;
				DisplayManage.get_WAR().addChild(fHitLine);
				
				hitTest = PixelCollisionDetection.isColliding(_backgroundFront, fHitLine, DisplayManage.get_WAR(), true);
				
				//trace("hitTest = " + hitTest);
				
				if (hitTest) {
					var fArrPoint:Array = PointUtil.tweenDistance(beginP, endP, 1);
					
					var fPointHitLoop:Point=new Point(0,0);
					var fBlnHitLoop:Boolean = false;
					
					if (fArrPoint) {
						if (fArrPoint.length > 0) {
							//Logger.DEBUG(this, "fArrPoint.length = " + fArrPoint.length);
							for (var i:int = 0; i < fArrPoint.length; i++ ) {
								fPointHitLoop.x = int(Point(fArrPoint[i]).x);
								fPointHitLoop.y = int(Point(fArrPoint[i]).y);
								
								fBlnHitLoop = hitFloorAndTank(fPointHitLoop.x, fPointHitLoop.y);
								
								//drawTempPoint(fPointHitLoop.x, fPointHitLoop.y);
								
								//trace("fPointHitLoop.x " + fPointHitLoop.x + " fPointHitLoop.y " + fPointHitLoop.y + " fBlnHitLoop = " + fBlnHitLoop);
								
								if (fBlnHitLoop) {
									break;
								}
							}
						}
					}
					
					if (!fBlnHitLoop) {
						Logger.WARN(this, "命中点异常");
						hitFloorAndTank(fPointHitLoop.x, fPointHitLoop.y, true);
					}
					
					//var fHitPoint:Point = PixelCollisionDetection.getCollisionPoint(_backgroundFront, fHitLine, DisplayManage.get_WAR(), true);
					//hitFloorAndTank(fHitPoint.x, fHitPoint.y, true);
				}
				
				DisplayManage.get_WAR().removeChild(fHitLine);
			}
			
			return hitTest;
		}
		
		//XXX (临时方法) 绘制路径点 
		private function drawTempPoint(px:int,py:int):void {
			var fSP:Sprite = new Sprite();
			fSP.graphics.beginFill(0xFF0000);
			fSP.graphics.drawCircle(0,0,1);
			fSP.graphics.endFill();
			fSP.x = px;
			fSP.y = py;
			DisplayManage.get_WAR().addChild(fSP);
		}
		
		/**
		 * 根据点来命中(鼠标 or *固定爆炸点)
		 * @param	pX
		 * @param	pY
		 * @param	mustHit 为 true 是固定点爆破
		 * @return
		 */
		public function hitFloorAndTank(pX:Number, pY:Number, mustHit:Boolean = false):Boolean {
			
			var hitTest:Boolean = false;
			
			var fHitPoint:Sprite = new Sprite();
			
			fHitPoint.graphics.beginFill(0xFFFF00);
			fHitPoint.graphics.drawRect(0, 0, 2, 2);
			fHitPoint.graphics.endFill();
			
			fHitPoint.x = pX;
			fHitPoint.y = pY;
			
			DisplayManage.get_WAR().addChild(fHitPoint);
			
			if (!mustHit){
				hitTest = PixelCollisionDetection.isColliding(_backgroundFront, fHitPoint, DisplayManage.get_WAR(), true);
			}
			//trace("hitTest = " + hitTest);
			
			if (hitTest || mustHit) {
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
			
			return hitTest;
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