package com.ihsinformatics.tbreach5.web;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.JsonObject;
import com.ihsinformatics.tbreach5.elt.service.ClientService;
import com.ihsinformatics.tbreach5.util.CouchDBProperties;
import com.ihsinformatics.tbreach5.util.RestResourceURI;




@RestController
public class ClientController {
	
	@Autowired
	private CouchDBProperties couchDBProperties;
	
	@Autowired
	private ClientService clientService;
	@RequestMapping(value=RestResourceURI.CLIENT,method = RequestMethod.GET)
	public String getAllClient() {
		System.out.println("============================================");
			//System.out.println);
		String sql = "Select * from public.\"client\"";
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("sql", sql);
		//clientMapper.execute(map);
		JsonObject jsonException =new JsonObject();
		jsonException.addProperty("error", "This service is currently unavailable.");
		jsonException.addProperty("code",404);
		 return jsonException.toString();
	}
	
	@RequestMapping(value="/getdb1", method= RequestMethod.GET)
	public String getDB() {
		return clientService.findAll().toString();
	}

}
