/* RETORNA VALOR DATA HORA NO QUAL A INSTÂNCIA DO SQL SERVER 
 * ESTÁ SENDO EXECUTADA. 
 * O DESLOCAMENTO DE FUSO HORÁRIO NÃO INCLUÍDO. */

SELECT SYSDATETIME() AS exSysdatetime

SELECT SYSDATETIMEOFFSET() AS exSysdatetimeoffset

SELECT CURRENT_TIMESTAMP AS exCurrent_Timestamp 

SELECT GETDATE() AS exGetdate


/* RETORNA VALOR DATA HORA NO QUAL A INSTÂNCIA DO SQL SERVER 
 * ESTÁ SENDO EXECUTADA. 
 * DATA E HORA RETORNADA COMO UTC (TEMPO UNIVERSAL COORDENADO. */

SELECT SYSUTCDATETIME() AS exSysutcdatetime

SELECT GETUTCDATE() AS exGetutcdate