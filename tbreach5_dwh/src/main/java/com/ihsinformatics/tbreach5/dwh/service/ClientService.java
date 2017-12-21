package com.ihsinformatics.tbreach5.dwh.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ihsinformatics.tbreach5.dwh.dao.ClientDao;
import com.ihsinformatics.tbreach5.dwh.model.Client;

@Service
public class ClientService implements IClientService{

	@Autowired
	private ClientDao clientDao;
	
	@Override
	public Client findOne(long id) {
		
		return clientDao.findOne(id);
	}

	@Override
	public List<Client> findAll() {
		
		return clientDao.findAll();
	}

	@Override
	public void create(Client entity) {
		clientDao.create(entity);
		
	}

	@Override
	public void update(Client entity) {
		clientDao.update(entity);
		
	}

	@Override
	public void delete(Client entity) {
		clientDao.delete(entity);
		
	}

	@Override
	public void deleteById(long entityId) {
		clientDao.deleteById(entityId);
		
	}

}
