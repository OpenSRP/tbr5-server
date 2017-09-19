package com.ihsinformatics.tbreach5.elt.couchdb;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.json.Json;
import javax.json.JsonArray;
import javax.json.JsonObject;
import javax.json.JsonReader;

import com.ihsinformatics.tbreach5.elt.model.Client;
import com.ihsinformatics.tbreach5.elt.util.HttpCall;

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
	
	
	public List<Client> getAllClient(String url,JsonArray array){
		List<Client> list =new ArrayList<Client>();
		
		for(int i=0 ; i<array.size();i++) {
			Client c=new Client();
			JsonObject row = array.getJsonObject(i);
			c.setEntityID(row.getString("entityID"));

			//HttpCall httpCall=new HttpCall();
			//InputStream jsonResponse=httpCall.callByInputStream(url+"/"+(String)array.getJsonObject(i).getString("id"), HttpCall.GET);
			//JsonReader jsonReader = Json.createReader(jsonResponse);
			//JsonObject json = jsonReader.readObject();
			//c.set_void(_void);
			//array.getJsonObject(arg0)
		//	c.setEntityID(json.getString("_id"));
		//	c.set
		}
		
		return list;
		
	}
	
	
	
}
