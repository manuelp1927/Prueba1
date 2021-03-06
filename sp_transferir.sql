USE [PRUEBA]
GO
/****** Object:  StoredProcedure [dbo].[sp_prueba]    Script Date: 18/09/2021 10:25:31 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- realiza el calculo del nuevo saldo
-- Parámetros de entrada: valor a retirar
-- Retorna: saldo actual
-- Creada por:	EPP	18/09/2021
-- Modificada por:
alter Procedure [dbo].[sp_transferir]  @p_valor_a_transferir int,
										@p_banco_remitente varchar(50),
										@p_nro_cta_bancaria_remitente int,
										@p_banco_destino varchar(50),
										@p_nro_cta_bancaria_destino int
as
begin	
	
	set nocount on
	Declare @v_valor_a_transferir int
	Declare @v_ind_excento varchar(1)

	--Backup de los datos
	select *
	from saldoactual

	--Aplicacion GMF 4x1000

	select @v_ind_excento = excento
	from saldoactual
	where banco = @p_banco_destino
	and nro_cta_bancaria = @p_nro_cta_bancaria_destino

	
	--si se transifere a una cuenta de otro banco y el cliente no es Exento de GMF.
	--se valida solamente el indicador de excento debido a que si es o no de otro banco va aplicar 4x1000
	--por lo que es redundante
	if (@v_ind_excento = 'N' )
	begin
	select @p_valor_a_transferir = (@p_valor_a_transferir * 4) / 1000;
	end
	

	

	--se le quita el valor al saldo actual de la cuenta remitente
	update saldoactual
	set saldo = saldo - @p_valor_a_transferir
	where nro_cta_bancaria = @p_nro_cta_bancaria_remitente
	and banco = @p_banco_remitente

	--se le aumenta el valor al saldo actual de la cuenta destino
	update saldoactual
	set saldo = saldo + @p_valor_a_transferir
	where nro_cta_bancaria = @p_nro_cta_bancaria_destino
	and banco = @p_banco_destino

	--Inserta en el log remitente
	insert log_movimientos
	select @p_banco_remitente,
		   @p_nro_cta_bancaria_remitente,
		   @p_valor_a_transferir,
		   'T', --INSERTANDO operacion de transferencia
		   GETDATE()
	from saldoactual

		--Inserta en el log destino
	insert log_movimientos
	select @p_banco_destino,
		   @p_nro_cta_bancaria_destino,
		   @p_valor_a_transferir,
		   'T', --INSERTANDO operacion de transferencia
		   GETDATE()
	from saldoactual

End
