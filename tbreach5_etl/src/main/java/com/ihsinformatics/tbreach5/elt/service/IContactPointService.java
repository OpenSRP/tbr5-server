package com.ihsinformatics.tbreach5.elt.service;

import java.util.List;


import com.ihsinformatics.tbreach5.elt.model.ContactPoint;

public interface IContactPointService {

	ContactPoint findOne(long id);

	List<ContactPoint> findAll();

	void create(ContactPoint entity);

	void update(ContactPoint entity);

	void delete(ContactPoint entity);

	void deleteById(long entityId);
}
