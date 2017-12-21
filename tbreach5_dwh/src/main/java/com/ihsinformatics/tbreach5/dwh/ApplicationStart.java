package com.ihsinformatics.tbreach5.dwh;

import org.apache.ibatis.type.MappedTypes;
import org.lightcouch.CouchDbClient;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.ihsinformatics.tbreach5.dwh.model.Client;




@EnableAutoConfiguration
@Configuration
//@MappedTypes(value = {Client.class,AddressMapper.class})
//@MapperScan("com.ihsinformatics.tbreach5.elt.mapper")
@SpringBootApplication
public class ApplicationStart {
	
	
	
	public static void main(String[] args) {
		SpringApplication.run(ApplicationStart.class, args);
	//	CouchdbConfig cc=new CouchdbConfig();
		
		System.out.println("========================================================");
		//System.out.println(cc.getDB1());
		//System.out.println(clientMapper);
		System.out.println("========================================================");
	}
	
	  @Bean
	    public CouchDbClient getDBClient() {
	    	CouchDbClient dbClient= new CouchDbClient("thrive-opensrp", true, "http", "127.0.0.1", 5984, null,null);
	       return dbClient;
	    }
	    
	

	
		

		
	 
}
