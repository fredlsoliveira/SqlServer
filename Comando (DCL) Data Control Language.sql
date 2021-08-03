--CRIAR UM LOGIN E PERMISSÕES NO BANCO
EXEC master.dbo.sp_addlogin 'UsrTeste','123'
EXEC sp_grantdbaccess 'UsrTeste','UsrTeste'

--****** INICIO COMANDO GRANT ******

--DCL CONCEDENDO ACESSO ATUALIZAÇÃO PARA UsrTeste
GRANT UPDATE ON FUNCIONARIOS TO UsrTeste;

--DCL CONCEDENDO ACESSO INSERIR PARA UsrTeste
GRANT INSERT ON FUNCIONARIOS TO UsrTeste;

--DCL CONCEDENDO ACESSO LEITURA PARA UsrTeste
GRANT SELECT ON FUNCIONARIOS TO UsrTeste;

--DCL CONCEDENDO ACESSO DELETE PARA UsrTeste
GRANT DELETE ON FUNCIONARIOS TO UsrTeste;

--CRIAÇÃO DE PROCEDURE PARA TESTE
CREATE PROCEDURE procTeste
AS
SELECT * FROM cidades
--EXECUTAR PROCEDURE
EXEC procTeste

--DCL CONCEDENDO ACESSO PARA EXECUTAR PROCEDURE procTeste PARA UsrTeste
GRANT EXECUTE ON procTeste TO UsrTeste

--VERIFICANDO USUARIO LOGADO
SELECT CURRENT_USER

--ALTERANDO USUARIO LOGADO
SETUSER 'UsrTeste'


--****** INICIO COMANDO REVOKE ******

--****** INICIO COMANDO DENY ******