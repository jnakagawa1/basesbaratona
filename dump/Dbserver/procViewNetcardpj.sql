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
/****** Object:  View [dbo].[v_compras]    Script Date: 27/06/2019 15:26:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[v_compras]
AS
SELECT     u.CODCLI, u.CODFIL, u.MAT, u.CODSET, t.CODCRT, u.NOMUSU, u.STA, u.DATSTA, u.CPF, u.NUMDEP, u.GENERICO, t.DATTRA, t.NSUHOS, t.NSUAUT, t.CODCRE, 
                      t.TIPTRA, t.CODRTA, t.VALTRA, t.REC, t.DATFECCLI, t.NUMFECCLI, t.DATFECCRE, t.NUMFECCRE, t.DAD, t.TIPDEB, t.ATV, t.CODOPE, t.CONFERIDA
FROM         dbo.USUARIO AS u WITH (NOLOCK)INNER JOIN
                      dbo.TRANSACAO AS t WITH (NOLOCK) ON u.CPF = t.CPF AND u.NUMDEP = t.NUMDEP AND u.CODCLI = t.CODCLI
WHERE     (t.TIPTRA IN (51000, 51001, 51100, 51101, 51010, 51110, 11001, 11002, 51014, 51114, 800000, 11005, 11010, 11007, 11011, 11012, 11013, 11022, 11021, 11024, 11026, 11028, 11031, 800004)) 
                      AND (t.CODRTA IN ('V', 'A'))
GO
/****** Object:  View [dbo].[v_cronicos]    Script Date: 27/06/2019 15:26:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



--exec sp_transfere_usuarios '28413810809' , '00678', '00697', '0000000003',88
/**************************************************************************************
       Data de criação :??
       Autor Criação  : ??
       Objetivo da criação: Transferencia de Usuários
       Sistemas que utilizam : Todos habilitados a fazer transferencia(Site, FUNCIONAL MANAGEMENT)
       Histórico:  
       Data de alteração   Autor                      Linhas Alteradas           Objetivo  
       21/08/2015          Matheus Borte de Araujo    [28-31]                    Adicionado o Log para todos os procedimentos.
       21/09/2015		   Tarcísio					  [454-457]					 Adicionei os clientes 154,158,160,161 na transferência sem trocar nada, Também adicionei o try catch
       18/02/2016          JohnSantos                 [jsantos18022016]          Foi adicionado o clientes 164 na transferencia sem trocar nada.
	   15/04/2016		   Matheus Borte			  [maraujo15042016]			 Ajustado subquery apenas para olhar o limite folha de do titular[MSD]
	   07/05/2016			Rodolfo teles			RTeles_20160507				Retirei a chamada da procedure de inclusão de Coparticipação da TELEMAR
	   18/05/2016			Rodolfo Teles			RTeles_20160518				Reativei a chamada da procedure de inclusão de Coparticipação, devido a desativação da Trigger da OI
	   17/10/2016		  Matheus Oliveira			MOliveira20161017			Adicionei o código do grupo 1645 (WESTROCK) na transferência sem trocar nada
	   **************************************************************************************/
CREATE PROCEDURE [dbo].[sp_transfere_usuarios] @cpf_usu VARCHAR(11)
	,@codcli_origem VARCHAR(5)
	,@codcli_destino VARCHAR(5)
	,@matricula_destino VARCHAR(10)
	,@grc_codigo INT
AS
BEGIN TRY

--Colocado o LOG para todas as Transferencias Realizadas
INSERT INTO netcardpj.dbo.USUARIO_LOG_TRANSFERENCIAS (
	[DATA_TRANSFERENCIA]
	,[CODCLI_ORIGEM_TRANSFERENCIA]
	,[CODCLI_DESTINO_TRANSFERENCIA]
	,[MAT_NOVA_TRANSFERENCIA]
	,codcli
	,CPF
	,NUMDEP
	,CODFIL
	,CODPAR
	,NOMUSU
	,NUMPAC
	,NUMULTPAC
	,DATRENANU
	,DATATV
	,PMO
	,LIMPAD
	,DATINC
	,CODSET
	,MAT
	,DATANU
	,DATGERCRT
	,GERCRT
	,VALANU
	,CODCRT
	,STA
	,DATSTA
	,CTRATV
	,GENERICO
	,ACRESPAD
	,BANCO
	,AGENCIA
	,CONTA
	)
SELECT GETDATE()
	,@codcli_origem
	,@codcli_destino
	,@matricula_destino
	,CODCLI
	,CPF
	,NUMDEP
	,CODFIL
	,CODPAR
	,NOMUSU
	,NUMPAC
	,NUMULTPAC
	,DATRENANU
	,DATATV
	,PMO
	,LIMPAD
	,DATINC
	,codset
	,MAT
	,DATANU
	,DATGERCRT
	,GERCRT
	,VALANU
	,CODCRT
	,STA
	,DATSTA
	,CTRATV
	,GENERICO
	,ACRESPAD
	,BANCO
	,AGENCIA
	,CONTA
FROM usuario WITH(NOLOCK)
WHERE cpf = @cpf_usu
	AND codcli = convert(INT, @codcli_origem)

DECLARE @GERCRT CHAR(1)

SET @GERCRT = NULL

IF @matricula_destino = ''
BEGIN
	SET @matricula_destino = (
			SELECT mat
			FROM netcardpj.DBO.usuario WITH(NOLOCK)
			WHERE codcli = convert(INT, @codcli_origem)
				AND cpf = @cpf_usu
				AND numdep = '00'
			)
END

IF LEN(@matricula_destino) < 10
BEGIN
	SET @matricula_destino = REPLICATE('0', 10 - LEN(@matricula_destino)) + @matricula_destino
END

IF (
		SELECT CODEMB
		FROM netcardpj.DBO.CLIENTE WITH(NOLOCK)
		WHERE CODCLI = @codcli_origem
		) <> (
		SELECT CODEMB
		FROM netcardpj.DBO.CLIENTE WITH(NOLOCK)
		WHERE CODCLI = @codcli_DESTINO
		)
BEGIN
	SET @GERCRT = 'X'
END

--THIAGO 21/08/2013 - SE EXISTIR UM REGISTRO NA EMPRESA DE DESTINO A PROCEDURE GRAVA ESTE REGISTRO NA TABELA "USUARIO_LOG_TRANSFERENCIAS" E EM SEGUIDA APAGA O REGISTRO DA TABELA "USUARIO"
IF (
		SELECT COUNT(*)
		FROM netcardpj.DBO.usuario WITH(NOLOCK)
		WHERE CPF = @cpf_usu
			AND CODCLI = @codcli_destino
		) > 0
