package honambms.geospatial;

import java.util.ArrayList;
import java.util.List;

import honambms.support.ProcessBuilderSupport;
import lombok.extern.slf4j.Slf4j;

/**
 * ogr2ogr을 실행하여 shape 파일로 부터 layer를 생성
 * @author Cheon JeongDae
 *
 */
@Slf4j
public class Ogr2OgrRunnable implements Runnable {

	// os 종류(WINDOW, LINUX)
	private String osType;
	private String driver;
	private String shapeFile;
	private String tableName;
	// 새로 생성할건지, update 할건지, append 인지..... update가 upsert를 지원하는지 모르겠다.
	private String updateOption;
	
	public Ogr2OgrRunnable(String osType, String driver, String shapeFile, String tableName, String updateOption) {
		this.osType = osType;
		this.driver = driver;
		this.shapeFile = shapeFile;
		this.tableName = tableName;
		this.updateOption = updateOption;
	}
	
	@Override
	public void run() {
		List<String> command = new ArrayList<>();
		command.add("ogr2ogr");
		command.add("--config");
		
		if("update".equals(this.updateOption)) {
			command.add("-overwrite");
		}
		
		command.add("SHAPE_ENCODING");
		if("WINDOW".equals(this.osType)) {
			command.add("CP949");
		} else {
			command.add("UTF-8");
		}
		
		command.add("-f");
		command.add("PostgreSQL");
		//command.add("PG:\"host=localhost dbname=gis user=postgres password=postgres\"");
		//command.add(this.driver);
		log.info("============= driver = {}", this.driver);
		command.add("PG:host=localhost dbname=gis user=postgres password=postgres");
		
		// shape file full path 파일 호가장자 까지
		command.add(this.shapeFile);
		command.add("-nlt");
		command.add("PROMOTE_TO_MULTI");
		// schema 옵션이라서.... 현재는 빼고
//		command.add("-lco");
//		command.add("schema=");
		command.add("-nln");
		command.add(this.tableName);
		log.info(" >>>>>> command = {}", command.toString());
		
		try {
			ProcessBuilderSupport.execute(command);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}