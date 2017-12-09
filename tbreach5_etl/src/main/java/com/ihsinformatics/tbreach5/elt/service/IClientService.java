package com.ihsinformatics.tbreach5.elt.service;

import java.util.List;

import com.ihsinformatics.tbreach5.elt.model.Client;

public interface IClientService {

	Client findOne(long id);

	List<Client> findAll();

	void create(Client entity);

	void update(Client entity);

	void delete(Client entity);

	void deleteById(long entityId);
}
