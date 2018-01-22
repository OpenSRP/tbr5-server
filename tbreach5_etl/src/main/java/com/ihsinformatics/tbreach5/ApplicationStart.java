package com.ihsinformatics.tbreach5;


import java.io.IOException;
import java.text.ParseException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Component;

import com.ihsinformatics.tbreach5.etl.Test;






@Configuration
@SpringBootApplication
@ComponentScan( {"com.ihsinformatics.tbreach5","com.ihsinformatics.tbreach5.etl", "com.ihsinformatics.tbreach5.dwh"})
@Component
@EnableScheduling
public class ApplicationStart {
	
	
	@Autowired
    private static ApplicationContext appContext;
	
	public static void main(String[] args) throws IOException, ParseException {
		ConfigurableApplicationContext appctx = SpringApplication.run(ApplicationStart.class, args);
	//	CouchdbConfig cc=new CouchdbConfig();
		//ApplicationStart as=new ApplicationStart();
		Test t=appctx.getBean(Test.class);
		System.out.println("========================================================");
		//System.out.println(cc.getDB1());
		//System.out.println(clientMapper);
		
	//	Test t=new Test();
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
