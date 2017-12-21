package com.ihsinformatics.tbreach5.dwh.service;

import java.util.List;

import com.ihsinformatics.tbreach5.dwh.model.Obs;

public interface IObsService {

	Obs findOne(long id);

	List<Obs> findAll();

	void create(Obs entity);

	void update(Obs entity);

	void delete(Obs entity);

	void deleteById(long entityId);
}
