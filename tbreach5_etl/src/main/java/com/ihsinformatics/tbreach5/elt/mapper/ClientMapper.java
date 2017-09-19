package com.ihsinformatics.tbreach5.elt.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.ihsinformatics.tbreach5.elt.model.Client;


@Mapper
public interface ClientMapper {
	
	void insertClient(Client client);

	Client findUserById(Integer id);

	List<Client> selectAll();

}
