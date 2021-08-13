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