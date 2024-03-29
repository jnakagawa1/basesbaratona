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

USE [benefit]
GO
/****** Object:  StoredProcedure [dbo].[tira_acento]    Script Date: 27/06/2019 15:47:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--proceudure para tirar acentos e caracteres especiais do texto
/*exemplo

	begin
	declare 
		@texto_resp varchar(1000)
	exec tira_acento 'NÃO HÁ RESTRIÇÃO DE COMPRA. TODOS OS PRODUTOS SÃO LIBERADOS. NÃO É OBRIGATÓRIA APRESENTAÇÃO DE RECEITA.', @texto_resp output
		print 'texto final'
		print @texto_resp
	end
*/
CREATE procedure [dbo].[tira_acento] @texto varchar(1000), @texto_resp varchar(1000) output
as
begin
	
	--tirando Ç
	set @texto = replace(upper(@texto), 'Ç', 'C')
	--acento do A
	set @texto = replace(upper(@texto), 'á', 'A')
	set @texto = replace(upper(@texto), 'à', 'A')
	set @texto = replace(upper(@texto), 'â', 'A')
	set @texto = replace(upper(@texto), 'ã', 'A')
	set @texto = replace(upper(@texto), 'ä', 'A')	
	--acento do E
	set @texto = replace(upper(@texto), 'é', 'E')
	set @texto = replace(upper(@texto), 'è', 'E')
	set @texto = replace(upper(@texto), 'ê', 'E')
	set @texto = replace(upper(@texto), 'ë', 'E')	
	--acento do I
	set @texto = replace(upper(@texto), 'í', 'I')
	set @texto = replace(upper(@texto), 'ì', 'I')
	set @texto = replace(upper(@texto), 'î', 'I')
	set @texto = replace(upper(@texto), 'ï', 'I')	
	--acento do O
	set @texto = replace(upper(@texto), 'ó', 'O')
	set @texto = replace(upper(@texto), 'ò', 'O')
	set @texto = replace(upper(@texto), 'ô', 'O')
	set @texto = replace(upper(@texto), 'õ', 'O')	
	set @texto = replace(upper(@texto), 'ö', 'O')	
	--acento do U
	set @texto = replace(upper(@texto), 'ú', 'U')
	set @texto = replace(upper(@texto), 'ù', 'U')
	set @texto = replace(upper(@texto), 'û', 'U')
	set @texto = replace(upper(@texto), 'ü', 'U')
	

	print 'terminei'
	set @texto_resp = @texto
	
end

GO
