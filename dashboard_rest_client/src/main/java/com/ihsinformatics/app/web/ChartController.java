package com.ihsinformatics.app.web;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.websocket.server.PathParam;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.JsonSyntaxException;
import com.google.gson.reflect.TypeToken;
import com.google.gson.stream.JsonReader;
import com.ihsinformatics.app.model.FileInfo;
import com.ihsinformatics.app.service.JDBCService;
import com.ihsinformatics.app.util.RestResourceURI;


import net.minidev.json.JSONArray;


@RestController
public class ChartController {
	
	@Autowired
	private JDBCService jdbcService;
	
	private final String CHART_PATH=ChartController.class.getProtectionDomain().getCodeSource().getLocation().getPath()+"charts";
	
	@Autowired
	private ServletContext context;
	
	@RequestMapping(value=RestResourceURI.ALL_CHART,method = RequestMethod.GET)
	public String getAllChartsFile(){
		
		File configDir = new File(CHART_PATH);
		JsonArray  jsonArray=new JsonArray ();
		JsonObject jsonException=new JsonObject();
		if(configDir.isDirectory()) {
			for(String s:configDir.list()) {
			
				JsonObject jsonObject = new JsonObject();
			    JsonParser parser = new JsonParser();
	            JsonElement jsonElement;
				try {
					jsonElement = parser.parse(new FileReader(CHART_PATH+"/"+s));
					   jsonObject = jsonElement.getAsJsonObject();	
			            jsonArray.add(jsonObject);
				} catch (JsonIOException | JsonSyntaxException | FileNotFoundException e) {
					jsonException.addProperty("error",e.getLocalizedMessage());
					jsonException.addProperty("code", 404);
					e.printStackTrace();
					return jsonException.toString();
				}
	         
	      	}
		}
	return jsonArray.toString();
		
	}
	
	@RequestMapping(value = RestResourceURI.CHART+"/{fileName}", method = RequestMethod.GET)
	public String getChart(@PathVariable("fileName") String fileName) {

		JsonObject jsonObject = new JsonObject();
		JsonParser parser = new JsonParser();
		JsonElement jsonElement = null;
		JsonObject jsonException = new JsonObject();
		try {
			jsonElement = parser.parse(new FileReader(CHART_PATH + "/" + fileName + ".json"));
			jsonObject = jsonElement.getAsJsonObject();
			String query = jsonObject.get("query").getAsString();
			
			System.out.println(query);
			String querylower = query.toLowerCase();
			if (querylower.contains("file::")) {
				String[] ss = querylower.split(":");
		
				BufferedReader br =null;// new BufferedReader(new FileReader(CHART_PATH+"/"+ss[2]));
				try {
					br = new BufferedReader(new FileReader(CHART_PATH+"/"+ss[2]));
				    StringBuilder sb = new StringBuilder();
				    String line = br.readLine();

				    while (line != null) {
				        sb.append(line);
				        sb.append(System.lineSeparator());
				        line = br.readLine();
				    }
				    query = sb.toString().trim();
				    querylower = sb.toString().trim().toLowerCase();
				   
				} catch (Exception e) {
					jsonException.addProperty("error", e.getLocalizedMessage());
					e.printStackTrace();
				} finally {
				    try {
						br.close();
					} catch (IOException e) {
						jsonException.addProperty("error", e.getLocalizedMessage());
					}
				}      
			}
			if (querylower.contains("update") || querylower.contains("delete") || querylower.contains("insert")
					|| querylower.contains("drop")) {
				jsonException.addProperty("code", 401);
				jsonException.addProperty("error",
						"These Query Can be used for SQL injection.All Update , Delete , Drop , Insert SQL are prohibited! ");
				return jsonException.toString();
			}
			 System.out.println("SQL ::: "+query);
			List<Map<String, Object>> result = jdbcService.execute(query);

			Gson gson = new Gson();
			JsonElement element = gson.toJsonTree(result, new TypeToken<List<Map<String, Object>>>() {
			}.getType());

			jsonObject.add("datasets", element);
			
			return jsonObject.toString();
		
		} catch (JsonIOException e) {
			jsonException.addProperty("error", e.getLocalizedMessage());
			e.printStackTrace();
		} catch (JsonSyntaxException e) {
			jsonException.addProperty("error", e.getLocalizedMessage());
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			jsonException.addProperty("error", e.getLocalizedMessage());
			e.printStackTrace();
		}

		return jsonException.toString();

	}
	
	
	


	 @RequestMapping(value = RestResourceURI.CHART+"/fileupload", headers=("content-type=multipart/*"), method = RequestMethod.POST)
	 public ResponseEntity<FileInfo> upload(@RequestParam("file") MultipartFile inputFile) {
	  FileInfo fileInfo = new FileInfo();
	  HttpHeaders headers = new HttpHeaders();
	  if (!inputFile.isEmpty()) {
	   try {
		   System.out.println("INPUT ::::: "+inputFile.getOriginalFilename());
		   if(inputFile.getOriginalFilename().contains(".json")) {
	    String originalFilename = inputFile.getOriginalFilename();
	    File destinationFile = new File(CHART_PATH+  File.separator + originalFilename);
	    inputFile.transferTo(destinationFile);
	    fileInfo.setFileName(destinationFile.getPath());
	    fileInfo.setFileSize(inputFile.getSize());
	    headers.add("File Uploaded Successfully - ", originalFilename);
	    return new ResponseEntity<FileInfo>(fileInfo, headers, HttpStatus.OK);
		   }else {
			   headers.add("Only Json Format files are accepted. ",inputFile.getOriginalFilename() );
			   return new ResponseEntity<FileInfo>(HttpStatus.BAD_REQUEST);
		   }
	   } catch (Exception e) {    
	    return new ResponseEntity<FileInfo>(HttpStatus.BAD_REQUEST);
	   }
	  }else{
	   return new ResponseEntity<FileInfo>(HttpStatus.BAD_REQUEST);
	  }
	 }
	
	

}
