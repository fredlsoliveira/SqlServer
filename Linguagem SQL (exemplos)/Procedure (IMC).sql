/* PROCEDURE PARA CALCULAR IMC - INDICE DE MASSA DO CORPO */

CREATE PROCEDURE calc_imc @PESO decimal(10,2),@ALTURA decimal(10,2)
AS
BEGIN
DECLARE @IMC decimal(10,2);
SET @IMC= @PESO/(@ALTURA*@ALTURA)
END
IF @IMC < 17
	Begin
	PRINT 'SEU IMC é '+cast(@IMC as varchar(20))+' Muito abaixo do peso'
	End
IF @IMC >= 17 and @IMC <= 18.49
	Begin
	PRINT 'SEU IMC é '+cast(@IMC as varchar(20))+' Abaixo do peso'
	End

IF @IMC >= 18.5 and @IMC <= 24.99
	Begin
	PRINT 'SEU IMC é '+cast(@IMC as varchar(20))+' Peso normal'
	end

IF @IMC >= 25 and @IMC <= 29.99
	Begin
	PRINT 'SEU IMC é '+cast(@IMC as varchar(20))+' Acima do peso'
	End

IF @IMC >= 30 and @IMC <= 34.99
	Begin
	PRINT 'SEU IMC é '+cast(@IMC as varchar(20))+' Obesidade I'
	End

IF @IMC >= 35 and @IMC <= 39.99
	Begin
	PRINT 'SEU IMC é '+cast(@IMC as varchar(20))+' Obesidade II (severa)'
	End

IF @IMC >= 40
	Begin
	PRINT 'SEU IMC é '+cast(@IMC as varchar(20))+' Obesidade III (mórbida)'
	End

--DROP PROCEDURE calc_imc




/* EXCUTANDO PROCEDURE CALC_IMC
INFORMANDO PESO E ALTURA */

EXEC calc_imc 70,1.70