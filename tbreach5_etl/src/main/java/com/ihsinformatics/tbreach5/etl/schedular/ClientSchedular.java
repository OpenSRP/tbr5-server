package com.ihsinformatics.tbreach5.etl.schedular;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.lightcouch.CouchDbClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.ihsinformatics.tbreach5.etl.postgresql.hibernateService;

@Component
public class ClientSchedular {
		@Autowired
		private CouchDbClient dbClient;
		@Autowired
		private hibernateService hs;
	
		private static final Logger log = LoggerFactory.getLogger(ClientSchedular.class);

		private static final SimpleDateFormat dateFormat = new SimpleDateFormat(
				"MM/dd/yyyy HH:mm:ss");

	    @Scheduled(fixedRate = 5000)
	    public void reportCurrentTime() {
	        log.info("The time is now {}", dateFormat.format(new Date()));
	    }
}
