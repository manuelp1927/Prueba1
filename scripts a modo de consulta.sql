--scripts para la BD a modo de consulta

--Saldo  de todas las cuentas de un cliente en especifico

select *
from saldoactual
where cliente = '11233'


--Movimientos realizados sobre una cuenta durante un periodo de tiempo especificado

select *
from log_movimientos
where fecha_operacion > '2021-09-18 00:00:00.000'