BEGIN
	INSERT INTO netcardpj.DBO.USUARIO_LOG_TRANSFERENCIAS (
		[DATA_TRANSFERENCIA]
		,[CODCLI_ORIGEM_TRANSFERENCIA]
		,[CODCLI_DESTINO_TRANSFERENCIA]
		,[MAT_NOVA_TRANSFERENCIA]
		,codcli
		,CPF
		,NUMDEP
		,CODFIL
		,CODPAR
		,NOMUSU
		,NUMPAC
		,NUMULTPAC
		,DATRENANU
		,DATATV
		,PMO
		,LIMPAD
		,DATINC
		,CODSET
		,MAT
		,DATANU
		,DATGERCRT
		,GERCRT
		,VALANU
		,CODCRT
		,STA
		,DATSTA
		,CTRATV
		,GENERICO
		,ACRESPAD
		,BANCO
		,AGENCIA
		,CONTA
		)
	SELECT GETDATE()
		,@codcli_origem
		,@codcli_destino
		,@matricula_destino
		,CODCLI
		,CPF
		,NUMDEP
		,CODFIL
		,CODPAR
		,NOMUSU
		,NUMPAC
		,NUMULTPAC
		,DATRENANU
		,DATATV
		,PMO
		,LIMPAD
		,DATINC
		,codset
		,MAT
		,DATANU
		,DATGERCRT
		,GERCRT
		,VALANU
		,CODCRT
		,STA
		,DATSTA
		,CTRATV
		,GENERICO
		,ACRESPAD
		,BANCO
		,AGENCIA
		,CONTA
	FROM usuario WITH(NOLOCK)
	WHERE cpf = @cpf_usu
		AND codcli = convert(INT, @codcli_DESTINO)

	DELETE netcardpj.DBO.USUARIO
	WHERE cpf = @cpf_usu
		AND codcli = convert(INT, @codcli_DESTINO)
END

IF @grc_codigo IN (1) -- TELEMAR --> TRANSFERE USANDO DADOS DA FILIAL DO BENEFIT
BEGIN
	DECLARE @plano VARCHAR(5)
	DECLARE @saldo NUMERIC(9, 2)
	DECLARE @TOT_CONS NUMERIC(9, 2)
	DECLARE @NUMFECCLI INT
	DECLARE @DATINC VARCHAR(20)
	DECLARE @SEQCPF INT
	DECLARE @codfil_oi INT

	SELECT @codfil_oi = codfil
	FROM benefit4.benefit.dbo.empresa
	WHERE codcli = convert(INT, @codcli_destino)

	INSERT INTO netcardpj.dbo.usuario (
		codcli
		,CPF
		,NUMDEP
		,CODFIL
		,CODPAR
		,NOMUSU
		,NUMPAC
		,NUMULTPAC
		,DATRENANU
		,DATATV
		,PMO
		,LIMPAD
		,DATINC
		,CODSET
		,MAT
		,DATANU
		,DATGERCRT
		,GERCRT
		,VALANU
		,CODCRT
		,STA
		,DATSTA
		,CTRATV
		,GENERICO
		,ACRESPAD
		,BANCO
		,AGENCIA
		,CONTA
		)
	SELECT @codcli_destino
		,CPF
		,NUMDEP
		,@codfil_oi
		,CODPAR
		,NOMUSU
		,NUMPAC
		,NUMULTPAC
		,DATRENANU
		,DATATV
		,PMO
		,LIMPAD
		,DATINC
		,codset
		,@matricula_destino
		,DATANU
		,DATGERCRT
		,ISNULL(@GERCRT, GERCRT)
		,VALANU
		,CODCRT
		,STA
		,getdate() DATSTA
		,CTRATV
		,GENERICO
		,ACRESPAD
		,BANCO
		,AGENCIA
		,CONTA
	FROM usuario WITH(NOLOCK)
	WHERE cpf = @cpf_usu
		AND codcli = convert(INT, @codcli_origem)

	SELECT TOP 1 @plano = plano
		,@saldo = saldo
		,@TOT_CONS = total_consumido
		,@DATINC = convert(VARCHAR, datinc, 103)
		,@SEQCPF = sequencia + 1
		,@numfeccli = (
			SELECT numfec
			FROM netcardpj.dbo.cliente  WITH(NOLOCK)
			WHERE codcli = @codcli_destino
			)
	FROM telemar.dbo.coparticipacao t WITH(NOLOCK)
	WHERE cpf = @cpf_usu
		AND sequencia = (
			SELECT max(sequencia)
			FROM telemar.dbo.coparticipacao WITH(NOLOCK)
			WHERE cpf = t.cpf
			)

--RTeles_20160518
	EXEC telemar.dbo.SP_INSERE_COPARTICIPACAO_TELEMAR @cpf_usu
		,@plano
		,@saldo
		,@TOT_CONS
		,@NUMFECCLI
		,@CODCLI_destino
		,@DATINC
		,@SEQCPF
		select * from usuario where cpf = '10193612712'
END

IF @grc_codigo IN (
		2
		,28
		,21
		,5
		,46
		,44
		,32
		,46
		,62
		,70
		,77
		,33
		,51
		,82
		,133
		,118
		,120
		) --  FRB, KLABIN, VILLARES METALS, TELEMIG, FABER CASTELL,PHILIP MORRIS,VITOPEL,FABER CASTEL,VOTORANTIM,WHEATON,LWART,USJ,DM,CCR,NARDINI, AKZO E COPERSUCAR --> TRANSFERE USANDO DADOS DA FILIAL DO BENEFIT
BEGIN
	INSERT INTO usuario (
		codcli
		,CPF
		,NUMDEP
		,CODFIL
		,CODPAR
		,NOMUSU
		,NUMPAC
		,NUMULTPAC
		,DATRENANU
		,DATATV
		,PMO
		,LIMPAD
		,DATINC
		,CODSET
		,MAT
		,DATANU
		,DATGERCRT
		,GERCRT
		,VALANU
		,CODCRT
		,STA
		,DATSTA
		,CTRATV
		,GENERICO
		,ACRESPAD
		,BANCO
		,AGENCIA
		,CONTA
		)
	SELECT @codcli_destino
		,CPF
		,NUMDEP
		,(
			SELECT codfil
			FROM benefit.dbo.empresa WITH(NOLOCK)
			WHERE codcli = @codcli_destino
			)
		,CODPAR
		,NOMUSU
		,NUMPAC
		,NUMULTPAC
		,DATRENANU
		,DATATV
		,PMO
		,LIMPAD
		,DATINC
		,codset
		,@matricula_destino
		,DATANU
		,DATGERCRT
		,ISNULL(@GERCRT, GERCRT)
		,VALANU
		,CODCRT
		,STA
		,getdate() DATSTA
		,CTRATV
		,GENERICO
		,ACRESPAD
		,BANCO
		,AGENCIA
		,CONTA
	FROM usuario WITH(NOLOCK)
	WHERE cpf = @cpf_usu
		AND codcli = convert(INT, @codcli_origem)
