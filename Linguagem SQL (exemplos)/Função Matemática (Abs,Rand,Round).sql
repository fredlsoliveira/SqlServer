use curso

/* (ABS) RETORNA VALOR POSITIVO EXPRESSAO NUMERICA */
SELECT ABS(-1.0),
	ABS(0.0),
	ABS(1.0),
	ABS(-9.0),
	ABS(9.0),
	ABS(-5.4),
	ABS(5.4)


/* (RAND) RETORNA UM NUMEOR PSEUDOALEATORIO ENTRE 0 E 1 */

--1? EXEMPLO
SELECT RAND(),
	RAND(),
	RAND()

--2? EXEMPLO
DECLARE @cont SMALLINT;
SET @cont = 1
WHILE @cont <= 5
	BEGIN
		SELECT RAND() AS Random_Number
		SET @cont = @cont + 1
	END


/* (ROUND) RETORNA VALOR NUMERICO ARREDONDANDO */
SELECT ROUND(123.9994, 3)
SELECT ROUND(123.9995, 3)
SELECT ROUND(123.4545, 2)
SELECT ROUND(123.45, -2)
SELECT ROUND(193.45, -2)
SELECT ROUND(150.75, 0)
SELECT ROUND(150.75, 0.1)