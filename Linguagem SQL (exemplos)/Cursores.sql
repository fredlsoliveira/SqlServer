use curso

--CURSORES (EXEMPLO 1) --------------------------------------------------------------------
DECLARE @MinhaVariavel VARCHAR(100)
DECLARE meu_cursor
CURSOR LOCAL FOR SELECT nome FROM alunos
OPEN meu_cursor
FETCH NEXT FROM meu_cursor INTO @MinhaVariavel

WHILE(@@FETCH_STATUS = 0)
	BEGIN
	PRINT @MinhaVariavel+ ' FETCH_STATUS-> '+CAST(@@FETCH_STATUS AS VARCHAR(10))

	FETCH NEXT FROM meu_cursor INTO @MinhaVariavel
END

PRINT 'FETCH_STATUS-> '+CAST(@@FETCH_STATUS AS VARCHAR(10))
CLOSE meu_cursor
DEALLOCATE meu_cursor


-------------------------------------------------------------------------------------------
--CURSORES (EXEMPLO 2) --------------------------------------------------------------------

select a.BusinessEntityID codpessoa,
	    a.FirstName nome,
		a.LastName sobrenome,
		cast('' as varchar(100)) nomecompleto
      into clifor
  from AdventureWorks2017.person.person a
--verifcando dados carregado sem nome completo
select * from clifor

--Inicio cursor (Declara Variavies)
DECLARE @codpessoa   INT, 
        @primeironome VARCHAR(50), 
        @sobrenome    VARCHAR(50), 
        @nomecompleto VARCHAR(100) 
-- Cursor para percorrer os registros 
DECLARE cursor1 CURSOR FOR 
  SELECT codpessoa, 
         nome, 
         sobrenome 
  FROM   clifor 

--Abrindo Cursor 
OPEN cursor1 

-- Lendo a próxima linha 
FETCH next FROM cursor1 INTO @codpessoa, @primeironome, @sobrenome 

-- Percorrendo linhas do cursor (enquanto houverem) 
WHILE @@FETCH_STATUS = 0 
  BEGIN 
      -- Executando as rotinas desejadas manipulando o registro 
      UPDATE clifor 
      SET    nomecompleto =@primeironome+' '+@sobrenome 
      WHERE  codpessoa = @codpessoa 

      -- Lendo a próxima linha 
      FETCH next FROM cursor1 INTO @codpessoa, @primeironome, @sobrenome 
  END 

-- Fechando Cursor para leitura 
CLOSE cursor1 

-- Finalizado o cursor 
DEALLOCATE cursor1 

--verficando dados
--select * from clifor


-------------------------------------------------------------------------------------------
--CURSORES (EXEMPLO 3) --------------------------------------------------------------------

create table cli_nome
(cod_cliente int not null,
 nome_completo varchar(100) not null
 )

--CRIANDO CURSOR PARA INSERT
--DECLARANDO VARIAVEIS
    DECLARE @codcliente int, 
	        @primeironome VARCHAR(30), 
			@sobrenome VARCHAR(60), 
			@nomecompleto VARCHAR(90)
 
-- Cursor para percorrer os registros
DECLARE cursor1 CURSOR FOR
select EmployeeID, FirstName, LastName from NORTHWND.dbo.Employees
 
--Abrindo Cursor
OPEN cursor1
 
-- Lendo a próxima linha
FETCH NEXT FROM cursor1 INTO @codcliente, @primeironome, @sobrenome
 
-- Percorrendo linhas do cursor (enquanto houverem)
WHILE @@FETCH_STATUS = 0
BEGIN
 
-- Executando as rotinas desejadas manipulando o registro
--update clientes set nomecompleto = @primeironome + ' ' + @sobrenome where codcliente = @codcliente
 insert into cli_nome values (@codcliente,@primeironome + ' ' + @sobrenome)
-- Lendo a próxima linha
FETCH NEXT FROM cursor1 INTO @codcliente, @primeironome, @sobrenome
END
 
-- Fechando Cursor para leitura
CLOSE cursor1
 
-- Finalizado o cursor
DEALLOCATE cursor1

--verifindo insert 
--select * from cli_nome


-------------------------------------------------------------------------------------------
--CURSORES (EXEMPLO 4) --------------------------------------------------------------------

create table tabela_clientes(
nome_cliente varchar(200),
cpf_cliente varchar(20)
)
go
--delete from tabela_clientes
insert into tabela_clientes values
('Fabio', NULL),
('Jorge', 21325658454),
('Jack', NULL),
('Peter', 34132567878)
--go

--select * from tabela_clientes
--go

DECLARE
@nome_cliente VARCHAR(200),
@cpf_cliente VARCHAR(20)

--Declarando o cursor
DECLARE nome_do_cursor CURSOR FOR

