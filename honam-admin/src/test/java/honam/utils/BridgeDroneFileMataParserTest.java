package honam.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FilenameFilter;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import lombok.extern.slf4j.Slf4j;

@Slf4j
class BridgeDroneFileMataParserTest {

	@Test
	@DisplayName("드론파일 메타데이터 파싱 테스트 - 덕양")
	void parseDroneFileMetaTestDeckyang() {
		String filePath = "D:\\Drone\\deokyang\\";
		String uploadPath = "C:\\data\\honam\\mago3d\\upload\\deokyang\\";
		File path = Paths.get(filePath).toFile();
		File[] dirs = path.listFiles();
		for (File dir : dirs) {
			if (dir.isDirectory()) {
				String subPath = dir.getName();
				parseDroneFileMetaTest(filePath, subPath, uploadPath);
			}
		}
	}

	void parseDroneFileMetaTest(String path, String subPath, String uploadPath) {

		String dateString = "20" + subPath.substring(0, 2) + "/" + subPath.substring(2, 4) + "/" + subPath.substring(4, 6);
		String filePath = path + subPath;
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

					String[] location = line.substring(start, end).replaceAll("\\s+", "").replace("Lat", "")
							.replace("Lon", "").replace("Ellh", "").split(",");

					// log.info(String.format("fileName: %s, lat: %s, lon: %s, alt: %s", fileName,
					// location[0], location[1], location[2]));
					File droneFile = Paths.get(filePath, fileName).toFile();

					String insert = "INSERT INTO bridge_drone_file(\r\n"
							+ "	upload_drone_file_id, ogc_fid, user_id,\r\n"
							+ "	file_name, file_real_name, file_path, file_sub_path, file_size,\r\n"
							+ "	file_ext, error_message, create_date, location, altitude\r\n" + ") VALUES (\r\n"
							+ "	NEXTVAL('bridge_drone_file_seq'), 1, 'admin',\r\n" + "	'" + fileName + "', '"
							+ fileName + "', '" + uploadPath + subPath + "', '" + subPath + "', " + droneFile.length()
							+ ",\r\n" + "	'JPG', null, TO_TIMESTAMP('" + dateString
							+ " 00:00:00', 'YYYY/MM/DD/ HH24:MI:SS'), ST_GeomFromText('POINT(" + location[1] + " "
							+ location[0] + ")', 4326), " + location[2] + "\r\n" + ");";
					System.out.println(insert);

				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

	}

