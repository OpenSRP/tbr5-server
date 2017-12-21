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
@Table(name = "obs")
public class Obs implements Serializable {

	@Id
	@GeneratedValue
	@Column(name = "id")
	private int id;

	@Column(name = "fieldtype")
	private String fieldtype;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "eventid")
	private Event event;

	@Column(name = "fielddatatype")
	private String fielddatatype;

	@Column(name = "fieldcode")
	private String fieldcode;

	@Column(name = "parentCode")
	private String parentCode;

	@Column(name = "values")
	private String values;

	@Column(name = "comments")
	private String comments;

	@Column(name = "formsubmissionfield")
	private String formsubmissionfield;

	@Column(name = "date")
	private Date date;

	@Column(name = "humanreadablevalues")
	private String humanreadablevalues;
	
	@Column(name="effectivedatetime")
	private Date effectivedatetime;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFieldtype() {
		return fieldtype;
	}

	public void setFieldtype(String fieldtype) {
		this.fieldtype = fieldtype;
	}

	public Event getEvent() {
		return event;
	}

	public void setEvent(Event event) {
		this.event = event;
	}

	public String getFielddatatype() {
		return fielddatatype;
	}

	public void setFielddatatype(String fielddatatype) {
		this.fielddatatype = fielddatatype;
	}

	public String getFieldcode() {
		return fieldcode;
	}

	public void setFieldcode(String fieldcode) {
		this.fieldcode = fieldcode;
	}

	public String getParentCode() {
		return parentCode;
	}

	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}

	public String getValues() {
		return values;
	}

	public void setValues(String values) {
		this.values = values;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getFormsubmissionfield() {
		return formsubmissionfield;
	}

	public void setFormsubmissionfield(String formsubmissionfield) {
		this.formsubmissionfield = formsubmissionfield;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getHumanreadablevalues() {
		return humanreadablevalues;
	}

	public void setHumanreadablevalues(String humanreadablevalues) {
		this.humanreadablevalues = humanreadablevalues;
	}

	public Date getEffectivedatetime() {
		return effectivedatetime;
	}

	public void setEffectivedatetime(Date effectivedatetime) {
		this.effectivedatetime = effectivedatetime;
	}
	
	

}