--dados que o cursor ira trabalhar
SELECT
nome_cliente, cpf_cliente
FROM
tabela_clientes

--abre o cursor
OPEN nome_do_cursor

--posicionar o ponteiro do cursor na primeira linha do resultado do select acima
FETCH NEXT FROM nome_do_cursor

--insere nas variaveis os valores da primeira linha do resultado armazenado no cursor
INTO @nome_cliente, @cpf_cliente

--Esse parte diz "Enquanto tiver linha no cursor, faça:"
WHILE @@FETCH_STATUS = 0

--Nessa parte você insere o bloco de instruções que ira trabalhar no seu cursor.

--Se CPF for igual a nulo
BEGIN
IF (@cpf_cliente is NULL)
--Inserir no final do nome da pessoa o texto "Atualizar CPF"
	BEGIN
--UPDATE tabela_clientes SET nome_cliente = @nome_cliente + ' Atualizar CPF' where cpf_cliente is  null
	UPDATE tabela_clientes SET cpf_cliente = 'Atualizar CPF' where cpf_cliente is  null
	END
FETCH NEXT FROM nome_do_cursor
INTO @nome_cliente, @cpf_cliente
END

--Para fechar o cursos você precisar inserir os seguinte comandos
CLOSE nome_do_cursor
DEALLOCATE nome_do_cursor

--FIM


-------------------------------------------------------------------------------------------
--CURSORES (EXEMPLO 5) --------------------------------------------------------------------

create table contapagparc
(
 idcap  int ,
 dtvenc  date,
 parcela  int
 )  

select idcap,dtvenc from contapagparc
select *  from contapagparc


insert into contapagparc values ('1',getdate()+30,'')
insert into contapagparc values ('1',getdate()+45,'')
insert into contapagparc values ('1',getdate()+60,'')

insert into contapagparc values ('2',getdate()+15,'')
insert into contapagparc values ('2',getdate()+20,'')
insert into contapagparc values ('2',getdate()+25,'')

--select * from contapagparc

declare @idcap as int
declare @dtvenc as date
declare @cont as int =0
declare @idcap_aux as int

declare cursorparc cursor for
	select idcap,dtvenc from contapagparc
	order by idcap,dtvenc asc

		open cursorparc
			fetch next from cursorparc into @idcap,@dtvenc

			while @@FETCH_STATUS=0
--status fecth 
-- 0 Instrucao bem sucedida
-- 1 instrucao falhou 
-- 2 a linha buscado nao existe
			Begin
				if @idcap_aux<>@idcap 
				begin 
				set @cont=1;
				set @idcap_aux=@idcap;
				end
				else
				begin 
					set @cont=@cont+1
					set @idcap_aux=@idcap;
                end
				--atualizazao
				update contapagparc set parcela=@cont
				where idcap=@idcap
				and dtvenc=@dtvenc;
				
				            
		fetch next from cursorparc into @idcap,@dtvenc
		end
		
		close cursorparc
		deallocate cursorparc


-------------------------------------------------------------------------------------------
--CURSORES (EXEMPLO 6) --------------------------------------------------------------------

CREATE TABLE ##DADOS 
(
  NUMERO int NULL
 )
 
INSERT INTO ##DADOS VALUES (1)
INSERT INTO ##DADOS VALUES (2)
INSERT INTO ##DADOS VALUES (3)
INSERT INTO ##DADOS VALUES (4)
INSERT INTO ##DADOS VALUES (5)
INSERT INTO ##DADOS VALUES (6)
INSERT INTO ##DADOS VALUES (7)
INSERT INTO ##DADOS VALUES (8)
INSERT INTO ##DADOS VALUES (9)
INSERT INTO ##DADOS VALUES (10)

-- select * from ##DADOS
--Declarando cursor
DECLARE cDados SCROLL CURSOR FOR
SELECT NUMERO FROM ##DADOS
 
--Abre cursor
OPEN cDados;
 
--Verifica a quantidade de linhas
SELECT @@CURSOR_ROWS;
 
--Primeiro registro do cursor
FETCH ABSOLUTE 1 FROM cDados;
 
--Próximo registro
FETCH NEXT FROM cDados;
 
--Último Registro
FETCH LAST FROM cDados;
 
--Retorna a linha anterior ao registro atual do cursor
FETCH PRIOR FROM cDados;
 
--Volta para a segunha linha do cursor
FETCH ABSOLUTE 2 FROM cDados;
 
--Avança três registros em relação ao registro atual
FETCH RELATIVE 3 FROM cDados;
 
--Retrocede dois registros em relação ao registro atual
FETCH RELATIVE -2 FROM cDados;
 
CLOSE cDados;
DEALLOCATE cDados;