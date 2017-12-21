package com.ihsinformatics.tbreach5.dwh.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ihsinformatics.tbreach5.dwh.dao.ContactPointDao;
import com.ihsinformatics.tbreach5.dwh.model.ContactPoint;

@Service
public class ContactPointService implements IContactPointService {

	@Autowired
	private ContactPointDao contactPointDao;
	@Override
	public ContactPoint findOne(long id) {
		
		return contactPointDao.findOne(id);
	}

	@Override
	public List<ContactPoint> findAll() {
		
		return contactPointDao.findAll();
	}

	@Override
	public void create(ContactPoint entity) {
		contactPointDao.create(entity);

	}

	@Override
	public void update(ContactPoint entity) {
		contactPointDao.update(entity);

	}

	@Override
	public void delete(ContactPoint entity) {
		contactPointDao.delete(entity);

	}

	@Override
	public void deleteById(long entityId) {
		contactPointDao.deleteById(entityId);

	}

}
