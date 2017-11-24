package com.ihsinformatics.tbreach5.elt.model;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

public class Client {
	
	private int clientID;
	private String firstName;
	private String middleName;
	private String lastName;
	private Date birthDate;
	private Date deathDate;
	private boolean birthDateApprox;
	private boolean deathDateApprox;
	private String gender;
	private String entityID;
	private Date dateCreated;
	private Date dateEdited;
	private boolean voided;
	private String voidReason;
	private int _void;
	private String serverVersion;
	//private List<Identifier> identifiers;
	private List<Address> addresses;

	public List<Address> getAddresses() {
		return addresses;
	}

	public void setAddresses(List<Address> addresses) {
		this.addresses = addresses;
	}
/*
	public List<Identifier> getIdentifiers() {
		return identifiers;
	}

	public void setIdentifiers(List<Identifier> identifiers) {
		this.identifiers = identifiers;
	}
*/
	public int getClientID() {
		return clientID;
	}
	public void setClientID(int clientID) {
		this.clientID = clientID;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getMiddleName() {
		return middleName;
	}
	public void setMiddleName(String middleName) {
		this.middleName = middleName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public Date getBirthDate() {
		return birthDate;
	}
	public void setBirthDate(Date birthDate) {
		this.birthDate = birthDate;
	}
	public Date getDeathDate() {
		return deathDate;
	}
	public void setDeathDate(Date deathDate) {
		this.deathDate = deathDate;
	}
	public boolean isBirthDateApprox() {
		return birthDateApprox;
	}
	public void setBirthDateApprox(boolean birthDateApprox) {
		this.birthDateApprox = birthDateApprox;
	}
	public boolean isDeathDateApprox() {
		return deathDateApprox;
	}
	public void setDeathDateApprox(boolean deathDateApprox) {
		this.deathDateApprox = deathDateApprox;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getEntityID() {
		return entityID;
	}
	public void setEntityID(String entityID) {
		this.entityID = entityID;
	}
	public Date getDateCreated() {
		return dateCreated;
	}
	public void setDateCreated(Date dateCreated) {
		this.dateCreated = dateCreated;
	}
	public Date getDateEdited() {
		return dateEdited;
	}
	public void setDateEdited(Date dateEdited) {
		this.dateEdited = dateEdited;
	}
	public boolean isVoided() {
		return voided;
	}
	public void setVoided(boolean voided) {
		this.voided = voided;
	}
	public String getVoidReason() {
		return voidReason;
	}
	public void setVoidReason(String voidReason) {
		this.voidReason = voidReason;
	}
	public int get_void() {
		return _void;
	}
	public void set_void(int _void) {
		this._void = _void;
	}
	public String getServerVersion() {
		return serverVersion;
	}
	public void setServerVersion(String serverVersion) {
		this.serverVersion = serverVersion;
	}

	@Override
	public String toString() {
		return "Client [clientID=" + clientID + ", firstName=" + firstName + ", lastName=" + lastName + ", entityID="
				+ entityID + "]";
	}
	
	
	
	
	
}
