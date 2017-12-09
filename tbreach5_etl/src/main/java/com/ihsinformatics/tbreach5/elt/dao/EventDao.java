package com.ihsinformatics.tbreach5.elt.dao;

import org.springframework.stereotype.Repository;

import com.ihsinformatics.tbreach5.elt.model.Event;
import com.ihsinformatics.tbreach5.elt.model.Identifier;
@Repository
public class EventDao extends BaseDao<Event> {

	
	 public EventDao(){
	      setClazz(Event.class );
	   }
}
