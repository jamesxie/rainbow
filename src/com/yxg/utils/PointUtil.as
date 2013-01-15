package com.yxg.utils {
	import flash.geom.Point;				

	/**
	 * @author JamesXie
	 * @version 1.0
	 * @date Nov 12, 2009
	 * @name 点、线、面以及角度的工具类
	 */
	public class PointUtil {

		public function pointUtil() : void {
			init();
		}

		private function init() : void {
		}

		/**
		 * 在两点之间设置N个等距离的点
		 * @param p1 起始点
		 * @param p2 终点
		 * @param numP 点的数量
		 * @return Array(Point)
		 */
		public static function tweenPoint(p1 : Point,p2 : Point,numP : int = 1) : Array {
			var fArr : Array = new Array();
			for (var i : Number = 1;i <= numP; i++) {
				//以下两个方法只能二选一
				
				//优化的点 点坐标取整 方法二
				//var fPoint:Point=Point.interpolate(p1, p2, 1 - i / (numP + 1));
				//fPoint.x=int(fPoint.x);
				//fPoint.y=int(fPoint.y);
				//fArr.push(fPoint);
				
				//未优化的点 方法一
				fArr.push(Point.interpolate(p1, p2, 1 - i / (numP + 1)));
			}
			return fArr;
		}

		
		/**
		 * 在两点之间设置固定距离来设置若干点
		 * @param p1 起始点
		 * @param p2 终点
		 * @param numP 点之间的距离
		 * @return Array(Point)
		 */
		public static function tweenDistance(p1 : Point,p2 : Point,numD : int = 1) : Array {
			var fArr : Array = new Array();
			var fDis : Number = Point.distance(p1, p2);
			if (fDis > numD) {
				fDis = fDis / numD;
				fArr = PointUtil.tweenPoint(p1, p2, Math.floor(fDis) - 1);
			} else {
				//alert("[Error][pointUtil]设置的间距大于两点间的距离");
			}
			return fArr;
		}

		/**
		 * 多点路径修正和缩放 重设坐标
		 * @param arr 标记点 Array(Point)
		 * @param zoomX X轴缩放
		 * @param zoomY Y轴缩放
		 * @param fixX
		 * @param fixY
		 */
		public static function tweenFixZoom(arr : Array,zoomX : int = 1,zoomY : int = 1,fixX : int = 0,fixY : int = 0) : Array {
			var fArr : Array = new Array();
			//重设坐标
			for (var i : Number = 0;i < arr.length; i++) {
				var fP : Point = new Point();
				fP.x = Point(arr[i]).x * zoomX + fixX;
				fP.y = Point(arr[i]).y * zoomY + fixY;
				fArr.push(fP);
			}
			return fArr;
		}

		/**
		 * 在多点之间设置固定距离来设置若干点
		 * @param arr 标记点 Array(Point)
		 * @param numD 点间隔
		 */
		public static function tweenMorePointDistance(arr : Array,numD : int = 1) : Array {
			var fArr : Array = new Array();
			fArr.push(arr[0]);
			for (var n : int = 1;n < arr.length; n++) {
				fArr = fArr.concat(tweenDistance(Point(arr[n - 1]), Point(arr[n]), numD));
				fArr.push(arr[n]);
			}
			return fArr;
		}

		
		/**
		 * 设置圆周和半径以及角度来描绘圆形路劲点<br>
		 * @INFO
		 * 从弧度转换到角度的公式为：角度=(弧度/Math.PI)*180;<br>
		 * 从角度转换到弧度的公式为：弧度=(角度/180)*Math.PI;<br>
		 * @param angle 角度
		 * @param radius 半径
		 * @param numPoint 点数量
		 * @param x 圆心X
		 * @param y 圆心Y
		 * @return Array(Point)
		 */
		public static function drawAngleCirclePoint(angle : int = 1,radius : int = 100,numPoint : int = 1,x : int = 0,y : int = 0) : Array {
			var fArr : Array = new Array();
			if (numPoint > 0) {
				for (var i : Number = 0;i < numPoint; i++) {
					var fPoint : Point = Point.polar(radius, (i * angle / 180) * Math.PI);
					fPoint.offset(x, y);
					fArr.push(fPoint);
				}
			}
			return fArr;
		}

		
		/**
		 * 根据两个点返回其角度( 0 ~ ±180 )
		 * @param p1 起始点
		 * @param p2 终点
		 * @return 角度
		 */
		public static function pointToAngle180(p1 : Point, p2 : Point) : Number {
			return Math.atan2(p2.y - p1.y, p2.x - p1.x) * 180 / Math.PI;
		}

		
		/**
		 * 根据两个点返回其角度( 0 ~ 360 )
		 * @param p1 起始点
		 * @param p2 终点
		 * @param useClockType (默认true使用时钟夹角方式) (false 数学夹角方式)
		 * @return 角度
		 */
		public static function pointToAngle360(p1 : Point, p2 : Point, useClockType : Boolean = true) : Number {
			var fP : Number = PointUtil.pointToAngle180(p1, p2);
			
			if (useClockType) {
				fP += 90;
			}
			
			if (fP < 0) {
				fP += 360;
			}
			
			return fP;
		}

	}
}
