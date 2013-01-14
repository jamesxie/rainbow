package com.xskip.game.rainbow.algorithm 
{
	import com.xskip.game.rainbow.database.GlobalData;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.events.Event;
	/**
	 * 视差背景
	 * 所属 View
	 * @author XIEJ
	 */
	public class ParallaxBackground_bak
	{
		private var _displayBack:DisplayObject;
		private var _displayMiddle:DisplayObject;
		private var _displayFront:Quad;
		
		
		private var r:Number = 0; 
		private var g:Number = 0; 
		private var b:Number = 0; 
		
		private var rDest:Number = 0;
		private var gDest:Number = 0;
		private var bDest:Number = 0;
		
		public function ParallaxBackground_bak(parmBack:DisplayObject, parmMiddle:DisplayObject, parmFront:Quad) 
		{
			_displayBack = parmBack;
			_displayMiddle = parmMiddle;
			_displayFront = parmFront;
			
			init();
		}
		
		private function init():void {
			
			resetColors();
			
			GlobalData.GAME_WORLD.stage.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			
		}
		
		private function onEnterFrameHandler(e:Event):void {
			//trace("run it");
			if (_displayBack.x > GlobalData.GAME_WORLD.stage.stageWidth) {
				_displayBack.x = -_displayBack.width;
			}
			
			_displayBack.x ++;
			
			r -= (r - rDest) * .01;
			g -= (g - gDest) * .01; 
			b -= (b - bDest) * .01; 
			var color:uint = r << 16 | g << 8 | b; 
			
			//trace("color = "+color);
			
			_displayFront.color = color;
			
			// when reaching the color, pick another one 
			if ( Math.abs( r - rDest) < 1 && Math.abs( g - gDest) < 1 && Math.abs( b - bDest)){
				resetColors();
			}
		}
		
		private function resetColors():void {
			rDest = Math.random() * 255;
			gDest = Math.random() * 255;
			bDest = Math.random() * 255;
		}
		
	}

}