package com.ihsinformatics.tbreach5.dwh.utils;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.lang3.StringUtils;
import org.json.JSONObject;

import com.ihsinformatics.tbreach5.dwh.mapper.MetadataMapper;

public class DatabaseUtils {

	public static List<Map<String, Object>> resultSetToArrayList(ResultSet rs) throws SQLException {
		ResultSetMetaData md = rs.getMetaData();
		int columns = md.getColumnCount();
		ArrayList<Map<String, Object>> list = new ArrayList<>();
		while (rs.next()) {
			Map<String, Object> row = new HashMap<>();
			for (int i = 1; i <= columns; ++i) {
				row.put(md.getColumnName(i).toLowerCase(), rs.getObject(i));
			}
			list.add(row);
		}

		return list;
	}
	
	public static String getColumnType(String field, List<Map<String, Object>> metadata) {
		for (Map<String, Object> metadataitem : metadata) {
			Object col = null;
			if(((col=metadataitem.get("COLUMN_NAME")) != null || (col=metadataitem.get("column_name")) != null)
					&& col.toString().equalsIgnoreCase(field)) {
				for (Entry<String, Object> map : metadataitem.entrySet()) {
					if((map.getKey().toUpperCase().matches("TYPE_NAME") || map.getKey().toUpperCase().matches("DATA_TYPE"))) {
						return map.getValue().toString();
					}
				}
			}
			
		}
		return null;
	}
	
	public static Object formatValue(String type, Object value) {
		if(type.toLowerCase().contains("json")) {
			return value.toString();
		}
		else if(type.toLowerCase().startsWith("timestamp") || type.toLowerCase().startsWith("date")) {
			return DateUtils.formatDatetimeDb(value);
		}
		return value;
	}
	
	public static Map<String, Object> convertToDatabaseObject(JSONObject data, JSONObject dataMapping, List<Map<String, Object>> metadata) {
		Map<String, Object> persistable = new HashMap<>();
		persistable.put(MetadataMapper.DEFAULT_PROPERTY, data.toString());
		
		for (int i=0; i<dataMapping.getJSONArray("data_mapping").length(); i++) {
			JSONObject mappingAttr = dataMapping.getJSONArray("data_mapping").getJSONObject(i);
			
			if(mappingAttr.has("relation_type")) {
				String relation = mappingAttr.getString("relation_type");
				if(relation.equalsIgnoreCase("many-to-one")) {
					
				}
			}
			else {
				String col = mappingAttr.optString("reference_column");
				String source = mappingAttr.optString("source");
				
				if(StringUtils.isNoneBlank(col) && data.has(source)) {
					String colType = getColumnType(col, metadata);
					persistable.put(col, formatValue(colType, data.get(source)));
				}
			}
		}
		
		return persistable;
	}
}
