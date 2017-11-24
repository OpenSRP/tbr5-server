package com.ihsinformatics.app.model;

import java.time.LocalDate;
import java.util.Date;

public class Obs {

    private String fieldType;
    private int obsID;
    private int eventID;
    private String fieldDataType;
    private String fieldCode;
    private String parentCode;
    private String values;
    private String comments;
    private String formSubmissionField;
    private Date date;
    private String humanReadableValues;

    public String getFieldType() {
        return fieldType;
    }

    public void setFieldType(String fieldType) {
        this.fieldType = fieldType;
    }

    public int getObsID() {
        return obsID;
    }

    public void setObsID(int obsID) {
        this.obsID = obsID;
    }

    public int getEventID() {
        return eventID;
    }

    public void setEventID(int eventID) {
        this.eventID = eventID;
    }

    public String getFieldDataType() {
        return fieldDataType;
    }

    public void setFieldDataType(String fieldDataType) {
        this.fieldDataType = fieldDataType;
    }

    public String getFieldCode() {
        return fieldCode;
    }

    public void setFieldCode(String fieldCode) {
        this.fieldCode = fieldCode;
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

    public String getFormSubmissionField() {
        return formSubmissionField;
    }

    public void setFormSubmissionField(String formSubmissionField) {
        this.formSubmissionField = formSubmissionField;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getHumanReadableValues() {
        return humanReadableValues;
    }

    public void setHumanReadableValues(String humanReadableValues) {
        this.humanReadableValues = humanReadableValues;
    }
}
