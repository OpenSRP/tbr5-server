package com.ihsinformatics.tbreach5.dwh.mapper;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@SuppressWarnings("rawtypes")
@Mapper
public interface TokenMapper {

    HashMap findByName(@Param("name") String name);

    void insert(@Param("map") Map map);

    void update(@Param("name") String name, @Param("map") Map map);
}