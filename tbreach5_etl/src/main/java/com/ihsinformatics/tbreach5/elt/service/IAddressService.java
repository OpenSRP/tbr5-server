package com.ihsinformatics.tbreach5.elt.service;

import java.util.List;

import com.ihsinformatics.tbreach5.elt.model.Address;

public interface IAddressService {

	Address findOne(long id);

	List<Address> findAll();

	void create(Address entity);

	void update(Address entity);

	void delete(Address entity);

	void deleteById(long entityId);

}
