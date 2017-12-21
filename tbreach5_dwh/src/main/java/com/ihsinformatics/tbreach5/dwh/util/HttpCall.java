package com.ihsinformatics.tbreach5.dwh.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

public class HttpCall {
	
	public static final String GET="GET";
	public static final String POST="POST";
	private final String USER_AGENT = "Mozilla/5.0";

	
	public  String call(String url , String Method) throws IOException{
		
		
		URL obj = new URL(url);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();

		// optional default is GET
		con.setRequestMethod(Method);

		//add request header
		con.setRequestProperty("User-Agent", USER_AGENT);

		int responseCode = con.getResponseCode();
		
		BufferedReader in = new BufferedReader(
		        new InputStreamReader(con.getInputStream()));
		String inputLine;
		StringBuffer response = new StringBuffer();

		while ((inputLine = in.readLine()) != null) {
			response.append(inputLine);
		}
		in.close();

		return response.toString();
		
	}
	
	
  	public  InputStream callByInputStream(String url , String Method) throws IOException{
		
		
		URL obj = new URL(url);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();

		// optional default is GET
		con.setRequestMethod(Method);

		//add request header
		con.setRequestProperty("User-Agent", USER_AGENT);
		//in.close();
		int responseCode = con.getResponseCode();
		InputStream r = con.getInputStream();
		
		return r;
	

	//	return response.toString();
		
	}
	

}
