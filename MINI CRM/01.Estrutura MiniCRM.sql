-- MINI CRM --
CREATE DATABASE MiniCRM

-- TABELA USUARIO
CREATE TABLE USUARIO
(
	LOGIN VARCHAR(30) NOT NULL,
	MATRICULA INT NOT NULL,
	SENHA VARCHAR(32) NOT NULL,
	SITUACAO CHAR(1) NOT NULL, --A=ATIVO -B BLOQUEADO
	TIPO VARCHAR(20),
	CONSTRAINT PK_US1 PRIMARY KEY (LOGIN)
)


-- TABELA AGENDA
CREATE TABLE AGENDA
(
	ID_AGENDA INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	MATRICULA INT NOT NULL,
	ID_CLIENTE INT NOT NULL,
	DATA_VISITA DATE,
	HORA_VISITA_DE TIME,
	HORA_VISITA_ATE TIME,
	SITUACAO CHAR(1) NOT NULL, --P-PLANEJADA R-REALIZADA -C-CANCELADA
	OBS VARCHAR(255),
	DATA_LOG DATETIME NOT NULL
)


-- TABELA FOLLOW UP AGENDA
CREATE TABLE FOLLOW_UP_AGENDA
(
	ID_AGENDA INT NOT NULL,
	GEROU_VENDA CHAR(1)NOT NULL, --S/N
	OBS_POS_VISITA VARCHAR(255) NOT NULL,
	CONSTRAINT FK_FUP1 FOREIGN KEY (ID_AGENDA) REFERENCES AGENDA(ID_AGENDA)
)