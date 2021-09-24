/* (WHILE) ESTRUTURA DE REPETIÇÃO */

--1°EXEMPLO
DECLARE @cont INT
SET @cont = 10

WHILE (SELECT GETDATE() - @cont) <= GETDATE()
	BEGIN
		PRINT GETDATE() - @cont
		SET @cont = @cont - 1
	IF (GETDATE() - @cont) >= GETDATE()
		BREAK 
	ELSE 
		CONTINUE 
	END
	
	
--2° EXEMPLO (TABUADA)
DECLARE @cont INT,
		@tab INT
SET @cont = 0
SET @tab = 8

WHILE(@cont <= 10)
	BEGIN 
		PRINT CAST(@cont AS NVARCHAR) + N' X ' + CAST(@tab AS NVARCHAR) + N' = ' + CAST(@cont * @tab AS NVARCHAR)
		SET @cont = @cont + 1
	END
		
	
--3° EXEMPLO (NUM PAR OU IMPAR)
DECLARE @cont INT,
		@max INT,
		@mod INT
SET @cont = 1
SET @max = 10

WHILE(@cont <= @max)
	BEGIN 
		SET @mod = @cont % 2
		IF @mod = 0
			BEGIN 
				PRINT 'O Numero ' + CAST(@cont AS NCHAR(2)) + ' é par'
				SET @cont = @cont + 1
			END
		ELSE 
			BEGIN 
				PRINT 'O Numero ' + CAST(@cont AS NCHAR(2)) + ' é impar'
				SET @cont = @cont + 1
			END	
	END		
	
	