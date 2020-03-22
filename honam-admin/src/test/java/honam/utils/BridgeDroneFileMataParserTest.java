package honam.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FilenameFilter;
import java.io.IOException;
import java.nio.file.Paths;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import lombok.extern.slf4j.Slf4j;

@Slf4j
class BridgeDroneFileMataParserTest {

	@Test
	@DisplayName("드론파일 메타데이터 파싱 테스트")
	void parseDroneFileMetaTest() {

		String subPath = "190427";
		String filePath = "D:\\Drone\\deokyang\\" + subPath;
		File dir = Paths.get(filePath).toFile();
		File[] files = dir.listFiles(new FilenameFilter() {
		    public boolean accept(File dir, String name) {
		        return name.toLowerCase().endsWith(".mrk");
		    }
		});

		for (File file : files) {

			String filePrefix = file.getName().replace("_Timestamp.MRK", "");

			try (BufferedReader br = new BufferedReader(new FileReader(file))) {
				String line;
				while ((line = br.readLine()) != null) {

					String filePostFix = line.substring(0, 16).split("\\s+")[0];
					filePostFix = String.format("%04d", Integer.parseInt(filePostFix));

					String fileName = filePrefix + "_" + filePostFix + ".JPG";

					int start = line.indexOf("V") + 1;
					int end = line.indexOf("Ellh");

					String[] location = line.substring(start, end)
						.replaceAll("\\s+", "")
						.replace("Lat", "")
						.replace("Lon", "")
						.replace("Ellh", "")
						.split(",");

					//log.info(String.format("fileName: %s, lat: %s, lon: %s, alt: %s", fileName, location[0], location[1], location[2]));
					File droneFile = Paths.get(filePath, fileName).toFile();

					String insert = "INSERT INTO bridge_drone_file(\r\n" +
							"	upload_drone_file_id, ogc_fid, user_id,\r\n" +
							"	file_name, file_real_name, file_path, file_sub_path, file_size,\r\n" +
							"	file_ext, error_message, create_date, location, altitude\r\n" +
							") VALUES (\r\n" +
							"	NEXTVAL('bridge_drone_file_seq'), 1, 'admin',\r\n" +
							"	'" + fileName + "', '" + fileName + "', 'C:\\data\\honam\\mago3d\\upload\\deokyang\\" + subPath + "', '" + subPath + "', " + droneFile.length() + ",\r\n" +
							"	'JPG', null, TO_TIMESTAMP('2019/04/27 00:00:00', 'YYYY/MM/DD/ HH24:MI:SS'), ST_GeomFromText('POINT(" + location[1] + " " + location[0] + ")', 4326), " + location[2] + "\r\n" +
							");";
					System.out.println(insert);

				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

	}

}
