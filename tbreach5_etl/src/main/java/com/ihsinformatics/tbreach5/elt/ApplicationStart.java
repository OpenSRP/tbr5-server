package com.ihsinformatics.tbreach5.elt;

import org.apache.ibatis.type.MappedTypes;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Configuration;


import com.ihsinformatics.tbreach5.elt.model.Client;




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
	
	
	

	
		

		
	 
}
