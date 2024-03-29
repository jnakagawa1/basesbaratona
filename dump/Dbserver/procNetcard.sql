CREATE DATABASE $(MSSQL_DB);
GO
USE $(MSSQL_DB);
GO
CREATE LOGIN $(MSSQL_USER) WITH PASSWORD = '$(MSSQL_PASSWORD)';
GO
CREATE USER $(MSSQL_USER) FOR LOGIN $(MSSQL_USER);
GO
ALTER SERVER ROLE sysadmin ADD MEMBER [$(MSSQL_USER)];
GO

USE [netcardpj]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create procedure [dbo].[linkedServer_Baratona]
	@cpf as varchar(11),
	@generico as varchar(2),
	@limite as numeric(5,2),
	@codcli as int,
	@numdep as int

as
		Update netcardpj.dbo.usuario 
                	set acrespad = acrespad + @limite
	                where cpf = @cpf
        	          and generico = @generico
                	  and codcli = @codcli
	                  and sta = '00'

		Update benefit4.autorizador.dbo.ctcartao 
	        	set padacres = padacres + @limite
                        where cpftit = @cpf
                          and convert(int, numdepend) = @numdep
                          and convert(int, codempresa) = @codcli
                          and statusu in ('00' , '0') 

				
GO
