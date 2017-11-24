package com.ihsinformatics.app.mapper;

import com.ihsinformatics.app.model.Client;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;


@Mapper
public interface ClientMapper2 {

	@Select("Select * from 'Client'")
	List<Map<String, Object>> selectAll();
	
	//List<Client> selectAllByAge();

}
