package com.ihsinformatics.tbreach5;

import org.apache.ibatis.type.MappedTypes;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

import com.ihsinformatics.tbreach5.elt.model.Client;



@SpringBootApplication
@ComponentScan("com.ihsinformatics.tbreach5")
//@MappedTypes(Client.class)
//@MapperScan("com.ihsinformatics.tbreach5.elt.mapper")

public class DemoApplication {

	

    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }
    
    
    

}