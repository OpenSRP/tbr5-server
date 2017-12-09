package com.ihsinformatics.tbreach5.elt.model;

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
@Table(name="event")
public class Event implements Serializable {
	@Id
	@GeneratedValue
	@Column(name = "eventid")
	private int  eventid;
	
	@Column(name = "eventtype")
	private String eventtype;
	
	@Column(name = "eventname")
	private String eventname;
	

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "clientid")
	private Client client;
	
	@Column(name = "eventdate")
	private Date eventdate;
	
	/*@Column(name = "eventdatajson")
	private String eventdatajson;*/
	
	@Column(name = "entityid")
	private String entityid;
	
	@Column(name = "formsubmissionid")
	private String formsubmissionid;
	
	@Column(name = "entityType")
	private String entityType;
	
	@Column(name = "duration")
	private Long duration;
	
	@Column(name = "datecreated")
	private Date datecreated;
	
	@Column(name = "locationid")
	private String locationid;
	
	@Column(name = "version")
	private Long version;

	public int getEventid() {
		return eventid;
	}

	public void setEventid(int eventid) {
		this.eventid = eventid;
	}

	public String getEventtype() {
		return eventtype;
	}

	public void setEventtype(String eventtype) {
		this.eventtype = eventtype;
	}

	public String getEventname() {
		return eventname;
	}

	public void setEventname(String eventname) {
		this.eventname = eventname;
	}

	public Client getClient() {
		return client;
	}

	public void setClient(Client client) {
		this.client = client;
	}

	public Date getEventdate() {
		return eventdate;
	}

	public void setEventdate(Date eventdate) {
		this.eventdate = eventdate;
	}

	public String getEntityid() {
		return entityid;
	}

	public void setEntityid(String entityid) {
		this.entityid = entityid;
	}

	public String getFormsubmissionid() {
		return formsubmissionid;
	}

	public void setFormsubmissionid(String formsubmissionid) {
		this.formsubmissionid = formsubmissionid;
	}

	public String getEntityType() {
		return entityType;
	}

	public void setEntityType(String entityType) {
		this.entityType = entityType;
	}

	public Long getDuration() {
		return duration;
	}

	public void setDuration(Long duration) {
		this.duration = duration;
	}

	public Date getDatecreated() {
		return datecreated;
	}

	public void setDatecreated(Date datecreated) {
		this.datecreated = datecreated;
	}

	public String getLocationid() {
		return locationid;
	}

	public void setLocationid(String locationid) {
		this.locationid = locationid;
	}

	public Long getVersion() {
		return version;
	}

	public void setVersion(Long version) {
		this.version = version;
	}
	
	
	

}