END

IF @grc_codigo IN (
		 20
		,34
		,10
		,16
		,43
		,45
		,35
		,24
		,60
		,38
		,36
		,37
		,58
		,38
		,53
		,67
		,80
		,69
		,64
		,49
		,86
		,89
		,85
		,47
		,88
		,95
		,97
		,102
		,105
		,106
		,107
		,121
		,122
		,123
		,124
		,129
		,131
		,136
		,139
		,140
		,125
		,141
		,154
		,158
		,160
		,161
		,164
		/*jsantos18022016Inicio*/
		,165
		/*jsantos18022016Fim*/
		,1645 --MOliveira20161017
		) -- BRASKEM, POLITENO ,SALTENO , COCA-COLA ,EUROFARMA , DELFI CACAU , CARGILL , SEARA ,FARMACARD , QUALYTAS, CIA MULLER, TORCOMP, GERDAU, TREELOG,Marabraz , Zilor,COSAN, ABRIL-MEDISERVICE, FARMACARD ARMCO, ABBOTT, TECPAR, MOSAIC, TIGRE, LUBRIZOL, BRASIF , PIRELLI, RAIZEN, CAMIL , BARRACRED,  SANOFI , MSD, USJ, THOMSON, DOW, GSK, GSK LOJA, COMGÁS --> TRANSFERE SEM TROCAR NADA NOS DADOS - 
BEGIN
	INSERT INTO usuario (
		codcli
		,CPF
		,NUMDEP
		,CODFIL
		,CODPAR
		,NOMUSU
		,NUMPAC
		,NUMULTPAC
		,DATRENANU
		,DATATV
		,PMO
		,LIMPAD
		,DATINC
		,CODSET
		,MAT
		,DATANU
		,DATGERCRT
		,GERCRT
		,VALANU
		,CODCRT
		,STA
		,DATSTA
		,CTRATV
		,GENERICO
		,ACRESPAD
		,BANCO
		,AGENCIA
		,CONTA
		)
	SELECT @codcli_destino
		,CPF
		,NUMDEP
		,codfil
		,CODPAR
		,NOMUSU
		,NUMPAC
		,NUMULTPAC
		,DATRENANU
		,DATATV
		,PMO
		,LIMPAD
		,DATINC
		,codset
		,@matricula_destino
		,DATANU
		,DATGERCRT
		,ISNULL(@GERCRT, GERCRT)
		,VALANU
		,CODCRT
		,STA
		,getdate() DATSTA
		,CTRATV
		,GENERICO
		,ACRESPAD
		,BANCO
		,AGENCIA
		,CONTA
	FROM usuario WITH(NOLOCK)
	WHERE cpf = @cpf_usu
		AND codcli = convert(INT, @codcli_origem)
END

IF @grc_codigo IN (
		27
		,4
		) -- BUNGE,FERTIMPORT /  TERMAG --> TRANSFERE SEM TROCAR NADA NOS DADOS , GERANDO 2ª VIA
BEGIN
	INSERT INTO bunge.dbo.coparticipacao (
		codcli
		,cpf
		,mat
		,limite
		,saldo
		,total_consumido
		,datinc
		,ultfeccli
		,sequencia
		)
	SELECT @codcli_destino
		,cpf
		,mat
		,limite
		,saldo
		,total_consumido
		,getdate()
		,(
			SELECT max(numfeccli)
			FROM fechcliente WITH(NOLOCK)
			WHERE codcli = @codcli_destino
			) AS ultfeccli
		,(
			SELECT max(sequencia) + 1
			FROM bunge.dbo.coparticipacao WITH(NOLOCK)
			WHERE cpf = @cpf_usu
			)
	FROM bunge.dbo.coparticipacao WITH(NOLOCK)
	WHERE codcli = @codcli_origem
		AND cpf = @cpf_usu
	GROUP BY codcli
		,cpf
		,mat
		,limite
		,saldo
		,total_consumido
		,datinc
		,ultfeccli
		,sequencia

	INSERT INTO usuario (
		codcli
		,CPF
		,NUMDEP
		,CODFIL
		,CODPAR
		,NOMUSU
		,NUMPAC
		,NUMULTPAC
		,DATRENANU
		,DATATV
		,PMO
		,LIMPAD
		,DATINC
		,CODSET
		,MAT
		,DATANU
		,DATGERCRT
		,GERCRT
		,VALANU
		,CODCRT
		,STA
		,DATSTA
		,CTRATV
		,GENERICO
		,ACRESPAD
		,BANCO
		,AGENCIA
		,CONTA
		)
	SELECT @codcli_destino
		,CPF
		,NUMDEP
		,codfil
		,CODPAR
		,NOMUSU
		,NUMPAC
		,NUMULTPAC
		,DATRENANU
		,DATATV
		,PMO
		,LIMPAD
		,DATINC
		,codset
		,@matricula_destino
		,DATANU
		,NULL
		,'X'
		,(
			SELECT valanutit
			FROM cliente WITH(NOLOCK)
			WHERE codcli = @codcli_destino
			) valanu
		,CODCRT
		,STA
		,getdate() DATSTA
		,CTRATV
		,GENERICO
		,ACRESPAD
		,BANCO
		,AGENCIA
		,CONTA
	FROM usuario WITH(NOLOCK)
	WHERE cpf = @cpf_usu
		AND codcli = convert(INT, @codcli_origem)
END

IF @grc_codigo IN (
		3
		,17
		) -- NESTLE, ORCALI --> TRANSFERE USANDO DADOS DE FILIAL E SETOR DO BENEFIT
BEGIN
	INSERT INTO usuario (
		codcli
		,CPF
		,NUMDEP
		,CODFIL
		,CODPAR
		,NOMUSU
		,NUMPAC
		,NUMULTPAC
		,DATRENANU
		,DATATV
		,PMO
		,LIMPAD
		,DATINC
		,CODSET
		,MAT
		,DATANU
		,DATGERCRT
		,GERCRT
		,VALANU
		,CODCRT
		,STA
		,DATSTA
		,CTRATV
		,GENERICO
		,ACRESPAD
		,BANCO
		,AGENCIA
		,CONTA
		)
	SELECT @codcli_destino
		,CPF
		,NUMDEP
		,(
			SELECT codfil
			FROM benefit.dbo.empresa WITH(NOLOCK)
			WHERE codcli = @codcli_destino
			)
		,CODPAR
		,NOMUSU
		,NUMPAC
		,NUMULTPAC
		,DATRENANU
		,DATATV
		,PMO
		,CASE 
			WHEN NUMDEP = '00'
				AND @codcli_destino IN (
					422
					,423
					,424
					,141
					,379
					,350
					)
				THEN 600
			WHEN NUMDEP = '00'
				AND @codcli_destino IN (
					277
					,364
					,278
					,390
					,369
					,249
					,248
					,250
					,194
					,210
					,211
					)
				THEN 1100
			ELSE LIMPAD
			END
		,DATINC
		,(
			SELECT codset
			FROM benefit.dbo.empresa WITH(NOLOCK)
			WHERE codcli = @codcli_destino
			)
		,@matricula_destino
		,DATANU
		,DATGERCRT
		,ISNULL(@GERCRT, GERCRT)
		,VALANU
		,CODCRT
		,STA
		,getdate() DATSTA
		,CTRATV
		,GENERICO
		,ACRESPAD
		,BANCO
		,AGENCIA
		,CONTA
	FROM usuario WITH(NOLOCK)
	WHERE cpf = @cpf_usu
		AND codcli = @Codcli_origem
