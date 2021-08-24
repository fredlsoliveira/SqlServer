/* (ASCII) RETORNA CODIGO DO PRIMEIRO CARACTER A ESQUERDA */
--1° EXEMPLO
SELECT ASCII('SQL')
SELECT ASCII('S')
SELECT ASCII('Q')
SELECT ASCII('L')

--2° EXEMPLO
DECLARE @position INT,
		@string CHAR(9)
SET @position = 1
SET @string = 'Ola Mundo'
WHILE @position <= DATALENGTH(@string)
	BEGIN
		SELECT ASCII(SUBSTRING(@string, @position, 1)) AS Cod_Ascii,
		CHAR(ASCII(SUBSTRING(@string, @position, 1)))
		SET @position = @position + 1
	END


/* (LTRIM) RETORNA UMA EXPRESSAO DEPOIS DE REMOVER ESPAÇOS EM BRANCO A ESQUERDA */
DECLARE @string_to_trim VARCHAR(60)
SET @string_to_trim = '     Cinco espaços no inicio'
SELECT 'Texto sem espaço'+LTRIM(@string_to_trim)
SELECT 'Texto com espaço'+@string_to_trim


/* (STR) CONVERTER NUMERO EM TEXTO */
--1° EXEMPLO
SELECT STR(123.45, 6,1)

--2° EXEMPLO
SELECT 'Teste '+STR(123.45, 6,1)


/* (CONCAT) RETORNA A CONCATENACAO DE DOIS OU MAIS VALORES */
SELECT CONCAT(CURRENT_USER, ' Seu Saldo é R$ ', 11.00, ' em ', DAY(GETDATE()),'/',MONTH(GETDATE()),'/',YEAR(GETDATE())) AS Resultado


/* (REPLACE) SUBSTITUI CARACTERES ESPECIFICADO */
--1° EXEMPLO
SELECT REPLACE('abcdefghicde', 'cde', 'xxx')

--2° EXEMPLO
SELECT REPLACE('Isso é teste', 'teste', 'Produção')

--3° EXEMPLO
SELECT REGIAO, REPLACE(REGIAO,'Sul','South') AS Para
FROM regiao_uf

--4° EXEMPLO > UPDATE USANDO REPLACE
CREATE TABLE pessoa
(
	nome VARCHAR(50)
)

INSERT INTO pessoa VALUES('Jose')
INSERT INTO pessoa VALUES('Maria')
INSERT INTO pessoa VALUES('Ana')

SELECT * FROM pessoa

UPDATE pessoa SET nome=REPLACE(nome, 'a','4')


/* (REPLICATE) REPETE UMA CADEIA DE CARACTER NÚMERO REPETIDO DE VEZES */

--1° EXEMPLO
SELECT name,
	ProductLine,
	REPLICATE('0',4) + ProductLine AS 'Line Code' 
FROM Production.Product
WHERE ProductLine = 'T'
ORDER BY name

--2° EXEMPLO
use curso
CREATE TABLE t1
(
	c1 VARCHAR(3),
	c2 CHAR(3)
)

INSERT INTO t1 VALUES('2','2')
INSERT INTO t1 VALUES('37','37')
INSERT INTO t1 VALUES('597','597')

SELECT * FROM t1

SELECT 
	DATALENGTH(c1) AS dtlc1,
	DATALENGTH(c2) AS dtlc2,
	REPLICATE('0',3 - DATALENGTH(c1)) + c1 AS 'VARCHAR COLUNA',
	REPLICATE('0',3 - DATALENGTH(c2)) + c2 AS 'CHAR'
FROM t1


/* (LEFT) RETORNA UMA CADEIA DE CARACTERES A ESQUERDA */
use AdventureWorks2014

SELECT 
	name,
	LEFT(name, 6) AS 'Left Nome'
FROM Production.Product
ORDER BY ProductID 


/* (UPPER) PASSAR A CADEIA DE CARACTERES PARA MAIUSCULAS */
use curso

SELECT 
	estado,
	UPPER(estado) AS 'Upper Estado' 
FROM regiao_uf


/* (SUBSTRING) RETORNA A QUANTIDADE DE CARACTERES INFORMADA NA CONSULTA */
use AdventureWorks2014

SELECT
	 LastName,
	 SUBSTRING(LastName, 1,3) AS 'LastName 3 carac',
	 SUBSTRING(LastName, 4,9) AS 'LastName 9 carac'
FROM Person.Person
ORDER BY LastName