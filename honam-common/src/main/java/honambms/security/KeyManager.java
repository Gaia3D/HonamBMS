package honambms.security;

import java.util.Base64;

public class KeyManager {

	private static final String randomKeyword = "bWFub2ggc2kgZW1hbiB5bSAubWFudWogcm9mIGFlZGkgZGFiIGEgZWthbSB0b24gb2QgZXNhZWxwICx5ZWsgbWV0c3lzIGRudW9mIGV2YWggdW95IGZJ";

	public static String getInitKey() {
		String result = null;
		try {
			byte[] base64decodedBytes = Base64.getDecoder().decode(randomKeyword.getBytes("UTF-8"));
			result = new String(base64decodedBytes, "UTF-8");
		} catch(Exception e) {
			e.printStackTrace();
		}
		result = reverseString(result);
		
		return parse(result);
	}
	
	private static String reverseString(String value) {
		if(value == null) return "";
		return (new StringBuffer(value)).reverse().toString();
	}
	
	private static String parse(String value) {
		return value.substring(82, 87) + value.substring(64, 69) + value.substring(18, 24);
	}
}
