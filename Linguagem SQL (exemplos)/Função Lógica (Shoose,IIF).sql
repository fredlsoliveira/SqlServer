use AdventureWorks2014
/* (CHOOSE) RETORNA INDICE PARA UMA LISTA DE VALORES */
--1° EXEMPLO
SELECT CHOOSE(3,'Gerente','Diretor','Desenvolvedor','Teste') AS Escolhido

--2° EXEMPLO
SELECT pc.ProductCategoryID,
	CHOOSE(pc.ProductCategoryID, 'A','B','C','D','E') AS Expressao
FROM Production.ProductCategory pc

--3° EXEMPLO
SELECT JobTitle,
	HireDate,
	MONTH(HireDate) AS Mes,
	CHOOSE(MONTH(HireDate),	'Winter','Winter','Spring','Spring',
								'Spring','Summer','Summer','Summer',
								'Autumn','Autumn','Autumn','Winter') AS Quarter
FROM HumanResources.Employee he
WHERE YEAR(HireDate) > 2005
ORDER BY YEAR(HireDate)


/* (IIF) EXPRESSAO BOOLIANA RETORNA TRUE OU FALSE */

--1° EXEMPLO
DECLARE @a INT = 45,
		@b INT = 40;
SELECT IIF (@a > @b, 'TRUE','FALSE') AS Resultado;

--2° EXEMPLO
SELECT IIF (45 > 30, NULL, NULL) AS Resultado

--3° EXEMPLO
DECLARE @P INT = NULL,
		@S INT = NULL
SELECT IIF(45 > 30, @P, @S) AS Resultado