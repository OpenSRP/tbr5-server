package com.ihsinformatics.tbreach5.dwh.dao;

import org.springframework.stereotype.Repository;

import com.ihsinformatics.tbreach5.dwh.model.Event;
import com.ihsinformatics.tbreach5.dwh.model.Identifier;
@Repository
public class EventDao extends BaseDao<Event> {

	
	 public EventDao(){
	      setClazz(Event.class );
	   }
}