END

IF @grc_codigo IN (26) -- GRUPO ABRIL --> TRANSFERE SÓ DANDO UPDATE NOS CAMPOS
BEGIN
	UPDATE netcardpj.dbo.usuario
	SET codcli = @codcli_destino
		,mat = @matricula_destino
	WHERE codcli = convert(INT, @codcli_origem)
		AND cpf = @cpf_usu
END

IF (@grc_codigo IN (129)) -- MSD -> transfere tambem o limite de folha do usuário, se houver algum limite já cadastrado
BEGIN
	DECLARE @numdep INT

	SET @numdep = (
			--maraujo15042016
			SELECT TOP 1 isnull(NUMDEP, - 1)
			FROM usuario WITH(NOLOCK)
			WHERE cpf = @cpf_usu
				AND codcli = @Codcli_origem
				AND NUMDEP = 0
			)

	IF (CAST(@numdep AS INT) = 0)
	BEGIN
		IF EXISTS (
				SELECT 1
				FROM funcionalcard.dbo.LimiteFolha WITH(NOLOCK)
				WHERE codcli = convert(INT, @codcli_origem)
					AND cpf = @cpf_usu
				)
		BEGIN --só migra o limite de folha para o novo codcli se já houver algum limite de folha cadastrado
			INSERT INTO funcionalcard.dbo.LimiteFolha (
				CodCli
				,CPF
				,Numdep
				,Limite
				,Sequencia
				,DataCadastro
				,DataUltimaSequencia
				,DataProcessamento
				)
			SELECT @codcli_destino
				,@cpf_usu
				,@numdep
				,(
					SELECT TOP 1 ISNULL(Limite, 0)
					FROM funcionalcard.dbo.LimiteFolha WITH(NOLOCK)
					WHERE codcli = convert(INT, @codcli_origem)
						AND cpf = @cpf_usu
					ORDER BY Sequencia DESC
					)
				,(
					SELECT ISNULL(MAX(ISNULL(sequencia, 0)), 0) + 1
					FROM funcionalcard.dbo.LimiteFolha WITH(NOLOCK)
					WHERE cpf = @cpf_usu
					)
				,GETDATE()
				,GETDATE()
				,NULL
		END
	END
END

--###################################################################################################
--Coloca T no cartao transferido da maneira antiga (T, TT, TTT, T1T, T2T)
--###################################################################################################
--if @grc_codigo not in (26) and (select count(*) from usuario where cpf = @cpf_usu and numdep = '00' and codcrt like '%t') >= 3 
--	begin 
--		update netcardpj.dbo.usuario
--		set sta = '01', codcrt = substring(codcrt,1,17) + 'T' + convert(varchar,(select count(*) from usuario where cpf = @cpf_usu and numdep = '00' and codcrt like '%t'))  + 'T'
--		where cpf = @cpf_usu
--		and codcli = @codcli_origem
--	end
--if @grc_codigo not in (26) and (select count(*) from usuario where cpf = @cpf_usu and numdep = '00' and codcrt like '%t') < 3 
--	begin
--		update netcardpj.dbo.usuario
--		set sta = '01', codcrt = codcrt + (select replicate('T', 1 + (select count(*) from usuario where cpf = @cpf_usu and numdep = '00' and codcrt like '%t')))
--		where cpf = @cpf_usu
--		and codcli = @codcli_origem
--	end
--###################################################################################################
--Coloca T no cartao transferido da maneira nova (T01, T02, T03, T99)
--###################################################################################################
IF @grc_codigo NOT IN (26)
BEGIN
	--Variaveis usadas no loop e alteracao do CODCRT
	DECLARE @ExitWhileT BIT

	SET @ExitWhileT = 0

	DECLARE @T INT

	SET @T = 1

	--Loop de T01 ate T99 para encontrar um CODCRT ainda nao usado para a transferencia
	WHILE @T <= 99
		AND @ExitWhileT = 0
	BEGIN
		--Se este cartão com T00 não existir, usa-o no update
		IF NOT EXISTS (
				SELECT *
				FROM netcardpj.dbo.USUARIO WITH(NOLOCK)
				WHERE CPF = @cpf_usu
					AND NUMDEP = '00'
					AND CODCRT = (SUBSTRING(REPLACE(CODCRT, 'T', ''), 1, 17) + 'T' + REPLICATE('0', 2 - LEN(CAST(@T AS VARCHAR(2)))) + CAST(@T AS VARCHAR(2)))
				)
		BEGIN
			--Aqui este cartão não existe, então pode dar o update
			--Select abaixo é de TESTE!
			--SELECT CODCLI, CPF, NUMDEP, SUBSTRING(REPLACE(CODCRT, 'T', ''),1,17) + 'T' + REPLICATE('0', 2 - LEN(CAST(@T AS VARCHAR(2)))) + CAST(@T AS VARCHAR(2)) AS [CODCRTNOVO] FROM netcardpj.dbo.USUARIO WHERE CPF = @cpf_usu AND CODCLI = @codcli_origem
			--Aqui executa o update do cartao para transferencia e marca sta=01
			UPDATE netcardpj.dbo.usuario
			SET sta = '01'
				,codcrt = (SUBSTRING(REPLACE(CODCRT, 'T', ''), 1, 17) + 'T' + REPLICATE('0', 2 - LEN(CAST(@T AS VARCHAR(2)))) + CAST(@T AS VARCHAR(2)))
			WHERE cpf = @cpf_usu
				AND codcli = @codcli_origem

			SET @ExitWhileT = 1 --Acaba com o Loop
		END

		--Avança para o proximo numero de T00
		SET @T = @T + 1
	END
			----Aqui o cartao nao foi alterado, o que fazer quando passar de T99?
			--IF @ExitWhileT = 0
			--	BEGIN
			--		PRINT('Não encontrou combinações de T01 até T99')
			--	END
