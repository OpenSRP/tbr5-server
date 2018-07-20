package com.ihsinformatics.tbreach5.etl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.cloudant.client.api.Database;
import com.cloudant.client.api.model.ChangesResult.Row;
import com.ihsinformatics.tbreach5.dwh.mapper.DataMapper;
import com.ihsinformatics.tbreach5.dwh.mapper.MetadataMapper;
import com.ihsinformatics.tbreach5.dwh.mapper.TokenMapper;
import com.ihsinformatics.tbreach5.dwh.utils.DatabaseUtils;
import com.ihsinformatics.tbreach5.dwh.utils.DateUtils;

@Component
public class CloudantSyncService {
	public static final String CLOUDANT_SYNC_TOKEN = "CLOUDANT_SYNC_TOKEN";

	@Autowired
	private TokenMapper tokenDao;
	
	@Autowired
	private DataMapper dataDao;
	
	@Autowired
	private MetadataMapper metadataDao;
	
	@Autowired
	private Database cloudantDb;

	public Database getCloudantDb() {
		return cloudantDb;
	}
	
	public List<Row> getData(String since) {
		return since == null? cloudantDb.changes().includeDocs(true).getChanges().getResults():cloudantDb.changes().since(since).getChanges().getResults();
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Scheduled(fixedDelayString = "${cloudant.changes.read-interval-ms}") 
	public void syncCloudant() {
        Logger.getGlobal().info("The time is now {} "+new Date());
        
        HashMap syncToken = tokenDao.findByName(CLOUDANT_SYNC_TOKEN);
        
        String since = null;

        if(syncToken != null && syncToken.size() > 0) {
        	since = syncToken.get("value") == null ? null : syncToken.get("value").toString();
        }
        
        // do the dew
        List<Row> data = getData(since);
        
        Logger.getGlobal().info("Got new changes of size "+data.size());
        
        for (Row row : data) {
        	if(row.getDoc().has("type")) {
        		String type = row.getDoc().get("type").getAsString();

        		if(type.equalsIgnoreCase("client")) {
        			JSONObject clientMapping = metadataDao.getMapping("couldant-client-mapping");
        			List<Map<String, Object>> client = metadataDao.getMetadata("client");
        			
        			Map<String, Object> persistable = DatabaseUtils.convertToDatabaseObject(new JSONObject(row.getDoc().toString()), clientMapping, client);
        			
        			if(dataDao.findByUniqueId("client", "baseentityid", persistable.get("baseentityid").toString()) != null) {
        				dataDao.update("client", "baseentityid", persistable.get("baseentityid").toString(), persistable);
        			}
        			else {
        				dataDao.insert("client", persistable);
        			}
        		}
        		else if(type.equalsIgnoreCase("event")) {
        			JSONObject eventMapping = metadataDao.getMapping("couldant-event-mapping");
        			List<Map<String, Object>> event = metadataDao.getMetadata("event");
        			
        			Map<String, Object> persistable = DatabaseUtils.convertToDatabaseObject(new JSONObject(row.getDoc().toString()), eventMapping, event);
        			
        			if(dataDao.findByUniqueId("event", "_id", persistable.get("_id").toString()) != null) {
        				dataDao.update("event", "_id", persistable.get("_id").toString(), persistable);
        			}
        			else {
        				dataDao.insert("event", persistable);
        			}
        		}
        	}
		}
        
		if(syncToken == null || syncToken.size() == 0) {
        	syncToken = new HashMap<>();
        	syncToken.put("name", CLOUDANT_SYNC_TOKEN);
        	syncToken.put("datecreated", DateUtils.todaysDatetimeDb());
        	syncToken.put("dateedited", DateUtils.todaysDatetimeDb());
        	syncToken.put("value", since /*DateUtils.todaysDatetimeWithMillis()*/);
        	
        	tokenDao.insert(syncToken);        	
        }
        else {
        	syncToken.put("dateedited", DateUtils.todaysDatetimeDb());
        	syncToken.put("value", since /*DateUtils.todaysDatetimeWithMillis()*/);
        	
        	tokenDao.update(CLOUDANT_SYNC_TOKEN, syncToken);        	
        }
        
        System.out.println();
    }
	
	public static void main(String[] args) {
		System.out.println(DateTime.parse("2017-01-01 21:21:32.333", DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss.SSS")));
	}
}
