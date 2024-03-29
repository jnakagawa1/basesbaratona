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
/****** Object:  Table [dbo].[BAIRRO]    Script Date: 27/06/2019 14:27:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAIRRO](
	[CODBAI] [int] NOT NULL,
	[NOMBAI] [varchar](35) NOT NULL,
	[msrepl_synctran_ts] [timestamp] NOT NULL,
 CONSTRAINT [PK_BAIRRO] PRIMARY KEY CLUSTERED 
(
	[CODBAI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CLIENTE]    Script Date: 27/06/2019 14:27:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLIENTE](
	[CODCLI] [int] NOT NULL,
	[CODBAI] [int] NOT NULL,
	[STA] [char](2) NOT NULL,
	[DATINC] [datetime] NOT NULL,
	[DATCTT] [datetime] NOT NULL,
	[DATSTA] [datetime] NOT NULL,
	[CTRATV] [char](1) NOT NULL,
	[VALANUTIT] [numeric](9, 2) NOT NULL,
	[DATANU] [datetime] NOT NULL,
	[NUMPAC] [smallint] NOT NULL,
	[NOMCLI] [varchar](50) NOT NULL,
	[CGC] [char](14) NOT NULL,
	[INSEST] [char](15) NOT NULL,
	[ENDCLI] [varchar](50) NOT NULL,
	[CEP] [char](8) NOT NULL,
	[PRAPAG] [smallint] NOT NULL,
	[NUMCRT] [int] NOT NULL,
	[OBS] [text] NULL,
	[TEL] [varchar](20) NULL,
	[FAX] [varchar](20) NULL,
	[DATFEC] [smallint] NOT NULL,
	[NUMFEC] [smallint] NOT NULL,
	[DATULTFEC] [datetime] NULL,
	[DATPRCULTFEC] [datetime] NULL,
	[EMA] [varchar](45) NULL,
	[CODLOC] [int] NOT NULL,
	[SIGUF0] [char](2) NOT NULL,
	[EXIREC] [char](1) NULL,
	[CODFILNUT] [int] NULL,
	[CON] [varchar](30) NOT NULL,
	[VALANUDEP] [numeric](9, 2) NOT NULL,
	[TIPDES] [char](1) NULL,
	[SUBMED] [char](1) NULL,
	[PAGANU] [char](1) NULL,
	[CONPMO] [char](1) NULL,
	[VAL2AV] [numeric](9, 2) NULL,
	[NOMGRA] [varchar](26) NULL,
	[ENDCPL] [varchar](9) NULL,
	[VALTOTCRE] [float] NOT NULL,
	[ENDEDC] [varchar](50) NULL,
	[ENDCPLEDC] [varchar](9) NULL,
	[CODBAIEDC] [int] NULL,
	[CODLOCEDC] [int] NULL,
	[SIGUF0EDC] [char](2) NULL,
	[CEPEDC] [char](8) NULL,
	[RESEDC] [varchar](30) NULL,
	[TELEDC] [varchar](20) NULL,
	[CODREG] [int] NOT NULL,
	[CODATI] [int] NOT NULL,
	[CODREO] [smallint] NOT NULL,
	[CODEPS] [smallint] NOT NULL,
	[PERSUB] [smallint] NOT NULL,
	[OUTCRT] [char](1) NOT NULL,
	[OUTLAY] [smallint] NULL,
	[MAXPARC] [smallint] NULL,
	[PMOEXCSEG] [int] NULL,
	[COB2AV] [char](1) NOT NULL,
	[ORDEMCL] [char](1) NULL,
	[COBRAANU] [char](1) NULL,
	[ANUIPERIODO] [char](1) NULL,
	[NUMANUICOB] [smallint] NULL,
	[LIMRISCO] [smallint] NULL,
	[COBATV] [char](1) NULL,
	[VALATV] [numeric](9, 2) NULL,
	[COBANUIMOV] [char](1) NULL,
	[DADIAMENTO] [smallint] NULL,
	[CRTINCBLQ] [char](1) NULL,
	[CODMENS] [int] NULL,
	[SALDOFUNC] [char](1) NULL,
	[msrepl_synctran_ts] [timestamp] NOT NULL,
	[CODEMB] [int] NULL,
	[ICOMPSEGF] [char](1) NULL,
	[CAR2VIA] [smallint] NULL,
	[NAOVERIFCPF] [char](1) NULL,
 CONSTRAINT [PK_CLIENTE] PRIMARY KEY CLUSTERED 
(
	[CODCLI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CREDENCIADO]    Script Date: 27/06/2019 14:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CREDENCIADO](
	[CODCRE] [int] NOT NULL,
	[CODLOC] [int] NOT NULL,
	[CODBAI] [int] NOT NULL,
	[CODATI] [int] NOT NULL,
	[CODSEG] [int] NOT NULL,
	[SIGUF0] [char](2) NULL,
	[STA] [char](2) NOT NULL,
	[RAZSOC] [varchar](50) NOT NULL,
	[NOMFAN] [varchar](50) NOT NULL,
	[TEL] [varchar](20) NOT NULL,
	[COA] [varchar](25) NOT NULL,
	[DATINC] [datetime] NOT NULL,
	[DATCTT] [datetime] NOT NULL,
	[DATSTA] [datetime] NOT NULL,
	[CTABCO] [varchar](22) NOT NULL,
	[TAXSER] [numeric](9, 2) NOT NULL,
	[DATTAXSER] [datetime] NOT NULL,
	[MSGATVCRT] [char](1) NOT NULL,
	[QTDPOS] [smallint] NOT NULL,
	[EMA] [varchar](45) NULL,
	[FAX] [varchar](20) NULL,
	[TIPFEC] [int] NOT NULL,
	[DIAFEC] [int] NOT NULL,
	[NUMFEC] [int] NOT NULL,
	[DATULTFEC] [datetime] NULL,
	[DATPRCULTFEC] [datetime] NULL,
	[ENDCRE] [varchar](50) NOT NULL,
	[OBS] [text] NULL,
	[CEP] [char](8) NOT NULL,
	[INSEST] [char](15) NOT NULL,
	[CGC] [char](14) NOT NULL,
	[CODFILNUT] [int] NOT NULL,
	[SENCRE] [char](6) NOT NULL,
	[PRAPAG] [smallint] NOT NULL,
	[ENDCPL] [varchar](9) NULL,
	[TIPEST] [smallint] NOT NULL,
	[CODMAT] [int] NOT NULL,
	[QTEFIL] [smallint] NOT NULL,
	[QTEMAQ] [smallint] NOT NULL,
	[LOCPAG] [smallint] NOT NULL,
	[CODCEN] [int] NOT NULL,
	[LINPQ1] [varchar](27) NULL,
	[LINPQ2] [varchar](27) NULL,
	[DATGERCRT] [datetime] NULL,
	[GERCRT] [char](1) NOT NULL,
	[ENDCOR] [varchar](50) NULL,
	[ENDCPLCOR] [varchar](9) NULL,
	[CODBAICOR] [int] NULL,
	[CODLOCCOR] [int] NULL,
	[SIGUF0COR] [char](2) NULL,
	[CEPCOR] [char](8) NULL,
	[FORPAG] [smallint] NOT NULL,
	[CODCAN] [smallint] NOT NULL,
	[CODREG] [int] NOT NULL,
	[CODREO] [smallint] NOT NULL,
	[CODEPS] [smallint] NOT NULL,
	[TRANSHAB] [char](4) NULL,
	[FLAG_PJ] [char](1) NULL,
	[MASCONTA] [char](21) NULL,
	[FLAG_VA] [char](1) NULL,
	[INTVENDINI] [smallint] NULL,
	[INTVENDFIN] [smallint] NULL,
	[CTRLFUNC] [datetime] NULL,
	[rowversion] [timestamp] NOT NULL,
	[DATALT] [datetime] NULL,
 CONSTRAINT [PK_CREDENCIADO] PRIMARY KEY CLUSTERED 
(
	[CODCRE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FECHCLIENTE]    Script Date: 27/06/2019 14:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FECHCLIENTE](
	[CODCLI] [int] NOT NULL,
	[NUMFECCLI] [int] NOT NULL,
	[DATINI] [datetime] NOT NULL,
	[DATFIN] [datetime] NOT NULL,
	[CODOPE] [smallint] NULL,
	[DATFECLOT] [datetime] NULL,
	[PRAPAG] [smallint] NULL,
	[PAGANU] [char](1) NULL,
	[CONPMO] [char](1) NULL,
	[SUBMED] [char](1) NULL,
	[PERSUB] [smallint] NULL,
	[TOTTRANS] [int] NULL,
	[TOTAL] [numeric](15, 2) NULL,
	[COMPCREC] [numeric](15, 2) NULL,
	[ANUIDADE] [numeric](15, 2) NULL,
	[VAL2VIA] [numeric](15, 2) NULL,
	[COMPRAS] [numeric](15, 2) NULL,
	[PREMIO] [numeric](15, 2) NULL,
	[DESCFOLHA] [numeric](15, 2) NULL,
	[msrepl_synctran_ts] [timestamp] NOT NULL,
 CONSTRAINT [PK_FECHCLIENTE] PRIMARY KEY CLUSTERED 
(
	[CODCLI] ASC,
	[NUMFECCLI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FECHCRED]    Script Date: 27/06/2019 14:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FECHCRED](
	[CODCRE] [int] NOT NULL,
	[NUMFECCRE] [int] NOT NULL,
	[DATINI] [datetime] NOT NULL,
	[DATFIN] [datetime] NOT NULL,
	[CODOPE] [smallint] NULL,
	[TAXSER] [numeric](9, 2) NULL,
	[VALPAG] [numeric](15, 2) NULL,
	[QTETRA] [int] NULL,
	[QTETRAVAD] [int] NULL,
	[DATFECLOT] [datetime] NULL,
	[NUMBOR] [varchar](7) NULL,
	[VALBOR] [numeric](15, 2) NULL,
	[QTETRABOR] [int] NULL,
	[PRAPAG] [smallint] NULL,
	[TIPFEC] [int] NULL,
	[CTABCO] [varchar](22) NULL,
	[CODCEN] [int] NULL,
	[FORPAG] [smallint] NULL,
	[CODFEN] [int] NULL,
	[DATBOR] [datetime] NULL,
	[QTELANC] [int] NULL,
	[VALLANC] [numeric](15, 2) NULL,
	[QTEALANC] [int] NULL,
	[VALALANC] [numeric](15, 2) NULL,
	[DATPGTO] [datetime] NULL,
 CONSTRAINT [PK_FECHCRED] PRIMARY KEY CLUSTERED 
(
	[CODCRE] ASC,
	[NUMFECCRE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Grupo_Cliente]    Script Date: 27/06/2019 14:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Grupo_Cliente](
	[codcli] [int] NOT NULL,
	[grc_codigo] [int] NOT NULL,
	[grc_descricao] [varchar](50) NOT NULL,
	[nomcli] [varchar](60) NULL,
	[Aposentado] [char](1) NULL,
	[usa_dados_comp] [char](1) NULL,
	[msrepl_synctran_ts] [timestamp] NOT NULL,
	[Pode_subir_para_BI] [char](1) NULL,
	[Tipo_cliente] [varchar](20) NULL,
	[mps_participa_programa] [char](1) NOT NULL,
	[fl_migrado] [bit] NOT NULL,
	[fl_extrato_detalhado] [bit] NOT NULL,
	[usa_proc_venda_padrao] [bit] NOT NULL,
	[PossuiIntegracaoPlant] [bit] NOT NULL,
	[mps_cobra_taxa_adesao] [bit] NOT NULL,
	[mps_cobra_frete] [bit] NOT NULL,
	[mps_valor_frete_isento] [decimal](18, 2) NULL,
	[Faturamento_Plant] [bit] NOT NULL,
	[DescricaoMeuBeneficio] [varchar](max) NULL,
	[LimiteMinimoAnuidade] [numeric](9, 2) NULL,
 CONSTRAINT [PK_Grupo_Cliente] PRIMARY KEY NONCLUSTERED 
(
	[codcli] ASC,
	[grc_codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LOCALIDADE]    Script Date: 27/06/2019 14:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOCALIDADE](
	[CODLOC] [int] NOT NULL,
	[NOMLOC] [varchar](35) NOT NULL,
	[msrepl_synctran_ts] [timestamp] NOT NULL,
 CONSTRAINT [PK_LOCALIDADE] PRIMARY KEY NONCLUSTERED 
(
	[CODLOC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TRANSACAO]    Script Date: 27/06/2019 14:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRANSACAO](
	[DATTRA] [datetime] NOT NULL,
	[NSUHOS] [int] NOT NULL,
	[NSUAUT] [int] NOT NULL,
	[CODCLI] [int] NULL,
	[CODCRE] [int] NULL,
	[TIPTRA] [int] NOT NULL,
	[CODCRT] [varchar](20) NULL,
	[CODRTA] [char](1) NOT NULL,
	[VALTRA] [numeric](15, 2) NOT NULL,
	[REC] [char](1) NOT NULL,
	[CPF] [varchar](11) NULL,
	[NUMDEP] [smallint] NULL,
	[DATFECCLI] [datetime] NULL,
	[NUMFECCLI] [int] NULL,
	[DATFECCRE] [datetime] NULL,
	[NUMFECCRE] [int] NULL,
	[DAD] [varchar](32) NULL,
	[TIPDEB] [char](1) NULL,
	[ATV] [char](1) NULL,
	[CODOPE] [smallint] NULL,
	[CONFERIDA] [char](1) NULL,
	[NUMFECHAUT] [char](3) NULL,
	[VERSAOTEC] [char](8) NULL,
	[VALAVISTA] [numeric](9, 2) NULL,
	[DELIVERY] [varchar](5) NULL,
 CONSTRAINT [PK_TRANSACAO] PRIMARY KEY CLUSTERED 
(
	[DATTRA] ASC,
	[NSUHOS] ASC,
	[NSUAUT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USUARIO]    Script Date: 27/06/2019 14:27:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_PERSUB]  DEFAULT (100) FOR [PERSUB]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_OUTCRT]  DEFAULT ('N') FOR [OUTCRT]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF__CLIENTE__COB2AV__24B26D99]  DEFAULT ('N') FOR [COB2AV]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_COBATV]  DEFAULT ('N') FOR [COBATV]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_COBANUIMOV]  DEFAULT ('N') FOR [COBANUIMOV]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_DADIAMENTO]  DEFAULT (0) FOR [DADIAMENTO]
GO
ALTER TABLE [dbo].[CLIENTE] ADD  CONSTRAINT [DF_CLIENTE_CRTINCBLQ]  DEFAULT ('N') FOR [CRTINCBLQ]
GO
ALTER TABLE [dbo].[Grupo_Cliente] ADD  DEFAULT ('N') FOR [mps_participa_programa]
GO
ALTER TABLE [dbo].[Grupo_Cliente] ADD  DEFAULT ((0)) FOR [fl_migrado]
GO
ALTER TABLE [dbo].[Grupo_Cliente] ADD  CONSTRAINT [DF_Grupo_Cliente_fl_extrato_detalhado]  DEFAULT ((1)) FOR [fl_extrato_detalhado]
GO
ALTER TABLE [dbo].[Grupo_Cliente] ADD  DEFAULT ((0)) FOR [usa_proc_venda_padrao]
GO
ALTER TABLE [dbo].[Grupo_Cliente] ADD  DEFAULT ((0)) FOR [PossuiIntegracaoPlant]
GO
ALTER TABLE [dbo].[Grupo_Cliente] ADD  DEFAULT ((0)) FOR [mps_cobra_taxa_adesao]
GO
ALTER TABLE [dbo].[Grupo_Cliente] ADD  DEFAULT ((0)) FOR [mps_cobra_frete]
GO
ALTER TABLE [dbo].[Grupo_Cliente] ADD  DEFAULT (NULL) FOR [mps_valor_frete_isento]
GO
ALTER TABLE [dbo].[Grupo_Cliente] ADD  CONSTRAINT [chk_Faturamento_Plant]  DEFAULT ((0)) FOR [Faturamento_Plant]
GO
-- ALTER TABLE [dbo].[CREDENCIADO]  WITH CHECK ADD  CONSTRAINT [FK_CREDENCIADO_ATIVIDADE] FOREIGN KEY([CODATI])
-- REFERENCES [dbo].[ATIVIDADE] ([CODATI])
-- GO
-- ALTER TABLE [dbo].[CREDENCIADO] CHECK CONSTRAINT [FK_CREDENCIADO_ATIVIDADE]
-- GO
ALTER TABLE [dbo].[CREDENCIADO]  WITH CHECK ADD  CONSTRAINT [FK_CREDENCIADO_BAIRRO] FOREIGN KEY([CODBAI])
REFERENCES [dbo].[BAIRRO] ([CODBAI])
GO
ALTER TABLE [dbo].[CREDENCIADO] CHECK CONSTRAINT [FK_CREDENCIADO_BAIRRO]
GO
ALTER TABLE [dbo].[CREDENCIADO]  WITH CHECK ADD  CONSTRAINT [FK_CREDENCIADO_BAIRRO1] FOREIGN KEY([CODBAICOR])
REFERENCES [dbo].[BAIRRO] ([CODBAI])
GO
ALTER TABLE [dbo].[CREDENCIADO] CHECK CONSTRAINT [FK_CREDENCIADO_BAIRRO1]
GO
-- ALTER TABLE [dbo].[CREDENCIADO]  WITH CHECK ADD  CONSTRAINT [FK_CREDENCIADO_CANAL] FOREIGN KEY([CODCAN])
-- REFERENCES [dbo].[CANAL] ([CODCAN])
-- GO
-- ALTER TABLE [dbo].[CREDENCIADO] CHECK CONSTRAINT [FK_CREDENCIADO_CANAL]
-- GO
ALTER TABLE [dbo].[CREDENCIADO]  WITH CHECK ADD  CONSTRAINT [FK_CREDENCIADO_CREDENCIADO] FOREIGN KEY([CODCEN])
REFERENCES [dbo].[CREDENCIADO] ([CODCRE])
GO
ALTER TABLE [dbo].[CREDENCIADO] CHECK CONSTRAINT [FK_CREDENCIADO_CREDENCIADO]
GO
ALTER TABLE [dbo].[CREDENCIADO]  WITH CHECK ADD  CONSTRAINT [FK_CREDENCIADO_CREDENCIADO1] FOREIGN KEY([CODMAT])
REFERENCES [dbo].[CREDENCIADO] ([CODCRE])
GO
ALTER TABLE [dbo].[CREDENCIADO] CHECK CONSTRAINT [FK_CREDENCIADO_CREDENCIADO1]
GO
-- ALTER TABLE [dbo].[CREDENCIADO]  WITH CHECK ADD  CONSTRAINT [FK_CREDENCIADO_EPS] FOREIGN KEY([CODREO], [CODEPS])
-- REFERENCES [dbo].[EPS] ([CODREO], [CODEPS])
-- GO
-- ALTER TABLE [dbo].[CREDENCIADO] CHECK CONSTRAINT [FK_CREDENCIADO_EPS]
-- GO
ALTER TABLE [dbo].[CREDENCIADO]  WITH CHECK ADD  CONSTRAINT [FK_CREDENCIADO_LOCALIDADE] FOREIGN KEY([CODLOCCOR])
REFERENCES [dbo].[LOCALIDADE] ([CODLOC])
GO
ALTER TABLE [dbo].[CREDENCIADO] CHECK CONSTRAINT [FK_CREDENCIADO_LOCALIDADE]
GO
ALTER TABLE [dbo].[CREDENCIADO]  WITH CHECK ADD  CONSTRAINT [FK_CREDENCIADO_LOCALIDADE1] FOREIGN KEY([CODLOC])
REFERENCES [dbo].[LOCALIDADE] ([CODLOC])
GO
ALTER TABLE [dbo].[CREDENCIADO] CHECK CONSTRAINT [FK_CREDENCIADO_LOCALIDADE1]
GO
-- ALTER TABLE [dbo].[CREDENCIADO]  WITH CHECK ADD  CONSTRAINT [FK_CREDENCIADO_REEMBOLSO] FOREIGN KEY([FORPAG])
-- REFERENCES [dbo].[REEMBOLSO] ([FORPAG])
-- GO
-- ALTER TABLE [dbo].[CREDENCIADO] CHECK CONSTRAINT [FK_CREDENCIADO_REEMBOLSO]
-- GO
-- ALTER TABLE [dbo].[CREDENCIADO]  WITH CHECK ADD  CONSTRAINT [FK_CREDENCIADO_REGIAO] FOREIGN KEY([CODREG])
-- REFERENCES [dbo].[REGIAO] ([CODREG])
-- GO
-- ALTER TABLE [dbo].[CREDENCIADO] CHECK CONSTRAINT [FK_CREDENCIADO_REGIAO]
-- GO
-- ALTER TABLE [dbo].[CREDENCIADO]  WITH CHECK ADD  CONSTRAINT [FK_CREDENCIADO_SEGMENTO] FOREIGN KEY([CODSEG])
-- REFERENCES [dbo].[SEGMENTO] ([CODSEG])
-- GO
-- ALTER TABLE [dbo].[CREDENCIADO] CHECK CONSTRAINT [FK_CREDENCIADO_SEGMENTO]
-- GO
-- ALTER TABLE [dbo].[CREDENCIADO]  WITH CHECK ADD  CONSTRAINT [FK_CREDENCIADO_STATUS] FOREIGN KEY([STA])
-- REFERENCES [dbo].[STATUS] ([STA])
-- GO
-- ALTER TABLE [dbo].[CREDENCIADO] CHECK CONSTRAINT [FK_CREDENCIADO_STATUS]
-- GO
-- ALTER TABLE [dbo].[CREDENCIADO]  WITH CHECK ADD  CONSTRAINT [FK_CREDENCIADO_UF] FOREIGN KEY([SIGUF0])
-- REFERENCES [dbo].[UF] ([SIGUF0])
-- GO
-- ALTER TABLE [dbo].[CREDENCIADO] CHECK CONSTRAINT [FK_CREDENCIADO_UF]
-- GO
-- ALTER TABLE [dbo].[CREDENCIADO]  WITH CHECK ADD  CONSTRAINT [FK_CREDENCIADO_UF1] FOREIGN KEY([SIGUF0COR])
-- REFERENCES [dbo].[UF] ([SIGUF0])
-- GO
-- ALTER TABLE [dbo].[CREDENCIADO] CHECK CONSTRAINT [FK_CREDENCIADO_UF1]
-- GO
-- ALTER TABLE [dbo].[FECHCLIENTE]  WITH NOCHECK ADD  CONSTRAINT [FK_FECHCLIENTE_CLIENTE] FOREIGN KEY([CODCLI])
-- REFERENCES [dbo].[CLIENTE] ([CODCLI])
-- GO
ALTER TABLE [dbo].[FECHCLIENTE] CHECK CONSTRAINT [FK_FECHCLIENTE_CLIENTE]
GO
ALTER TABLE [dbo].[FECHCRED]  WITH CHECK ADD  CONSTRAINT [FK_FECHCRED_CREDENCIADO] FOREIGN KEY([CODCRE])
REFERENCES [dbo].[CREDENCIADO] ([CODCRE])
GO
ALTER TABLE [dbo].[FECHCRED] CHECK CONSTRAINT [FK_FECHCRED_CREDENCIADO]
GO
ALTER TABLE [dbo].[FECHCRED]  WITH CHECK ADD  CONSTRAINT [FK_FECHCRED_REEMBOLSO] FOREIGN KEY([FORPAG])
REFERENCES [dbo].[REEMBOLSO] ([FORPAG])
GO
-- ALTER TABLE [dbo].[FECHCRED] CHECK CONSTRAINT [FK_FECHCRED_REEMBOLSO]
-- GO
-- ALTER TABLE [dbo].[CLIENTE]  WITH NOCHECK ADD  CONSTRAINT [CK_CLIENTE_CODCLI] CHECK  (([CODCLI] > 0 and [CODCLI] < 100000))
-- GO
ALTER TABLE [dbo].[CLIENTE] CHECK CONSTRAINT [CK_CLIENTE_CODCLI]
GO
ALTER TABLE [dbo].[CLIENTE]  WITH NOCHECK ADD  CONSTRAINT [CK_CLIENTE_DATAFEC] CHECK  (([DATFEC] >= 1 and [DATFEC] <= 31))
GO
ALTER TABLE [dbo].[CLIENTE] CHECK CONSTRAINT [CK_CLIENTE_DATAFEC]
GO
ALTER TABLE [dbo].[CLIENTE]  WITH NOCHECK ADD  CONSTRAINT [CK_CLIENTE_NUMPAC] CHECK  (([NUMPAC] >= 0 and [NUMPAC] < 13))
GO
ALTER TABLE [dbo].[CLIENTE] CHECK CONSTRAINT [CK_CLIENTE_NUMPAC]
GO
ALTER TABLE [dbo].[CLIENTE]  WITH NOCHECK ADD  CONSTRAINT [CK_CLIENTE_PRAPAG] CHECK  (([PRAPAG] > 0 and [PRAPAG] < 31))
GO
ALTER TABLE [dbo].[CLIENTE] CHECK CONSTRAINT [CK_CLIENTE_PRAPAG]
GO
ALTER TABLE [dbo].[CREDENCIADO]  WITH NOCHECK ADD  CONSTRAINT [CK_CREDENCIADO_DIAFEC] CHECK  (([DIAFEC] >= 1 and [DIAFEC] <= 30))
GO
ALTER TABLE [dbo].[CREDENCIADO] CHECK CONSTRAINT [CK_CREDENCIADO_DIAFEC]
GO
ALTER TABLE [dbo].[CREDENCIADO]  WITH NOCHECK ADD  CONSTRAINT [CK_CREDENCIADO_INTVENDFIN] CHECK  (([INTVENDFIN] >= 1 and [INTVENDFIN] <= 31))
GO
ALTER TABLE [dbo].[CREDENCIADO] CHECK CONSTRAINT [CK_CREDENCIADO_INTVENDFIN]
GO
ALTER TABLE [dbo].[CREDENCIADO]  WITH NOCHECK ADD  CONSTRAINT [CK_CREDENCIADO_INTVENDINI] CHECK  (([INTVENDINI] >= 1 and [INTVENDFIN] <= 31))
GO
ALTER TABLE [dbo].[CREDENCIADO] CHECK CONSTRAINT [CK_CREDENCIADO_INTVENDINI]
GO
ALTER TABLE [dbo].[Grupo_Cliente]  WITH CHECK ADD  CONSTRAINT [CK_Grupo_Cliente] CHECK  (([usa_dados_comp] = 'N' or [usa_dados_comp] = 'S'))
GO
ALTER TABLE [dbo].[Grupo_Cliente] CHECK CONSTRAINT [CK_Grupo_Cliente]
GO
ALTER TABLE [dbo].[Grupo_Cliente]  WITH CHECK ADD  CONSTRAINT [CK_Grupo_Cliente_tipo_cliente] CHECK  (([tipo_cliente]='Pagamento Vista' OR [tipo_cliente]='Desconto Folha' OR [tipo_cliente]='PBM' OR [tipo_cliente]='FP' OR [tipo_cliente]='LISTA E REDE' OR [tipo_cliente]=' LISTA E REDE' OR [tipo_cliente]=' GI' OR [tipo_cliente]='PI' OR [tipo_cliente]='CONVENIO FARMACIA'))
GO
ALTER TABLE [dbo].[Grupo_Cliente] CHECK CONSTRAINT [CK_Grupo_Cliente_tipo_cliente]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Coluna para identificar se o cliente é PBM, somente desconto em folha ou pagamento àvista' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Grupo_Cliente', @level2type=N'COLUMN',@level2name=N'Tipo_cliente'
GO
