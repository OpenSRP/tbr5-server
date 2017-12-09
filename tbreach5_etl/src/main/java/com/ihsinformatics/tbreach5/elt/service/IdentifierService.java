package com.ihsinformatics.tbreach5.elt.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ihsinformatics.tbreach5.elt.dao.IdentifierDao;
import com.ihsinformatics.tbreach5.elt.model.Identifier;

@Service
public class IdentifierService implements IIdentifierService {
	
	@Autowired
	private IdentifierDao identifierDao;
	
	@Override
	public Identifier findOne(long id) {
	
		return identifierDao.findOne(id);
	}

	@Override
	public List<Identifier> findAll() {
		
		return identifierDao.findAll();
	}

	@Override
	public void create(Identifier entity) {
		identifierDao.create(entity);

	}

	@Override
	public void update(Identifier entity) {
		identifierDao.update(entity);

	}

	@Override
	public void delete(Identifier entity) {
		identifierDao.delete(entity);

	}

	@Override
	public void deleteById(long entityId) {
		identifierDao.deleteById(entityId);

	}

}
