use NORTHWND

/* (TOP) RETORNA QUANTIDADE DE LINHAS DEFINIDA NO SELECT PELO TOP */

--1° EXEMPLO
SELECT TOP 3 * FROM Customers

--2° EXEMPLO
SELECT TOP 10 C.CustomerID, C.CompanyName FROM Customers C

--3° EXEMPLO
SELECT TOP 10
	RANK() OVER(ORDER BY SUM(d.Quantity*d.UnitPrice) DESC) AS Classificacao,
	c.CompanyName,
	SUM(d.Quantity*d.UnitPrice) AS Total_Compra	
FROM Customers c
INNER JOIN Orders o ON o.CustomerID = c.CustomerID
INNER JOIN [Order Details] d ON d.OrderID = o.OrderID
GROUP BY c.CompanyName

--4° EXEMPLO
use curso
SELECT TOP 10 * 
FROM cidades
ORDER BY populacao DESC

--5° EXEMPLO
SELECT TOP 10 *, 
	RANK() OVER(ORDER BY populacao DESC) AS Classificacao
FROM cidades
ORDER BY populacao DESC