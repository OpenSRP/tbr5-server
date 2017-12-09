package com.ihsinformatics.tbreach5.elt.service;

import java.util.List;

import com.ihsinformatics.tbreach5.elt.model.Identifier;

public interface IIdentifierService {

	Identifier findOne(long id);

	List<Identifier> findAll();

	void create(Identifier entity);

	void update(Identifier entity);

	void delete(Identifier entity);

	void deleteById(long entityId);
}
