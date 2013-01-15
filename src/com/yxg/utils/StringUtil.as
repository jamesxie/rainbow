package com.yxg.utils {
	import flash.utils.ByteArray;		

	/**
	 * @author JamesXie
	 * @version 1.0
	 * @date Sep 28, 2009
	 * @name 字符串工具
	 */
	public class StringUtil {

		/**
		 * FunctionName 输入秒为单位的数字返回短日期格式的字符串
		 * import Number return ShortTime format
		 * @param num1:Number second
		 * @param str1:String second or milliscond
		 * @return String
		 * <br><b>E.g.</b> NumbertoShortTime(1279) <b>Return</b> "00:21:19"
		 */
		public static function NumbertoShortTime(num1 : Number,str1 : String = "second") : String {
			var re_str1 : String;
			var seconds_ : Number;
			if (str1 == "second") {
				seconds_ = num1;
			}
			if (str1 == "milliscond") {
				seconds_ = Number((num1 / 1000).toFixed(2));
			}
			
			var hours : Number = Math.floor(seconds_ / 3600);
			seconds_ -= hours * 3600;
			
			
			var minutes : Number = Math.floor(seconds_ / 60);
			var seconds : Number = Math.floor(seconds_ % 60);
			
			//trace(seconds_ + " hours " + hours + " minutes " + minutes + " seconds " + seconds);
			
			var strHours : String = String(hours);
			var strMinutes : String = String(minutes);
			var strSeconds : String = String(seconds);
			
			if (hours < 10) {
				strHours = "0" + String(hours);
			}
			
			if (minutes < 10) {
				strMinutes = "0" + String(minutes);
			}
			
			if (seconds < 10) {
				strSeconds = "0" + String(seconds);
			}
			re_str1 = String(strHours + " : " + strMinutes + " : " + strSeconds);
			return re_str1;
		}
		
		
		/**
		 * FunctionName 输入秒为单位的数字返回短日期格式的字符串只返回分钟
		 * import Number return ShortTime format
		 * @param num1:Number second
		 * @param str1:String second or milliscond
		 * @return String
		 * <br><b>E.g.</b> NumbertoShortTime(1279) <b>Return</b> "00:21"
		 */
		public static function NumbertoShortTime2(num1 : Number,str1 : String = "second") : String {
			var re_str1 : String;
			var seconds_ : Number;
			if (str1 == "second") {
				seconds_ = num1;
			}
			if (str1 == "milliscond") {
				seconds_ = Number((num1 / 1000).toFixed(2));
			}
			
			var hours : Number = Math.floor(seconds_ / 3600);
			seconds_ -= hours * 3600;
			
			
			var minutes : Number = Math.floor(seconds_ / 60);
			var seconds : Number = Math.floor(seconds_ % 60);
			
			//trace(seconds_ + " hours " + hours + " minutes " + minutes + " seconds " + seconds);
			
			var strHours : String = String(hours);
			var strMinutes : String = String(minutes);
			var strSeconds : String = String(seconds);
			
			if (hours < 10) {
				strHours = "0" + String(hours);
			}
			
			if (minutes < 10) {
				strMinutes = "0" + String(minutes);
			}
			
			if (seconds < 10) {
				strSeconds = "0" + String(seconds);
			}
			re_str1 = String(strHours + " : " + strMinutes);
			return re_str1;
		}
		
		
		/**
		 * FunctionName 输入秒为单位的数字返回短日期格式的字符串只返回分钟
		 * import Number return ShortTime format
		 * @param num1:Number second
		 * @param str1:String second or milliscond
		 * @return String
		 * <br><b>E.g.</b> NumbertoShortTime(1279) <b>Return</b> "00小时21分钟"
		 */
		public static function NumbertoShortTime3(num1 : Number,str1 : String = "second") : String {
			var re_str1 : String;
			var seconds_ : Number;
			if (str1 == "second") {
				seconds_ = num1;
			}
			if (str1 == "milliscond") {
				seconds_ = Number((num1 / 1000).toFixed(2));
			}
			
			var hours : Number = Math.floor(seconds_ / 3600);
			seconds_ -= hours * 3600;
			
			
			var minutes : Number = Math.floor(seconds_ / 60);
			var seconds : Number = Math.floor(seconds_ % 60);
			
			//trace(seconds_ + " hours " + hours + " minutes " + minutes + " seconds " + seconds);
			
			var strHours : String = String(hours);
			var strMinutes : String = String(minutes);
			var strSeconds : String = String(seconds);
			
			if (hours < 10) {
				strHours = "0" + String(hours);
			}
			
			if (minutes < 10) {
				strMinutes = "0" + String(minutes);
			}
			
			if (seconds < 10) {
				strSeconds = "0" + String(seconds);
			}
			re_str1 = String(strHours + "小时" + strMinutes+"分钟");
			return re_str1;
		}
		

		/**
		 * FunctionName 得到当前时间 YYYYMMDDHHMMSSMMM
		 * return now full time
		 * @param str1:String 分隔符1 YYYY{$str1}MM{$str1}DDHHMMSSMMM
		 * @param str2:String 分隔符2 YYYYMMDD{$str2}HHMMSS{$str2}MMM
		 * @param str3:String 分隔符3 YYYYMMDDHH{$str3}MM{$str3}SSMMM
		 * @return String
		 * Example
		 * CommonTools.GetFullTime("-"," ",":");
		 */
		public static function GetFullTime(str1 : String = "", str2 : String = "", str3 : String = "") : String {
			var today_date : Date = new Date();
			var date_str : String = "";
			var delimiter1 : String = "";
			var delimiter2 : String = "";
			var delimiter3 : String = "";

			delimiter1 = str1;
			delimiter2 = str2;
			delimiter3 = str3;

			date_str = StringUtil.FillPlace(String(today_date.getFullYear()), 4, "0", "<") + delimiter1;
			date_str += StringUtil.FillPlace(String(today_date.getMonth() + 1), 2, "0", "<") + delimiter1;
			date_str += StringUtil.FillPlace(String(today_date.getDate()), 2, "0", "<") + delimiter2;
			date_str += StringUtil.FillPlace(String(today_date.getHours()), 2, "0", "<") + delimiter3;
			date_str += StringUtil.FillPlace(String(today_date.getMinutes()), 2, "0", "<") + delimiter3;
			date_str += StringUtil.FillPlace(String(today_date.getSeconds()), 2, "0", "<") + delimiter2;
			date_str += StringUtil.FillPlace(String(today_date.getMilliseconds()), 3, "0", "<");
			return date_str;
		}

		/**
		 * FunctionName 补位
		 * @param str1:String 数据
		 * @param num1:Number 补到的位数
		 * @param str2:String 补充的数据
		 * @param str3:String 补到左边还是右边"<"or">"
		 */
		public static function FillPlace(str1 : String = "", num1 : Number = 0, str2 : String = "", str3 : String = "<") : String {
			var strReturn : String = "";
			var strFillLength : Number = 0;
			strFillLength = num1 - str1.length;
			if (strFillLength < 1) {
				strFillLength = 0;
			}
			str3 = "<";
			for (var i : Number = 0;i < strFillLength;i++) {
				strReturn += str2;
			}
			if (str3 == "<") {
				strReturn = strReturn + str1;
			}else {
				strReturn = str1 + strReturn;
			}
			return strReturn;
		}

		//String转Unicode码
		//alert(ChineseToUnicode("中国人民银行"));
		//alert("\u4e2d\u56fd\u4eba\u6c11\u94f6\u884c");
		public static function stringToUnicode(str : String) : String {
			var fArr : Array = new Array();
			var fStr : String = "";
			fArr = str.split("");
			for (var i : Number = 0;i < fArr.length; i++) {
				fStr += ("\\u" + fArr[i].charCodeAt().toString(16));
			}
			return fStr;
		}

		//Unicode码转String

		public static function unicodeToString(srcText : String) : String {
			if(srcText.indexOf("\\u") == -1) {
				return srcText;	
			}
			var result : String = "";
			try {
				var ary : Array = srcText.split("\\u");
				for(var i : int = 0;i < ary.length;i++) {
					if(ary[i] != null && String(ary[i]).length > 0) {
						result += String.fromCharCode("0x" + ary[i]);
					}
				}
			}catch(e : Error) {
			}
			return result;
		}

		//[Code Info] 正则表达式基本使用方法

		/**
		 * 替换所有非中文<br>
		 * <br>
		 * @Example
		 * alert(replaceAllNotChinese("中国2e人民46银7行56")); //output 中国人民银行<br>
		 * 
		 * @Example
		 * alert(replaceAllNotChinese("中国2e人民46银7行56","|")); //output 中国|人民|银|行|<br>
		 */
		public static function replaceAllNotChinese(str1 : String,str2 : String = "") : String {
			var fStr : String = "";
			//非中文
			var fExp : RegExp = /[u4e00-u9fa5]+/g;
			fStr = str1.replace(fExp, str2);
			
			return fStr;
		}

		
		/**
		 * 替换单个中文<br>
		 * <br>
		 * @Example
		 * alert(replaceChinese("中国2e人民46银7行56")); //output 2e人民46银7行56<br>
		 * 
		 * @Example
		 * alert(replaceChinese("中国2e人民46银7行56","|")); //output |2e人民46银7行56<br>
		 */
		public static function replaceChinese(str1 : String,str2 : String = "") : String {
			var fStr : String = "";
			//中文
			var fExp : RegExp = /[\u4e00-\u9fa5]+/;
			fStr = str1.replace(fExp, str2);
			
			return fStr;
		}

		
		/**
		 * 替换所有中文<br>
		 * <br>
		 * @Example
		 * alert(replaceAllChinese("中国2e人民46银7行56")); //output 2e46756<br>
		 * 
		 * @Example
		 * alert(replaceAllChinese("中国2e人民46银7行56","|")); //output |2e|46|7|56<br>
		 */
		public static function replaceAllChinese(str1 : String,str2 : String = "") : String {
			var fStr : String = "";
			//全部中文
			var fExp : RegExp = /[\u4e00-\u9fa5]+/g;
			fStr = str1.replace(fExp, str2);
			return fStr;
		}

		/**
		 * 第三方代码 Kinglong
		 */
		 
		//忽略大小字母比较字符是否相等
		public static function equalsIgnoreCase(char1 : String,char2 : String) : Boolean {  
			return char1.toLowerCase() == char2.toLowerCase();  
		}  

		//比较字符是否相等
		public static function equals(char1 : String,char2 : String) : Boolean {  
			return char1 == char2;  
		}  

		//是否为Email地址
		public static function isEmail(char : String) : Boolean {  
			if(char == null) {  
				return false;  
			}  
			char = trim(char);  
			var pattern : RegExp = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;   
			var result : Object = pattern.exec(char);  
			if(result == null) {  
				return false;  
			}  
			return true;  
		}  

		//是否是数值字符串
		public static function isNumber(char : String) : Boolean {  
			if(char == null) {  
				return false;  
			}  
			return !isNaN(Number(char));  
		}  

		//是否为Double型数据
		public static function isDouble(char : String) : Boolean {  
			char = trim(char);  
			var pattern : RegExp = /^[-\+]?\d+(\.\d+)?$/;   
			var result : Object = pattern.exec(char);  
			if(result == null) {  
				return false;  
			}  
			return true;  
		}  

		//Integer
		public static function isInteger(char : String) : Boolean {  
			if(char == null) {  
				return false;  
			}  
			char = trim(char);  
			var pattern : RegExp = /^[-\+]?\d+$/;   
			var result : Object = pattern.exec(char);  
			if(result == null) {  
				return false;  
			}  
			return true;  
		}  

		//English
		public static function isEnglish(char : String) : Boolean {  
			if(char == null) {  
				return false;  
			}  
			char = trim(char);  
			var pattern : RegExp = /^[A-Za-z]+$/;   
			var result : Object = pattern.exec(char);  
			if(result == null) {  
				return false;  
			}  
			return true;  
		}

		//中文
		public static function isChinese(char : String) : Boolean {  
			if(char == null) {  
				return false;  
			}  
			char = trim(char);  
			var pattern : RegExp = /^[\u0391-\uFFE5]+$/;   
			var result : Object = pattern.exec(char);  
			if(result == null) {  
				return false;  
			}  
			return true;  
		}  

		//双字节  
		public static function isDoubleChar(char : String) : Boolean {  
			if(char == null) {  
				return false;  
			}  
			char = trim(char);  
			var pattern : RegExp = /^[^\x00-\xff]+$/;   
			var result : Object = pattern.exec(char);  
			if(result == null) {  
				return false;  
			}  
			return true;  
		}  

		//含有中文字符(全角字符)
		public static function hasChineseChar(char : String) : Boolean {  
			if(char == null) {  
				return false;  
			}  
			char = trim(char);  
			var pattern : RegExp = /[^\x00-\xff]/;   
			var result : Object = pattern.exec(char);  
			if(result == null) {  
				return false;  
			}  
			return true;  
		}  

		//注册字符
		public static function hasAccountChar(char : String,len : uint = 15) : Boolean {  
			if(char == null) {  
				return false;  
			}  
			if(len < 10) {  
				len = 15;  
			}  
			char = trim(char);  
			var pattern : RegExp = new RegExp("^[a-zA-Z0-9][a-zA-Z0-9_-]{0," + len + "}$", "");   
			var result : Object = pattern.exec(char);  
			if(result == null) {  
				return false;  
			}  
			return true;  
		}

		//XXX URL地址
		public static function isURL(char : String) : Boolean {  
			if(char == null) {  
				return false;  
			}  
			char = trim(char).toLowerCase();  
			var pattern : RegExp;
			//pattern = /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/;   
			var result : Object = pattern.exec(char);  
			if(result == null) {
				return false;  
			}
			return true;  
		}

		// 是否为空白   
		public static function isWhitespace(char : String) : Boolean {  
			switch (char) {  
				case " ":  
				case "\t":  
				case "\r":  
				case "\n":  
				case "\f":  
					return true;      
				default:  
					return false;  
			}  
		}  

		//去左右空格
		public static function trim(char : String) : String {  
			if(char == null) {  
				return null;  
			}  
			return rtrim(ltrim(char));  
		}  

		//去左空格
		public static function ltrim(char : String) : String {  
			if(char == null) {  
				return null;  
			}  
			var pattern : RegExp = /^\s*/;   
			return char.replace(pattern, "");  
		}  

		//去右空格
		public static function rtrim(char : String) : String {  
			if(char == null) {  
				return null;  
			}  
			var pattern : RegExp = /\s*$/;   
			return char.replace(pattern, "");  
		}  

		//是否为前缀字符串
		public static function beginsWith(char : String, prefix : String) : Boolean {            
			return (prefix == char.substring(0, prefix.length));  
		}  

		//是否为后缀字符串
		public static function endsWith(char : String, suffix : String) : Boolean {  
			return (suffix == char.substring(char.length - suffix.length));  
		}  

		//去除指定字符串
		public static function remove(char : String,remove : String) : String {  
			return replace(char, remove, "");  
		}  

		//字符串替换
		public static function replace(char : String, replace : String, replaceWith : String) : String {           
			return char.split(replace).join(replaceWith);  
		}  

		//utf16转utf8编码
		public static function utf16to8(char : String) : String {  
			var out : Array = new Array();  
			var len : uint = char.length;  
			for(var i : uint = 0;i < len;i++) {  
				var c : int = char.charCodeAt(i);  
				if(c >= 0x0001 && c <= 0x007F) {  
					out[i] = char.charAt(i);  
				} else if (c > 0x07FF) {  
					out[i] = String.fromCharCode(0xE0 | ((c >> 12) & 0x0F), 0x80 | ((c >> 6) & 0x3F), 0x80 | ((c >> 0) & 0x3F));  
				} else {  
					out[i] = String.fromCharCode(0xC0 | ((c >> 6) & 0x1F), 0x80 | ((c >> 0) & 0x3F));  
				}  
			}  
			return out.join('');  
		}  

		//utf8转utf16编码
		public static function utf8to16(char : String) : String {  
			var out : Array = new Array();  
			var len : uint = char.length;  
			var i : uint = 0;  
			var char2 : int,char3 : int;  
			while(i < len) {  
				var c : int = char.charCodeAt(i++);  
				switch(c >> 4) {  
					case 0: 
					case 1: 
					case 2: 
					case 3: 
					case 4: 
					case 5: 
					case 6: 
					case 7:  
						// 0xxxxxxx  
						out[out.length] = char.charAt(i - 1);  
						break;  
					case 12: 
					case 13:  
						// 110x xxxx   10xx xxxx  
						char2 = char.charCodeAt(i++);  
						out[out.length] = String.fromCharCode(((c & 0x1F) << 6) | (char2 & 0x3F));  
						break;  
					case 14:  
						// 1110 xxxx  10xx xxxx  10xx xxxx  
						char2 = char.charCodeAt(i++);  
						char3 = char.charCodeAt(i++);  
						out[out.length] = String.fromCharCode(((c & 0x0F) << 12) | ((char2 & 0x3F) << 6) | ((char3 & 0x3F) << 0));  
						break;  
				}  
			}  
			return out.join('');  
		}  

		//转换字符编码
		public static function encodeCharset(char : String,charset : String) : String {  
			var bytes : ByteArray = new ByteArray();  
			bytes.writeUTFBytes(char);  
			bytes.position = 0;  
			return bytes.readMultiByte(bytes.length, charset);  
		}  

		//添加新字符到指定位置       
		public static function addAt(char : String, value : String, position : int) : String {  
			if (position > char.length) {  
				position = char.length;  
			}  
			var firstPart : String = char.substring(0, position);  
			var secondPart : String = char.substring(position, char.length);  
			return (firstPart + value + secondPart);  
		}  

		//替换指定位置字符
		public static function replaceAt(char : String, value : String, beginIndex : int, endIndex : int) : String {  
			beginIndex = Math.max(beginIndex, 0);             
			endIndex = Math.min(endIndex, char.length);  
			var firstPart : String = char.substr(0, beginIndex);  
			var secondPart : String = char.substr(endIndex, char.length);  
			return (firstPart + value + secondPart);  
		}

		//删除指定位置字符
		public static function removeAt(char : String, beginIndex : int, endIndex : int) : String {  
			return StringUtil.replaceAt(char, "", beginIndex, endIndex);  
		}  

		//修复双换行符
		public static function fixNewlines(char : String) : String {  
			return char.replace(/\r\n/gm, "\n");  
		}

		//返回字符串的字符数
		public static function getCharLeight(str : String) : int {
			var ba : ByteArray = new ByteArray();
			ba.writeMultiByte(str, "gb2312");
			return ba.length;
		}

		
		/**
		 * 中文换行排版（仅限全角中文）
		 * 每个固定长度后插入特定字符
		 * 每个固定长度后插入特定字符
		 * @param word 传入的内容（仅限全角中文） 
		 * @param len 多少个字为一个循环（是字数,不是字节数）
		 * @param par 插入什么字符（例如 "-" or "\n" 换行符）
		 * <br><br><b>Example:</b>
		 * <br>alert(StringUtil.addChineseTrim("山重水复疑无路，柳暗花明又一村",3,"--"));
		 * <br><b>Output:</b>
		 * <br>山重水--复疑无--路，柳--暗花明--又一村--
		 */
		public static function addChineseTrim(word : String,len : int,par : String) : String {
			var fStr : String = "";
	
			var fNum : int = 0;
			var pattern : RegExp = /[^\x00-\xff]/g;
			
			if (len > word.length) {
				return word;
			}
			
			var str : String = word;
			pattern.lastIndex = 0;

			while (true) {
				var fV : String = "";
				fV = pattern.exec(str);
				
				if (fV) {
					fStr += fV;
				} else {
					break;
				}
				pattern.lastIndex;
				fNum++;
				if (fNum > (len - 1)) {
					fStr += par;
					fNum = 0;
				}
			}
	
			return fStr;
		}

		
		/**
		 * 中英文换行排版（中文英文混合排版）
		 * 每个固定长度后插入特定字符
		 * @param word 传入的内容
		 * @param len 半角字符数 比如"你a好"为5个字符
		 * @param par 插入什么字符（例如 "-" or "\n" 换行符）
		 * <br><br><b>Example:</b>
		 * <br>alert(StringUtil.addWordTrim("山重水复疑无路，柳暗花明又一村",4,"--"));
		 * <br><b>Output:</b>
		 * <br>山重--水复--疑无--路，--柳暗--花明--又一--村
		 */
		public static function addWordTrim(word : String,len : int,par : String) : String {
			var fStr : String = "";
			var fLen : int = 0;

			//循环
			var fNum : int = 0;

			if (word.length > 0) {
				fLen = getCharLeight(word);
			} else {
				return word;
			}

			if (fLen < len) {
				return word;
			}

			for (var i : uint = 0;i < word.length; i++) {
				var fWord : String = word.substr(i, 1);
				//if (hasChineseChar(fWord)) {

				//alert("hasChineseChar " + hasChineseChar(fWord) + " isChinese  " + isChinese(fWord) + " = " + fWord);

				if (isChinese(fWord) || fWord == "　") {
					fStr += fWord;
					fNum += 2;
				} else {
					fStr += fWord;
					fNum++;
				}

				if (fNum > (len - 2)) {
					fStr += par;
					fNum = 0;
				}
			}
			return fStr;
		}

		/**
		 * 双重换行排版（支持中文英文混合排版）
		 * 每个固定长度后插入特定字符
		 * @param word 传入的内容
		 * @param len (自然换行字节数) 半角字符数 比如"你a好"为5个字符
		 * @param par 插入什么字符（例如 "-" or "\n" 换行符）也可以是换行符 外加 空格 例如: "\n　　"
		 * @param lineFlag (自定义硬换行标识) 例如"&lt;br&gt;"
		 * <br><br><b>Example:</b>
		 * <br>alert(StringUtil.addAdvWordTrim("山HM重水复疑无路，柳暗花明又一村",8,"-->>","HM"));
		 * <br><b>Output:</b>
		 * <br>山-->>重水复疑-->>无路，柳-->>暗花明又-->>一村
		 */
		public static function addAdvWordTrim(word : String,len : int,par : String,lineFlag : String = "") : String {
			var fStr : String = "";
			var fArr : Array = new Array();
			
			fArr = word.split(lineFlag);
			
			for (var i : Number = 0;i < fArr.length; i++) {
				fStr += addWordTrim(String(fArr[i]), len, par);
				if (i < fArr.length) {
					fStr += par;
				}
			}

			return fStr;
		}
	}
}
