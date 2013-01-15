package com.yxg.net {
	import com.yxg.log4f.Logger;
	import com.yxg.net.IRESLoader;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;	

	/**
	 * @author com
	 * @version Version 1.00
	 * Date	2008-10-01
	 */
	public class RESLoader extends EventDispatcher implements IRESLoader {

		private var _stream : URLStream;

		protected var _url : String;

		protected var _key : String;

		protected var _label : String;

		protected var _byteArray : ByteArray;

		protected var _isLoadding : Boolean = false;

		protected var _isLoaded : Boolean = false;

		public function RESLoader(url : String,key : String = null,label : String = null) {
			Logger.INFO(this, "RESLoader run");

			this._url = url;
			
			//解析路径使文件名成为key
			if(key == null) {
				var separator : String = (url.indexOf("/") > -1) ? "/" : "\\";
				this._key = this._url.split(separator).pop();
			}
			else this._key = key;
			if(label == null) {
				this._label = this._key;
			}
			else {
				this._label = label;
			}
		}

		private function addListeners() : void {
			this._stream.addEventListener(ProgressEvent.PROGRESS, this.progressHandler);
			this._stream.addEventListener(Event.COMPLETE, this.completeHandler);
			this._stream.addEventListener(IOErrorEvent.IO_ERROR, this.ioErrorHandler);
			this._stream.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityErrorHandler);
		}

		private function removeListeners() : void {
			this._stream.removeEventListener(ProgressEvent.PROGRESS, this.progressHandler);
			this._stream.removeEventListener(Event.COMPLETE, this.completeHandler);
			this._stream.removeEventListener(IOErrorEvent.IO_ERROR, this.ioErrorHandler);
			this._stream.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityErrorHandler);
		}

		private function ioErrorHandler(event : IOErrorEvent) : void {
			this.removeListeners();
			this._stream.close();
			this._isLoadding = false;
			this._isLoaded = false;
			this.dispatchEvent(new Event(Event.COMPLETE));
		}

		private function securityErrorHandler(event : SecurityErrorEvent) : void {
			this.removeListeners();
			this._stream.close();
			throw new Error(this, "security error " + this._url);
		}

		private function progressHandler(event : ProgressEvent) : void {
			this.dispatchEvent(event);
		}

		private function completeHandler(event : Event) : void {
			this.removeListeners();
			this._byteArray = new ByteArray();
			var length : int = this._stream.bytesAvailable;
			this._stream.readBytes(this._byteArray, 0, length);
			this._stream.close();
			this.onComplete();
		}

		protected function onComplete() : void {
			this._isLoadding = false;
			this._isLoaded = true;
			this.dispatchEvent(new Event(Event.COMPLETE));
		}

		
		
		public function get isLoaded() : Boolean {
			return this._isLoaded;
		}

		public function getKey() : String {
			return this._key;
		}

		public function getLabel() : String {
			return this._label;
		}

		public function load() : void {
			if(this._isLoadding)return;
			if(this._isLoaded)return;
			this._isLoadding = true;
			this._stream = new URLStream();
			this.addListeners();
			this._stream.load(new URLRequest(this._url));
			//logger.info("loadding " + this._url);
		}

		public function getByteArray() : ByteArray {
			return this._byteArray;
		}
	}
}