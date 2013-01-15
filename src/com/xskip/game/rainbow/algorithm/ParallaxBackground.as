package com.xskip.game.rainbow.algorithm 
{
	import com.xskip.game.rainbow.database.GlobalData;
	import com.xskip.game.rainbow.player.HeroView;
	import com.yxg.utils.PixelCollisionDetection;
	import com.yxg.utils.PixelCollisionDetectionStarling;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.utils.deg2rad;
	/**
	 * 视差背景
	 * 所属 View
	 * @author XIEJ
	 */
	public class ParallaxBackground 
	{
		private var _displayBack:Quad;
		private var _displayMiddle:Quad;
		private var _displayFront:Sprite;
		
		private var _displayHero:HeroView;
		
		private var r:Number = 0; 
		private var g:Number = 0; 
		private var b:Number = 0; 
		
		private var rDest:Number = 0;
		private var gDest:Number = 0;
		private var bDest:Number = 0;
		
		private var _angle:uint;
		
		private var i:int;
		
		private var _mouseX:Number;
		private var _mouseY:Number;
		
		private var _onKeyboardLeft:Boolean;
		private var _onKeyboardRight:Boolean;
		private var _onKeyboardJump:Boolean;
		
		public var _xSpeed:Number=0;
		public var _ySpeed:Number=0;
		
		//private var _point:Point;
		
		public function ParallaxBackground(parmBack:Quad, parmMiddle:Quad, parmFront:Sprite, parmHero:HeroView) 
		{
			_displayBack = parmBack;
			_displayMiddle = parmMiddle;
			_displayFront = parmFront;
			
			_displayHero = parmHero;
			
			init();
		}
		
		private function init():void {
			
			_angle = 0;
			
			i = 0;
			
			_mouseX = 0;
			_mouseY = 0;
			
			_onKeyboardLeft = false;
			_onKeyboardRight = false;
			_onKeyboardJump = false;
			
			GlobalData.GAME_WORLD.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDownHandler);
			GlobalData.GAME_WORLD.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUpHandler);
			
			
			/*_point = new Point(_displayHero.x, _displayFront.y);
			var quad:Quad = new Quad(2, 2, 0xFF0000);
			quad.x = _point.x;
			quad.y = _point.y;
			GlobalData.GAME_WORLD.stage.addChild(quad);*/
			
			
			GlobalData.GAME_WORLD.stage.addEventListener(TouchEvent.TOUCH, onTouchedSprite); 
			
			//GlobalData.GAME_WORLD.stage.advanceTime
			GlobalData.GAME_WORLD.stage.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			
		}
		
		private function onKeyDownHandler(e:KeyboardEvent):void {
			if (e.keyCode == 32) {
				_onKeyboardJump = true;
			}
			if (e.keyCode == 37) {
				_onKeyboardLeft = true;
			}
			if (e.keyCode == 39) {
				_onKeyboardRight= true;
			}
		}
		
		private function onKeyUpHandler(e:KeyboardEvent):void {
			if (e.keyCode == 32) {
				_onKeyboardJump = false;
			}
			if (e.keyCode == 37) {
				_onKeyboardLeft = false;
			}
			if (e.keyCode == 39) {
				_onKeyboardRight = false;
			}
			
		}
		
		private function  onTouchedSprite(e:TouchEvent):void {
			// get the mouse location related to the stage 
			var touch:Touch = e.getTouch(GlobalData.GAME_WORLD.stage);
			//var pos:Point = touch.getLocation(GlobalData.GAME_WORLD.stage);
			
			//Began Moved End
			//trace ( touch.phase );
			
			// store the mouse coordinates
			//_mouseX = pos.x;
			//_mouseY = pos.y;
			
			_mouseX = touch.globalX;
			_mouseY = touch.globalY;
			
			//trace("_mouseX " + _mouseX + " _mouseY " + _mouseY);
		}
		
		private function onEnterFrameHandler(e:Event):void {
			//trace("run it");
			if (_displayMiddle.x > GlobalData.GAME_WORLD.stage.stageWidth) {
				_displayMiddle.x = -_displayMiddle.width;
			}
			
			_displayMiddle.x ++;
			
			var fNum:int = _displayFront.numChildren;
			
			/*
			//JUMP CODE
			if (_onKeyboardJump) {
				_ySpeed = -10;
			}
			
			_ySpeed++;
			
			
			var fCheckHit_jump:Rectangle = _displayHero.bounds;
			
			
			if (_ySpeed > 0) {
				for (i = 0; i < _ySpeed; i++) {
					var fCheckHit_jump01:Boolean = false;
					
					for (var j01:int = 0; j01 < fNum;j01++ ) {
						var fDoj001:DisplayObject = _displayFront.getChildAt(j01);
						if (fDoj001) {
							var bounds001:Rectangle = fDoj001.bounds;
							bounds02.x = fDoj01.x;
							bounds02.y = fDoj01.y;
							if (fCheckHit_jump.intersects(bounds001)){
								fCheckHit_jump01 = true;
								//trace("fCheckHit01");
								break;
							}
						}
					}
					
					if (!fCheckHit_jump01){
					//if (! terrain_bmpd.hitTest(new Point(terrain_bmp.x, terrain_bmp.y), 0x01, new Rectangle(character.x - 5, character.y + 10, 10, 1))) {
						_displayHero.y++;
					} else {
						_ySpeed = 0;
					}
				}
			} else {
				for (i = 0; i < Math.abs(_ySpeed); i++) {
					//if (! terrain_bmpd.hitTest(new Point(terrain_bmp.x, terrain_bmp.y), 0x01, new Rectangle(character.x - 5, character.y - 10, 10, 1))) {
						_displayHero.y--;
					} else {
						_ySpeed = 0;
					}
				}
			}*/
			
			
			//LEFT CODE
			if (_onKeyboardLeft) {
				for (i = 0; i < 5;i++ ){
					var fCheckHit01:Boolean = false;
					var bounds01:Rectangle = _displayHero._left.bounds;
					bounds01.x = _displayHero.x+_displayHero._left.x;
					bounds01.y = _displayHero.y+_displayHero._left.y;
					
					for (var j01:int = 0; j01 < fNum;j01++ ) {
						var fDoj01:DisplayObject = _displayFront.getChildAt(j01);
						if (fDoj01) {
							var bounds02:Rectangle = fDoj01.bounds;
							bounds02.x = fDoj01.x;
							bounds02.y = fDoj01.y;
							if (bounds01.intersects(bounds02)){
								fCheckHit01 = true;
								//trace("fCheckHit01");
								break;
							}
						}
					}
					
					if (!fCheckHit01) {
						_displayHero.x--;
					}
					
				}
					/*while (PixelCollisionDetection.isColliding(_backgroundFront, _player001._hitDown, DisplayManage.get_WAR(), true)) {
						_player001.y--;
					}*/
			}
			
			
			
			
			//RIGHT CODE
			if (_onKeyboardRight) {
				for (i = 0; i < 5;i++ ){
				var fCheckHit02:Boolean = false;
					var bounds03:Rectangle = _displayHero._right.bounds;
					bounds03.x = _displayHero.x + _displayHero._right.x;
					bounds03.y = _displayHero.y + _displayHero._right.y;
					
					for (var j02:int = 0; j02 < fNum;j02++ ) {
						var fDoj02:DisplayObject = _displayFront.getChildAt(j02);
						if (fDoj02) {
							var bounds04:Rectangle = fDoj02.bounds;
							bounds04.x = fDoj02.x;
							bounds04.y = fDoj02.y;
							if (bounds03.intersects(bounds04)){
								fCheckHit02 = true;
								//trace("fCheckHit02");
								break;
							}
						}
					}
					
					if (!fCheckHit02) {
						_displayHero.x++;
					}
					
					/*while (PixelCollisionDetection.isColliding(_backgroundFront, _player001._hitDown, DisplayManage.get_WAR(), true)) {
						_player001.y--;
					}*/
				}
			}
			
			//_displayMiddle.rotation = deg2rad(_angle++);
			
			//_displayHero.rotation = deg2rad(_angle++);
			
			//物理
			/*if (_displayFront.hitTest(new Point(_mouseX-_displayFront.x, _mouseY-_displayFront.y), false)) {
http://wiki.starling-framework.org/extensions/pixel_perfect_touch				trace("命中");
			}*/
			
			/*if (_displayHero.hitTest(new Point(_mouseX - _displayHero.x, _mouseY - _displayHero.y), false)) {
				trace("命中");
			}*/
			
			/*for (i = 0; i < 3; i++) {
				//trace("point = " + _point);
				if (!_displayHero._down.hitTest(new Point(_point.x - _displayHero.x, _point.y - _displayHero.y))) {
					//trace("_player001.rotation Left = "+_player001.rotation);
					_displayHero.y++;
				}
			}*/
			
			for (i = 0; i < 3; i++) {
				var bounds1:Rectangle = _displayHero._down.bounds;
				bounds1.x = _displayHero.x;
				bounds1.y = _displayHero.y;
				
				var fCheckHit:Boolean = false;
				
				//var bounds2:Rectangle = _displayFront.getBounds(_displayFront);

				for (var j:int = 0; j < fNum;j++ ) {
					var fDo:DisplayObject = _displayFront.getChildAt(j);
					
					if (fDo) {
						var bounds2:Rectangle = fDo.bounds;
						bounds2.x = fDo.x;
						bounds2.y = fDo.y;
						if (bounds1.intersects(bounds2)){
							fCheckHit = true;
							break;
						}
					}
				}
				
				
				if (fCheckHit){
					//trace("Collision!");
				}else {
					_displayHero.y++;
				}

			}
			
			
			/*for (i = 0; i < 2; i++) {
				if (!PixelCollisionDetectionStarling.isColliding(_displayFront, _displayHero._left, GlobalData.GAME_WORLD.stage, true)) {
					//trace("_player001.rotation Left = "+_player001.rotation);
					_displayHero.x--;
					
					while (PixelCollisionDetectionStarling.isColliding(_displayFront, _displayHero._down, GlobalData.GAME_WORLD.stage, true)) {
						_displayHero.y--;
					}
				}
			}*/
			
			/*if (PixelCollisionDetectionStarling.isColliding(_displayFront, _displayHero._down, GlobalData.GAME_WORLD.stage, true)) {
				trace("check Colliding YES");
			}else {
				trace("check Colliding NO");
				_displayHero.y++;
			}*/
			
		}
		
		/**
		 * checkPlayerHit
		 * @param	targetRect 目标
		 * @param	floorDisplay 场景(包含子集)
		 * @return
		 */
		private function checkPlayerHit(targetRect:Rectangle, floorDisplay:Sprite):Boolean {
			var fBtnReturn:Boolean = false;
			var fTargetRect:Rectangle = targetRect;
			var fFloorDisplay:Sprite = floorDisplay;
			
			var fNumChildren:int = fFloorDisplay.numChildren;
			
			for (var j:int = 0; j < fNumChildren; j++) {
				var fDo:DisplayObject = fFloorDisplay.getChildAt(j);
				if (fDo) {
					var floorRect:Rectangle = fDo.bounds;
					floorRect.x = fDo.x;
					floorRect.y = fDo.y;
					
					if (fTargetRect.intersects(floorRect)){
						fBtnReturn = true;
						break;
					}
				}
			}
			return fBtnReturn;
		}
		
	}

}