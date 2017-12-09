package com.ihsinformatics.tbreach5.elt.dao;

import org.springframework.stereotype.Repository;

import com.ihsinformatics.tbreach5.elt.model.Attribute;
import com.ihsinformatics.tbreach5.elt.model.Client;
@Repository
public class AttributeDao extends BaseDao<Attribute> {

	 public AttributeDao(){
	      setClazz(Attribute.class );
	   }
}
