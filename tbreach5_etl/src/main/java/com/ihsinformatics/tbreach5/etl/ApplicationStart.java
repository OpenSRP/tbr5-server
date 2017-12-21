package com.ihsinformatics.tbreach5.etl;


import org.lightcouch.CouchDbClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;





@EnableAutoConfiguration
@Configuration
@ComponentScan("com.ihsinformatics.tbreach5.etl")
@SpringBootApplication
public class ApplicationStart {
	
	

	
	public static void main(String[] args) {
		SpringApplication.run(ApplicationStart.class, args);
	//	CouchdbConfig cc=new CouchdbConfig();
		
		System.out.println("========================================================");
		//System.out.println(cc.getDB1());
		//System.out.println(clientMapper);
		
		Test t=new Test();
		t.test();
		System.out.println("========================================================");
	}
	/*
	  @Bean
	    public CouchDbClient getDBClient() {
	    	CouchDbClient dbClient= new CouchDbClient("thrive-opensrp", true, "http", "127.0.0.1", 5984, null,null);
	       System.out.println(dbClient.context().getAllDbs());
	    	return dbClient;
	    }*/
	    
	
	
	

	
		

		
	 
}
