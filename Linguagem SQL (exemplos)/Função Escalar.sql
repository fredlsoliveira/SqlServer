/* CRIANDO FUN��O ESCALAR TRIM */

CREATE�FUNCTION�Trim(@ST�VARCHAR(1000))�
 RETURNS�VARCHAR(1000)���
  BEGIN�������
	RETURN(Ltrim(Rtrim(@ST)))���
  END

--INVOCANDO A FUN��O ESCALAR TRIM
SELECT�'>'�+�('      Ana Maria       ')+'<'
UNION
SELECT�'>'�+�DBO.TRIM('      Ana Maria       ')+'<'

--DROP FUNCTION Trim
--********************************************************--



/* CRIANDO FUN��O ESCALAR Soma */

CREATE�FUNCTION�Soma(@num1�INT,@num2�INT)�
	RETURNS�INT���
	BEGIN�������
		DECLARE�@res�INT�������
		SET�@res=@num1�+�@num2�������
		RETURN�(�@res�)���
	END
	

--(1) INVOCANDO A FUN��O ESCALAR Soma
SELECT�'>>>'�,�DBO.SOMA(1,3)

--CRIANDO TABELA #testesoma
CREATE TABLE #testesoma
 (val1 INT,
  val2 INT
  )

--INSERINDO VALORES
INSERT INTO #testesoma VALUES (10,2),(5,4),(89,3)


--(2) INVOCANDO A FUN��O ESCALAR Soma
SELECT val1,
       val2,
       dbo.soma(val1,val2)
FROM #testesoma
�
--DROP FUNCTION Soma
--********************************************************--



/* CRIANDO FUN��O ESCALAR inventario */

use AdventureWorks2017

CREATE�FUNCTION�inventario(@ProductID�INT)�
	RETURNS�INT�
	AS���
--�Retorna estoque de produto.���
BEGIN�������
	DECLARE�@ret�INT;�������
	SELECT�@ret�=�Sum(p.quantity)�������
		FROM���production.productinventory�p������
	�WHERE��p.productid�=�@ProductID��������������
		    AND�p.locationid�=�'6';�������
	IF�(�@ret�IS�NULL�)���������
	SET�@ret�=�0;�������
	RETURN�@ret;���
	END;
	
--INVOCANDO A FUN��O ESCALAR inventario
	SELECT�productmodelid,��������
		   NAME,��������
		   dbo.inventario(productid)AS�Estoque_atual�
		   FROM���production.product�
		   WHERE��productmodelid�BETWEEN�75�AND�100;�

--DROP FUNCTION inventario
--********************************************************--



/* CRIANDO FUN��O ESCALAR F_Cidades */

use curso

CREATE FUNCTION F_Cidades (@UF VARCHAR(2))
RETURNS TABLE
As
 RETURN(
  SELECT * FROM cidades a
  WHERE a.uf = @UF)
 
--INVOCANDO A FUN��O ESCALAR F_Cidades
SELECT * FROM dbo.F_Cidades('YY')

--********************************************************--



/* FUNCAO PARA RECEBER DUAS DATA E RETORNAR INTERVALO DE ACORDO COM PARAMETRO. */
CREATE�FUNCTION�dbo.func_dias(@dia�INT,@dti�DATETIME,@dtf�DATETIME)�
	RETURNS�@tbl�TABLE(dt�DATETIME)�
	AS���
	BEGIN�������
		WHILE�@dti�<=�@dtf���������
			BEGIN�������������
				INSERT�INTO�@tbl��(dt)�VALUES�(@dti)�������������
				SET�@dti�=�Dateadd(day,�@dia,�@dti)���������
			END
			RETURN
	END

--INVOCANDO A FUN��O ESCALAR dias
	SELECT�*�FROM���dbo.func_dias(3,getdate(),getdate()+12)