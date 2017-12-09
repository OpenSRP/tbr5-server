package com.ihsinformatics.tbreach5.elt.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "identifier")
public class Identifier implements Serializable {

	@Id
	@GeneratedValue
	@Column(name = "identifierid")
	private int identifierid;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "clientid")
	private Client client;

	@Column(name = "identifier")
	private String identifier;

	@Column(name = "description")
	private String description;

	@Column(name = "entityID")
	private String entityID;

	@Column(name = "key")
	private String key;

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getIdentifier() {
		return identifier;
	}

	public void setIdentifier(String identifier) {
		this.identifier = identifier;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getEntityID() {
		return entityID;
	}

	public void setEntityID(String entityID) {
		this.entityID = entityID;
	}

	public int getIdentifierid() {
		return identifierid;
	}

	public void setIdentifierid(int identifierid) {
		this.identifierid = identifierid;
	}

	public Client getClient() {
		return client;
	}

	public void setClient(Client client) {
		this.client = client;
	}

}