END
END TRY
BEGIN CATCH
	DECLARE @ErrorMessage NVARCHAR(4000)
	DECLARE @ErrorSeverity VARCHAR(10)
	DECLARE @ErrorState VARCHAR(10)
	DECLARE @ErrorLine VARCHAR(10)
	DECLARE @DataLog DATETIME = GETDATE()
	DECLARE @Level VARCHAR(50) = 'ERROR'
	DECLARE @NomeProcedure VARCHAR(255)


	SELECT  @ErrorLine = ERROR_LINE()
		  , @ErrorSeverity = ERROR_SEVERITY()
		  , @ErrorState = ERROR_STATE()
		  , @NomeProcedure = OBJECT_NAME(@@PROCID)

	SELECT  @ErrorMessage = ERROR_MESSAGE() + ' - ErrorLine: ' + @ErrorLine + ' - ErrorSeverity: ' + @ErrorSeverity + ' - ErrorState: ' + @ErrorState

	INSERT INTO [log].[dbo].[t_LogGeral] (
		 [Date]
		,[Thread]
		,[Level]
		,[Logger]
		,[Message]
		)
	VALUES (
		 @DataLog
		,0
		,@Level
		,@NomeProcedure
		,@ErrorMessage
		)

	/* Utilizar quando o comportamento esperado é retornar erro(exception) a quem está chamando a procedure */
	RAISERROR (
			 @ErrorMessage
			,@ErrorSeverity
			,@ErrorState
			)
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[spEmbossing]    Script Date: 27/06/2019 15:26:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--SPEMBOSSING - UTILIZADA PRA TODOS COM EXCESSAO DE KLABIN

CREATE           PROCEDURE [dbo].[spEmbossing]
	@pArquivo nvarchar(255), @grc_codigo varchar(5), @pLinha nvarchar(500),
        @embossing_padrao varchar(1),  
	@entrega varchar(20)--1=empresa, 2=residencia, 3=sede
        --@embossing_padrao           	
	--S embossing padrao netcard (3linha)
        --N embossing filial, mat, numdep (3linha)
        --@etiqueta varchar(1)          
	--S Sabesprev no mesmo arquivo vamos ter na 
        --etiqueta enderecamento ou endereco
        --N Não entra no esquema da sabesprev
	--//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
	--
	--   insere um registro na tabela EMBOSSING, para que seja incluido a matricula e num. dependente
	--      STATUS: '0' - atualizar
	--              '1' - atualizado
	--      RETORNO: OK ou a mensagem de erro
	--
	--//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
