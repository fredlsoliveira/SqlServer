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