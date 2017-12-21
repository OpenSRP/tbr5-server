package com.ihsinformatics.tbreach5.dwh.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ihsinformatics.tbreach5.dwh.dao.EventDao;
import com.ihsinformatics.tbreach5.dwh.model.Event;

@Service
public class EventService implements IEventService {

	@Autowired
	private EventDao eventDao;

	@Override
	public Event findOne(long id) {

		return eventDao.findOne(id);
	}

	@Override
	public List<Event> findAll() {

		return eventDao.findAll();
	}

	@Override
	public void create(Event entity) {
		eventDao.create(entity);
	}

	@Override
	public void update(Event entity) {
		eventDao.update(entity);

	}

	@Override
	public void delete(Event entity) {
		eventDao.delete(entity);

	}

	@Override
	public void deleteById(long entityId) {
		eventDao.deleteById(entityId);

	}

}
