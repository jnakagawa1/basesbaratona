-- CREATE DATABASE $(MSSQL_DB);
-- GO
-- USE $(MSSQL_DB);
-- GO
-- CREATE LOGIN $(MSSQL_USER) WITH PASSWORD = '$(MSSQL_PASSWORD)';
-- GO
-- CREATE USER $(MSSQL_USER) FOR LOGIN $(MSSQL_USER);
-- GO
-- ALTER SERVER ROLE sysadmin ADD MEMBER [$(MSSQL_USER)];
-- GO

USE netcardpj
EXEC sp_addlinkedserver 'BENEFIT4', '', 'SQLNCLI', '10.1.4.217,1433'
EXEC sp_addlinkedsrvlogin 'BENEFIT4', 'FALSE', NULL, 'sa', '2astazeY'
