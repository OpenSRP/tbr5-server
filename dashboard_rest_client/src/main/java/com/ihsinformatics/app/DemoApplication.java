package com.ihsinformatics.app;

import com.ihsinformatics.tbreach5.elt.model.Client;
import org.apache.ibatis.type.MappedTypes;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import  com.ihsinformatics.tbreach5.elt.service.Service;
import  com.ihsinformatics.tbreach5.elt.service.ServiceConfiguration;

@SpringBootApplication
@ComponentScan("com.ihsinformatics.app")
@MappedTypes(Client.class)
@MapperScan("com.ihsinformatics.tbreach5.elt.mapper")

public class DemoApplication {



    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }
    
    
    

}