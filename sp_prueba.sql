USE [PRUEBA]
GO
/****** Object:  StoredProcedure [dbo].[sp_prueba]    Script Date: 18/09/2021 12:33:02 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- realiza el calculo del nuevo saldo
-- Parámetros de entrada: valor a retirar
-- Retorna: saldo actual
-- Creada por:	EPP	18/09/2021
-- Modificada por:
ALTER Procedure [dbo].[sp_prueba]  @p_valor_a_retirar int,
								   @p_banco varchar(50),
								   @p_nro_cta_bancaria int
as
begin	
	
	set nocount on
	Declare @v_valor_a_retirar int

	--Backup de los datos
	select *
	from saldoactual

	--Aplicacion GMF 4x1000
	if @p_valor_a_retirar >= 9600000
	begin
	select @p_valor_a_retirar = (@p_valor_a_retirar * 4) / 1000;
	end

	--Actualiza el saldo con el valor a retirar ya incluido el 4x1000 en caso que aplique
	update saldoactual
	set saldo = saldo - @p_valor_a_retirar


	--Inserta en el log
	insert log_movimientos
	select @p_banco,
		   @p_nro_cta_bancaria,
		   @p_valor_a_retirar,
		   'R', --INSERTANDO operacion de retiro
		   GETDATE()
	from saldoactual

	



End
