package com.ihsinformatics.tbreach5.elt.dao;

import org.springframework.stereotype.Repository;

import com.ihsinformatics.tbreach5.elt.model.Identifier;
import com.ihsinformatics.tbreach5.elt.model.Obs;
@Repository
public class IdentifierDao extends BaseDao<Identifier> {

	 public IdentifierDao(){
	      setClazz(Identifier.class );
	   }
}
