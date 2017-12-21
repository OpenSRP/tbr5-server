package com.ihsinformatics.tbreach5.etl;

import java.util.List;

import org.lightcouch.CouchDbClient;
import org.lightcouch.DesignDocument;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.google.gson.JsonObject;
@Component
public class Test {
	

	//private CouchDbClient dbClient;
/*	 @Autowired
	public Test(CouchDbClient dbClient) {
		 this.dbClient=dbClient;
	}*/
	public void test() {
		CouchDbClient dbClient= new CouchDbClient("thrive-opensrp", true, "http", "127.0.0.1", 5984, null,null);
		JsonObject json = dbClient.find(JsonObject.class, "00ea803420f88d955c8bcce7c8f86f0e");	
		System.out.println(json);
	}
/*	@Autowired
	public void setdbClient(CouchDbClient dbClient) {
		this.dbClient=dbClient;
		
	}*/
	
}
