package com.ihsinformatics.app.web;




import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.stream.Stream;

import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;


import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.ihsinformatics.app.model.FileInfo;
import com.ihsinformatics.app.util.RestResourceURI;

@RestController
public class ReportController {
	
	private static final String FILE_PATH=ReportController.class.getProtectionDomain().getCodeSource().getLocation().getPath()+"/jasperreports/reports";
	@RequestMapping(value=RestResourceURI.GET_ALL_REPORTS,method= RequestMethod.GET)
	@ResponseBody
	public String getAllReports(HttpServletRequest request) {
		
		String url=request.getRequestURL().toString();
		String replacedURL=url.replaceAll("getAllReports", "");
		
		File configDir = new File(FILE_PATH);
		JsonArray  jsonArray=new JsonArray ();
		JsonObject jsonException=new JsonObject();
		if(configDir.isDirectory()) {
			
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder db;
			Document document = null ;
			for(String s:configDir.list()) {
				JsonObject  jsonObject=new JsonObject ();
				File f=new File(FILE_PATH+"/"+s);
				
				try {
					db = dbf.newDocumentBuilder();
					document = db.parse(f);
				} catch (ParserConfigurationException e) {
					jsonException.addProperty("error", e.getLocalizedMessage());
					e.printStackTrace();
					return jsonException.toString();
				} catch (SAXException e) {
					jsonException.addProperty("error", e.getLocalizedMessage());
					e.printStackTrace();
					return jsonException.toString();
				} catch (IOException e) {
					jsonException.addProperty("error", e.getLocalizedMessage());
					e.printStackTrace();
				return jsonException.toString();
				}
				JsonObject  jsonObject2=new JsonObject ();
				if (document != null) {
					NodeList nodes = document.getElementsByTagName("parameter");
					
					for (int i = 0; i < nodes.getLength(); i++) {
						Node n = nodes.item(i);
						
						if(n.getAttributes().getLength()>0) {
							String name= n.getAttributes().getNamedItem("name").getNodeValue();
							String classType=n.getAttributes().getNamedItem("class").getNodeValue();
							jsonObject2.addProperty(name, classType);
						}
						
						
					}
				}
				
				String reportName =s.replace(".jrxml", "");
				jsonObject.addProperty("reportName", reportName);
				StringBuilder stringBuilder=new StringBuilder();
				stringBuilder.append(replacedURL);
				stringBuilder.append("reports/");
				stringBuilder.append(reportName);
				stringBuilder.append("?reportName=");
				stringBuilder.append(reportName);
				//stringBuilder.append();
				jsonObject.addProperty("reportURL",stringBuilder.toString());
				jsonObject.add("parameters", jsonObject2);
				jsonArray.add(jsonObject);
				
			}
		
		}
		 
		
		return jsonArray.toString();
		
		
	}
	
	 @RequestMapping(value = RestResourceURI.REPORTS+"/fileupload", headers=("content-type=multipart/*"), method = RequestMethod.POST)
	 public ResponseEntity<FileInfo> upload(@RequestParam("file") MultipartFile inputFile) {
	  FileInfo fileInfo = new FileInfo();
	  HttpHeaders headers = new HttpHeaders();
	  if (!inputFile.isEmpty()) {
	   try {
		   System.out.println("INPUT ::::: "+inputFile.getOriginalFilename());
		   if(inputFile.getOriginalFilename().contains(".jrxml")) {
	    String originalFilename = inputFile.getOriginalFilename();
	    File destinationFile = new File(FILE_PATH+  File.separator + originalFilename);
	    inputFile.transferTo(destinationFile);
	    fileInfo.setFileName(destinationFile.getPath());
	    fileInfo.setFileSize(inputFile.getSize());
	    headers.add("File Uploaded Successfully - ", originalFilename);
	    return new ResponseEntity<FileInfo>(fileInfo, headers, HttpStatus.OK);
		   }else {
			   headers.add("Only jrxml Format files are accepted. ",inputFile.getOriginalFilename() );
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
