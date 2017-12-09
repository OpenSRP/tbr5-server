package com.ihsinformatics.tbreach5.elt.model;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.boot.autoconfigure.domain.EntityScan;

@Entity
@Table(name = "client")
public class Client implements Serializable {

	@Id
	@GeneratedValue
	@Column(name = "clientid")
	private int clientid;

	@Column(name = "firstname")
	private String firstname;

	@Column(name = "middlename")
	private String middlename;

	@Column(name = "lastname")
	private String lastname;

	@Column(name = "birthdate")
	private Date birthdate;

	@Column(name = "deathdate")
	private Date deathdate;

	@Column(name = "birthdateapprox")
	private Boolean birthdateapprox;

	@Column(name = "deathdateapprox")
	private Boolean deathdateapprox;

	@Column(name = "gender")
	private String gender;

	@Column(name = "entityid")
	private String entityid;

	@Column(name = "datecreated")
	private Date datecreated;

	@Column(name = "dateedited")
	private Date dateedited;

	@Column(name = "voided")
	private Boolean voided;

	@Column(name = "voidreason")
	private String voidreason;

	@Column(name = "void")
	private Integer _void;

	@Column(name = "serverversion")
	private Long serverversion;

	@OneToMany(fetch = FetchType.LAZY,mappedBy = "client")
	private List<Attribute> attributes;

	@OneToMany(fetch = FetchType.LAZY,mappedBy = "client")
	private List<Identifier> identifiers;

	@OneToMany(fetch = FetchType.LAZY,mappedBy = "client")
	private List<Address> addresses;

	public List<Address> getAddresses() {
		return addresses;
	}

	public void setAddresses(List<Address> addresses) {
		this.addresses = addresses;
	}

	public List<Identifier> getIdentifiers() {
		return identifiers;
	}

	public void setIdentifiers(List<Identifier> identifiers) {
		this.identifiers = identifiers;
	}

	public int getClientid() {
		return clientid;
	}

	public void setClientid(int clientid) {
		this.clientid = clientid;
	}

