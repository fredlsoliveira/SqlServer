use curso
/*******************************ALUNO*******************************/
--CRIANDO TABELA ALUNO PARA TESTES
CREATE TABLE aluno
(
	id_aluno	INT IDENTITY(1,1),
	nome		VARCHAR(50) NOT NULL
)
--CRIANDO CHAVE PRIMARIA TABELA ALUNO
ALTER TABLE aluno ADD CONSTRAINT PK1 PRIMARY KEY (id_aluno)

--INSERINDO REGISTRO
INSERT INTO aluno(nome) VALUES ('Ana'),('Maria'),('Pedro'),('Carlos'),('Leonardo')

/*****************************DISCIPLINA*****************************/
--CRIANDO TABELA DISCIPLINA PARA TESTE
CREATE TABLE disciplina
(
	id_disciplina	INT IDENTITY(1,1),
	nome_disc		VARCHAR(50)		
)
--CRIANDO CHAVE PRIMARIA DISCIPLINA
ALTER TABLE disciplina ADD CONSTRAINT PK2 PRIMARY KEY (id_disciplina)

--INSERINDO REGISTRO
INSERT INTO disciplina(nome_disc) VALUES ('Fisica'),('Quimica'),('Matematica'),('Ingles')

/*****************************MATRICULA*****************************/
--CRIANDO TABELA MATRICULA PARA TESTE
CREATE TABLE matricula
(
	id_aluno		INT,
	id_disciplina	INT,
	periodo			VARCHAR(20)
)
-- ALTERANDO OS CAMPOS IDs TABELA MATRICULA P/ NÃO NULO
ALTER TABLE matricula ALTER COLUMN id_aluno INT NOT NULL
ALTER TABLE matricula ALTER COLUMN id_disciplina INT NOT NULL

--CRIANDO CHAVE COMPOSTA TABELA MATRICULA
ALTER TABLE matricula ADD CONSTRAINT PK_1 PRIMARY KEY (id_aluno,id_disciplina)

--ADICIONANDO CHAVE ESTRANGEIRA NA TABELA MATRICULA (ID ALUNO, ID DISCIPLINA)
ALTER TABLE matricula ADD CONSTRAINT FK_MAT1 FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno)
ALTER TABLE matricula ADD CONSTRAINT FK_MAT2 FOREIGN KEY (id_disciplina) REFERENCES disciplina(id_disciplina)

--INSERINDO REGISTRO
INSERT INTO matricula VALUES ('1','1','Manha')
INSERT INTO matricula VALUES ('1','2','Tarde')
INSERT INTO matricula VALUES ('2','1','Manha')
INSERT INTO matricula VALUES ('2','2','Manha')
INSERT INTO matricula VALUES ('2','3','Tarde')
INSERT INTO matricula VALUES ('3','1','Manha')
INSERT INTO matricula VALUES ('3','2','Tarde')
INSERT INTO matricula VALUES ('3','3','Tarde')
INSERT INTO matricula VALUES ('4','2','Tarde')

/**************************************************************************************************************/