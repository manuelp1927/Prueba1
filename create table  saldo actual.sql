USE [PRUEBA]
GO

/****** Object:  Table [dbo].[saldoactual]    Script Date: 18/09/2021 2:09:35 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[saldoactual](
	[saldo] [int] NULL,
	[nro_cta_bancaria] [int] NULL,
	[banco] [varchar](50) NULL,
	[excento] [varchar](1) NULL,
	[cliente] [int] NULL
) ON [PRIMARY]
GO


