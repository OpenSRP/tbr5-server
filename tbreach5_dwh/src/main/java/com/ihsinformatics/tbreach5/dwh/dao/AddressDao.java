package com.ihsinformatics.tbreach5.dwh.dao;

import org.springframework.stereotype.Repository;

import com.ihsinformatics.tbreach5.dwh.model.Address;



@Repository
public class AddressDao extends BaseDao<Address> {

	
	 public AddressDao(){
	      setClazz(Address.class );
	   }
}
