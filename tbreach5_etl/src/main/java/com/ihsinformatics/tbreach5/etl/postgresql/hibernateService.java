package com.ihsinformatics.tbreach5.etl.postgresql;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.ihsinformatics.tbreach5.dwh.service.ClientService;
import com.ihsinformatics.tbreach5.dwh.model.Client;
@Component
public class hibernateService {

	@Autowired
	private ClientService clientService;

	
	public void saveToHibernate(List<com.ihsinformatics.tbreach5.dwh.model.Client> clientList) {
		
		for(Client client : clientList) {
		clientService.create(client);
		}
	}
	
/*	public void trasferFromCouchDBToPostgreSQL(Date StartTime , Date endTime) {
		
		List<Client> couchdbList = dbClient.view("Client/all")
				  .includeDocs(true)
				  .startKey(StartTime)
				  .endKey(endTime)
				  .limit(10)
				  .query(Client.class);
		
		
		
		
	}*/
	
}
