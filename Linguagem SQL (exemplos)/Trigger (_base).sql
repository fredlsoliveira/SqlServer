USE CURSO
--DROP TABLE FUNC
CREATE TABLE FUNC (
 MATRICULA INT IDENTITY(1,1) PRIMARY KEY,
 NOME VARCHAR(30) NOT NULL,
 SOBRENOME VARCHAR (30) NOT NULL,
 ENDERECO  VARCHAR (30) NOT NULL,
 CIDADE    VARCHAR (30) NOT NULL,
 ESTADO    VARCHAR (2) NOT NULL,
 DATA_NASC  DATETIME
 )  
insert into func values ('Steve','Morse','Rua 13','JUNDIAI','SP','1977-11-05')
insert into func values ('Joao','Pedro','Rua 14','SÃO PAULO','SP','1980-27-10')
insert into func values ('Maria','Clara','Rua 15','RIBERAO PRETO','SP','1985-05-05')
insert into func values ('Pedro','Luiz','Rua 16','CAMPINAS','SP','1990-12-09')

--SELECT * FROM FUNC
--DROP TABLE auditoria_salario
create table auditoria_salario (
matricula varchar(30) not null,
sal_antes decimal(10,2)  not null,
sal_depois decimal(10,2)  not null,
usuario varchar(20) not null,
data_atualizacao datetime not null
)

--DROP TABLE SALARIO
CREATE TABLE SALARIO 
( matricula INT NOT NULL,
  SALARIO DECIMAL(10,2) NOT NULL
  )

insert into SALARIO values (1,1000)
insert into SALARIO values (2,1500)
insert into SALARIO values (3,2000)
insert into SALARIO values (4,2500)

