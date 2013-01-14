﻿package gear.ui.skin.btn {
	import gear.ui.core.PhaseState;
	import gear.ui.manager.GUIUtil;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	/**
	 * 按钮皮肤
	 * 
	 * upSkin 正常
	 * overSkin 鼠标滑入
	 * downSkin 鼠标按下
	 * 
	 * @author bright
	 * @version 20120809
	 */
	public class ButtonSkin implements IButtonSkin {
		protected var _upSkin : DisplayObject;
		protected var _overSkin : DisplayObject;
		protected var _downSkin : DisplayObject;
		protected var _disabledSkin : DisplayObject;
		protected var _current : DisplayObject;

		public function ButtonSkin(upSkin : DisplayObject, overSkin : DisplayObject = null, downSkin : DisplayObject = null, disabledSkin : DisplayObject = null) {
			_upSkin = upSkin;
			_overSkin = overSkin;
			_downSkin = downSkin;
			_disabledSkin = disabledSkin;
		}

		public function addTo(parent : DisplayObjectContainer) : void {
			if (_current == null) {
				_current = _upSkin;
			}
			if (_current.parent != parent) {
				parent.addChild(_current);
			}
		}

		public function setSize(width : int, height : int) : void {
			if (_upSkin != null) {
				_upSkin.width = width;
				_upSkin.height = height;
			}
			if (_overSkin != null) {
				_overSkin.width = width;
				_overSkin.height = height;
			}
			if (_downSkin != null) {
				_downSkin.width = width;
				_downSkin.height = height;
			}
			if (_disabledSkin != null) {
				_disabledSkin.width = width;
				_disabledSkin.height = height;
			}
		}

		public function get width() : int {
			return _upSkin.width;
		}

		public function get height() : int {
			return _upSkin.height;
		}

		public function set phase(value : int) : void {
			if (value == PhaseState.UP) {
				_current = GUIUtil.replace(_current, _upSkin);
			} else if (value == PhaseState.OVER) {
				_current = GUIUtil.replace(_current, _overSkin);
			} else if (value == PhaseState.DOWN) {
				_current = GUIUtil.replace(_current, _downSkin);
			} else if (value == PhaseState.DISABLED) {
				_current = GUIUtil.replace(_current, _disabledSkin);
			}
		}

		public function clone() : IButtonSkin {
			return new ButtonSkin(GUIUtil.cloneSkin(_upSkin), GUIUtil.cloneSkin(_overSkin), GUIUtil.cloneSkin(_downSkin), GUIUtil.cloneSkin(_disabledSkin));
		}
	}
}