package com.ihsinformatics.tbreach5.etl.converter;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.joda.time.DateTime;
import org.lightcouch.CouchDbClient;
import org.springframework.beans.factory.annotation.Autowired;

import com.ihsinformatics.tbreach5.dwh.model.Address;
import com.ihsinformatics.tbreach5.dwh.model.Attribute;
import com.ihsinformatics.tbreach5.dwh.model.Identifier;
import com.ihsinformatics.tbreach5.etl.domain.Client;

public class ClientETL {

	@Autowired
	private CouchDbClient dbClient;

	public List<com.ihsinformatics.tbreach5.dwh.model.Client> trasferFromCouchDBToPostgreSQL(Date StartTime,
			Date endTime) {

		List<Client> couchdbList = dbClient.view("Client/all").includeDocs(true).startKey(StartTime).endKey(endTime)
				.query(Client.class);

		return convertCouchDBToHibernatePOJO(couchdbList);

	}

	public List<com.ihsinformatics.tbreach5.dwh.model.Client> convertCouchDBToHibernatePOJO(
			List<com.ihsinformatics.tbreach5.etl.domain.Client> couchDBList) {
		List<com.ihsinformatics.tbreach5.dwh.model.Client> hibertanteList = new ArrayList<>();

		for (Client couchdbClient : couchDBList) {
			com.ihsinformatics.tbreach5.dwh.model.Client hibernateClient = new com.ihsinformatics.tbreach5.dwh.model.Client();
			hibernateClient.setBirthdateapprox(couchdbClient.getBirthdateApprox());
			hibernateClient.setDeathdateapprox(couchdbClient.getDeathdateApprox());
			hibernateClient.setEntityid(couchdbClient.getBaseEntityId());
			hibernateClient.setFirstname(couchdbClient.getFirstName());
			hibernateClient.setGender(couchdbClient.getGender());
			hibernateClient.setLastname(couchdbClient.getLastName());
			hibernateClient.setMiddlename(couchdbClient.getMiddleName());
			hibernateClient.setVoided(couchdbClient.getVoided());
			hibernateClient.setVoidreason(couchdbClient.getVoidReason());

			DateTime dateCreated = new DateTime(couchdbClient.getDateCreated());
			hibernateClient.setDatecreated(dateCreated.toDate());

			DateTime dateEdited = new DateTime(couchdbClient.getDateEdited());
			hibernateClient.setDateedited(dateEdited.toDate());
			DateTime deathDate = new DateTime(couchdbClient.getDeathdate());
			hibernateClient.setDeathdate(deathDate.toDate());
			DateTime birthDate = new DateTime(couchdbClient.getBirthdate());
			hibernateClient.setBirthdate(birthDate.toDate());

			List<com.ihsinformatics.tbreach5.dwh.model.Address> hibernateAddressList = new ArrayList<>();

			for (com.ihsinformatics.tbreach5.etl.domain.Address couchDBAddress : couchdbClient.getAddresses()) {
				com.ihsinformatics.tbreach5.dwh.model.Address hibernateAddress = new com.ihsinformatics.tbreach5.dwh.model.Address();
				if(couchDBAddress.getAddressFields()!=null) {
				hibernateAddress.setAddressfields(couchDBAddress.getAddressFields().toString());
				}
				hibernateAddress.setClient(hibernateClient);
				hibernateAddress.setAddressType(couchDBAddress.getAddressType());
				hibernateAddress.setCityvillage(couchDBAddress.getCityVillage());
				hibernateAddress.setCountry(couchDBAddress.getCountry());
				hibernateAddress.setCountrydistrict(couchDBAddress.getCountyDistrict());
				hibernateAddress.setLatitude(couchDBAddress.getLatitude());
				hibernateAddress.setLongitude(couchDBAddress.getLongitude());
				hibernateAddress.setPostalcode(couchDBAddress.getPostalCode());
				hibernateAddress.setSubdistrict(couchDBAddress.getSubDistrict());
				hibernateAddress.setTown(couchDBAddress.getTown());
				hibernateAddress.setSubtown(couchDBAddress.getSubTown());
				hibernateAddress.setStateprovince(couchDBAddress.getStateProvince());
				hibernateAddressList.add(hibernateAddress);

			}
			hibernateClient.setAddresses(hibernateAddressList);
			List<Identifier> identifiersList = new ArrayList<>();
			for (String key : couchdbClient.getIdentifiers().keySet()) {
				Identifier identifier = new Identifier();
				identifier.setIdentifier(couchdbClient.getIdentifiers().get(key));
				identifier.setKey(key);
				identifier.setClient(hibernateClient);
				identifiersList.add(identifier);
			}
			hibernateClient.setIdentifiers(identifiersList);

			List<Attribute> attributeList = new ArrayList<>();
			for (String key : couchdbClient.getAttributes().keySet()) {
				Attribute attribute = new Attribute();
				attribute.setAttribute(key);
				attribute.setValue(couchdbClient.getAttributes().get(key).toString());
				attribute.setClient(hibernateClient);
				attributeList.add(attribute);

			}

			hibernateClient.setAttributes(attributeList);
			
			
			
			
			hibertanteList.add(hibernateClient);

		}
		return hibertanteList;
	}

}
