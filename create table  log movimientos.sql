USE [PRUEBA]
GO

/****** Object:  Table [dbo].[log_movimientos]    Script Date: 18/09/2021 2:09:10 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[log_movimientos](
	[banco] [varchar](50) NULL,
	[nro_cta_bancaria] [int] NULL,
	[valor] [nchar](10) NULL,
	[ind_tranferencia_retiro] [varchar](1) NULL,
	[fecha_operacion] [datetime] NULL
) ON [PRIMARY]
GO


