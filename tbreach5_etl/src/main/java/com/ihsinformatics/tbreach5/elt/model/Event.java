package com.ihsinformatics.tbreach5.elt.model;

import java.util.Date;

public class Event {

    private int eventID;
    private int eventTypeID;
    private String eventName;
    private int clientID;
    private Date eventTimeStamp;
    private String eventDataJSON;
    private String entityID;

    public int getEventID() {
        return eventID;
    }

    public void setEventID(int eventID) {
        this.eventID = eventID;
    }

    public int getEventTypeID() {
        return eventTypeID;
    }

    public void setEventTypeID(int eventTypeID) {
        this.eventTypeID = eventTypeID;
    }

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public int getClientID() {
        return clientID;
    }

    public void setClientID(int clientID) {
        this.clientID = clientID;
    }

    public Date getEventTimeStamp() {
        return eventTimeStamp;
    }

    public void setEventTimeStamp(Date eventTimeStamp) {
        this.eventTimeStamp = eventTimeStamp;
    }

    public String getEventDataJSON() {
        return eventDataJSON;
    }

    public void setEventDataJSON(String eventDataJSON) {
        this.eventDataJSON = eventDataJSON;
    }

    public String getEntityID() {
        return entityID;
    }

    public void setEntityID(String entityID) {
        this.entityID = entityID;
    }
}
