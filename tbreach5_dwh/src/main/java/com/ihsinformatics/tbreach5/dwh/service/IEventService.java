package com.ihsinformatics.tbreach5.dwh.service;

import java.util.List;

import com.ihsinformatics.tbreach5.dwh.model.Event;

public interface IEventService {

	Event findOne(long id);

	List<Event> findAll();

	void create(Event entity);

	void update(Event entity);

	void delete(Event entity);

	void deleteById(long entityId);
}
