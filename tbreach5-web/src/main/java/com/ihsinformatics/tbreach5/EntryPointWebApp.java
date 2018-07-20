package com.ihsinformatics.tbreach5;

import java.io.File;
import java.io.IOException;
import java.io.OutputStreamWriter;

import org.codehaus.plexus.util.cli.CommandLineException;
import org.codehaus.plexus.util.cli.CommandLineUtils;
import org.codehaus.plexus.util.cli.Commandline;
import org.codehaus.plexus.util.cli.WriterStreamConsumer;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.SecurityAutoConfiguration;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.core.io.ClassPathResource;
import org.springframework.scheduling.annotation.EnableScheduling;

import com.cloudant.client.api.CloudantClient;
import com.cloudant.client.api.Database;

@SpringBootApplication(scanBasePackages = "com.ihsinformatics.tbreach5.*", exclude = { SecurityAutoConfiguration.class })
@EnableScheduling
public class EntryPointWebApp extends SpringBootServletInitializer {
	
	@Value( "${cloudant.database}" )
	private String cloudantDatabse;

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(EntryPointWebApp.class);
	}
	    
	public static void main(String[] args) throws CommandLineException, IOException {
		SpringApplication.run(EntryPointWebApp.class, args);
	}
	
	@Bean
	public Database cloudantDatabase(CloudantClient cloudant) {
		return cloudant.database(cloudantDatabse, false);
	}
}