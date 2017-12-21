package com.ihsinformatics.tbreach5.dwh.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="attribute")
public class Attribute implements Serializable  {
	
	@Id
	@GeneratedValue
	@Column(name="id")
	private Integer id;
	
	
	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "clientId")
	private Client client;
	
	@Column(name="attribute")
	private String attribute;
	
	@Column(name="value")
	private String value;
	

}