as
   declare @data datetime,
           @return Varchar(2),
           @codcli varchar(6),
           @linha nvarchar(500),
           @codset varchar(10),
           @nomusu varchar(50),
           @mat varchar(10),
           @generico varchar(2),
           @nomcli   varchar(50),
           @linha2 varchar(500),
           @endereco varchar(40),
           @bairro varchar(30),
           @cidade varchar(30),
           @uf varchar(10),
           @uf_cliente varchar(10),
           @cep varchar (8),
           @cpf varchar(11),
           @enderecamento varchar(30),
           @equipe varchar(50),
           @nomusu_titular varchar(50),
           @codfil varchar(2),
	   @aux char(50),
	   @linha3 varchar(500),
	   @Guia varchar(4),
	   @codcliEmb int,
	   @numdep varchar(2),
	   @tipocli varchar(20)
	   --@entrega int --1=empresa, 2=residencia, 3=sede
    --por enquanto entrega só na empresa
    --set @entrega = 1
	   
    set @data = convert(datetime, SUBSTRING(CONVERT(VARCHAR, GETDATE()), 1, 11), 103)

    --buscando informações para incluir no embossing
    select @cpf = cpf, @codcli = u.codcli, 
	@codset = convert(varchar(10), convert(varchar(10), isnull(codset,'')) + replicate(' ', 10 - len(isnull(codset,'')))),
        @codfil = convert(varchar(2), replicate('0', 2-len(isnull(codfil,'0'))) + convert(varchar(2), isnull(codfil,'0'))),
        @nomcli = isnull(nomcli,' '),
        @nomusu = ltrim(rtrim(nomusu)), @mat = isnull(mat,' '), @generico = isnull(substring(generico,1,2),'00'),
        @nomusu_titular = (select nomusu from netcardpj..usuario where cpf = u.cpf and codcli = u.codcli and numdep = 0 ),
	@codcliEmb = c.codemb, @numdep = convert(varchar(2), numdep)
    from usuario u,
        cliente c
    where u.codcli = c.codcli
          and codcrt = substring(@plinha, 100, 17) 		
    --verifica se o cliente eh nestle, frb, telemar
    set @tipocli = 'fc'
    if @grc_codigo = 3 begin--@codcli in (select codcli from v_clientes_nestle) begin
	set @tipocli = 'nestle'
    end
    else 
    if @grc_codigo = 1 begin--@codcli in (select codcli from v_clientes_telemar) begin
       set @tipocli = 'telemar'
    end
    else 
    if @grc_codigo = 2 begin--@codcli in (select codcli from v_clientes_rubem_berta) begin
	set @tipocli = 'frb'	
    end

   -- se @embossing_padrao = S entao considerar a impressão da 3 linha do cartao como veio do netcard
    -- senao imprimir filial mat numdep
    if @generico = '' or @generico = ' ' or @generico is null begin
    	set @numdep = isnull(@numdep,'00')
    	if @generico = '' begin	
       	   set @generico = replicate('0',2-len(@numdep)) + @numdep  
    	end
    end
    if @embossing_padrao = '0' --padrao netcard
    begin
         --montando linha um
         set @linha  = substring(@plinha, 1, 150) 
    end
    else if @embossing_padrao = '1' --filial, mat, numdep
    begin
	print 'aa'
         --montando linha 1
	 if (@tipocli = 'telemar') or (@tipocli = 'frb')
	 --if @codcli in(select codcli from v_clientes_telemar union select codcli from v_clientes_rubem_berta)
         begin
		print 'aaa'
                --se for telemar, rubemberta, nao imprimir filial no cartao. somente mat, numdep.
	 	set @linha  = substring(@plinha, 1, 65) +  @mat + '-' + @generico				
	 end
	 else begin
		set @linha  = substring(@plinha, 1, 65) + isnull(@codfil,'00') + '-' + @mat + '-' + @generico
	 end
	 --set @linha  = substring(@plinha, 1, 65) + isnull(@codfil,'00') + '-' + @mat + '-' + @generico
         set @linha = @linha + replicate(' ', 92-len(@linha))
         set @linha = @linha + substring(@plinha, 93, 57)
         --fim da montagem da linha um
    end
    else if @embossing_padrao = '2' --setor, mat, numdep
    begin
	 if @tipocli = 'nestle'	
	 --if @codcli in(select codcli from v_clientes_nestle)
         begin
                --se for nestle nao imprimir pa no cartao. somente mat, numdep.
                -- NOVA SOLICITACAO: imprimir sem mat, numdep
	 	--set @linha  = substring(@plinha, 1, 65) +  @mat + '-' + @generico				
                          set @linha  = substring(@plinha, 1, 65) +  @mat + '-' + @generico
	 end
	 else begin
		set @linha  = substring(@plinha, 1, 65) + rtrim(ltrim(@codset)) + '-' + @mat + '-' + replicate('0',2-len(@generico )) + @generico
	 end
         --montando linha um
         --set @linha  = substring(@plinha, 1, 65) + rtrim(ltrim(@codset)) + '-' + @mat + '-' + replicate('0',2-len(@generico )) + @generico
         set @linha = @linha + replicate(' ', 92-len(@linha))
         set @linha = @linha + substring(@plinha, 93, 57)
         --fim da montagem da linha um
    end
	--print @codfil
	--print @codset
	--print @generico

    --pegando informações do endereco
	 --dados comp unificados
	 
    /*    --pegando informações do endereco
    if @codcli in(select codcli from v_clientes_nestle)begin
       select @endereco = rtrim(ltrim(endereco)) , @bairro = rtrim(ltrim(bairro)) , 
       @cidade = ltrim(rtrim(cidade)) , @uf = ltrim(rtrim(uf)), @cep = substring(ltrim(rtrim(cep)), 1, 5) + '-' + substring(rtrim(ltrim(cep)), 6, 3) ,
       @enderecamento = ltrim(rtrim(isnull(enderecamento,'')))
       from funcionalcard..dados_comp_clientes
       where cpf = @cpf and numdep = '00'          
    end
    else
    if @codcli in(select codcli from v_clientes_telemar)begin
       select @endereco = rtrim(ltrim(endereco)) , @bairro = rtrim(ltrim(bairro)) , 
       @cidade = ltrim(rtrim(cidade)) , @uf = ltrim(rtrim(uf)), @cep = substring(ltrim(rtrim(cep)), 1, 5) + '-' + substring(rtrim(ltrim(cep)), 6, 3) ,
       @enderecamento = ltrim(rtrim(isnull(enderecamento,'')))
       from telemar..dados_comp
       where cpf = @cpf and numdeptelemar = 0
    end 
    else*/
    if @tipocli = 'frb' begin
    --if @codcli in(select codcli from v_clientes_rubem_berta)begin
       select @endereco = ' ' , @bairro = ' ' , 
       @cidade = ' ' , @uf = ltrim(rtrim(uf)), @cep = ' ',
       @codset = setor 
       from funcionalcard..dados_comp_clientes
       where cpf = @cpf and cast(numdep as integer) = 0
	set @codset = isnull(@codset,'') + replicate(' ', 10 - len(isnull(@codset,'')))
	if substring(@codset,1,3) in('RIO','BHZ','VIX','JDF','UBA','MOC','FNO','BEL','SLZ','IMP','BSB','CGR','CGB','GYN','STM','MCP','AUX','GIG') begin
       		set @enderecamento = 'RIO'
	end 
	Else
	if substring(@codset,1,3) in('SAO','GRU','CWB','LDB','MGF','CPQ','BAU','QOC','RAO','SSZ','SJK','QSE','IGU','CGH') begin
       		set @enderecamento = 'SAO'
	end
	Else
	if substring(@codset,1,3) in('POA','CXJ','QHV','GEL','PFB','RIG','FLN','JOI','ITJ','LAJ','BNU','XAP') begin
       		set @enderecamento = 'POA'
	end
	Else
	if substring(@codset,1,3) in('IOS','BPS','REC','MAO','BVB','PVH','RBR','TBT','TFF','MCP','FOR','NAT','THE','JPA','AJU','MCZ') begin
       		set @enderecamento = 'SSA'
	end
	else
        if CONVERT(varchar, isnull(substring(@codset,1,3),'')) = '' begin
		if @codcli in (95,96) begin
       	        	set @enderecamento = 'APO'
       	      	end 
	      	else begin
	        	set @enderecamento = 'OUT'
	      	end
	end
	else set @enderecamento = 'OUT'
    end 
    
    else if @tipocli = 'telemar' begin
       select @endereco = rtrim(ltrim(endereco)) , @bairro = rtrim(ltrim(bairro)) , 
       @cidade = ltrim(rtrim(cidade)) , @uf = ltrim(rtrim(uf)), @cep = substring(ltrim(rtrim(cep)), 1, 8),
       @enderecamento = ltrim(rtrim(isnull(enderecamento,'')))
       from funcionalcard..dados_comp_clientes
       where cpf = @cpf and (numdep = '00' or numdep = '0')and grc_codigo = @grc_codigo  ----thiago     
       select @uf_cliente = ltrim(rtrim(siguf0)) from cliente where codcli = @codcli 
    end

    else begin
       select @endereco = rtrim(ltrim(endereco)) , @bairro = rtrim(ltrim(bairro)) , 
       @cidade = ltrim(rtrim(cidade)) , @uf = ltrim(rtrim(uf)), @cep = substring(ltrim(rtrim(cep)), 1, 8),
       @enderecamento = ltrim(rtrim(isnull(enderecamento,'')))
       from funcionalcard..dados_comp_clientes
       where cpf = @cpf and convert(int,numdep) = 0 and grc_codigo = @grc_codigo
    end 
    	set @enderecamento = isnull(@enderecamento,'')
	--se for atlas procurar pelo setor
    	if @grc_codigo ='14' begin
		set @guia = (select codigo from funcionalcard..emb_clienteGuia where codcliEmb = @codcliemb and uf = @codset)
    	end 
        else if @grc_codigo = '1' begin
        	set @guia = (select codigo from funcionalcard..emb_clienteGuia where codcliEmb = @codcliemb and uf = @uf_cliente)
        end
	else begin
		set @guia = (select codigo from funcionalcard..emb_clienteGuia where codcliEmb = @codcliemb and uf = @uf)
	end
   --Pegando informações da guia
   if @guia is null begin
   	set @guia = isnull((select codigo from funcionalcard..emb_clienteGuia where codcliEmb = @codcliemb and uf = 'XX'),'0000')
   end
   --montando a linha 2 de etiqueta de acordo com a regra
   --Se for etiqueta igual a S , vamos verificar se existir enderecamento colocaremos enderecamento senao o endereco normal 
   --if @etiqueta = 'S'
   --begin
       --montando linha 2	
   if @tipocli <> 'nestle' begin
