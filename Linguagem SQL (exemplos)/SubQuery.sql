--CRIANDO TABELA CLIENTE PARA TESTE
use curso
CREATE TABLE cliente
(
	cod_cli		NCHAR(5) PRIMARY KEY,
	cli_nome	VARCHAR(50) NOT NULL
)

--INSERINDO REGISTROS NA TABELA CLIENTE APARTIR DE OUTRA TABELA
INSERT INTO cliente
SELECT CustomerID, CompanyName FROM NORTHWND.dbo.Customers

--CRIANDO TABELA PEDIDO PARA TESTE
CREATE TABLE pedido
(
	num_ped		INT PRIMARY KEY,
	cod_cliente	NCHAR(5) NOT NULL,
	data		DATETIME NOT NULL,
	total		DECIMAL(10,2)
)

--INSERINDO REGISTROS NA TABELA PEDIDO APARTIR DE OUTRA TABELA
INSERT INTO pedido (num_ped, cod_cliente, data)
SELECT OrderID, CustomerID, OrderDate FROM NORTHWND.dbo.Orders

--ATUALIZANDO CAMPO TOTAL DA TABELA PEDIDO COM UPDATE EM SUBSELECT
UPDATE pedido SET total = 
(
	SELECT SUM(d.UnitPrice*d.Quantity) FROM NORTHWND.dbo.[Order Details] d
	WHERE num_ped = d.OrderID
)

--APRESENTANDO OS CLIENTES QUE FIZERAM COMPRAS ANTES DA DATA ATUAL (GETDATE())
SELECT	c.cod_cli,
		c.cli_nome
FROM cliente c
WHERE c.cod_cli IN
(
	SELECT p.cod_cliente
	FROM pedido p
	WHERE p.data < GETDATE()
)

--CONSULTA TRZER O NOME CLIENTE NA TABELA DE PEDIDO
SELECT	p.num_ped,
		p.data,
		p.cod_cliente,
		(	
		SELECT c.cli_nome 
		FROM cliente c
		WHERE p.cod_cliente = c.cod_cli
		) 
		AS NomeCliente
FROM pedido p

--CONSULTA SOMAR TODO VALOR COMPRADO PELO CLIENTE
SELECT	p.cod_cliente,
		(
		SELECT c.cli_nome
		FROM cliente c
		WHERE p.cod_cliente = c.cod_cli
		)
		AS NomeCliente,
		SUM(p.total) AS ValorTotal		 
FROM pedido p
GROUP BY p.cod_cliente 

--CONSULTA MOSTRA TODOS OS CLIENTES E VALOR DE COMPRAS
SELECT	c.cod_cli,
		(
		SELECT	ISNULL(SUM(p.total),0)				 
		FROM pedido p
		WHERE c.cod_cli = p.cod_cliente
		)
		AS ValorTotal
FROM cliente c
GROUP BY c.cod_cli

--EXCLUINDO CLIENTE SEM PEDIDO
DELETE FROM cliente
WHERE cod_cli NOT IN (SELECT p.cod_cliente FROM pedido p)