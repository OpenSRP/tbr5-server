package com.ihsinformatics.tbreach5.elt.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ihsinformatics.tbreach5.elt.dao.ObsDao;
import com.ihsinformatics.tbreach5.elt.model.Obs;

@Service
public class ObsService implements IObsService {

	@Autowired
	private ObsDao obsDao;

	@Override
	public Obs findOne(long id) {

		return obsDao.findOne(id);
	}

	@Override
	public List<Obs> findAll() {

		return obsDao.findAll();
	}

	@Override
	public void create(Obs entity) {
		obsDao.create(entity);

	}

	@Override
	public void update(Obs entity) {
		obsDao.update(entity);

	}

	@Override
	public void delete(Obs entity) {
		obsDao.delete(entity);

	}

	@Override
	public void deleteById(long entityId) {
		obsDao.deleteById(entityId);

	}

}
