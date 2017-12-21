package com.ihsinformatics.tbreach5.dwh.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "contactpoint")
public class ContactPoint implements Serializable {

	@Id
	@GeneratedValue
	@Column(name = "contactpointid")
	private int contactpointid;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "clientid")
	private Client client;

	@Column(name = "type")
	private String type;

	@Column(name = "use")
	private String use;

	@Column(name = "number")
	private String number;

	@Column(name = "preference")
	private Integer preference;

	@Column(name = "startdate")
	private Date startdate;

	@Column(name = "enddate")
	private Date enddate;

	@Column(name = "entity")
	private String entity;

	public int getContactpointid() {
		return contactpointid;
	}

	public void setContactpointid(int contactpointid) {
		this.contactpointid = contactpointid;
	}

	public Client getClient() {
		return client;
	}

	public void setClient(Client client) {
		this.client = client;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getUse() {
		return use;
	}

	public void setUse(String use) {
		this.use = use;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public Integer getPreference() {
		return preference;
	}

	public void setPreference(Integer preference) {
		this.preference = preference;
	}

	public Date getStartdate() {
		return startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}

	public Date getEnddate() {
		return enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public String getEntity() {
		return entity;
	}

	public void setEntity(String entity) {
		this.entity = entity;
	}

}
