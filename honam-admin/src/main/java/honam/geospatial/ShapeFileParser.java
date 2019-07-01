package honam.geospatial;

import java.io.File;

import org.geotools.data.FileDataStore;
import org.geotools.data.FileDataStoreFinder;
import org.geotools.data.Query;
import org.geotools.data.simple.SimpleFeatureSource;
import org.geotools.feature.FeatureCollection;
import org.geotools.feature.FeatureIterator;
import org.geotools.feature.type.GeometryTypeImpl;
import org.opengis.feature.Property;
import org.opengis.feature.simple.SimpleFeature;
import org.opengis.feature.simple.SimpleFeatureType;

import lombok.extern.slf4j.Slf4j;

/**
 * @author Cheon JeongDae
 *
 */
@Slf4j
public class ShapeFileParser {

	/**
	 * shape 파일 파싱
	 * @param fileName
	 */
	public void parse(String fileName) {
		try {
			File file = new File(fileName);
			FileDataStore myData = FileDataStoreFinder.getDataStore(file);
			SimpleFeatureSource source = myData.getFeatureSource();
			SimpleFeatureType schema = source.getSchema();
	
			Query query = new Query(schema.getTypeName());
			// query.setMaxFeatures(1);
	
			FeatureCollection<SimpleFeatureType, SimpleFeature> collection = source.getFeatures(query);
			try (FeatureIterator<SimpleFeature> features = collection.features()) {
				while (features.hasNext()) {
					SimpleFeature feature = features.next();
					log.info(feature.getID() + ": ");
					for (Property attribute : feature.getProperties()) {
						if (attribute.getType() instanceof GeometryTypeImpl) {
							log.info("\t\t" + attribute.getName() + ":" + attribute.getValue());
						} else {
							log.info("\t" + attribute.getName() + ":" + attribute.getValue());
						}
					}
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
