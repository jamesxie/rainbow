package com.yxg.text {
	import com.yxg.log4f.Level;
	import com.yxg.log4f.Logger;
	
	import flash.text.TextField;	

	/**
	 * @author James
	 * @version 1.0
	 * @date 2008-12-21
	 * @name 文字常用描边（包边）样式 CSS
	 */
	/**
	 * Example 例子<br>
	 * ----------------------------------------<br>
	 * import com.xskip.project.aoh.text.TextCss;
	 * TextCss.CssDefault(_mc_text01);
	 * TextCss.CssItemLv0(_mc_text02);
	 * TextCss.CssItemLv1(_mc_text03);
	 * TextCss.CssItemLv2(_mc_text04);
	 * TextCss.CssItemLv3(_mc_text05);
	 * TextCss.CssItemLv4(_mc_text06);
	 * TextCss.CssItemLv5(_mc_text07);
	 * ----------------------------------------<br>
	 */
	public class TextCss extends TextStroke {
		private static var _instance : TextCss;
		private var logger : Logger;

		public function TextCss() : void {
			logger = new Logger();
			logger.setName("TextCss.as");
			logger.setLevel(Level.ALL);
			logger.info("Start!");
			super();
		}
		
		//用户自定义CSS
		public static function CssUserDefined(textField : TextField,color1:Number,color2:Number) : void {
			if (_instance == null) {
				_instance = new TextCss();
			}
			_instance.setStroke(textField, color1, color2);
		}

		//白字黑边 默认
		public static function CssDefault(textField : TextField) : void {
			if (_instance == null) {
				_instance = new TextCss();
			}
			_instance.setStroke(textField);
		}
		
		//黑字白边 默认
		public static function CssDefault2(textField : TextField) : void {
			if (_instance == null) {
				_instance = new TextCss();
			}
			_instance.setStroke(textField, 0x000000, 0xFFFFFF);
		}

		//灰字黑边 破损装备
		public static function CssItemLv0(textField : TextField) : void {
			if (_instance == null) {
				_instance = new TextCss();
			}
			_instance.setStroke(textField, 0x999999, 0x333333);
		}

		//白字灰黑边 普通装备
		public static function CssItemLv1(textField : TextField) : void {
			if (_instance == null) {
				_instance = new TextCss();
			}
			_instance.setStroke(textField, 0xFFFFFF, 0x2B2B2B);
		}

		//绿字深绿边 高级装备
		public static function CssItemLv2(textField : TextField) : void {
			if (_instance == null) {
				_instance = new TextCss();
			}
			_instance.setStroke(textField, 0x00FF00, 0x003300);
		}

		//天蓝字深蓝边 超级装备
		public static function CssItemLv3(textField : TextField) : void {
			if (_instance == null) {
				_instance = new TextCss();
			}
			_instance.setStroke(textField, 0x00FFFF, 0x003542);
		}

		//紫红字深红边 逆天装备
		public static function CssItemLv4(textField : TextField) : void {
			if (_instance == null) {
				_instance = new TextCss();
			}
			_instance.setStroke(textField, 0xFF00FF, 0x3E003E);
		}

		//金铜字 史诗装备
		public static function CssItemLv5(textField : TextField) : void {
			if (_instance == null) {
				_instance = new TextCss();
			}
			_instance.setStroke(textField, 0xFFCC66, 0x392600);
		}

		//暗金铜字 JWindow Title
		public static function CssJWindowTitleText(textField : TextField) : void {
			if (_instance == null) {
				_instance = new TextCss();
			}
			_instance.setStroke(textField, 0x693108, 0xF8D058);
		}

		//深绿字黄边 JWindow Title 人物名称
		public static function CssJWindowTitleNPCName(textField : TextField) : void {
			if (_instance == null) {
				_instance = new TextCss();
			}
			_instance.setStroke(textField, 0x003300, 0xFFFF00);
		}

		//深绿字白边 JWindow Content 任务信息
		public static function CssJWindowContentJobInfo(textField : TextField) : void {
			if (_instance == null) {
				_instance = new TextCss();
			}
			_instance.setStroke(textField, 0x006600, 0xFFFFFF);
		}

		//深棕字白边 JWindow Content 货币和数字
		public static function CssJWindowContentMoneyNumber(textField : TextField) : void {
			if (_instance == null) {
				_instance = new TextCss();
			}
			_instance.setStroke(textField, 0x6B3309, 0xFFFFFF);
		}

		//深棕字白边  JButton Text 按钮文字
		public static function CssJButtonText(textField : TextField) : void {
			if (_instance == null) {
				_instance = new TextCss();
			}
			_instance.setStroke(textField, 0x6B3309, 0xFFFFFF);
		}

		//黄字深棕边 JButton Text 按钮文字 选中状态
		public static function CssJButtonText_OVER(textField : TextField) : void {
			if (_instance == null) {
				_instance = new TextCss();
			}
			_instance.setStroke(textField, 0xFFFF00, 0x6B3309);
		}
	}
}
