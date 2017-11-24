package com.ihsinformatics.tbreach5.elt.couchdb;

public class CouchdbMapper {

    public static final String DOCUMENT="doc";
    public static final String ID="id";
    public static final String KEY="key";
    public static final String TYPE="type";
    public static final String DATECREATED="dateCreated";
    public static final String DATEEDITED="dateEdited";
    public static final String ENTITYID="baseEntityId";

    public static final String IDENTIFIERS="identifiers";
    public static final String ADDRESSES="addresses";
    public static final String ATTRIBUTES="attributes";
    public static final String RELATIONSHIPS="relationships";

    public static final class Databases{
    	
    	public static final String OPENSRP="thrive-opensrp";
    	public static final String OPENSRP_FORM="thrive-opensrp-form";
    }
    
    public static final class Client{


        public static final String FIRSTNAME="firstName";
        public static final String LASTNAME="lastName";
        public static final String BIRTHDATE="birthdate";
        public static final String BIRTHDATE_APPROX="birthdateApprox";

        public static final String GENDER="gender";
        public static final String DEATHDATE_APPROX="deathdateApprox";


        public static final String DEATHDATE ="deathdate" ;
    }


    public static final class Address {

        public static final String CITYVILLAGE="cityVillage";
        public static final String STATEPROVINCE="stateProvince";
        public static final String COUNTRY="country";
        public static final String ADDRESS_TYPE="type";


    }


    public static final class Creator {


    }



}
