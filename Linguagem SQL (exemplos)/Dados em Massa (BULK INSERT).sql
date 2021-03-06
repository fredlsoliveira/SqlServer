/* (BULK INSERT) CARREGAR DADOS EM MASSA A PARTIR DE UM ARQUIVO */

use curso

--CRIAÇÃO DA TABELA RECEBER O ARQUIVO EXTERNO
CREATE TABLE PRODUTO
(
	codigo NVARCHAR(5),
	produto NVARCHAR(20)
)


--(BULK INSERT) CRIAÇÃO DO CODIGO DE IMPORTAÇÃO
BULK INSERT PRODUTO
FROM '/home/fredoliveira/Downloads/Bulk/carga/Dados em Massa (tb produto).txt'
WITH
(
	CODEPAGE = 'RAW',
	DATAFILETYPE = 'CHAR',
	FIELDTERMINATOR = '|',
	ROWTERMINATOR = '\n',
	MAXERRORS = 0,
	FIRE_TRIGGERS
	/*FIRSTROW = 1, > Linha inicio (opcional)
	LASTROW = 11	> Linha final  (opcional) */
)

--CONSULTANDO TABELA
SELECT * FROM PRODUTO 

--LIMPANDO DADOS DA TABELA
DELETE FROM PRODUTO