package com.ihsinformatics.tbreach5.web;

import org.lightcouch.CouchDbClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller

public class HomeController {
	/*@Autowired
	private ClientMapper clientMapper;*/
	
	@Autowired
	private CouchDbClient dbClient;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
    public String home() {
		//clientMapper.selectAll2();
		//System.out.println(clientMapper.selectAll2());
		
		//dbClient.find();
        return "index";
    }

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index() {

        return "index";
    }
}