print ','+@enderecamento+','
print ','+@tipocli+','
      --if (@enderecamento = '') and (@tipocli <> 'telemar')
      if ( @tipocli= 'telemar' OR (@enderecamento = '') and (@tipocli <> 'telemar'))
		begin
				print 'yukioz'
           		--enderecamento vazio utilizaremos os dados de endereco residencial
	           	set @linha2 = 'Titular:' + @nomusu_titular + replicate(' ', 50 - len(@nomusu_titular + 'Titular:'))
	           	set @linha2 = @linha2 + 'End:' + isnull(@endereco,'') + replicate(' ', 50 - len(isnull(@endereco,'')+'End:'))
		   	set @aux = 'Bairro:' + isnull(@bairro,'') +replicate(' ', 30-len(isnull(@bairro,''))) +  
				' Cep:' + isnull(@cep,'') + replicate(' ', 8- len(isnull(@cep,'')))
	           	set @linha2 = @linha2 + @aux
		   	set @aux = 'Cidade:' + isnull(@cidade,'') +replicate(' ', 30-len(isnull(@cidade,'')))+ ' UF:' + isnull(@uf,'')
	           	set @linha2 = @linha2 + @aux				
	 	end	
      if ((@enderecamento <> '') and (@tipocli <> 'telemar'))
		begin
		   	set @aux = +  'Cliente:' + @nomcli + replicate(' ', 50 - len(@nomcli))
           		set @linha2 = @aux 
		   	set @aux = 'Filial:' + replicate('0', 2 - len(@codfil)) + @codfil + ' Titular:' + convert(char(23),@nomusu_titular)
                        set @linha2 = @linha2 + @aux
		print @nomusu_titular
		        set @aux = 'Matrícula:' + @mat + replicate(' ', 10 - len(@mat)) + ' Setor:' +  @codset + replicate(' ', 10 - len(@codset))
		   	set @linha2 = @linha2 + @aux
			set @aux = 'Endereçamento:' + @enderecamento + replicate(' ', 50 - len(@enderecamento + 'Endereçamento:'))
		   	set @linha2 = @linha2 + @aux

                print 'entrou - ' 
		end
			
       end

	else begin
		--se a entrega é na empresa ou sede, imprime os dados da empresa
		if @entrega in('FABRICA','SEDE') begin
	   		set @aux = 'Cliente:' + @nomcli + replicate(' ', 50 - len(@nomcli))	    
           		set @linha2 = @aux 
	   		set @aux = 'Titular:' + convert(char(23),@nomusu_titular) + 'PA:' +  @codset + replicate(' ', 10 - len(@codset))
           		set @linha2 = @linha2 + @aux
	   		set @linha2 = @linha2 + 'SAP:' + @mat + replicate(' ', 50 - len('SAP:' + @mat))
	   		--set @linha2 = @linha2 + 'Endereçamento:' + @enderecamento + replicate(' ', 30 - len(@enderecamento+'Endereçamento:'))
			set @aux = 'Endereçamento:' + @enderecamento + replicate(' ', 50 - len(@enderecamento + 'Endereçamento:'))
	   		set @linha2 = @linha2 + @aux
		end 
		else
		if @entrega = 'RESIDENCIA' begin
			--se a entrega é na residencia, imprimir os dados da residencia
         --set @linha2 = 'Titular:' + @nomusu_titular + replicate(' ', 50 - len(@nomusu_titular + 'Titular:'))
         -- NOVA SOLICITACAO: imprimir numero SAP para facilitar localizacao de devolvidos pelo correio
         set @linha2 = 'Titular:' + @nomusu_titular +  replicate(' ', 31 - len(@nomusu_titular + 'Titular:')) + ' SAP:' +  @mat + replicate(' ', 19 - len(@mat + ' SAP:'))
         set @linha2 = @linha2 + 'End:' + isnull(ltrim(rtrim(@endereco)),'') + replicate(' ', 50 - len(substring(isnull(ltrim(rtrim(@endereco)),'')+'End:',1,50)))
	   	set @aux = 'Bairro:' + isnull(@bairro,'') +replicate(' ', 30-len(isnull(@bairro,''))) +  
			' Cep:' + isnull(@cep,'') + replicate(' ', 8- len(isnull(@cep,'')))
         set @linha2 = @linha2 + @aux
	   	set @aux = 'Cidade:' + isnull(@cidade,'') +replicate(' ', 30-len(isnull(@cidade,'')))+ ' UF:' + isnull(@uf,'')
         set @linha2 = @linha2 + @aux			
		end
	end
	
       /*if @enderecamento = ''
       begin
	   if @entrega in('FABRICA', 'SEDE') begin
	   		set @aux = 'Cliente:' + @nomcli + replicate(' ', 50 - len(@nomcli))	    
           		set @linha2 = @aux 
	   		set @aux = 'Titular:' + @nomusu_titular + replicate(' ', 23 - len(@nomusu_titular)) + 'PA:' +  @codset + replicate(' ', 10 - len(@codset))
           		set @linha2 = @linha2 + @aux
	   		set @linha2 = @linha2 + 'SAP:' + @mat + replicate(' ', 50 - len('SAP:' + @mat))
	   		--set @linha2 = @linha2 + 'Endereçamento:' + @enderecamento + replicate(' ', 30 - len(@enderecamento+'Endereçamento:'))
			set @aux = 'Endereçamento:' + @enderecamento + replicate(' ', 50 - len(@enderecamento + 'Endereçamento:'))
	   		set @linha2 = @linha2 + @aux
	   end
	   else 
	   if @entrega = 'RESIDENCIA' begin	
           	--enderecamento vazio utilizaremos os dados de endereco residencial
           	set @linha2 = 'Titular:' + @nomusu_titular + replicate(' ', 50 - len(@nomusu_titular + 'Titular:'))
           	set @linha2 = @linha2 + 'End:' + isnull(@endereco,'') + replicate(' ', 50 - len(isnull(@endereco,'')+'End:'))
	   	set @aux = 'Bairro:' + isnull(@bairro,'') +replicate(' ', 30-len(isnull(@bairro,''))) +  
		' Cep:' + isnull(@cep,'') + replicate(' ', 8- len(isnull(@cep,'')))
           	set @linha2 = @linha2 + @aux
	   	set @aux = 'Cidade:' + isnull(@cidade,'') +replicate(' ', 30-len(isnull(@cidade,'')))+ ' UF:' + isnull(@uf,'')
           	set @linha2 = @linha2 + @aux
	   end
       end
       else --usuario com enderecamento
       begin
           --montando linha2
	   --se nao for nestle...	
           if @tipocli <> 'nestle' begin
	   --if @codcli not in (select codcli from v_clientes_nestle) begin
	   	set @aux = +  'Cliente:' + @nomcli + replicate(' ', 50 - len(@nomcli))
           	set @linha2 = @aux 
	   	set @aux = 'Filial:' + replicate('0', 2 - len(@codfil)) + @codfil + ' Titular:' + @nomusu_titular + replicate(' ', 23 - len(@nomusu_titular))
           	set @linha2 = @linha2 + @aux
		set @aux = 'Matrícula:' + @mat + replicate(' ', 10 - len(@mat)) + ' Setor:' +  @codset + replicate(' ', 10 - len(@codset))
	   	set @linha2 = @linha2 + @aux
		set @aux = 'Endereçamento:' + @enderecamento + replicate(' ', 50 - len(@enderecamento + 'Endereçamento:'))
	   	set @linha2 = @linha2 + @aux
	   end	
           else begin
		--se a entrega é na empresa ou sede, imprime os dados da empresa
		if @entrega in('FABRICA','SEDE') begin
	   		set @aux = 'Cliente:' + @nomcli + replicate(' ', 50 - len(@nomcli))	    
           		set @linha2 = @aux 
	   		set @aux = 'Titular:' + @nomusu_titular + replicate(' ', 23 - len(@nomusu_titular)) + 'PA:' +  @codset + replicate(' ', 10 - len(@codset))
           		set @linha2 = @linha2 + @aux
	   		set @linha2 = @linha2 + 'SAP:' + @mat + replicate(' ', 50 - len('SAP:' + @mat))
	   		--set @linha2 = @linha2 + 'Endereçamento:' + @enderecamento + replicate(' ', 30 - len(@enderecamento+'Endereçamento:'))
			set @aux = 'Endereçamento:' + @enderecamento + replicate(' ', 50 - len(@enderecamento + 'Endereçamento:'))
	   		set @linha2 = @linha2 + @aux
		end 
		else
		if @entrega = 'RESIDENCIA' begin
			--se a entrega é na residencia, imprimir os dados da residencia
           		set @linha2 = 'Titular:' + @nomusu_titular + replicate(' ', 50 - len(@nomusu_titular + 'Titular:'))
           		set @linha2 = @linha2 + 'End:' + isnull(@endereco,'') + replicate(' ', 50 - len(isnull(@endereco,'')+'End:'))
	   		set @aux = 'Bairro:' + isnull(@bairro,'') +replicate(' ', 30-len(isnull(@bairro,''))) +  
			' Cep:' + isnull(@cep,'') + replicate(' ', 8- len(isnull(@cep,'')))
           		set @linha2 = @linha2 + @aux
	   		set @aux = 'Cidade:' + isnull(@cidade,'') +replicate(' ', 30-len(isnull(@cidade,'')))+ ' UF:' + isnull(@uf,'')
           		set @linha2 = @linha2 + @aux			
		end
           end
        end*/
   /*end --@etiqueta = N
   else
   begin
	   if @tipocli<>'nestle' begin	
	   --if @codcli not in (select codcli from v_clientes_nestle) begin
	   	set @aux = 'Cliente:' + @nomcli + replicate(' ', 50 - len(@nomcli))
           	set @linha2 = @aux 
	   	set @aux = 'Filial:' + replicate('0', 2 - len(@codfil)) + @codfil + ' Titular:' + @nomusu_titular + replicate(' ', 23 - len(@nomusu_titular))
           	set @linha2 = @linha2 + @aux
		set @aux = 'Matrícula:' + @mat + replicate(' ', 10 - len(@mat)) + ' Setor:' +  @codset + replicate(' ', 10 - len(@codset))
	   	set @linha2 = @linha2 + @aux
	   	--set @linha2 = @linha2 + 'Endereçamento:' + @enderecamento + replicate(' ', 30 - len('Endereçamento:' + @enderecamento))
		set @aux = 'Endereçamento:' + @enderecamento + replicate(' ', 50 - len(@enderecamento + 'Endereçamento:'))
	   	set @linha2 = @linha2 + @aux
	   end	
           else begin
           	set @linha2 = 'Cliente:' + @nomcli + replicate(' ', 50 - len('Cliente:' + @nomcli))
	   	set @aux = 'Titular:' + @nomusu_titular + replicate(' ', 23 - len(@nomusu_titular)) + 'PA:' +  @codset + replicate(' ', 10 - len(@codset))
           	set @linha2 = @linha2 + @aux
	   	set @linha2 = @linha2 + 'SAP:' + @mat + replicate(' ', 50 - len('SAP:' + @mat))
	   	--set @linha2 = @linha2 + 'Endereçamento:' + @enderecamento + replicate(' ', 30 - len(@enderecamento+'Endereçamento:'))
		set @aux = 'Endereçamento:' + @enderecamento + replicate(' ', 50 - len(@enderecamento + 'Endereçamento:'))
	   	set @linha2 = @linha2 + @aux
           end
    end*/
    --Completa a etiqueta com a 5a linha
    set @linha2 = @linha2 + replicate(' ', 50)		
