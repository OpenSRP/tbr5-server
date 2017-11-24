package com.ihsinformatics.app.model;

public class Identifier {

     private int identifierID;
     private int ClientID;
     private String identifier;
     private String description;
     private String entityID;
     private String key;

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public int getIdentifierID() {
        return identifierID;
    }

    public void setIdentifierID(int identifierID) {
        this.identifierID = identifierID;
    }

    public int getClientID() {
        return ClientID;
    }

    public void setClientID(int clientID) {
        ClientID = clientID;
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
}