	@Test
	@DisplayName("드론파일 메타데이터 파싱 테스트 - 마동IC")
	void parseDroneFileMetaTest2() {

		String subPathFirst = "170529";
		String dateStringFirst = "20" + subPathFirst.substring(0, 2) + "/" + subPathFirst.substring(2, 4) + "/" + subPathFirst.substring(4, 6);
		String subPathSecond = "171009";
		String dateStringSecond = "20" + subPathSecond.substring(0, 2) + "/" + subPathSecond.substring(2, 4) + "/" + subPathSecond.substring(4, 6);

		String filePath = "D:\\Drone\\madongIC";
		String uploadPath = "C:\\data\\honam\\mago3d\\upload\\madongIC\\";
		File file = new File("D:\\Drone\\madongIC\\AeroSysEO.orn");

		try (BufferedReader br = new BufferedReader(new FileReader(file))) {
			String line;

			boolean isFirst = true;
			List<String> firstList = new ArrayList<>();
			List<String> secondList = new ArrayList<>();

			int i = 0;
			while ((line = br.readLine()) != null) {
				String filePostFix = line.split("\\s+")[0].trim();

				if ("DJI_0967".equals(filePostFix)) {
					isFirst = false;
				}
				if (!isFirst) {
					secondList.add(line);
				} else {
					if (i % 2 == 0) {
						firstList.add(line);
					} else {
						secondList.add(line);
					}
				}
				i++;
			}


			for (String first : firstList) {
				String[] element = first.split("\\s+");
				String filePostFix = element[0].trim();
				File droneFile = Paths.get(filePath, subPathFirst, filePostFix + ".JPG").toFile();
				String fileName = droneFile.getName();

				String insert = "INSERT INTO bridge_drone_file(\r\n" + "	upload_drone_file_id, ogc_fid, user_id,\r\n"
						+ "	file_name, file_real_name, file_path, file_sub_path, file_size,\r\n"
						+ "	file_ext, error_message, create_date, location, altitude\r\n" + ") VALUES (\r\n"
						+ "	NEXTVAL('bridge_drone_file_seq'), 2, 'admin',\r\n" + "	'" + fileName + "', '" + fileName
						+ "', '" + uploadPath + subPathFirst + "', '" + subPathFirst + "', " + droneFile.length()
						+ ",\r\n" + "	'JPG', null, TO_TIMESTAMP('" + dateStringFirst
						+ "', 'YYYY/MM/DD/ HH24:MI:SS'), ST_Transform(ST_GeomFromText('POINT(" + element[4] + " "
						+ element[5] + ")', 5186), 4326), " + element[6] + "\r\n" + ");";
				System.out.println(insert);
			}

			for (String second : secondList) {
				String[] element = second.split("\\s+");
				String filePostFix = element[0].trim();
				File droneFile = Paths.get(filePath, subPathSecond, filePostFix + ".JPG").toFile();
				String fileName = droneFile.getName();

				String insert = "INSERT INTO bridge_drone_file(\r\n" + "	upload_drone_file_id, ogc_fid, user_id,\r\n"
						+ "	file_name, file_real_name, file_path, file_sub_path, file_size,\r\n"
						+ "	file_ext, error_message, create_date, location, altitude\r\n" + ") VALUES (\r\n"
						+ "	NEXTVAL('bridge_drone_file_seq'), 2, 'admin',\r\n" + "	'" + fileName + "', '" + fileName
						+ "', '" + uploadPath + subPathSecond + "', '" + subPathSecond + "', " + droneFile.length()
						+ ",\r\n" + "	'JPG', null, TO_TIMESTAMP('" + dateStringSecond
						+ "', 'YYYY/MM/DD/ HH24:MI:SS'), ST_Transform(ST_GeomFromText('POINT(" + element[4] + " "
						+ element[5] + ")', 5186), 4326), " + element[6] + "\r\n" + ");";
				System.out.println(insert);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Test
	@DisplayName("드론파일 메타데이터 파싱 테스트2 - 마동IC")
	void parseDroneFileMetaTest3() {

		String subPath = "180618";
		String filePath = "D:\\Drone\\madongIC\\";
		String uploadPath = "C:\\data\\honam\\mago3d\\upload\\madongIC\\";
		String metaFileName = "AeroSysEO_180618.orn";

		String dateString = "20" + subPath.substring(0, 2) + "/" + subPath.substring(2, 4) + "/" + subPath.substring(4, 6);
		File file = new File(filePath + metaFileName);

		try (BufferedReader br = new BufferedReader(new FileReader(file))) {
			String line;
			while ((line = br.readLine()) != null) {
				String[] element = line.split("\\s+");
				String filePostFix = element[0].trim();
				File droneFile = Paths.get(filePath, subPath, filePostFix + ".JPG").toFile();
				String fileName = droneFile.getName();

				String insert = "INSERT INTO bridge_drone_file(\r\n" + "	upload_drone_file_id, ogc_fid, user_id,\r\n"
						+ "	file_name, file_real_name, file_path, file_sub_path, file_size,\r\n"
						+ "	file_ext, error_message, create_date, location, altitude\r\n" + ") VALUES (\r\n"
						+ "	NEXTVAL('bridge_drone_file_seq'), 2, 'admin',\r\n" + "	'" + fileName + "', '" + fileName
						+ "', '" + uploadPath + subPath + "', '" + subPath + "', " + droneFile.length() + ",\r\n"
						+ "	'JPG', null, TO_TIMESTAMP('" + dateString
						+ "', 'YYYY/MM/DD/ HH24:MI:SS'), ST_Transform(ST_GeomFromText('POINT(" + element[4] + " "
						+ element[5] + ")', 5186), 4326), " + element[6] + "\r\n" + ");";
				System.out.println(insert);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
