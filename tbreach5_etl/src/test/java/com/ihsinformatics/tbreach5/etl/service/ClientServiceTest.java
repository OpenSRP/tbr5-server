package com.ihsinformatics.tbreach5.etl.service;

import java.io.File;
import java.util.Date;



import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import com.ihsinformatics.tbreach5.elt.ApplicationStart;
import com.ihsinformatics.tbreach5.elt.model.Client;
import com.ihsinformatics.tbreach5.elt.service.ClientService;


//@RunWith(SpringRunner.class)
//@DataJpaTest
//@SpringBootTest(classes = ApplicationStart.class)
public class ClientServiceTest {

	@Autowired
	private ClientService clientService;
	
	//@Test
	public void insertTest() {
		
	}
}
