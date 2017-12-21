package com.ihsinformatics.tbreach5.dwh.service;

import java.util.List;

import com.ihsinformatics.tbreach5.dwh.model.ContactPoint;

public interface IContactPointService {

	ContactPoint findOne(long id);

	List<ContactPoint> findAll();

	void create(ContactPoint entity);

	void update(ContactPoint entity);

	void delete(ContactPoint entity);

	void deleteById(long entityId);
}
