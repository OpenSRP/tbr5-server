package com.ihsinformatics.tbreach5.dwh.dao;

import org.springframework.stereotype.Repository;

import com.ihsinformatics.tbreach5.dwh.model.Identifier;
import com.ihsinformatics.tbreach5.dwh.model.Obs;
@Repository
public class IdentifierDao extends BaseDao<Identifier> {

	 public IdentifierDao(){
	      setClazz(Identifier.class );
	   }
}
