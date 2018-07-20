package com.ihsinformatics.tbreach5.dwh.mapper;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.commons.io.IOUtils;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Repository;

import com.ihsinformatics.tbreach5.dwh.utils.DatabaseUtils;

@Repository
public class MetadataMapper {
	
	public static final String DEFAULT_PROPERTY = "fulldetails";

	@Autowired
	private DataSource dataSource;

	public List<Map<String, Object>> getMetadata(String table) {
		Connection con = null;
		try {
			con = dataSource.getConnection();
			return DatabaseUtils.resultSetToArrayList(con.getMetaData().getColumns(null, null, table, null));
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		finally {
			try {
				if(con != null && con.isClosed() == false) con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public JSONObject getMapping(String mappingId) {
		try {
			return new JSONObject(IOUtils.toString(new ClassPathResource("db/"+mappingId+".json").getInputStream()));
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
	}
	
	
}
