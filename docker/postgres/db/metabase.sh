#!/bin/bash   
export SQL_CMD="UPDATE metabase_database SET details='{\"host\":\"localhost\",\"port\":5432,\"dbname\":\"tbreach5\",\"user\":\"postgres\",\"password\":\"${POSTGRES_PASSWORD}\",\"ssl\":false,\"tunnel-port\":22}' WHERE name='TBREACH5'"
echo ${SQL_CMD}
psql -U postgres -d metabase -c "$SQL_CMD"
