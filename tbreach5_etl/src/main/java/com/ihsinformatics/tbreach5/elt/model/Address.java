package com.ihsinformatics.tbreach5.elt.model;

import javax.json.Json;

import java.util.Date;

public class Address {
    private int addressId;
    private String entityID;
    private String country;
    private String stateProvince;
    private String cityVillage;
    private String countryDistrict;
    private String subDistrict;
    private boolean preffered;
    private String addressType;
    private Date startDate;
    private Date endDate;
    private String addressFields;
    private String latitude;
    private String longitude;
    private String geopoint;
    private String postalCode;
    private String subTown;
    private String town;

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public String getEntityID() {
        return entityID;
    }

    public void setEntityID(String entityID) {
        this.entityID = entityID;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getStateProvince() {
        return stateProvince;
    }

    public void setStateProvince(String stateProvince) {
        this.stateProvince = stateProvince;
    }

    public String getCityVillage() {
        return cityVillage;
    }

    public void setCityVillage(String cityVillage) {
        this.cityVillage = cityVillage;
    }

    public String getCountryDistrict() {
        return countryDistrict;
    }

    public void setCountryDistrict(String countryDistrict) {
        this.countryDistrict = countryDistrict;
    }

    public String getSubDistrict() {
        return subDistrict;
    }

    public void setSubDistrict(String subDistrict) {
        this.subDistrict = subDistrict;
    }

    public boolean isPreffered() {
        return preffered;
    }

    public void setPreffered(boolean preffered) {
        this.preffered = preffered;
    }

    public String getAddressType() {
        return addressType;
    }

    public void setAddressType(String addressType) {
        this.addressType = addressType;
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

    public String getAddressFields() {
        return addressFields;
    }

    public void setAddressFields(String addressFields) {
        this.addressFields = addressFields;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public String getGeopoint() {
        return geopoint;
    }

    public void setGeopoint(String geopoint) {
        this.geopoint = geopoint;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

    public String getSubTown() {
        return subTown;
    }

    public void setSubTown(String subTown) {
        this.subTown = subTown;
    }

    public String getTown() {
        return town;
    }

    public void setTown(String town) {
        this.town = town;
    }
}
