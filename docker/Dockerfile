FROM tomcat:8.5-jre8

RUN cd /usr && ls

RUN mkdir /usr/local/downloads && \
	 wget -O /usr/local/downloads/openmrs.war https://sourceforge.net/projects/openmrs/files/releases/OpenMRS_Platform_2.1.2/openmrs.war && \
	 wget -O /usr/local/downloads/openmrsmodules.zip https://sourceforge.net/projects/openmrs/files/releases/OpenMRS_Reference_Application_2.7.0/referenceapplication-addons-2.7.0.zip && \
	 wget -O /usr/local/downloads/opensrp.war https://sourceforge.net/projects/tbreach5/files/tbreach5-1.0.0b/opensrp.war && \
	 wget -O /usr/local/downloads/tbreach5.war https://sourceforge.net/projects/tbreach5/files/tbreach5-1.0.0b/tbreach5.war 

COPY .env.production /usr/local/downloads/

RUN mv /usr/local/downloads/.env.production /usr/local/downloads/env.sh && \
	sed -i '/^$/d' /usr/local/downloads/env.sh
		 
RUN mkdir /usr/local/downloads/openmrsmodules/ && \ 
	unzip -j /usr/local/downloads/openmrsmodules.zip -d /usr/local/downloads/openmrsmodules/ && \
	mkdir /root/.OpenMRS && \
	mkdir /root/.OpenMRS/modules && \
	cp /usr/local/downloads/openmrsmodules/* /root/.OpenMRS/modules/

COPY tomcat/openmrs-runtime.properties /root/.OpenMRS
	
RUN	set -o allexport; . /usr/local/downloads/env.sh; set +o allexport && \
	echo $OPENMRS_DB_USER; echo $OPENMRS_DB_PASSWORD && \
	sed -i "s/openmrs_user/${OPENMRS_DB_USER}/g" /root/.OpenMRS/openmrs-runtime.properties && \
	sed -i "s/openmrs_password/${OPENMRS_DB_PASSWORD}/g" /root/.OpenMRS/openmrs-runtime.properties && \
	cp /usr/local/downloads/openmrs.war /usr/local/tomcat/webapps/openmrs.war
	
RUN unzip -qq /usr/local/downloads/opensrp.war -d /usr/local/tomcat/webapps/opensrp 

COPY tomcat/couchdb.properties /usr/local/tomcat/webapps/opensrp/WEB-INF/classes
COPY tomcat/opensrp.properties /usr/local/tomcat/webapps/opensrp/WEB-INF/classes
COPY tomcat/quartz.properties /usr/local/tomcat/webapps/opensrp/WEB-INF/classes

RUN	set -o allexport; . /usr/local/downloads/env.sh; set +o allexport && \
	sed -i "s/couchrootuser/${COUCHDB_USER}/g" /usr/local/tomcat/webapps/opensrp/WEB-INF/classes/couchdb.properties && \
	sed -i "s/couchrootpassword/${COUCHDB_PASSWORD}/g" /usr/local/tomcat/webapps/opensrp/WEB-INF/classes/couchdb.properties && \
	sed -i "s/rdbrootuser/${OPENSRP_DB_USER}/g" /usr/local/tomcat/webapps/opensrp/WEB-INF/classes/quartz.properties && \
	sed -i "s/rdbrootpassword/${OPENSRP_DB_PASSWORD}/g" /usr/local/tomcat/webapps/opensrp/WEB-INF/classes/quartz.properties && \
	sed -i "s/couchrootuser/${COUCHDB_USER}/g" /usr/local/tomcat/webapps/opensrp/WEB-INF/classes/opensrp.properties && \
	sed -i "s/couchrootpassword/${COUCHDB_PASSWORD}/g" /usr/local/tomcat/webapps/opensrp/WEB-INF/classes/opensrp.properties && \
	sed -i "s/rdbrootuser/${OPENSRP_DB_USER}/g" /usr/local/tomcat/webapps/opensrp/WEB-INF/classes/opensrp.properties && \
	sed -i "s/rdbrootpassword/${OPENSRP_DB_PASSWORD}/g" /usr/local/tomcat/webapps/opensrp/WEB-INF/classes/opensrp.properties
	

RUN unzip -qq /usr/local/downloads/tbreach5.war -d /usr/local/tomcat/webapps/tbreach5 

COPY tomcat/application.properties /usr/local/tomcat/webapps/tbreach5/WEB-INF/classes

RUN	set -o allexport; . /usr/local/downloads/env.sh; set +o allexport && \
	sed -i "s/couchrootuser/${COUCHDB_USER}/g" /usr/local/tomcat/webapps/tbreach5/WEB-INF/classes/application.properties && \
	sed -i "s/couchrootpassword/${COUCHDB_PASSWORD}/g" /usr/local/tomcat/webapps/tbreach5/WEB-INF/classes/application.properties && \
	sed -i "s/postgrespassword/${POSTGRES_PASSWORD}/g" /usr/local/tomcat/webapps/tbreach5/WEB-INF/classes/application.properties


	
VOLUME ["/root/.OpenMRS", "/usr/local/tomcat/"]

EXPOSE 8080
CMD ["catalina.sh", "run"]
