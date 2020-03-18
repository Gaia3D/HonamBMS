package honambms.security;

import java.util.Base64;

import org.junit.Test;

public class KeyManagerTest {

	@Test
	public void test() throws Exception {
		String key = KeyManager.getInitKey();
		System.out.println(key);
		
		String encryptKey = "bWFub2ggc2kgZW1hbiB5bSAubWFudWogcm9mIGFlZGkgZGFiIGEgZWthbSB0b24gb2QgZXNhZWxwICx5ZWsgbWV0c3lzIGRudW9mIGV2YWggdW95IGZJ";
		byte[] base64decodedBytes = Base64.getDecoder().decode(encryptKey.getBytes("UTF-8"));
		String result = new String(base64decodedBytes, "UTF-8");
		result = (new StringBuffer(result)).reverse().toString();
		System.out.println("1 ===== " + result);
		result = result.substring(82, 87) + result.substring(64, 69) + result.substring(18, 24);
		System.out.println("2 ===== " + result);
	}

	@Test
	public void 키_암호화() throws Exception {
		String key = "If you have found system key, please do not make a bad idea for junam. my name is honam";
		System.out.println("key = " + key);
		String reverseKey =  new StringBuffer(key).reverse().toString();
		System.out.println("reverseKey = " + reverseKey);
		String encryptKey = new String(Base64.getEncoder().encode(reverseKey.getBytes("UTF-8")));
		System.out.println("encryptKey = " + encryptKey);
	}
}