print 'fim da linha 2' + @linha2
    	--Montando linha 3
		
	set @linha3 = replicate('0', 2 - len(@codfil)) + @codfil
	set @linha3 = @linha3 + @codset
	set @linha3 = @linha3 + @mat + replicate(' ', 10 - len(@mat))	
	set @linha3 = @linha3 + replicate('0', 2 - len(@generico)) + @generico
	set @linha3 = @linha3 + @enderecamento + replicate(' ', 30 - len(@enderecamento))
	set @linha3 = @linha3 + convert(char(23),@nomusu_titular)--///+ ltrim(rtrim(@nomusu_titular)) + replicate(' ', 23 - len(ltrim(rtrim(@nomusu_titular))))
	if @generico = '00' begin
		set @linha3 = @linha3 + replicate('0', 4 - len(@guia)) + @guia	
	end
	else begin
		--se for klabin, envia a guia tbm
		if @grc_codigo = 28 begin
			set @linha3 = @linha3 + replicate('0', 4 - len(@guia)) + @guia	
		end
		else begin
			set @linha3 = @linha3 + '0000'
		end
	end
        print '@linha  - '+ @linha 
	print '@linha2  - '+ @linha2
	print '@linha3  - '+ @linha3 

   begin transaction
    insert into funcionalcard..embossing_clientes
      (arquivo, grc_codigo, codcli, filial, setor, nome, nome_titular, matricula, numdep, dt_emissao, status, cpf, enderecamento, linha, linha2, linha3, codemb, entrega)
    values
      (@pArquivo, @grc_codigo, @codcli, @codfil, @codset, @nomusu, @nomusu_titular, @mat, @generico, getdate(), '0', @cpf, @enderecamento, @linha, @linha2, @linha3, @codcliemb, @entrega)
    if @@error <> 0 
    begin
        select description 
          from master..sysmessages
          where error = @@error
        rollback transaction
        return @@error
    end 
    else
    begin
      commit transaction
      select 'Ok'
    end

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "u"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 121
               Right = 213
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t"
            Begin Extent = 
               Top = 6
               Left = 251
               Bottom = 121
               Right = 426
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_compras'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_compras'
GO
