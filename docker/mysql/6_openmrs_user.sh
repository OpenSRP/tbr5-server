#!/bin/bash   
mysql -u root -p${MYSQL_ROOT_PASSWORD} << EOF
GRANT ALL PRIVILEGES ON openmrs.* TO 'ou'@'localhost' IDENTIFIED BY 'ttt'; flush privileges;
GRANT ALL PRIVILEGES ON openmrs.* TO '${OPENMRS_DB_USER}'@'%' IDENTIFIED BY '${OPENMRS_DB_PASSWORD}'; flush privileges;
EOF