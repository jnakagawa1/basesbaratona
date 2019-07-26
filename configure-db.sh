#!/bin/bash

# wait for MSSQL server to start
export STATUS=1
i=0

while [[ $STATUS -ne 0 ]] && [[ $i -lt 30 ]]; do
	i=$i+1
	/opt/mssql-tools/bin/sqlcmd -t 1 -U sa -P $SA_PASSWORD -Q "select 1" >> /dev/null
	STATUS=$?
done

if [ $STATUS -ne 0 ]; then 
	echo "Error: MSSQL SERVER took more than thirty seconds to start up."
	exit 1
fi


if [ $SQL_DB == "BENEFITDEV" ]; then
	
	echo "======= MSSQL SERVER BENEFITDEV STARTED ========" | tee -a ./config.log
	# Run the setup script to create the DB and the schema in the DB
	# /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -d master -i ./dump/Benefit/ressuprimento.sql 
	# /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -d master -i ./dump/Benefit/proc_benefit.sql
	/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -d master -i ./dump/Benefit/scriptBenefit.sql

	echo "======= MSSQL CONFIG COMPLETE =======" | tee -a ./config.log

fi

if [ $SQL_DB == "DBSERVERDEV" ]; then
	
	echo "======= MSSQL SERVER DBSERVERDEV STARTED ========" | tee -a ./config.log
	# Run the setup script to create the DB and the schema in the DB
	/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -d master -i ./dump/Dbserver/NetcardPJ.sql
	# /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -d master -i ./dump/Dbserver/procViewNetcardpj.sql
	/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -d master -i ./dump/linkedServer/linked.sql
	/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -d master -i ./dump/Dbserver/procNetcard.sql
	
	echo "======= MSSQL CONFIG COMPLETE =======" | tee -a ./config.log

fi





