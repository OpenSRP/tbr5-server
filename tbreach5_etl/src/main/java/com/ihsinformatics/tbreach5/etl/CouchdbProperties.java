package com.ihsinformatics.tbreach5.etl;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

@Configuration
@PropertySource("classpath:couchdb.properties")
@ConfigurationProperties(prefix = "couchdb")
public class CouchdbProperties {
	// @Value("${name}")
	private String name ;
	// @Value("${port}")
	private int port ;
	// @Value("${host}")
	private String host;
	// @Value("${username}")
	private String username;
	// @Value("${password}")
	private String password;
	// @Value("${createdb.if-not-exist}")
	private boolean createdbifnotexist;
	// @Value("${protocol}")
	private String protocol;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getPort() {
		return port;
	}

	public void setPort(int port) {
		this.port = port;
	}

	public String getHost() {
		return host;
	}

	public void setHost(String host) {
		this.host = host;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public boolean isCreatedbifnotexist() {
		return createdbifnotexist;
	}

	public void setCreatedbifnotexist(boolean createdbifnotexist) {
		this.createdbifnotexist = createdbifnotexist;
	}

	public String getProtocol() {
		return protocol;
	}

	public void setProtocol(String protocol) {
		this.protocol = protocol;
	}
	
	

}
