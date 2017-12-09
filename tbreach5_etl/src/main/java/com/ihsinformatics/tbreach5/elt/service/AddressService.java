package com.ihsinformatics.tbreach5.elt.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ihsinformatics.tbreach5.elt.dao.AddressDao;
import com.ihsinformatics.tbreach5.elt.model.Address;

@Service
public class AddressService implements IAddressService {

	@Autowired
	private AddressDao addressDao;
	
	@Override
	public Address findOne(long id) {
		
		return addressDao.findOne(id);
	}

	@Override
	public List<Address> findAll() {
	
		return addressDao.findAll();
	}

	@Override
	public void create(Address entity) {
		addressDao.create(entity);

	}

	@Override
	public void update(Address entity) {
		addressDao.update(entity);

	}

	@Override
	public void delete(Address entity) {
		addressDao.delete(entity);

	}

	@Override
	public void deleteById(long entityId) {
		addressDao.deleteById(entityId);

	}

}
