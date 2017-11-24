package com.ihsinformatics.tbreach5.elt.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Component;

import com.ihsinformatics.tbreach5.elt.model.Client;

@Component
@Mapper
public interface ClientMapper {

	@Insert("INSERT INTO public.\"Client\"(\n" +
			"             \"firstName\", \"middleName\", \"lastName\", \"birthDate\", \n" +
			"            \"deathDate\", \"birthDateApprox\", \"deathDateApprox\", gender, \"dateCreated\", \n" +
			"            \"dateEdited\", voided, \"dateVoid\", \"voidReason\", \"serverVersion\", \n" +
			"            \"entityID\", creator, editor, void)\n" +
			"    VALUES ( #{firstName}, #{middleName}, #{lastName},#{birthDate}, \n" +
			"            #{deathDate},#{birthDateApprox},#{dateDateApprox},#{gender}, #{dateCreated}, \n" +
			"            #{dateEdited},#{voided}, #{dateVoid}, #{voidReason},#{serverVersion}, \n" +
			"            #{entityID},#{creator}, #{editor}, #{void})")
	public int insertClient(Client client);

	@Select("Select * from 'Client' Where clientID=#{id}")
	Client findUserById(@Param("id") int id);

	@Select("Select * from 'Client' Where entityID=#{entityID}")
	Client findUserByEntityID(@Param("entityID") String entityID);

	@Select("Select * from public.\"Client\"")
	List<Client> selectAll();
	
	@Select("Select * from public.\"Client\"")
	List<Map<String, Object>> selectAll2();
	
	
	

	
/*	final String sql = "${sql}";

	@Select(sql)
	void execute(HashMap<String, String> m);*/
}
