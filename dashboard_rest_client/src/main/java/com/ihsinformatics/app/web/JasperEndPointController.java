/**
 * 
 */
package com.ihsinformatics.app.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.ihsinformatics.app.util.RestResourceURI;

import javax.json.Json;
import javax.sql.DataSource;
import javax.websocket.server.PathParam;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Muhammad Ahmed
 *
 */
@Controller
@RequestMapping(value = RestResourceURI.REPORTS)
public class JasperEndPointController {
    private static final String FILE_FORMAT = "format";

    private static final String DATASOURCE = "datasource";

    @Autowired
    private DataSource dbsoruce;

    /*
     * @RequestMapping(value = "{reportname}", method = RequestMethod.GET) public ModelAndView getReportsFull(final ModelMap
     * modelMap, ModelAndView modelAndView, @PathParam("reportname") final String reportname, @RequestParam(FILE_FORMAT) final
     * String format) { // JRDataSource datasource = new JRBeanCollectionDataSource(dataMap); modelMap.put(DATASOURCE, dbsoruce);
     * modelMap.put(FILE_FORMAT, format); modelAndView = new ModelAndView(reportname, modelMap); return modelAndView; }
     */
    @RequestMapping(value = "{reportname}", method = RequestMethod.GET)
    public ModelAndView getRptByParam(final ModelMap modelMap, ModelAndView modelAndView, @PathParam("reportname")
    final String reportname, @RequestParam(FILE_FORMAT)
    final String format, @RequestParam(value = "id" ,required = false)
    final String id) {

        List<String> paramMap = new ArrayList<>();
        

        JsonParser jsonParser = new JsonParser();
        JsonObject  jsonObject=new JsonObject ();
        if(id!=null && !id.isEmpty()) {
        jsonObject=(JsonObject) jsonParser.parse(id);
        //gson.toJson(id);
        for(String s:jsonObject.keySet()) {
        	Integer passedId=null; 
        	if(s.contains("id")) {
        		passedId=Integer.parseInt(jsonObject.get(s).getAsString());
        		modelMap.put(s, passedId);
        	}else {
        	modelMap.put(s, jsonObject.get(s));
        	}
        }
        
    }
        // connecting to mysql
        modelMap.put(DATASOURCE, dbsoruce);
        modelMap.put(FILE_FORMAT, format);
        
        modelAndView = new ModelAndView(reportname, modelMap);
        return modelAndView;
    }
}
