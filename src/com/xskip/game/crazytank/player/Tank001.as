package com.xskip.game.crazytank.player 
{
	import com.xskip.game.crazytank.asset.AssetCenter;
	import com.xskip.game.crazytank.asset.AssetList;
	import com.xskip.game.crazytank.database.DataPlayer;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import gear.utils.GBDUtil;
	/**
	 * ...
	 * @author XIEJ
	 */
	public class Tank001 extends Sprite
	{
		private var _data:DataPlayer;
		
		private var _spTankBMP:Sprite;
		
		private var _spBG:Sprite;
		private var _spGUN:Sprite;
		
		private var _bg:Bitmap;
		private var _gun:Bitmap;
		
		//最大最小角度
		private static const AngleMin:int = -60;
		private static const AngleMax:int = 0;
		
		private var _angle:int;
		
		//最大最小力量
		private static const PowerMin:int = 0;
		private static const PowerMax:int = 100;
		private var _power:int;
		
		private var _allowControl:Boolean;
		
		//TankWidth/2
		private static const TankWidthHalf:int = 15;
		
		public var _hitBaseLeft:Sprite;
		public var _hitBaseRight:Sprite;
		
		public var _hitDown:Sprite;
		public var _hitLeft:Sprite;
		public var _hitRight:Sprite;
		
		public var _tankSpeed:int;
		
		public var _tankAngleSpeed:int;
		
		//角度趋势
		public var _tankAngleTrend:int;
		
		//坦克角度限制
		public static const TankAngleLimit:int = 43;
		
		private static const TankFixRotation:Number = 0.4;
		
		//当角度在旋转中 大于0 禁止移动 （旋转中禁止移动）
		private var _allowMove:Number;
		
		//是否镜像 1为 向右 -1为向左
		private var _scaleX:int;
		
		public function Tank001() 
		{
			init();
		}
		
		private function init():void {
			
			//旋转
			this.rotation = 0;
			
			_allowControl = true;
			
			_angle = 0;
			_power = 0;
			
			_tankAngleTrend = 0;
			
			_allowMove = 0;
			
			_scaleX = 1;
			
			//绘制中心点看看
			/*this.graphics.beginFill(0xFF0000);
			this.graphics.drawCircle(0, 0, 3);
			this.graphics.endFill();*/
			
			_spBG = new Sprite();
			_spGUN = new Sprite();
			
			_bg = new Bitmap();
			_gun = new Bitmap();
			
			_bg.bitmapData = BitmapData(AssetCenter.getValues(AssetList.TANK_001)).clone();
			_gun.bitmapData = BitmapData(AssetCenter.getValues(AssetList.TANK_002)).clone();
			
			_bg.x = -(_bg.width / 2);
			_bg.y = -(_bg.height);
			_spBG.addChild(_bg);
			
			_gun.x = -4;
			_gun.y = -(_gun.height/2);
			
			_spGUN.addChild(_gun);
			//改小
			//_spGUN.x = 10;
			//_spGUN.y = -46;
			_spGUN.x = 8;
			_spGUN.y = -24;
			
			_spTankBMP = new Sprite();
			this.addChild(_spTankBMP);
			
			_spTankBMP.addChild(_spBG);
			_spTankBMP.addChild(_spGUN);
			
			
			//碰撞监测底座
			_hitBaseLeft = new Sprite();
			_hitBaseLeft.graphics.beginFill(0xFFFF00);
			_hitBaseLeft.graphics.drawRect(-TankWidthHalf, -1, TankWidthHalf, 2);
			_hitBaseLeft.graphics.endFill();
			
			_hitBaseRight = new Sprite();
			_hitBaseRight.graphics.beginFill(0xFF0000);
			_hitBaseRight.graphics.drawRect(0, -1, TankWidthHalf, 2);
			_hitBaseRight.graphics.endFill();
			
			_hitBaseLeft.visible = false;
			_hitBaseRight.visible = false;
			
			this.addChild(_hitBaseLeft);
			this.addChild(_hitBaseRight);
			
			//设置内容
			/*_hitDown = new Sprite();
			_hitDown.graphics.beginFill(0xFF0000);
			_hitDown.graphics.drawRect(x - 19, y - 1, 38, 1);
			_hitDown.graphics.endFill();
			
			_hitLeft = new Sprite();
			_hitLeft.graphics.beginFill(0xFFFF00);
			_hitLeft.graphics.drawRect(x - 20, y - 30, 1, 27);
			_hitLeft.graphics.endFill();
			
			_hitRight = new Sprite();
			_hitRight.graphics.beginFill(0xFF6600);
			_hitRight.graphics.drawRect(x + 19, y - 30, 1, 27);
			_hitRight.graphics.endFill();*/
			
			//设置内容 缩小三像素
			_hitDown = new Sprite();
			_hitDown.graphics.beginFill(0xFF0000);
			_hitDown.graphics.drawRect(x - 15, y - 1, 30, 1);
			_hitDown.graphics.endFill();
			
			_hitLeft = new Sprite();
			_hitLeft.graphics.beginFill(0xFFFF00);
			_hitLeft.graphics.drawRect(x - 17, y - 30, 1, 27);
			//_hitLeft.graphics.drawRect(x - 17, y - 30, 1, 24);
			_hitLeft.graphics.endFill();
			
			_hitRight = new Sprite();
			_hitRight.graphics.beginFill(0xFF6600);
			_hitRight.graphics.drawRect(x + 16, y - 30, 1, 27);
			//_hitRight.graphics.drawRect(x + 16, y - 30, 1, 24);
			_hitRight.graphics.endFill();
			
			
			this.addChild(_hitDown);
			this.addChild(_hitLeft);
			this.addChild(_hitRight);
			
			_hitDown.visible = false;
			_hitLeft.visible = false;
			_hitRight.visible = false;
			
			_tankSpeed = 0;
			
			_tankAngleSpeed = 0;
			
		}
		
		//旋转角度受限
		override public function set rotation(value:Number):void {
			if (value > -TankAngleLimit && value < TankAngleLimit) {
				
				if (super.rotation == value) {
					_allowMove ++;
				}
				
				super.rotation = value;
				
				if (_hitBaseLeft && _hitBaseRight) {
					var fFixY:Number = Math.floor(Math.abs(super.rotation) / 10) * TankFixRotation;
					
					//XXX 2012-12-28
					_hitDown.y = -fFixY * 0.5;
					
					if (super.rotation > 0) {
						_hitRight.y = -fFixY;
						//标准长度 加角度变化后 加成
						_hitLeft.y = fFixY;
					}else {
						_hitLeft.y = -fFixY;
						//标准长度 加角度变化后 加成
						_hitRight.y = fFixY;
					}
				}
				
			}else {
				//trace("super.rotation == " + super.rotation);
			}
		}
		
		
		//移动受限
		override public function set x(value:Number):void {
			if (value < super.x) {
				if (_allowMove > 0) {
					_allowMove-= 0.33;
					return;
				}
				
				if (super.rotation < TankAngleLimit) {
					super.x = value;
					
					if (_scaleX!=-1) {
						_scaleX = -1;
						this._spTankBMP.scaleX = _scaleX;
					}
					
				}else {
					trace("super.rotation -- " + super.rotation);
				}
			}
			if (value > super.x) {
				if (_allowMove > 0) {
					_allowMove--;
					return;
				}
				
				if (super.rotation > -TankAngleLimit) {
					super.x = value;
					
					if (_scaleX!=1) {
						_scaleX = 1;
						this._spTankBMP.scaleX = _scaleX;
					}
					
				}else {
					trace("super.rotation ++ " + super.rotation);
				}
			}
		}
		
		public function gunAngleChange(pUP:Boolean = true) :void {
			if (!_allowControl) {
				return;
			}
			
			if (pUP) {
				_angle-= 1;
				if (_angle < AngleMin) {
					_angle = AngleMin;
				}
				
			}else {
				_angle += 1;
				if (_angle > AngleMax) {
					_angle = AngleMax;
				}
			}
			_spGUN.rotation = _angle;
		}
		
		public function gunAngle():Number {
			return _spGUN.rotation;
		}
		
		//最终发射角度
		public function finalAngle():int {
			var fReturn:Number = 0;
			fReturn = gunAngle();
			if (this.stage) {
				fReturn += this.rotation;
			}
			
			//trace("前角度 = " + fReturn);
			
			//镜向
			if (_scaleX == -1) {
				fReturn = this.rotation + 180;
				fReturn += -(gunAngle());
			}
			
			//trace("后角度 = " + fReturn);
			
			return int(fReturn);
		}
		
		public function set gunPower(pPower:int):void {
			if (!_allowControl) {
				return;
			}
			
			_power = pPower;
			
			if (_power > PowerMax) {
				_power = PowerMax;
			}
		}
		
		public function get gunPower():int {
			return _power;
		}
		
		public function get data():DataPlayer {
			return _data;
		}
		
		public function set data(p:DataPlayer):void {
			_data = p;
		}
		
		public function clear():void {
			if (this.stage) {
				while(_spTankBMP.numChildren > 0) {
					_spTankBMP.removeChildAt(0);
					removeChild(_spTankBMP);
				}
				
				this.parent.removeChild(this);
			}
		}
		
	}

}