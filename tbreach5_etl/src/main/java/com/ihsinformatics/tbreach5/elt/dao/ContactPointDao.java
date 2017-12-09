package com.ihsinformatics.tbreach5.elt.dao;

import org.springframework.stereotype.Repository;

import com.ihsinformatics.tbreach5.elt.model.ContactPoint;
import com.ihsinformatics.tbreach5.elt.model.Event;
@Repository
public class ContactPointDao extends BaseDao<ContactPoint> {

	
	 public ContactPointDao(){
	      setClazz(ContactPoint.class );
	   }
}
