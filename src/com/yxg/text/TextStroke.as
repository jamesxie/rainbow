package com.yxg.text {
	import com.yxg.log4f.Level;
	import com.yxg.log4f.Logger;
	
	import flash.filters.GlowFilter;
	import flash.text.TextField;	

	/**
	 * @author James
	 * @version 1.0
	 * @date 2008-12-20
	 * @name 文字描边,文字包边
	 */
	/**
	 * Example 例子<br>
	 * ----------------------------------------<br>
	 * import com.xskip.filters.TextStroke;
	 * var textStroke1:TextStroke=new TextStroke();
	 * //白字黑边
	 * textStroke1.setStroke(_mc_text01);
	 * //灰字黑边 破损装备
	 * textStroke1.setStroke(_mc_text02,0x999999,0x333333);
	 * //白字灰黑边 普通装备
	 * textStroke1.setStroke(_mc_text03,0xFFFFFF,0x2B2B2B);
	 * //绿字深绿边 高级装备
	 * textStroke1.setStroke(_mc_text04,0x00FF00,0x003300);
	 * //天蓝字深蓝边 超级装备
	 * textStroke1.setStroke(_mc_text05,0x00FFFF,0x003542);
	 * //紫红字深红边 逆天装备
	 * textStroke1.setStroke(_mc_text06,0xFF00FF,0x3E003E);
	 * //金铜字 史诗装备
	 * textStroke1.setStroke(_mc_text07,0xFFCC66,0x392600);
	 * //暗金铜字 JWindow Title
	 * textStroke1.setStroke(_mc_text08,0x693108,0xF8D058);
	 * //深绿字黄边 JWindow Title 人物名称
	 * textStroke1.setStroke(_mc_text09,0x003300,0xFFFF00);
	 * //深绿字白边 JWindow Content 任务信息
	 * textStroke1.setStroke(_mc_text10,0x006600,0xFFFFFF);
	 * //深棕字白边 JWindow Content 货币和数字 JButton Text 按钮文字
	 * textStroke1.setStroke(_mc_text11,0x6B3309,0xFFFFFF);
	 * //黄字深棕边 JButton Text 按钮文字 选中状态
	 * textStroke1.setStroke(_mc_text12,0xFFFF00,0x6B3309);
	 * ----------------------------------------<br>
	 */
	public class TextStroke {
		private var logger : Logger;

		private var _textField : TextField;

		private var _textColor : Number = 0xFFFFFF;
		private var _color : Number = 0x000000;
		private var _alpha : Number = 1;
		private var _blurX : Number = 2;
		private var _blurY : Number = 2;
		private var _strength : Number = 10;
		private var _quality : Number = 3;

		public function TextStroke() : void {
			logger = new Logger();
			logger.setName("TextStroke.as");
			logger.setLevel(Level.ALL);
			//logger.info("Start!");
		}

		public function setStroke(textField : TextField,textColor : Number = 0xFFFFFF,color : Number = 0x00000,alpha : Number = 1,blurX : Number = 2,blurY : Number = 2,strength : Number = 10,quality : Number = 1) : void {
			_textField = textField;
			_textColor = textColor;
			_color = color;
			_alpha = alpha;
			_blurX = blurX;
			_blurY = blurY;
			_strength = strength;
			_quality = quality;
			setFilter();
		}

		private function setFilter() : void {
			_textField.textColor = _textColor;
			_textField.filters = [new GlowFilter(_color, _alpha, _blurX, _blurY, _strength, _quality)];
		}
	}
}