	public String getFirstname() {
		return firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public String getMiddlename() {
		return middlename;
	}

	public void setMiddlename(String middlename) {
		this.middlename = middlename;
	}

	public String getLastname() {
		return lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	public Date getBirthdate() {
		return birthdate;
	}

	public void setBirthdate(Date birthdate) {
		this.birthdate = birthdate;
	}

	public Date getDeathdate() {
		return deathdate;
	}

	public void setDeathdate(Date deathdate) {
		this.deathdate = deathdate;
	}

	public Boolean getBirthdateapprox() {
		return birthdateapprox;
	}

	public void setBirthdateapprox(Boolean birthdateapprox) {
		this.birthdateapprox = birthdateapprox;
	}

	public Boolean getDeathdateapprox() {
		return deathdateapprox;
	}

	public void setDeathdateapprox(Boolean deathdateapprox) {
		this.deathdateapprox = deathdateapprox;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getEntityid() {
		return entityid;
	}

	public void setEntityid(String entityid) {
		this.entityid = entityid;
	}

	public Date getDatecreated() {
		return datecreated;
	}

	public void setDatecreated(Date datecreated) {
		this.datecreated = datecreated;
	}

	public Date getDateedited() {
		return dateedited;
	}

	public void setDateedited(Date dateedited) {
		this.dateedited = dateedited;
	}

	public Boolean getVoided() {
		return voided;
	}

	public void setVoided(Boolean voided) {
		this.voided = voided;
	}

	public String getVoidreason() {
		return voidreason;
	}

	public void setVoidreason(String voidreason) {
		this.voidreason = voidreason;
	}

	public Integer get_void() {
		return _void;
	}

	public void set_void(Integer _void) {
		this._void = _void;
	}

	public Long getServerversion() {
		return serverversion;
	}

	public void setServerversion(Long serverversion) {
		this.serverversion = serverversion;
	}

	public List<Attribute> getAttributes() {
		return attributes;
	}

	public void setAttributes(List<Attribute> attributes) {
		this.attributes = attributes;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((_void == null) ? 0 : _void.hashCode());
		result = prime * result + ((addresses == null) ? 0 : addresses.hashCode());
		result = prime * result + ((attributes == null) ? 0 : attributes.hashCode());
		result = prime * result + ((birthdate == null) ? 0 : birthdate.hashCode());
		result = prime * result + ((birthdateapprox == null) ? 0 : birthdateapprox.hashCode());
		result = prime * result + clientid;
		result = prime * result + ((datecreated == null) ? 0 : datecreated.hashCode());
		result = prime * result + ((dateedited == null) ? 0 : dateedited.hashCode());
		result = prime * result + ((deathdate == null) ? 0 : deathdate.hashCode());
		result = prime * result + ((deathdateapprox == null) ? 0 : deathdateapprox.hashCode());
		result = prime * result + ((entityid == null) ? 0 : entityid.hashCode());
		result = prime * result + ((firstname == null) ? 0 : firstname.hashCode());
		result = prime * result + ((gender == null) ? 0 : gender.hashCode());
		result = prime * result + ((identifiers == null) ? 0 : identifiers.hashCode());
		result = prime * result + ((lastname == null) ? 0 : lastname.hashCode());
		result = prime * result + ((middlename == null) ? 0 : middlename.hashCode());
		result = prime * result + ((serverversion == null) ? 0 : serverversion.hashCode());
		result = prime * result + ((voided == null) ? 0 : voided.hashCode());
		result = prime * result + ((voidreason == null) ? 0 : voidreason.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Client other = (Client) obj;
		if (_void == null) {
			if (other._void != null)
				return false;
		} else if (!_void.equals(other._void))
			return false;
		if (addresses == null) {
			if (other.addresses != null)
				return false;
		} else if (!addresses.equals(other.addresses))
			return false;
		if (attributes == null) {
			if (other.attributes != null)
				return false;
		} else if (!attributes.equals(other.attributes))
			return false;
		if (birthdate == null) {
			if (other.birthdate != null)
				return false;
		} else if (!birthdate.equals(other.birthdate))
			return false;
		if (birthdateapprox == null) {
			if (other.birthdateapprox != null)
				return false;
		} else if (!birthdateapprox.equals(other.birthdateapprox))
			return false;
		if (clientid != other.clientid)
			return false;
		if (datecreated == null) {
			if (other.datecreated != null)
				return false;
		} else if (!datecreated.equals(other.datecreated))
			return false;
		if (dateedited == null) {
			if (other.dateedited != null)
				return false;
		} else if (!dateedited.equals(other.dateedited))
			return false;
		if (deathdate == null) {
			if (other.deathdate != null)
				return false;
		} else if (!deathdate.equals(other.deathdate))
			return false;
		if (deathdateapprox == null) {
			if (other.deathdateapprox != null)
				return false;
		} else if (!deathdateapprox.equals(other.deathdateapprox))
			return false;
		if (entityid == null) {
			if (other.entityid != null)
				return false;
		} else if (!entityid.equals(other.entityid))
			return false;
		if (firstname == null) {
			if (other.firstname != null)
				return false;
		} else if (!firstname.equals(other.firstname))
			return false;
		if (gender == null) {
			if (other.gender != null)
				return false;
		} else if (!gender.equals(other.gender))
			return false;
		if (identifiers == null) {
			if (other.identifiers != null)
				return false;
		} else if (!identifiers.equals(other.identifiers))
			return false;
		if (lastname == null) {
			if (other.lastname != null)
				return false;
		} else if (!lastname.equals(other.lastname))
			return false;
		if (middlename == null) {
			if (other.middlename != null)
				return false;
		} else if (!middlename.equals(other.middlename))
			return false;
		if (serverversion == null) {
			if (other.serverversion != null)
				return false;
		} else if (!serverversion.equals(other.serverversion))
			return false;
		if (voided == null) {
			if (other.voided != null)
				return false;
		} else if (!voided.equals(other.voided))
			return false;
		if (voidreason == null) {
			if (other.voidreason != null)
				return false;
		} else if (!voidreason.equals(other.voidreason))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Client [clientid=" + clientid + ", firstname=" + firstname + ", middlename=" + middlename
				+ ", lastname=" + lastname + ", birthdate=" + birthdate + ", deathdate=" + deathdate
				+ ", birthdateapprox=" + birthdateapprox + ", deathdateapprox=" + deathdateapprox + ", gender=" + gender
				+ ", entityid=" + entityid + ", datecreated=" + datecreated + ", dateedited=" + dateedited + ", voided="
				+ voided + ", voidreason=" + voidreason + ", _void=" + _void + ", serverversion=" + serverversion
				+ ", attributes=" + attributes + ", identifiers=" + identifiers + ", addresses=" + addresses + "]";
	} 
	
	
	



}
