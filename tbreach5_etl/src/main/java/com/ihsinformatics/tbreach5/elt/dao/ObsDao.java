package com.ihsinformatics.tbreach5.elt.dao;

import org.springframework.stereotype.Repository;

import com.ihsinformatics.tbreach5.elt.model.Obs;
@Repository
public class ObsDao extends BaseDao<Obs> {
	 public ObsDao(){
	      setClazz(Obs.class );
	   }
}
