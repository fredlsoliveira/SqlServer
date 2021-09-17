/* (VIEW) CRIAÇÃO DE UMA TABELA VIRTUAL */

-- CRIAÇÃO DA VIEW
use AdventureWorks2017
CREATE VIEW v_dataContratacao
AS
	SELECT 
		p.FirstName,
		p.LastName,
		e.BusinessEntityID,
		e.HireDate
	FROM HumanResources.Employee e 
	JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID 
	
	
-- ALTERAÇÃO DA VIEW 
ALTER VIEW v_dataContratacao
AS
	SELECT 
		p.Title,
		p.FirstName,
		p.LastName,
		e.BusinessEntityID,
		e.HireDate
	FROM HumanResources.Employee e 
	JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID 	
	
	
-- CONSULTAR VIEW
SELECT * FROM v_dataContratacao vdc



/*CRIAÇÃO DE TABELAS PARA TESTE DE NOVA VIEW---------------------------------*/

use curso
CREATE TABLE fornecedor1
(
	id_fornecedor INT PRIMARY KEY CHECK(id_fornecedor BETWEEN 1 AND 150),
	fornecedor CHAR(50)
)


CREATE TABLE fornecedor2
(
	id_fornecedor INT PRIMARY KEY CHECK(id_fornecedor BETWEEN 151 AND 300),
	fornecedor CHAR(50)
)

CREATE TABLE fornecedor3
(
	id_fornecedor INT PRIMARY KEY CHECK(id_fornecedor BETWEEN 301 AND 450),
	fornecedor CHAR(50)
)

CREATE TABLE fornecedor4
(
	id_fornecedor INT PRIMARY KEY CHECK(id_fornecedor BETWEEN 451 AND 600),
	fornecedor CHAR(50)
)

INSERT fornecedor1 VALUES('120','A')
INSERT fornecedor2 VALUES('180','B')
INSERT fornecedor3 VALUES('310','C')
INSERT fornecedor4 VALUES('550','D')

SELECT * FROM fornecedor1 f 

/*----------------------------------------------------------------------------*/


--2° EXEMPLO DE VIEW
CREATE VIEW v_fornecedor
AS
SELECT id_fornecedor, fornecedor, 'F1' AS tb_origem FROM fornecedor1
UNION ALL
SELECT id_fornecedor, fornecedor, 'F2' AS tb_origem FROM fornecedor2
UNION ALL
SELECT id_fornecedor, fornecedor, 'F3' AS tb_origem FROM fornecedor3
UNION ALL
SELECT id_fornecedor, fornecedor, 'F4' AS tb_origem FROM fornecedor4

-- CONSULTAR VIEW
SELECT * FROM v_fornecedor 
