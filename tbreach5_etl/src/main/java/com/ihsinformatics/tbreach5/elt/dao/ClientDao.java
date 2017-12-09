package com.ihsinformatics.tbreach5.elt.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;

import com.ihsinformatics.tbreach5.elt.model.Client;

@Repository
public class ClientDao extends BaseDao<Client> {
	
	 @PersistenceContext	
	 private EntityManager entityManager;	
	 
	 public ClientDao(){
	      setClazz(Client.class );
	 }

	@Override
	public List<Client> findAll() {
		 String hql = "FROM Client";
		return (List<Client>) entityManager.createQuery(hql).getResultList();
	}
	
	 
	
}
