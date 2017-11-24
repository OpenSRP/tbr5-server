package com.ihsinformatics.app.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.JsonObject;
import com.ihsinformatics.app.util.RestResourceURI;
import com.ihsinformatics.tbreach5.elt.mapper.ClientMapper;




@RestController
public class ClientController {
	
	/*@Autowired
	private ClientMapper clientMapper;*/
	
/*	@Autowired
	private SQLAdapter sqlAdapter;*/
	@RequestMapping(value=RestResourceURI.CLIENT,method = RequestMethod.GET)
	public String getAllClient() {
		System.out.println("============================================");
			//System.out.println);
		String sql = "Select * from public.\"Client\"";
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("sql", sql);
		//clientMapper.execute(map);
		JsonObject jsonException =new JsonObject();
		jsonException.addProperty("error", "This service is currently unavailable.");
		jsonException.addProperty("code",404);
		 return jsonException.toString();
	}

}
