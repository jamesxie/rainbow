﻿package gear.ui.controls {
	import gear.ui.data.GIconData;
	import gear.ui.data.GRadioButtonData;

	import flash.events.MouseEvent;

	/**
	 * 单选按钮控件
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public class GRadioButton extends GToggleBase {
		/**
		 * @private
		 */
		protected var _data : GRadioButtonData;
		/**
		 * @private
		 */
		protected var _icon : GIcon;
		/**
		 * @private
		 */
		protected var _label : GLabel;

		/**
		 * @private
		 */
		override protected function create() : void {
			var data : GIconData = new GIconData();
			data.x = _data.padding;
			_icon = new GIcon(data);
			_selected = _data.selected;
			_icon.bitmapData = (_data.selected ? _data.selectedUpIcon : _data.upIcon);
			_label = new GLabel(_data.labelData);
			addChild(_data.upSkin);
			addChild(_icon);
			addChild(_label);
		}

		/**
		 * @private
		 */
		override protected function layout() : void {
			_label.x = _data.padding + _icon.width + _data.hGap;
			_width = _icon.width + _data.hGap + _label.width + _data.padding * 2;
			_height = Math.max(_icon.height, _label.height) + _data.padding * 2;
			_icon.y = Math.floor((_height - _icon.height) / 2);
			_label.y = Math.floor((_height - _label.height) / 2);
			_data.upSkin.width = _width;
			_data.upSkin.height = _height;
		}

		/**
		 * @private
		 */
		protected function mouseDownHandler(event : MouseEvent) : void {
			if (!_enabled)
				return;
			if (_group) {
				if (!_selected)
					selected = true;
			} else {
				selected = !_selected;
			}
		}

		/**
		 * @private
		 */
		override protected function onSelect() : void {
			_icon.bitmapData = (_selected ? _data.selectedUpIcon : _data.upIcon);
		}

		/**
		 * @private
		 */
		override protected function onEnabled() : void {
			_icon.gray = !_enabled;
			_label.enabled = _enabled;
		}

		/**
		 * @private
		 */
		override protected  function onShow() : void {
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		}

		/**
		 * @private
		 */
		protected override function onHide() : void {
			removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		}

		/**
		 * @inheritDoc
		 */
		public function GRadioButton(data : GRadioButtonData) {
			_data = data;
			super(data);
		}
	}
}
