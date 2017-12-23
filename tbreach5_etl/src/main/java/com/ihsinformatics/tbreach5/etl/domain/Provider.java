package com.ihsinformatics.tbreach5.etl.domain;

public class Provider extends BaseEntity {

	private String fullName;

	protected Provider() {
		
	}
	
	public Provider(String baseEntityId) {
		super(baseEntityId);
	}

	public Provider(String baseEntityId, String fullName) {
		super(baseEntityId);
		this.setFullName(fullName);
	}

/*	@Override
	public boolean equals(Object o) {
		return EqualsBuilder.reflectionEquals(this, o, "id", "revision");
	}

	@Override
	public int hashCode() {
		return HashCodeBuilder.reflectionHashCode(this, "id", "revision");
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}*/

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

}
