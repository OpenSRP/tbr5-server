package com.ihsinformatics.tbreach5.etl.couchdb;

import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.json.Json;
import javax.json.JsonArray;
import javax.json.JsonObject;
import javax.json.JsonReader;

import org.springframework.beans.factory.annotation.Autowired;


import com.ihsinformatics.tbreach5.etl.util.HttpCall;

public class CouchdbConfig {
	



	JsonArray getAllDocuments(String url) throws IOException{
		 HttpCall httpCall =new HttpCall();
		 InputStream response = httpCall.callByInputStream(url, httpCall.GET);
		
		JsonReader jsonReader = Json.createReader(response);
		JsonObject mainJson = jsonReader.readObject();
		int totalRows=-1;
		if(mainJson.containsKey("total_rows"))
		{
			totalRows=mainJson.getInt("total_rows");
			
		}
		if(totalRows>0)
		{
			if(mainJson.containsKey("rows")){
				
				JsonArray array = mainJson.getJsonArray("rows");
				
				return array;	
			}
			
		}
		
			
			return null;
		
		
	}
	
	
	/*public List<Client> getAllClient(JsonArray array){
		List<Client> list =new ArrayList<Client>();
		
		for(int i=0 ; i<array.size();i++) {
			Client c=new Client();
			JsonObject row = array.getJsonObject(i);
			c.setEntityID(row.getString(CouchdbMapper.ENTITYID));

			c.setBirthDate(LocalDateTime.from( DateTimeFormatter.ISO_OFFSET_DATE_TIME.parse(row.getString(CouchdbMapper.Client.BIRTHDATE))));
			c.setDateCreated(LocalDateTime.from( DateTimeFormatter.ISO_OFFSET_DATE_TIME.parse(row.getString(CouchdbMapper.DATECREATED))));
			c.setFirstName(row.getString(row.getString(CouchdbMapper.Client.FIRSTNAME)));
			c.setLastName(row.getString(CouchdbMapper.Client.LASTNAME)) ;
			c.setGender(row.getString(CouchdbMapper.Client.GENDER));
			//c.setVoided();
			c.setDeathDate(LocalDateTime.from( DateTimeFormatter.ISO_OFFSET_DATE_TIME.parse(row.getString(CouchdbMapper.Client.DEATHDATE))));
			c.setDeathDateApprox(row.getBoolean(CouchdbMapper.Client.DEATHDATE_APPROX));
			c.setDeathDateApprox(row.getBoolean(CouchdbMapper.Client.BIRTHDATE_APPROX));

            //setting client Identifiers
            JsonObject identifiers = row.getJsonObject(CouchdbMapper.IDENTIFIERS);
            Set<String> keys = identifiers.keySet();
            List<Identifier> identifierList=new ArrayList<>();
            for(String s: keys) {
                Identifier ident = new Identifier();
                ident.setEntityID(row.getString(CouchdbMapper.ENTITYID));
                ident.setIdentifier(identifiers.getString(s));
                ident.setKey(s);
            }
            c.setIdentifiers(identifierList);
			//HttpCall httpCall=new HttpCall();
			//InputStream jsonResponse=httpCall.callByInputStream(url+"/"+(String)array.getJsonObject(i).getString("id"), HttpCall.GET);
			//JsonReader jsonReader = Json.createReader(jsonResponse);
			//JsonObject json = jsonReader.readObject();
			//c.set_void(_void);
			//array.getJsonObject(arg0)
		//	c.setEntityID(json.getString("_id"));
		//	c.set
		}
		
		return null;
		
	}*/
	
	
	
}
