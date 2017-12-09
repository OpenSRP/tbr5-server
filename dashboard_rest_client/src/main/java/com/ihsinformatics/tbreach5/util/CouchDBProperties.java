package com.ihsinformatics.tbreach5.util;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@ConfigurationProperties(prefix = "couchdb")
@Component
public class CouchDBProperties {
	
	private String db1;
	
	private String db2;
	
	private String url;
	
	
	public String getDb1() {
		return db1;
	}
	public void setDb1(String db1) {
		this.db1 = db1;
	}
	public String getDb2() {
		return db2;
	}
	public void setDb2(String db2) {
		this.db2 = db2;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	
}
