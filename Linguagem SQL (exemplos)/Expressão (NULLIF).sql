/* (NULLIF) RETORNA UM VALOR NULO SE AS DUAS EXPRESSÕES ESPECIFICADAS FOREM IGUAIS */

--1° EXEMPLO
SELECT ISNULL(100 / NULLIF(50,0),0) /* = SELECT 100 / 50 */ 

SELECT ISNULL(100 / NULLIF(0,0),0)  /* = SELECT 100 / 0  */



--2° EXEMPLO
/* TABELA PARA SIMULAÇÃO DO NULLIF */
use curso
CREATE TABLE testeNullif
(
	Valor1 INT,
	Valor2 INT
)

INSERT INTO testeNullif VALUES (100,0),(100,25),(1,0),(5,2)

SELECT
	Valor1,
	Valor2,
	ISNULL(Valor1 / NULLIF(Valor2,0),0) AS Expressao
FROM testeNullif



--3° EXEMPLO
use AdventureWorks2017
SELECT 
	p.ProductID,
	p.MakeFlag,
	p.FinishedGoodsFlag,
	NULLIF(p.MakeFlag,p.FinishedGoodsFlag) AS 'Null se Igual'
FROM Production.Product p
WHERE p.ProductID  < 10
