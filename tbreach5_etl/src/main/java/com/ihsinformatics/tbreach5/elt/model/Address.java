package com.ihsinformatics.tbreach5.elt.model;

import java.io.Serializable;
import java.time.LocalDate;
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
@Table(name = "address")
public class Address implements Serializable{

	@Id
	@GeneratedValue
	@Column(name = "addressid")
	private int addressid;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "clientid")
	private Client client;

	@Column(name = "country")
	private String country;

	@Column(name = "stateprovince")
	private String stateprovince;

	@Column(name = "cityvillage")
	private String cityvillage;

	@Column(name = "countrydistrict")
	private String countrydistrict;

	@Column(name = "subdistrict")
	private String subdistrict;

	@Column(name = "preffered")
	private boolean preffered;

	@Column(name = "addressType")
	private String addressType;

	@Column(name = "startDate")
	private Date startDate;

	@Column(name = "endDate")
	private Date endDate;

	@Column(name = "addressfields")
	private String addressfields;

	@Column(name = "latitude")
	private String latitude;

	@Column(name = "longitude")
	private String longitude;

	@Column(name = "geopoint")
	private String geopoint;

	@Column(name = "postalcode")
	private String postalcode;

	@Column(name = "subtown")
	private String subtown;

	@Column(name = "town")
	private String town;

	public int getAddressid() {
		return addressid;
	}

	public void setAddressid(int addressid) {
		this.addressid = addressid;
	}

	public Client getClient() {
		return client;
	}

	public void setClient(Client client) {
		this.client = client;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getStateprovince() {
		return stateprovince;
	}

	public void setStateprovince(String stateprovince) {
		this.stateprovince = stateprovince;
	}

	public String getCityvillage() {
		return cityvillage;
	}

	public void setCityvillage(String cityvillage) {
		this.cityvillage = cityvillage;
	}

	public String getCountrydistrict() {
		return countrydistrict;
	}

	public void setCountrydistrict(String countrydistrict) {
		this.countrydistrict = countrydistrict;
	}

	public String getSubdistrict() {
		return subdistrict;
	}

	public void setSubdistrict(String subdistrict) {
		this.subdistrict = subdistrict;
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

	public String getAddressfields() {
		return addressfields;
	}

	public void setAddressfields(String addressfields) {
		this.addressfields = addressfields;
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

	public String getPostalcode() {
		return postalcode;
	}

	public void setPostalcode(String postalcode) {
		this.postalcode = postalcode;
	}

	public String getSubtown() {
		return subtown;
	}

	public void setSubtown(String subtown) {
		this.subtown = subtown;
	}

	public String getTown() {
		return town;
	}

	public void setTown(String town) {
		this.town = town;
	}

}
