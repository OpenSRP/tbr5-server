package com.ihsinformatics.tbreach5.elt.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ihsinformatics.tbreach5.elt.dao.AttributeDao;
import com.ihsinformatics.tbreach5.elt.model.Attribute;

@Service
public class AttributeService implements IAttributeService {

	
	@Autowired
	private AttributeDao attributeDao;
	
	@Override
	public Attribute findOne(long id) {
		
		return attributeDao.findOne(id);
	}

	@Override
	public List<Attribute> findAll() {
		
		return attributeDao.findAll();
	}

	@Override
	public void create(Attribute entity) {
		attributeDao.create(entity);

	}

	@Override
	public void update(Attribute entity) {
		attributeDao.update(entity);

	}

	@Override
	public void delete(Attribute entity) {
		attributeDao.delete(entity);

	}

	@Override
	public void deleteById(long entityId) {
		attributeDao.deleteById(entityId);

	}

}
