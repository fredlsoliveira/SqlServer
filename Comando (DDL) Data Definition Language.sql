CREATE DATABASE curso

--DDL CRIANDO TABELA
use curso
CREATE TABLE funcionario
(
	matricula	INT PRIMARY KEY IDENTITY(1,1),
	nome		CHAR(50) NOT NULL,
	sobrenome	CHAR(50) NOT NULL,
	data_nasc	DATETIME,
	endereco	CHAR(50),
	cidade		CHAR(50),
	pais		CHAR(25)
)

--DDL CRIANDO TABELA COM CHAVE ESTRANGEIRA
use curso
CREATE TABLE salario
(
	matricula	INT PRIMARY KEY NOT NULL,
	salario		DECIMAL(10,2) NOT NULL,
	FOREIGN KEY(matricula) REFERENCES funcionario(matricula)
)

--DDL CRIANDO TABELA COM CHAVE PRIMARIA
use curso
CREATE TABLE audit_salario
(
	transacao	INT IDENTITY(1,1),
	matricula	INT NOT NULL PRIMARY KEY,
	data_trans	DATETIME NOT NULL,
	sal_antigo	DECIMAL(10,2),
	sal_novo	DECIMAL(10,2),
	usuario		VARCHAR(20) NOT NULL
)

--DDL CRIANDO INDEX
use curso
CREATE INDEX index_func1 ON funcionario(data_nasc)

CREATE INDEX index_func2 ON funcionario(cidade,pais)

--DDL ADICIONADO NOVO CAMPO NA TABELA
use curso
ALTER TABLE funcionario ADD genero CHAR(1)

--DDL EXEMPLO ADD CHAVE PRIMARIA EM TABELA JA CRIADA
use curso
ALTER TABLE funcionario ADD PRIMARY KEY (matricula)

--RENOMEANDO CAMPO DE UMA TABELA
use curso
EXEC sp_rename 'funcionario.endereco', 'logradouro', 'COLUMN'

--ALTERAR TIPO DA COLUNA
use curso
ALTER TABLE funcionario ALTER COLUMN logradouro VARCHAR(30)

--EXCLUINDO COLUNA
use curso
ALTER TABLE funcionario DROP COLUMN genero

--RENOMEANDO UMA TABELA
use curso
EXEC sp_rename 'funcionario','func'

--EXCLUIDO TABELA
use curso
DROP TABLE salario

--CRIANDO BANDO DADOS
CREATE DATABASE teste

--EXCLUIDO BANDO DADOS
DROP DATABASE teste

--CRIANDO VIEW
CREATE VIEW v_funcionario
	AS
	SELECT * FROM funcionario

--ALTERAR VIEW
ALTER VIEW v_funcionario
	AS
	SELECT nome FROM funcionario

--EXCLUIR VIEW
DROP VIEW v_funcionario

--EXCLUIR INDEX
DROP INDEX index_func1 ON funcionario

--EXCLUIR PROCEDURE
DROP PROCEDURE nome_da_procedure

--EXCLUIR FUNÇÃO
DROP FUNCTION nome_da_funcao

--EXCLUIR TRIGGER 
DROP TRIGGER nome_da_trigger

--DDL TRUNCATE 
--(ELIMINA TODOS OS DADOS DE UMA TABELA)
TRUNCATE TABLE cidades

--FAZENDO BACKUP EM TABELA TEMPORARIA
use curso
SELECT * INTO #HJTEMP FROM funcionario

--FAZENDO RESTAURE DA TABELA BACKUP
INSERT INTO funcionario
SELECT * FROM #HJTEMP