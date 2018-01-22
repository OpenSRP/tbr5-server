package com.ihsinformatics.tbreach5.etl.thread;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.ihsinformatics.tbreach5.etl.postgresql.hibernateService;
//@Component
public class ClientRunnable implements Runnable {

	private List<com.ihsinformatics.tbreach5.dwh.model.Client> clientList;
	
	@Autowired
	private hibernateService hs;
	
	public ClientRunnable(List<com.ihsinformatics.tbreach5.dwh.model.Client> clientList) {
		this.clientList=clientList;
	}
	@Override
	public void run() {
		hs.saveToHibernate(clientList);

	}

}
