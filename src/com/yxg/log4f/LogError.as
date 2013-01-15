package com.yxg.log4f {
	import com.yxg.log4f.Level;
	import com.yxg.log4f.Logger;
	import com.yxg.log4f.LoggingData;	

	public class LogError extends Error {
		private var logger : Logger;

		public function LogError(...log : Array) {
			
			super(LoggingData.toCode(log));
			logger = new Logger();
			logger.setName("LogError.as");
			logger.setLevel(Level.ERROR);
			logger.error(log);
		}
	}
}







