package com.ihsinformatics.tbreach5.dwh.mapper;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@SuppressWarnings("rawtypes")
@Mapper
public interface DataMapper {

    HashMap findByState(@Param("mappedId") int mappedId);

    HashMap findByUniqueId(@Param("table") String table, @Param("id") String id, @Param("value") String value);

    void insert(@Param("table") String table, @Param("map") Map map);

    void update(@Param("table") String table, @Param("id") String id, @Param("value") String value, @Param("map") Map map);

}