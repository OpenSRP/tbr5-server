package com.ihsinformatics.tbreach5.dwh.dao;

import org.springframework.stereotype.Repository;

import com.ihsinformatics.tbreach5.dwh.model.Attribute;
import com.ihsinformatics.tbreach5.dwh.model.Client;
@Repository
public class AttributeDao extends BaseDao<Attribute> {

	 public AttributeDao(){
	      setClazz(Attribute.class );
	   }
}
