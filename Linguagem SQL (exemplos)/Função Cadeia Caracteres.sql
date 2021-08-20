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