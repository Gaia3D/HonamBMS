package honam.geospatial;

import java.util.ArrayList;
import java.util.List;

import honam.support.ProcessBuilderSupport;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class Ogr2OgrExecute {

	// os 종류(WINDOW, LINUX)
	private String osType;
	private String driver;
	private String shapeFile;
	private String shapeEncoding;
	private String tableName;
	// 새로 생성할건지, update 할건지, append 인지..... update가 upsert를 지원하는지 모르겠다.
	private String updateOption;
	private String layerSourceCoordinate;
	private String layerTargetCoordinate;
	
	public Ogr2OgrExecute(String osType, String driver, String shapeFile, String shapeEncoding, String tableName, String updateOption, String layerSourceCoordinate, String layerTargetCoordinate) {
		this.osType = osType;
		this.driver = driver;
		this.shapeFile = shapeFile;
		this.shapeEncoding = shapeEncoding;
		this.tableName = tableName;
		this.updateOption = updateOption;
		this.layerSourceCoordinate = layerSourceCoordinate;
		this.layerTargetCoordinate = layerTargetCoordinate;
	}
	
	public void execute() throws Exception {
		List<String> command = new ArrayList<>();
		command.add("ogr2ogr");
		command.add("-s_srs");
		command.add(layerTargetCoordinate);
		command.add("-t_srs");
		command.add(layerSourceCoordinate);
		command.add("--config");
		
		command.add("SHAPE_ENCODING");
		if(shapeEncoding == null || "".equals(shapeEncoding)) {
			command.add("CP949");
		} else {
			command.add(shapeEncoding);
		}
		
		if("update".equals(this.updateOption)) {
			command.add("-append");
		}
		
		command.add("-f");
		command.add("PostgreSQL");
		//command.add("PG:\"host=localhost dbname=gis user=postgres password=postgres\"");
		command.add(this.driver);
		log.info("============= driver = {}", this.driver);
		
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
		
		ProcessBuilderSupport.execute(command);
	}
}