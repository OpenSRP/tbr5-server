package com.ihsinformatics.tbreach5.dwh.service;

import java.util.List;

import com.ihsinformatics.tbreach5.dwh.model.Attribute;

public interface IAttributeService {
	
	Attribute findOne(long id);

	List<Attribute> findAll();

	void create(Attribute entity);

	void update(Attribute entity);

	void delete(Attribute entity);

	void deleteById(long entityId);

}
