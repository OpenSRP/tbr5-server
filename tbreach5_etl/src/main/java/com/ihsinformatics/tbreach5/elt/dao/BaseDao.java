package com.ihsinformatics.tbreach5.elt.dao;

import java.io.Serializable;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.beans.factory.annotation.Autowired;

public abstract class  BaseDao< T extends Serializable > {

	 private Class< T > clazz;
	 
	   
	   
	   @PersistenceContext	
		private EntityManager entityManager;	
	 
	   public final void setClazz( Class< T > clazzToSet ){
	      this.clazz = clazzToSet;
	   }
	 
	   public T findOne( long id ){
		   
		   return entityManager.find(clazz, id);
	      //return (T) getCurrentSession().get( clazz, id );
	   }
	   public List< T > findAll(){
		   System.out.println("==========================================");
		   System.out.println(clazz.getSimpleName());
		   System.out.println("==========================================");
		   String hql = "FROM "+clazz.getSimpleName();
			return (List<T>) entityManager.createQuery(hql).getResultList();
	    //  return getCurrentSession().createQuery( "from " + clazz.getName() ).list();
	   }
	 
	   public void create( T entity ){
		   entityManager.persist( entity );
	   }
	 
	   public void update( T entity ){
		   entityManager.merge( entity );
	   }
	 
	   public void delete( T entity ){
		   entityManager.remove( entity );
	   }
	   public void deleteById( long entityId ) {
	      T entity = findOne( entityId );
	      delete( entity );
	   }
	 
	 
  
	
	
}
