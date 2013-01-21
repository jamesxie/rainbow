package com.xskip.game.rainbow.algorithm 
{
	import com.xskip.game.rainbow.database.GlobalData;
	import com.xskip.game.rainbow.player.HeroView;
	import com.yxg.utils.PixelCollisionDetection;
	import com.yxg.utils.PixelCollisionDetectionStarling;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.extensions.advancedjoystick.JoyStick;
	import starling.textures.Texture;
	import starling.utils.deg2rad;
	/**
	 * 视差背景
	 * 所属 View
	 * @author XIEJ
	 */
	public class ParallaxBackground 
	{
		[Embed( source="jump_button.png" )]
		private const class_jump:Class;
		
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
		
		private var _joystick:JoyStick;
		private var _btnJump:Button;
		
		private var _joyTouch:Boolean;
		
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
			
			_joyTouch = false;
			
			_xSpeed = 0;
			_ySpeed = 0;
			
			addJoyPad();
			
			GlobalData.GAME_WORLD.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDownHandler);
			GlobalData.GAME_WORLD.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUpHandler);
			
			GlobalData.GAME_WORLD.stage.addEventListener(TouchEvent.TOUCH, onTouchedSprite); 
			
			//GlobalData.GAME_WORLD.stage.advanceTime
			GlobalData.GAME_WORLD.stage.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			
		}
		
		private function addJoyPad():void {
			_joystick = new JoyStick();
			//_joystick.setPosition( _joystick.minOffsetX, 600 - _joystick.minOffsetY );
			
			_joystick.x = _joystick.minOffsetX;
			_joystick.y = -_joystick.minOffsetY + GlobalData.GAME_WORLD.stage.stageHeight;
			
			GlobalData.GAME_WORLD.stage.addChild( _joystick );
			
			_btnJump = new Button(Texture.fromBitmap(new class_jump()));
			
			_btnJump.x = GlobalData.GAME_WORLD.stage.stageWidth - _btnJump.width - 50;
			_btnJump.y = GlobalData.GAME_WORLD.stage.stageHeight - _btnJump.height - 50;
			
			GlobalData.GAME_WORLD.stage.addChild( _btnJump );
			
			_btnJump.addEventListener(TouchEvent.TOUCH, onJumpHandler);
		}
		
		private function onJumpHandler(e:TouchEvent):void {
			var touch:Touch = e.getTouch(_btnJump);
			
			//trace("touch = " + touch);
			if (!touch) {
				return;
			}
			if (touch.phase == TouchPhase.BEGAN) {
				_onKeyboardJump = true;
			}
			if (touch.phase == TouchPhase.ENDED) {
				if (_onKeyboardJump) {
					_onKeyboardJump = false;
				}
			}
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
		
		private function checkControl():void {
			if(_joystick.touched)
			{
				_joyTouch = true;
				if (_joystick.velocityX < 0){
					_onKeyboardLeft = true;
					_onKeyboardRight = false;
				}
				if (_joystick.velocityX > 0) {
					_onKeyboardLeft = false;
					_onKeyboardRight = true;
				}
				if (_joystick.velocityX==0) {
					_onKeyboardLeft = false;
					_onKeyboardRight = false;
				}
			}else {
				if (_joyTouch){
					_onKeyboardLeft = false;
					_onKeyboardRight = false;
					_joyTouch = false;
				}
			}
		}
		
		private function onEnterFrameHandler(e:Event):void {
			
			checkControl();
			
			//trace("run it");
			if (_displayMiddle.x > GlobalData.GAME_WORLD.stage.stageWidth) {
				_displayMiddle.x = -_displayMiddle.width;
			}
			
			_displayMiddle.x ++;
			
			var fNum:int = _displayFront.numChildren;
			
			var boundsDown:Rectangle = _displayHero._down.getBounds(GlobalData.GAME_WORLD.stage);
			
			var blnIsLand:Boolean = false;
			
			//boundsDown.x = _displayHero.x;
			//boundsDown.y = _displayHero.y;
			
			blnIsLand = checkPlayerHit(boundsDown, _displayFront);
			
			//JUMP CODE
			if (_onKeyboardJump && blnIsLand) {
				//trace("jump");
				_ySpeed = -15;
			}
			_ySpeed++;
			
			//var boundsJump:Rectangle = _displayHero.bounds;
			var boundsJump:Rectangle = _displayHero._hero.getBounds(GlobalData.GAME_WORLD.stage);
			
			//TODO 需要向四周扩大 boundsJump

			if (_ySpeed > 0) {
				for (i = 0; i < _ySpeed; i++) {
					var blnBoundsJump01:Boolean = false;

					boundsJump = _displayHero._hero.getBounds(GlobalData.GAME_WORLD.stage);
					//boundsJump.x = _displayHero.x;
					//boundsJump.y = _displayHero.y;
					
					blnBoundsJump01 = checkPlayerHit(boundsJump, _displayFront);
					if (!blnBoundsJump01){
						_displayHero.y++;
						//trace("down 01");
					} else {
						_ySpeed = 0;
					}
				}
			} else {
				for (i = 0; i < Math.abs(_ySpeed); i++) {
					var blnBoundsJump02:Boolean = false;
					
					boundsJump = _displayHero._hero.getBounds(GlobalData.GAME_WORLD.stage);
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
					var boundsLeft:Rectangle = _displayHero._left.getBounds(GlobalData.GAME_WORLD.stage);
					//boundsLeft.x = _displayHero.x + _displayHero._left.x;
					//boundsLeft.y = _displayHero.y + _displayHero._left.y;
					var fCheckLeftHit:Boolean = false;
					fCheckLeftHit = checkPlayerHit(boundsLeft, _displayFront);
					if (!fCheckLeftHit) {
						_displayHero.x--;
					}else {
						break;
					}
				}
			}
			
			//RIGHT CODE
			if (_onKeyboardRight) {
				for (i = 0; i < 5; i++ ) {
					var boundsRight:Rectangle = _displayHero._right.getBounds(GlobalData.GAME_WORLD.stage);
					//boundsRight.x = _displayHero.x + _displayHero._right.x;
					//boundsRight.y = _displayHero.y + _displayHero._right.y;
					var fCheckRightHit:Boolean = false;
					fCheckRightHit = checkPlayerHit(boundsRight, _displayFront);
					if (!fCheckRightHit) {
						_displayHero.x++;
					}else {
						break;
					}
				}
			}
			
			//gravity CODE
			for (i = 0; i < 3; i++) {
				boundsDown = _displayHero._down.getBounds(GlobalData.GAME_WORLD.stage);
				
				//boundsDown.x = _displayHero.x;
				//boundsDown.y = _displayHero.y;
				
				var fCheckGravityHit:Boolean = false;
				fCheckGravityHit = checkPlayerHit(boundsDown, _displayFront);
				if (!fCheckGravityHit){
					_displayHero.y++;
					//trace("down 02");
				}else {
					//重力接触后回移一格
					_displayHero.y--;
					break;
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
					var floorRect:Rectangle = fDo.getBounds(GlobalData.GAME_WORLD.stage);
					//floorRect.x = fFloorDisplay.x + fDo.x;
					//floorRect.y = fFloorDisplay.y + fDo.y;
					
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