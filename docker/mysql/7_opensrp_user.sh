#!/bin/bash
mysql -u root -p${MYSQL_ROOT_PASSWORD} << EOF
GRANT ALL PRIVILEGES ON opensrp_tbreach.* TO '${OPENSRP_DB_USER}'@'localhost' IDENTIFIED BY '${OPENSRP_DB_PASSWORD}'; flush privileges;
GRANT ALL PRIVILEGES ON opensrp_tbreach.* TO '${OPENSRP_DB_USER}'@'%' IDENTIFIED BY '${OPENSRP_DB_PASSWORD}'; flush privileges;
GRANT ALL PRIVILEGES ON motechquartz_tbreach.* TO '${OPENSRP_DB_USER}'@'localhost' IDENTIFIED BY '${OPENSRP_DB_PASSWORD}'; flush privileges;
GRANT ALL PRIVILEGES ON motechquartz_tbreach.* TO '${OPENSRP_DB_USER}'@'%' IDENTIFIED BY '${OPENSRP_DB_PASSWORD}'; flush privileges;
EOF