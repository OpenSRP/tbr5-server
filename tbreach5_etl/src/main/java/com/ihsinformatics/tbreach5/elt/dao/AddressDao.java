package com.ihsinformatics.tbreach5.elt.dao;

import org.springframework.stereotype.Repository;

import com.ihsinformatics.tbreach5.elt.model.Address;



@Repository
public class AddressDao extends BaseDao<Address> {

	
	 public AddressDao(){
	      setClazz(Address.class );
	   }
}
