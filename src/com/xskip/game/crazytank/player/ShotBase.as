package com.xskip.game.crazytank.player
{
	import com.xskip.game.crazytank.database.GlobalData;
	import com.yxg.utils.PointUtil;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	/**
	 * 子弹
	 * @author XIEJ
	 */
	public class ShotBase extends Sprite
	{
		private var _owner:Tank001;
		
		private var _maxSpeed:Number;
		
		private var _xSpeed:Number;
		private var _ySpeed:Number;
		
		//private var _timer:Timer;
		private var _funHitCallBack:Function;
		
		private var _funEndCallBack:Function;
		
		private static const fireVelocity:Number = 40;
		
		//X\Y speed
		private var _xVelocity:Number;
		private var _yVelocity:Number;
		
		private var _initAngle:Number;
		
		private var _lastPoint:Point;
		private var _nowPoint:Point;
		
		public function ShotBase(pTarget:Tank001,hitFun:Function , endFun:Function)
		{
			_owner = pTarget;
			
			_funHitCallBack = hitFun;
			
			_funEndCallBack = endFun;
			
			this.addEventListener(Event.ADDED, init);
		}
		
		private function init(e:Event):void
		{
			//越小越快
			_maxSpeed = 3;
			
			draw();
			
			//_initAngle = _owner.finalAngle() - 90;
			
			var fOwner:Number = _owner.finalAngle();
			
			_initAngle = fOwner * Math.PI / 180;
			
			//trace("_initAngle = " + _initAngle);
			
			this.rotation = _owner.finalAngle();
			
			//trace("_owner.gunPower = "+_owner.gunPower);
			
			var fFirePower:Number = (_owner.gunPower/100) * fireVelocity;
			
			_xVelocity = Math.cos(_initAngle) * fFirePower;
			_yVelocity = Math.sin(_initAngle) * fFirePower;
			
			_lastPoint = new Point(0, 0);
			_nowPoint = new Point(0, 0);
			
			this.addEventListener(Event.ENTER_FRAME, onTimerHandler);
		
		}
		
		private function onTimerHandler(e:Event):void
		{
			var fAllowDestroy:Boolean = false;
			
			if (GlobalData.GAME_PAUSE)
			{
				return;
			}
			
			if (y > 1200) {
				fAllowDestroy = true;
			}
			
			if (!fAllowDestroy){
				var fBln:Boolean = false;
				//fBln = Boolean(_funHitCallBack(x, y));
				
				if (_lastPoint.x != 0 && _lastPoint.y != 0 && _nowPoint.x != 0 && _nowPoint.y != 0) {
					fBln = Boolean(_funHitCallBack(_lastPoint, _nowPoint));
				}
				
				if (fBln) {
					fAllowDestroy = true;
				}
			}
			
			if (!fAllowDestroy){
				fly();
			}
			
			if (fAllowDestroy) {
				destroy();
				return;
			}
		}
		
		private function fly():void
		{
			
			_lastPoint.x = _nowPoint.x;
			_lastPoint.y = _nowPoint.y;
			
			x += _xVelocity;
			y += _yVelocity;
			_yVelocity += 0.98;
			
			//摩擦力(风向)
			_xVelocity *= 0.99;
			_yVelocity *= 0.99;
			
			_nowPoint.x = x;
			_nowPoint.y = y;
		}
		
		private function draw():void
		{
			this.graphics.clear();
			
			this.graphics.lineStyle(1, 0x000000);
			this.graphics.beginFill(0xFF6600);
			this.graphics.drawCircle(0,0,6);
			this.graphics.endFill();
			this.graphics.lineStyle(1, 0x000000);
			this.graphics.moveTo(0, 0);
			this.graphics.lineTo(6, 0);
		}
		
		public function destroy():void
		{
			//trace("销毁子弹");
			
			if (this.hasEventListener(Event.ENTER_FRAME))
			{
				this.removeEventListener(Event.ENTER_FRAME, onTimerHandler);
			}
			
			this.parent.removeChild(this);
			this.graphics.clear();
			
			_funEndCallBack();
		}
	
	}

}