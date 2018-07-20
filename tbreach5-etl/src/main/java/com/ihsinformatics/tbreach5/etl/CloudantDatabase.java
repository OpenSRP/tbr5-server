package com.ihsinformatics.tbreach5.etl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cloudant.client.api.Database;
import com.cloudant.client.api.model.ChangesResult.Row;

@Repository
public class CloudantDatabase {
	
	@Autowired
	private Database cloudantDb;

	public Database getCloudantDb() {
		return cloudantDb;
	}
	
	public List<Row> getData(String since) {
		return cloudantDb.changes().since(since).getChanges().getResults();
	}
	
}
