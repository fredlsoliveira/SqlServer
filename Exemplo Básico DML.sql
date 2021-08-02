CREATE DATABASE curso

--DDL CRIAÇÃO DA TABELA PARA EXERCICIOS
use curso
CREATE TABLE FUNCIONARIOS
(
	ID int identity(1,1),
	NOME VARCHAR(50) NOT NULL,
	SALARIO DECIMAL(10,2) NOT NULL,
	SETOR VARCHAR(30) NOT NULL
)

--EXEMPLO DE SELECT
use curso
SELECT * FROM FUNCIONARIOS

--DML INSERT
use curso
INSERT INTO FUNCIONARIOS (NOME,SALARIO,SETOR) VALUES ('Fred',1000,'TI'),('Pedro',500,'RH'),('Maria',800,'Financeiro')

INSERT INTO FUNCIONARIOS VALUES ('Ana',600,'RH')

--DML UPDATE
use curso
UPDATE FUNCIONARIOS SET SALARIO = 1200
WHERE ID = 1

UPDATE FUNCIONARIOS SET SALARIO = SALARIO*1.2
WHERE ID = 1

UPDATE FUNCIONARIOS SET SALARIO = SALARIO*1.5
WHERE ID <> 1

--DML DELETE
use curso
DELETE FUNCIONARIOS
WHERE ID = 2