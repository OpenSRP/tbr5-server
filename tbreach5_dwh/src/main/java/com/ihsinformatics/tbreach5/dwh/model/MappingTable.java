
package com.ihsinformatics.tbreach5.dwh.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="mappingtable")
public class MappingTable {

	@Id
	@GeneratedValue
	@Column(name = "id")
	private int id;
	
	@Column(name = "db1table")
	private String db1table;
	
	@Column(name = "db1tablecolumn")
	private String db1tablecolumn;
	
	
	@Column(name = "db2table")
	private String db2table;
	
	@Column(name = "db2tablecolumn")
	private String db2tablecolumn;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDb1table() {
		return db1table;
	}

	public void setDb1table(String db1table) {
		this.db1table = db1table;
	}

	public String getDb1tablecolumn() {
		return db1tablecolumn;
	}

	public void setDb1tablecolumn(String db1tablecolumn) {
		this.db1tablecolumn = db1tablecolumn;
	}

	public String getDb2table() {
		return db2table;
	}

	public void setDb2table(String db2table) {
		this.db2table = db2table;
	}

	public String getDb2tablecolumn() {
		return db2tablecolumn;
	}

	public void setDb2tablecolumn(String db2tablecolumn) {
		this.db2tablecolumn = db2tablecolumn;
	}
	
	
	
}
