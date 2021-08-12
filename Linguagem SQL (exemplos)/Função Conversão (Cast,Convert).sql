/* (CAST) RETORNA VALOR ALTERADO DO TIPO DO CAMPO */

DECLARE @meuvalor DECIMAL(5,2)
SET @meuvalor = 193.57

--CAST 1° EXEMPLO
SELECT CAST(@meuvalor AS VARBINARY(20))
SELECT CAST(CAST(@meuvalor AS VARBINARY(20)) AS DECIMAL(5,2))

--CAST 2° EXEMPLO
SELECT Substring(Name, 1, 30) AS ProductName,
	ListPrice
FROM Production.Product
WHERE CAST(ListPrice AS INT) LIKE '3%'

----CAST 3° EXEMPLO
SELECT CAST(ROUND(SalesYTD / CommissionPct, 0) AS INT) AS Formatado,
	(SalesYTD / CommissionPct) AS NaoFormatado
FROM Sales.SalesPerson
WHERE CommissionPct <> 0

----CAST 4° EXEMPLO
SELECT 'A lista de preco é '+ CAST(ListPrice AS VARCHAR(12)) AS ListPrice
FROM Production.Product
WHERE ListPrice BETWEEN 350.00 AND 400.00

----CAST 5° EXEMPLO
SELECT DISTINCT
	p.Name,
	CAST(p.Name AS CHAR(10)) AS Name,
	s.UnitPrice 
FROM Sales.SalesOrderDetail s
INNER JOIN Production.Product p ON s.ProductID = p.ProductID
WHERE p.Name LIKE 'Long-Sleeve Logo Jersey, M'

----CAST 6° EXEMPLO
SELECT p.FirstName,
	p.LastName,
	s.SalesYTD,
	s.BusinessEntityID,
	CAST(CAST(s.SalesYTD AS INT) AS CHAR(20)) AS Sales2,
	CAST(s.SalesYTD AS CHAR(20)) AS Sales3
FROM Person.Person p
INNER JOIN Sales.SalesPerson s ON s.BusinessEntityID = p.BusinessEntityID
WHERE CAST(CAST(s.SalesYTD AS INT) AS CHAR(20)) LIKE '2%'


/* (CONVERT) RETORNA VALOR ALTERADO DO TIPO DO CAMPO */

DECLARE @meuvalor2 DECIMAL(5,2)
SET @meuvalor2 = 193.57

--CONVERT 1° EXEMPLO
SELECT CONVERT(VARBINARY(20), @meuvalor2)
SELECT CONVERT(DECIMAL(5,2), CONVERT(VARBINARY(20), @meuvalor2))

--CONVERT 2° EXEMPLO
SELECT Substring(Name, 1, 30) AS ProductName,
	ListPrice
FROM Production.Product
WHERE CONVERT(INT, ListPrice) LIKE '3%'