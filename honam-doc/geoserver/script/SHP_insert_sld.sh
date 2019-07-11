restapi=http://localhost:8080/geoserver/rest
login=admin:geoserver
workspace=hhi
store=hhi

for file in *.shp; do
	
	IFS='.' read -r -a array <<< $file
        tempname=${array[0]}
        filename="$tempname.shp"

        IFS='_' read -r -a splitname <<< $tempname
        datename=${splitname[@]: -1}
        echo "$datename"
        echo "$tempname"
        layerkey=`echo $tempname | sed s/_$datename//`

	ogr2ogr --config SHAPE_ENCODING CP949 -a_srs EPSG:5187 -f PostgreSQL PG:"host=127.0.0.1 dbname=gis user=postgres password=postgres" "$filename" -lco SCHEMA=public -lco PRECISION=NO -nln $layerkey -nlt PROMOTE_TO_MULTI 
	psql -h 127.0.0.1 -U postgres -d gis -c "VACUUM FULL $layerkey"

	
	# layer
	curl -v -u $login -XPOST -H "Content-type: text/xml" \
	-d "<featureType><name>$layerkey</name></featureType>" \
	$restapi/workspaces/$workspace/datastores/$store/featuretypes?recalculate=nativebbox,latlonbbox
	 
	
	# sld
	sldfile=$layerkey.sld
	
	if [ -r "$sldfile" ]; then
		# style
		curl -v -u $login -XPOST -H "Content-type: text/xml" \
		-d "<style><name>$layerkey</name><filename>$sldfile</filename></style>" \
		$restapi/workspaces/$workspace/styles

		# upload the SLD definition to the style
		curl -v -u $login -XPUT -H "Content-type: application/vnd.ogc.sld+xml" \
		-d @$sldfile \
		$restapi/workspaces/$workspace/styles/$layerkey

		# apply style
		curl -v -u $login -XPUT -H "Content-type: text/xml" \
		-d "<layer><enabled>true</enabled><defaultStyle><name>$layerkey</name><workspace>$workspace</workspace></defaultStyle></layer>" \
		$restapi/layers/$workspace:$layerkey
	else 
		echo "$path not exists!"
	fi
	
done
    curl -v -u $login -XPOST -d@layergroup.xml -H "Content-type: text/xml" $restapi/layergroups
