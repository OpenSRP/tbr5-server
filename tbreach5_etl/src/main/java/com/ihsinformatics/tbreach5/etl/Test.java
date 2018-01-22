package com.ihsinformatics.tbreach5.etl;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.Date;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import org.joda.time.DateTime;
import org.lightcouch.CouchDbClient;
import org.lightcouch.DesignDocument;
import org.lightcouch.Page;
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
	public void test() throws IOException, ParseException {
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
*/		
		DateTime sDate=new  DateTime();
		//DateTime sDate=new  DateTime();
		LocalDateTime lDate =LocalDateTime.of(2010, 1, 1, 0, 0);
		LocalDateTime enDate=LocalDateTime.now();
		//Date startDate=DateFormat.getDateInstance().parse("2016-01-01");
		
		ZonedDateTime zdt = lDate.atZone(ZoneId.of("Asia/Karachi"));
		Date endDate=new Date();
		
		DateTime dateTime=new DateTime(2016, 1, 1, 0, 0);
		DateTime dT=new DateTime();
		System.out.println(dateTime);
		
		System.out.println(dateTime.toDateTimeISO());
		List<Client> list = dbClient.view("Client/all_clients")
				  .includeDocs(true)
				  .startKey("2010-01-01")
				 .endKey("2017-12-27")
				  .limit(10)
				  .query(Client.class);
		
		
		
		// null param gets the first page
		Page<Client> page = dbClient.view("Client/all_clients")
		 .reduce(false)
		 .queryPage(1000, null, Client.class); 
		System.out.println(page.getNextParam());
ClientETL etl=new ClientETL();
System.out.println("pagenation : "+page.getResultList().size());
System.out.println("Client List : "+list.size());
System.out.println("Client[0] :"+ list.get(0));
page=dbClient.view("Client/all_clients")
.reduce(false)
.queryPage(1000, page.getNextParam(), Client.class); 
System.out.println("pagenation : "+page.getResultList().size());
//etl.trasferFromCouchDBToPostgreSQL(new Date(), endTime)
//hibernateService hs=new hibernateService();
//hs.saveToHibernate(etl.convertCouchDBToHibernatePOJO(list));


ScheduledExecutorService execService
=	Executors.newScheduledThreadPool(5);
//execService.
/*		ScheduledExecutorService execService
	=	Executors.newScheduledThreadPool(5);
			execService.scheduleAtFixedRate(()->{
//The repetitive task, say to update Database
		System.out.println("Running repetitive task at: "+ new java.util.Date());
				}	, 0, 10, TimeUnit.SECONDS);*/
			//hs.saveToHibernate(etl.convertCouchDBToHibernatePOJO(list));
		//System.out.println(list);
		//System.out.println(json);
	}
/*	@Autowired
	public void setdbClient(CouchDbClient dbClient) {
		this.dbClient=dbClient;
		
	}*/
	
}
