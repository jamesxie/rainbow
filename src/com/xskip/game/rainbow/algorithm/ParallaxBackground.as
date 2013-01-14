package com.xskip.game.rainbow.algorithm 
{
	import com.xskip.game.rainbow.database.GlobalData;
	import com.xskip.game.rainbow.player.HeroView;
	import com.yxg.utils.PixelCollisionDetection;
	import com.yxg.utils.PixelCollisionDetectionStarling;
	import flash.geom.Point;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
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
		private var _displayFront:Quad;
		
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
		
		private var _point:Point;
		
		public function ParallaxBackground(parmBack:Quad, parmMiddle:Quad, parmFront:Quad, parmHero:HeroView) 
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
			
			
			_point = new Point(_displayHero.x, _displayFront.y);
			var quad:Quad = new Quad(2, 2, 0xFF0000);
			quad.x = _point.x;
			quad.y = _point.y;
			GlobalData.GAME_WORLD.stage.addChild(quad);
			
			
			GlobalData.GAME_WORLD.stage.addEventListener(TouchEvent.TOUCH, onTouchedSprite); 
			
			//GlobalData.GAME_WORLD.stage.advanceTime
			GlobalData.GAME_WORLD.stage.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			
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
			
			//_displayMiddle.rotation = deg2rad(_angle++);
			
			//_displayHero.rotation = deg2rad(_angle++);
			
			//物理
			/*if (_displayFront.hitTest(new Point(_mouseX-_displayFront.x, _mouseY-_displayFront.y), false)) {
http://wiki.starling-framework.org/extensions/pixel_perfect_touch				trace("命中");
			}*/
			
			/*if (_displayHero.hitTest(new Point(_mouseX - _displayHero.x, _mouseY - _displayHero.y), false)) {
				trace("命中");
			}*/
			
			for (i = 0; i < 3; i++) {
				//trace("point = " + _point);
				if (!_displayHero._down.hitTest(new Point(_point.x - _displayHero.x, _point.y - _displayHero.y))) {
					//trace("_player001.rotation Left = "+_player001.rotation);
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
			
		}
		
	}

}