package com.ihsinformatics.app.service;

import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.stereotype.Service;

@Service
public class JDBCService {
	
	 private JdbcTemplate jdbcTemplate;
	    private DataSource dataSource;
	    @Autowired
	    public void setDataSource(DataSource dataSource) {
	        this.dataSource = dataSource;
	    }
	 
	 public List<Map<String, Object>> execute(String sql) {
		 if(jdbcTemplate==null) {
		 jdbcTemplate = new JdbcTemplate(dataSource);
		 }
		 System.out.println("JDBC "+jdbcTemplate);
		 
		 return jdbcTemplate.queryForList(sql);
	 }
	
	

}
