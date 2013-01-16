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
		
		private var _xSpeed:Number;
		private var _ySpeed:Number;
		
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
			
			_xSpeed = 0;
			_ySpeed = 0;
			
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
			if (touch){
				_mouseX = touch.globalX;
				_mouseY = touch.globalY;
			}
			//trace("_mouseX " + _mouseX + " _mouseY " + _mouseY);
		}
		
		private function onEnterFrameHandler(e:Event):void {
			//trace("run it");
			if (_displayMiddle.x > GlobalData.GAME_WORLD.stage.stageWidth) {
				_displayMiddle.x = -_displayMiddle.width;
			}
			
			_displayMiddle.x ++;
			
			var fNum:int = _displayFront.numChildren;
			var boundsDown:Rectangle = _displayHero._down.bounds;
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
			
			var blnIsLand:Boolean = false;
			boundsDown.x = _displayHero.x;
			boundsDown.y = _displayHero.y;
			blnIsLand = checkPlayerHit(boundsDown, _displayFront);
			
			//JUMP CODE
			if (_onKeyboardJump && blnIsLand) {
				_ySpeed = -15;
			}
			_ySpeed++;
			
			var boundsJump:Rectangle = _displayHero.bounds;
			
			//TODO 需要向四周扩大 boundsJump

			if (_ySpeed > 0) {
				for (i = 0; i < _ySpeed; i++) {
					var blnBoundsJump01:Boolean = false;
					
					boundsJump.x = _displayHero.x;
					boundsJump.y = _displayHero.y;
					
					blnBoundsJump01 = checkPlayerHit(boundsJump, _displayFront);
					if (!blnBoundsJump01){
						_displayHero.y++;
					} else {
						_ySpeed = 0;
					}
				}
			} else {
				for (i = 0; i < Math.abs(_ySpeed); i++) {
					var blnBoundsJump02:Boolean = false;
					//boundsJump.x = _displayHero.x;
					//boundsJump.y = _displayHero.y;
					blnBoundsJump02 = checkPlayerHit(boundsJump, _displayFront);
					if (!blnBoundsJump02){
						_displayHero.y--;
					} else {
						_ySpeed = 0;
					}
				}
			}
			
			
			//LEFT CODE
			if (_onKeyboardLeft) {
				for (i = 0; i < 5; i++ ) {
					var boundsLeft:Rectangle = _displayHero._left.bounds;
					boundsLeft.x = _displayHero.x + _displayHero._left.x;
					boundsLeft.y = _displayHero.y + _displayHero._left.y;
					var fCheckLeftHit:Boolean = false;
					fCheckLeftHit = checkPlayerHit(boundsLeft, _displayFront);
					if (!fCheckLeftHit) {
						_displayHero.x--;
					}
				}
			}
			
			//RIGHT CODE
			if (_onKeyboardRight) {
				for (i = 0; i < 5; i++ ) {
					
					var boundsRight:Rectangle = _displayHero._right.bounds;
					boundsRight.x = _displayHero.x + _displayHero._right.x;
					boundsRight.y = _displayHero.y + _displayHero._right.y;
					var fCheckRightHit:Boolean = false;
					fCheckRightHit = checkPlayerHit(boundsRight, _displayFront);
					if (!fCheckRightHit) {
						_displayHero.x++;
					}
				}
			}
			
			//gravity CODE
			for (i = 0; i < 3; i++) {
				boundsDown.x = _displayHero.x;
				boundsDown.y = _displayHero.y;
				var fCheckGravityHit:Boolean = false;
				fCheckGravityHit = checkPlayerHit(boundsDown, _displayFront);
				if (!fCheckGravityHit){
					_displayHero.y++;
				}
			}
			
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
					floorRect.x = fFloorDisplay.x + fDo.x;
					floorRect.y = fFloorDisplay.y + fDo.y;
					
					if (fTargetRect.intersects(floorRect)) {
						fBtnReturn = true;
						break;
					}
				}
			}
			return fBtnReturn;
		}
		
	}

}