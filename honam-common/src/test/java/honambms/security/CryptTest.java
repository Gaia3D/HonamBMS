package honambms.security;

import org.junit.Test;

public class CryptTest {

	@Test
	public void test() {
		System.out.println(Crypt.encrypt("jdbc:mariadb://localhost/transport"));
		System.out.println("user : " + Crypt.encrypt("test"));
		System.out.println("password : " + Crypt.encrypt("test"));
		
		System.out.println(Crypt.decrypt("VisSFDP+8GqC9Pdnr6q5fQ=="));
		
		System.out.println("gis : " + Crypt.encrypt("jdbc:postgresql://localhost:5432/gis"));
	}
}
