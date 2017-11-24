package com.ihsinformatics.app.model;

import java.time.LocalDate;
import java.util.Date;

public class ContactPoint {

    private int contactPointID;
    private int clientID ;
    private String type;
    private String use;
    private String number;
    private int preference;
    private Date startDate;
    private Date endDate;
    private String entity;


    public int getContactPointID() {
        return contactPointID;
    }

    public void setContactPointID(int contactPointID) {
        this.contactPointID = contactPointID;
    }

    public int getClientID() {
        return clientID;
    }

    public void setClientID(int clientID) {
        this.clientID = clientID;
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

    public int getPreference() {
        return preference;
    }

    public void setPreference(int preference) {
        this.preference = preference;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getEntity() {
        return entity;
    }

    public void setEntity(String entity) {
        this.entity = entity;
    }
}
