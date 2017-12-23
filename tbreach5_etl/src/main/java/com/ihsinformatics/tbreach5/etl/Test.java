package com.ihsinformatics.tbreach5.etl;

import java.io.IOException;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import org.lightcouch.CouchDbClient;
import org.lightcouch.DesignDocument;
import org.lightcouch.View;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.google.gson.JsonObject;
import com.ihsinformatics.tbreach5.etl.converter.ClientETL;
import com.ihsinformatics.tbreach5.etl.domain.Client;
import com.ihsinformatics.tbreach5.etl.postgresql.hibernateService;
@Component
public class Test {
	

	//private CouchDbClient dbClient;
/*	 @Autowired
	public Test(CouchDbClient dbClient) {
		 this.dbClient=dbClient;
	}*/
	@Autowired
	private hibernateService hs;
	public void test() throws IOException {
		CouchDbClient dbClient= new CouchDbClient("thrive-opensrp", true, "http", "127.0.0.1", 5984, null,null);
		JsonObject json = dbClient.find(JsonObject.class, "00ea803420f88d955c8bcce7c8f86f0e");	
		DesignDocument documents = dbClient.design().getFromDb("_design/Client");
		//String s=dbClient.view("Client/all")
		//  .includeDocs(true) .queryForString();
		
		/*View d = dbClient.view("Client/all")
		  .includeDocs(true) .limit(10).query(Client.class);
		  //.startKey("start-key")
		  //.endKey("end-key")
		 // .limit(10).queryForString();
		//  .query(Foo.class);
*/		List<Client> list = dbClient.view("Client/all")
				  .includeDocs(true)
				  //.startKey("start-key")
				 // .endKey("end-key")
				  .limit(10)
				  .query(Client.class);
ClientETL etl=new ClientETL();
//hibernateService hs=new hibernateService();
hs.saveToHibernate(etl.convertCouchDBToHibernatePOJO(list));

	ScheduledExecutorService execService
		=	Executors.newScheduledThreadPool(5);
			execService.scheduleAtFixedRate(()->{
//The repetitive task, say to update Database
		System.out.println("Running repetitive task at: "+ new java.util.Date());
				}	, 0, 1000L, TimeUnit.MILLISECONDS);
			hs.saveToHibernate(etl.convertCouchDBToHibernatePOJO(list));
		System.out.println(list);
		//System.out.println(json);
	}
/*	@Autowired
	public void setdbClient(CouchDbClient dbClient) {
		this.dbClient=dbClient;
		
	}*/
	
}
