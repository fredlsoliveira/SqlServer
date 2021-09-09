/* (CASE) COMPARA UMA EXPRESSÃO COM UM CONJUNTO DE 
 * EXPRESSÕES PARA DETERMINAR O RESULTADO */

--1° EXEMPLO ********************************
DECLARE @data DATETIME
--SET @data=GETDATE()
--SET @data=DATEADD(DAY,-1, GETDATE()) 
SET @data=DATEADD(DAY,1, GETDATE()) 
SELECT 
	CASE 
		WHEN @data = GETDATE() THEN 'Hoje'
		WHEN @data < GETDATE() THEN 'Ontem'
		WHEN @data > GETDATE() THEN 'Amanhã'
	END AS DIA
	
	
--2° EXEMPLO ********************************
use AdventureWorks2017

SELECT
	p.productnumber,
	p.productline,
	
CATEGORIA = CASE p.productline
				WHEN 'R' THEN 'Road'
				WHEN 'M' THEN 'Mountain'
				WHEN 'T' THEN 'Touring'
				WHEN 'S' THEN 'Other sale itens'
				ELSE 'Not for sale'
			END,
			
	p.name
FROM Production.Product p
ORDER BY p.productnumber	
	

--3° EXEMPLO ********************************
use AdventureWorks2017

SELECT
	p.productnumber,
	p.productline,
	
CASE 
	WHEN p.productline = 'R' THEN 'Road'
	WHEN p.productline = 'M' THEN 'Mountain'
	WHEN p.productline = 'T' THEN 'Touring'
	WHEN p.productline = 'S' THEN 'Other sale itens'
	ELSE 'Not for sale'
END as CATEGORIA,
			
	p.name
FROM Production.Product p
ORDER BY p.productnumber	
	

--4° EXEMPLO ********************************	
SELECT 
	p.productnumber,
	p.name,
	p.ListPrice,
CASE 
	WHEN p.listprice = 0 THEN 'Não está a venda'
	WHEN p.listprice < 50 THEN 'Abaixo de $50'
	WHEN p.listprice >= 50 AND p.listprice < 250 THEN 'Abaixo de $250'
	WHEN p.listprice >= 250 AND p.listprice < 1000 THEN 'Abaixo de $1000'
	ELSE 'Acima de $1000' 
END AS RANK_PRECO,
	'PRODUTOS' AS CATEGORIA
FROM Production.Product p
ORDER BY p.productnumber
	

--5° EXEMPLO ********************************
SELECT 
	e.BusinessEntityID,
	e.SalariedFlag 
FROM HumanResources.Employee e 
ORDER BY 
	CASE WHEN e.SalariedFlag = 1 THEN e.BusinessEntityID END DESC,
	CASE WHEN e.SalariedFlag = 0 THEN e.BusinessEntityID END ASC 
	

--6° EXEMPLO ********************************
BEGIN TRANSACTION	
	

UPDATE HumanResources.Employee
SET VacationHours  = 
	(
	CASE WHEN ((VacationHours - 10.00) < 0 ) THEN VacationHours + 40
	 	 ELSE (VacationHours + 20.00)
	END
	)
	 
OUTPUT 
	deleted.businessentityid,
	deleted.VacationHours AS ANTES,
	inserted.VacationHours AS DEPOIS
WHERE SalariedFlag = 0


ROLLBACK TRANSACTION