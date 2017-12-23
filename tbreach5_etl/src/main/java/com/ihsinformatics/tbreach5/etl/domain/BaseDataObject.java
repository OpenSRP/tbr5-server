package com.ihsinformatics.tbreach5.etl.domain;


import org.apache.commons.lang3.builder.ToStringBuilder;
import org.codehaus.jackson.annotate.JsonProperty;
import org.joda.time.DateTime;


public abstract class BaseDataObject {

	@JsonProperty
	private User creator;
	@JsonProperty
	private String dateCreated;
	@JsonProperty
	private User editor;
	@JsonProperty
	private String dateEdited;
	@JsonProperty
	private Boolean voided;
	@JsonProperty
	private String dateVoided;
	@JsonProperty
	private User voider;
	@JsonProperty
	private String voidReason;

	public BaseDataObject() {}
	
	public User getCreator() {
		return creator;
	}

	public void setCreator(User creator) {
		this.creator = creator;
	}

	public String getDateCreated() {
		return dateCreated;
	}

	public void setDateCreated(String dateCreated) {
		this.dateCreated = dateCreated;
	}

	public User getEditor() {
		return editor;
	}

	public void setEditor(User editor) {
		this.editor = editor;
	}

	public String getDateEdited() {
		return dateEdited;
	}

	public void setDateEdited(String dateEdited) {
		this.dateEdited = dateEdited;
	}

	public Boolean getVoided() {
		return voided;
	}

	public void setVoided(Boolean voided) {
		this.voided = voided;
	}

	public String getDateVoided() {
		return dateVoided;
	}

	public void setDateVoided(String dateVoided) {
		this.dateVoided = dateVoided;
	}

	public User getVoider() {
		return voider;
	}

	public void setVoider(User voider) {
		this.voider = voider;
	}

	public String getVoidReason() {
		return voidReason;
	}

	public void setVoidReason(String voidReason) {
		this.voidReason = voidReason;
	}
	
	public BaseDataObject withCreator(User creator) {
		this.creator = creator;
		return this;
	}
/*
	public BaseDataObject withDateCreated(DateTime dateCreated) {
		this.dateCreated = dateCreated;
		return this;
	}*/

	public BaseDataObject withEditor(User editor) {
		this.editor = editor;
		return this;
	}

	public BaseDataObject withDateEdited(String dateEdited) {
		this.dateEdited = dateEdited;
		return this;
	}

	public BaseDataObject withVoided(Boolean voided) {
		this.voided = voided;
		return this;
	}

	public BaseDataObject withDateVoided(String dateVoided) {
		this.dateVoided = dateVoided;
		return this;
	}

	public BaseDataObject withVoider(User voider) {
		this.voider = voider;
		return this;
	}

	public BaseDataObject withVoidReason(String voidReason) {
		this.voidReason = voidReason;
		return this;
	}
	
    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
    
}
