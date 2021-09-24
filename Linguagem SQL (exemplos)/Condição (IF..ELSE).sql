/*(IF) CONDIÇÃO */

use curso

--1° EXEMPLO (AND)
IF 1=1 AND 2=2
	BEGIN 
		PRINT 'TRUE'
	END
	ELSE 
		PRINT 'FALSE'
		
		
--2° EXEMPLO (OR)
IF 1=1 OR 2=17
	BEGIN 
		PRINT 'TRUE'
	END
	ELSE 
		PRINT 'FALSE'
		
		
/* 3° EXEMPLO 
 * CRIAÇÃO DE TABELA */
		
SELECT 
	od.OrderID 		AS pedido,
	od.ProductID 	AS cod_mat,
	od.Quantity 	AS qtde,
	od.UnitPrice 	AS preco
INTO pedido_detalhe
FROM NORTHWND.dbo.[Order Details] od 
--------------------------------------
SELECT * FROM pedido_detalhe
--------------------------------------
SELECT pedido,COUNT(*)
FROM pedido_detalhe
GROUP BY pedido
--------------------------------------
--10411 = 3
--10720 = 2
--10789 = 4
--------------------------------------

DECLARE @pedido INT
SET @pedido = '10789'

IF (SELECT COUNT(*)
		FROM pedido_detalhe
		WHERE pedido = @pedido
		GROUP BY pedido) > 3
			BEGIN 
				PRINT 'Qtde maior que 3'
			END
			ELSE
			BEGIN 
				SELECT pedido,cod_mat
				FROM pedido_detalhe
				WHERE pedido = @pedido
			END
	

--4° EXEMPLO
DECLARE @idade INT
SET @idade = 17

IF @idade < 18
	PRINT 'Menor que 18 anos'
ELSE IF @idade >= 18 AND @idade <= 65
	PRINT 'Maior que 18 anos'
ELSE
	PRINT 'Maior que 65'
	