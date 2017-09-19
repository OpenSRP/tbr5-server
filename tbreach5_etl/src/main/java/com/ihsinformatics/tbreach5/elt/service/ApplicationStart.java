package com.ihsinformatics.tbreach5.elt.service;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.type.MappedTypes;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;

import com.ihsinformatics.tbreach5.elt.mapper.ClientMapper;
import com.ihsinformatics.tbreach5.elt.model.Client;



@EnableAutoConfiguration
@Configuration
@MappedTypes(Client.class)
@MapperScan("com.ihsinformatics.tbreach5.elt.mapper")
@SpringBootApplication
public class ApplicationStart {
	@Autowired
	private static ClientMapper clientMapper;
	
	public static void main(String[] args) {
		SpringApplication.run(ApplicationStart.class, args);
		
		
		System.out.println("========================================================");
	System.out.println("Size : "+   clientMapper.selectAll().toString() );
		System.out.println("========================================================");
	}

	
		

		
	 
}
