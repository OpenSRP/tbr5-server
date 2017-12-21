/**
 * 
 */
package com.ihsinformatics.tbreach5.etl;

import org.lightcouch.CouchDbClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * @author Muhammad Ahmed
 */
@Configuration
public class AdditionalConfig  {
	
	@Autowired
	private CouchdbProperties couchProperties;

	  @Bean
	    public CouchDbClient getDBClient() {
	
	    	CouchDbClient dbClient= new CouchDbClient(couchProperties.getName(), couchProperties.isCreatedbifnotexist(), couchProperties.getProtocol(),couchProperties.getHost() ,couchProperties.getPort() , null,null);
	       return dbClient;
	    }
    

    
   

}
