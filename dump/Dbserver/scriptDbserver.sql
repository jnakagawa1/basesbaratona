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


-- IF db_id('netcardpj') IS NOT NULL
-- 	BEGIN
-- 		DROP DATABASE netcardpj
-- 	END
-- GO
-- /* CRIA O BANCO DE LOG */
-- IF db_id('netcardpj') IS NULL
-- 	BEGIN
-- 		CREATE DATABASE netcardpj
-- 	END
-- GO
/* CRIA TABELA T_LOGGERAL */
USE netcardpj
GO
CREATE TABLE [dbo].[USUARIO](
	[CODCLI] [int] NOT NULL,
	[CPF] [varchar](11) NOT NULL,
	[NUMDEP] [smallint] NOT NULL,
	[CODFIL] [smallint] NULL,
	[CODPAR] [smallint] NULL,
	[NOMUSU] [varchar](50) NOT NULL,
	[NUMPAC] [smallint] NOT NULL,
	[NUMULTPAC] [smallint] NOT NULL,
	[DATRENANU] [datetime] NULL,
	[DATATV] [datetime] NULL,
	[PMO] [numeric](9, 2) NOT NULL,
	[LIMPAD] [numeric](9, 2) NOT NULL,
	[DATINC] [datetime] NOT NULL,
	[CODSET] [varchar](10) NULL,
	[MAT] [varchar](10) NOT NULL,
	[DATANU] [datetime] NULL,
	[DATGERCRT] [datetime] NULL,
	[GERCRT] [char](1) NULL,
	[VALANU] [numeric](9, 2) NOT NULL,
	[CODCRT] [varchar](20) NOT NULL,
	[STA] [char](2) NOT NULL,
	[DATSTA] [datetime] NULL,
	[CTRATV] [char](1) NULL,
	[GENERICO] [varchar](20) NULL,
	[ACRESPAD] [numeric](9, 2) NULL,
	[BANCO] [char](4) NULL,
	[AGENCIA] [varchar](6) NULL,
	[CONTA] [varchar](12) NULL,
	[rowversion] [timestamp] NOT NULL,
 CONSTRAINT [PK_USUARIO] PRIMARY KEY CLUSTERED 
(
	[CODCLI] ASC,
	[CPF] ASC,
	[NUMDEP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
