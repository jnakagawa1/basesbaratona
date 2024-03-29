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

USE [ressuprimento]
GO
/****** Object:  Table [dbo].[Contrato]    Script Date: 27/06/2019 14:40:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contrato](
	[Contrato] [int] NOT NULL,
	[CodCre] [int] NOT NULL,
	[Dt_Inicial] [datetime] NOT NULL,
	[DT_Final] [datetime] NULL,
	[FEE_Positiva] [numeric](9, 2) NULL,
	[FEE_Negativa] [numeric](9, 2) NULL,
	[FEE_Neutra] [numeric](9, 2) NULL,
	[FEE_por_produto] [varchar](1) NULL,
	[Central_Pag] [int] NOT NULL,
	[Central_Entrega] [int] NOT NULL,
	[Prapag] [int] NOT NULL,
	[DiaFec] [int] NOT NULL,
	[TipFec] [int] NOT NULL,
	[Pagamento] [varchar](1) NOT NULL,
	[Reposicao_LP] [varchar](1) NOT NULL,
	[DiaPed] [int] NULL,
	[Tipoped] [int] NULL,
	[Forcar_preco] [char](1) NULL,
	[teste] [varchar](3) NULL,
	[Usar_Lista_Produtos] [char](1) NULL,
	[observacao] [text] NULL,
	[Repoe_Taxa] [char](1) NULL,
	[Bloquear_Geracao_Pedido] [char](1) NULL,
	[Paga_taxa_LP] [char](1) NULL,
	[Perc_taxa_LP] [numeric](9, 2) NULL,
	[Paga_taxa_NLP] [char](1) NULL,
	[Perc_taxa_NLP] [numeric](9, 2) NULL,
	[Paga_taxa_LP_gestao] [char](1) NULL,
	[Perc_taxa_LP_gestao] [numeric](9, 2) NULL,
	[Paga_taxa_NLP_gestao] [char](1) NULL,
	[Perc_taxa_NLP_gestao] [numeric](9, 2) NULL,
	[FEE_lista_desco] [numeric](9, 2) NULL,
	[FEE_fora_lista_desco] [numeric](9, 2) NULL,
	[bloq_reposicao_prod_retem_receita] [char](1) NULL,
	[rowversion] [timestamp] NOT NULL,
	[separaFechamentoPI] [bit] NOT NULL,
	[Dt_Alteracao] [datetime] NULL,
 CONSTRAINT [PK_Contrato] PRIMARY KEY NONCLUSTERED 
(
	[CodCre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Distribuidor]    Script Date: 27/06/2019 14:40:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Distribuidor](
	[DISTRIBUIDOR] [nvarchar](50) NULL,
	[FILIAL] [nvarchar](50) NULL,
	[UF] [nvarchar](2) NOT NULL,
	[CNPJ] [nvarchar](20) NOT NULL,
	[CodLabo] [nvarchar](10) NOT NULL,
	[codfilial] [varchar](50) NULL,
	[cod_funcional] [varchar](10) NULL,
	[DATSTA] [datetime] NULL,
	[STA] [char](2) NULL,
 CONSTRAINT [PK_Distribuidor] PRIMARY KEY CLUSTERED 
(
	[UF] ASC,
	[CNPJ] ASC,
	[CodLabo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GPDC_DISTRIBUIDOR]    Script Date: 27/06/2019 14:40:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GPDC_DISTRIBUIDOR](
	[dis_cod] [int] NOT NULL,
	[dis_nome] [varchar](50) NULL,
	[dis_tipo] [varchar](12) NULL,
	[cnpj] [varchar](14) NULL,
 CONSTRAINT [PK_GPDC_DISTRIBUIDOR] PRIMARY KEY CLUSTERED 
(
	[dis_cod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pre_pedido]    Script Date: 27/06/2019 14:40:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pre_pedido](
	[codcre] [int] NOT NULL,
	[cod_prod] [varchar](6) NOT NULL,
	[ppd_codigo] [numeric](18, 0) IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ppd_data] [datetime] NOT NULL,
	[ppd_solicitar] [int] NOT NULL,
	[ppd_origem] [varchar](20) NOT NULL,
	[ppd_status] [varchar](16) NOT NULL,
	[ped_codigo] [numeric](18, 0) NULL,
	[ped_codigo_natendido] [numeric](18, 0) NULL,
	[usr_codigo_cancelamento] [varchar](20) NULL,
	[ppd_motivo_cancelamento] [varchar](255) NULL,
	[ppd_data_cancelamento] [datetime] NULL,
	[ppd_data_alteracao] [datetime] NULL,
	[usr_codigo_alteracao] [varchar](20) NULL,
	[ppd_motivo_alteracao] [varchar](255) NULL,
	[ppd_solicitar_original] [int] NULL,
	[ppd_Forcar_Distribuidor] [int] NULL,
	[cod_movi] [int] NULL,
	[dat_vend] [datetime] NULL,
	[nsuhos] [int] NULL,
	[ppd_distribuidor_alt] [int] NULL,
	[desc_repo] [numeric](9, 2) NULL,
	[desc_diferenciado] [char](1) NULL,
	[lt_movimentacao] [int] NULL,
	[CD_PROGRAMA] [int] NULL,
	[nsu_pre_pedido] [int] NULL,
	[desc_venda] [numeric](9, 2) NULL,
	[cod_item] [int] NULL,
	[StatusConciliacaoFidelize] [smallint] NULL,
 CONSTRAINT [PK_pre_pedido] PRIMARY KEY NONCLUSTERED 
(
	[codcre] ASC,
	[cod_prod] ASC,
	[ppd_codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pre_pedido_fracionados]    Script Date: 27/06/2019 14:40:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pre_pedido_fracionados](
	[ppf_id] [int] IDENTITY(1,1) NOT NULL,
	[ppf_codigo] [int] NULL,
	[codcre] [int] NULL,
	[cod_prod] [varchar](6) NULL,
	[cod_movi] [int] NULL,
	[dat_vend] [datetime] NULL,
	[ppf_status] [varchar](10) NULL,
	[ppd_codigo] [int] NULL,
	[nsuhos] [int] NULL,
 CONSTRAINT [PK_pre_pedido_fracionados] PRIMARY KEY CLUSTERED 
(
	[ppf_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_LogPedidoDescontoZerado]    Script Date: 27/06/2019 14:40:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_LogPedidoDescontoZerado](
	[id_log] [int] IDENTITY(1,1) NOT NULL,
	[ppd_codigo] [numeric](18, 0) NOT NULL,
	[cod_movi] [int] NOT NULL,
	[nsuhos] [int] NULL,
	[cod_esta] [varchar](8) NULL,
	[dat_vend] [datetime] NOT NULL,
	[dat_log] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_ReposicaoArquivo]    Script Date: 27/06/2019 14:40:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_ReposicaoArquivo](
	[arquivoId] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](128) NOT NULL,
	[dataInicial] [datetime] NOT NULL,
	[dataFinal] [datetime] NOT NULL,
	[dataGeracao] [datetime] NOT NULL,
	[charSet] [varchar](10) NOT NULL,
	[versaoLayout] [varchar](10) NOT NULL,
	[convernio] [varchar](50) NOT NULL,
	[cd_programa] [int] NULL,
 CONSTRAINT [PK_t_ReposicaoArquivo] PRIMARY KEY CLUSTERED 
(
	[arquivoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Contrato] ADD  DEFAULT ('N') FOR [Bloquear_Geracao_Pedido]
GO
ALTER TABLE [dbo].[Contrato] ADD  DEFAULT ((0)) FOR [separaFechamentoPI]
GO
ALTER TABLE [dbo].[Distribuidor] ADD  CONSTRAINT [DF_Distribuidor_DATSTA]  DEFAULT (getdate()) FOR [DATSTA]
GO
ALTER TABLE [dbo].[Distribuidor] ADD  CONSTRAINT [DF_Distribuidor_STA]  DEFAULT ('00') FOR [STA]
GO
ALTER TABLE [dbo].[pre_pedido]  WITH NOCHECK ADD  CONSTRAINT [FK_pre_pedido_pedido_1] FOREIGN KEY([ped_codigo])
REFERENCES [dbo].[pedido] ([ped_codigo])
GO
ALTER TABLE [dbo].[pre_pedido] NOCHECK CONSTRAINT [FK_pre_pedido_pedido_1]
GO
ALTER TABLE [dbo].[pre_pedido]  WITH NOCHECK ADD  CONSTRAINT [FK_pre_pedido_pedido_2] FOREIGN KEY([ped_codigo_natendido])
REFERENCES [dbo].[pedido] ([ped_codigo])
GO
ALTER TABLE [dbo].[pre_pedido] NOCHECK CONSTRAINT [FK_pre_pedido_pedido_2]
GO
ALTER TABLE [dbo].[Contrato]  WITH CHECK ADD  CONSTRAINT [ck_contrato_reposicao_lp] CHECK  (([reposicao_lp] = '3' or [reposicao_lp] = '2' or [reposicao_lp] = '1'))
GO
ALTER TABLE [dbo].[Contrato] CHECK CONSTRAINT [ck_contrato_reposicao_lp]
GO
ALTER TABLE [dbo].[GPDC_DISTRIBUIDOR]  WITH CHECK ADD  CONSTRAINT [ck_GPDC_DISTRIBUIDOR_dis_tipo] CHECK  (([dis_tipo]='DISTRIBUIDOR' OR [dis_tipo]='GRANDE REDE'))
GO
ALTER TABLE [dbo].[GPDC_DISTRIBUIDOR] CHECK CONSTRAINT [ck_GPDC_DISTRIBUIDOR_dis_tipo]
GO
ALTER TABLE [dbo].[pre_pedido]  WITH CHECK ADD  CONSTRAINT [ck_ppd_status_1] CHECK  (([ppd_status]='Fracionado' OR [ppd_status]='Cancelado Ajuste' OR [ppd_status]='Cancelado' OR [ppd_status]='Fechado' OR [ppd_status]='Aberto' OR [ppd_status]='BOEHRINGER' OR [ppd_status]='Enviado' OR [ppd_status]='Env Devolucao' OR [ppd_status]='Devolvido' OR [ppd_status]='Bloqueado' OR [ppd_status]='Devolver' OR [ppd_status]='Nao_Repoe_Taxa' OR [ppd_status]='Nao_Repoe'))
GO
ALTER TABLE [dbo].[pre_pedido] CHECK CONSTRAINT [ck_ppd_status_1]
GO
ALTER TABLE [dbo].[pre_pedido]  WITH NOCHECK ADD  CONSTRAINT [CK_pre_pedido_ppd_origem_1] CHECK  (([ppd_origem]='Ajuste' OR [ppd_origem]='Nao Atendido' OR [ppd_origem]='Transacao' OR [ppd_origem]='Fracionados' OR [ppd_origem]='Safe'))
GO
ALTER TABLE [dbo].[pre_pedido] CHECK CONSTRAINT [CK_pre_pedido_ppd_origem_1]
GO
ALTER TABLE [dbo].[pre_pedido_fracionados]  WITH CHECK ADD  CONSTRAINT [CK_pre_pedidos_fracionados_Status] CHECK  (([ppf_status] = 'Cancelado' or ([ppf_status] = 'Fechado' or [ppf_status] = 'Aberto')))
GO
ALTER TABLE [dbo].[pre_pedido_fracionados] CHECK CONSTRAINT [CK_pre_pedidos_fracionados_Status]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1=REPOE TUDO, 2=REPOE NADA, 3=REPOE LPM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Contrato', @level2type=N'COLUMN',@level2name=N'Reposicao_LP'
GO
