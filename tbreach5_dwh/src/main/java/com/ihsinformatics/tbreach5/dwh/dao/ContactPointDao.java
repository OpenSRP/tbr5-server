package com.ihsinformatics.tbreach5.dwh.dao;

import org.springframework.stereotype.Repository;

import com.ihsinformatics.tbreach5.dwh.model.ContactPoint;
import com.ihsinformatics.tbreach5.dwh.model.Event;
@Repository
public class ContactPointDao extends BaseDao<ContactPoint> {

	
	 public ContactPointDao(){
	      setClazz(ContactPoint.class );
	   }
}
