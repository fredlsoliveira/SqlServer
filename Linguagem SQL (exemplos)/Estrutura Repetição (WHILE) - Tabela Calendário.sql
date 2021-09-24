/* (WHILE) ESTRUTURA DE REPETIÇÃO TABELA CALENDARIO*/
use curso

--CRIANDO A TABELA CALENDARIO
CREATE TABLE CALENDARIO
(
	id_calendario INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	data DATE NOT NULL,
	ano SMALLINT NOT NULL,
	mes SMALLINT NOT NULL,
	dia SMALLINT NOT NULL,
	dia_semana SMALLINT NOT NULL,
	dia_ano SMALLINT NOT NULL,
	ano_bissexto CHAR(1) NOT NULL,
	dia_util CHAR(1) NOT NULL,
	fim_semana CHAR(1) NOT NULL,
	feriado CHAR(1) NOT NULL,
	nome_feriado VARCHAR(30) NULL,
	nome_dia_semana VARCHAR(15) NOT NULL,
	nome_dia_semana_abrev CHAR(3) NOT NULL,
	nome_mes VARCHAR(15) NOT NULL,
	nome_mes_abrev CHAR(3) NOT NULL,
	quinzena SMALLINT NOT NULL,
	bimestre SMALLINT NOT NULL,
	trimestre SMALLINT NOT NULL,
	semestre SMALLINT NOT NULL,
	nr_semana_mes SMALLINT NOT NULL,
	nr_semana_ano SMALLINT NOT NULL,
	estacao_ano VARCHAR(15) NOT NULL,
	data_por_extenso VARCHAR(50) NOT NULL,
	evento VARCHAR(50) NULL
)

-------------------------
SELECT * FROM CALENDARIO
-------------------------


--MONTANDO ESTRUTURA PARA ALIMENTAR A TABELA CALENDÁRIO
DECLARE @dataInicial DATE,
		@dataFinal DATE,
		@data DATE,
		@ano SMALLINT,
		@mes SMALLINT,
		@dia SMALLINT,
		@diaSemana SMALLINT,		
		@diaUtil CHAR(1),
		@fimSemana CHAR(1),
		@feriado CHAR(1),
		@preFeriado CHAR(1),
		@posFeriado CHAR(1),
		@nomeFeriado VARCHAR(30),
		@nomeDiaSemana VARCHAR(15),
		@nomeDiaSemanaAbrev CHAR(3),
		@nomeMes VARCHAR(15),
		@nomeMesAbrev CHAR(3),		
		@bimestre SMALLINT,
		@trimestre SMALLINT,
		@nrSemanaMes SMALLINT,		
		@estacaoAno VARCHAR(15),
		@dataPorExtenso VARCHAR(50)
		
SET @dataInicial = '01/01/2012'
SET @dataFinal = '31/12/2030'

WHILE @dataInicial <= @dataFinal
	BEGIN 
		SET @data = @dataInicial
		SET @ano = YEAR(@data)
		SET @mes = MONTH(@data)
		SET @dia = DAY(@data)
		SET @diaSemana = DATEPART(WEEKDAY,@data)
		
		IF @diaSemana IN (1,7)
			SET @fimSemana = 'S'
		ELSE
			SET @fimSemana = 'N'
			
		/* FERIADOS LOCAIS/REGIONAIS E AQUELES QUE NÃO POSSUEM DATA FIXA
		 * (CARNAVAL, PÁSCOA E CORPUS CRISTIS) DEVEM SER ADICIONADOS AQUI*/
		IF (@mes = 1 AND @dia = 1) OR (@mes = 12 AND @dia = 31)
			SET @nomeFeriado = 'Ano Novo'
		ELSE 
		IF (@mes = 4 AND @dia = 21)
			SET @nomeFeriado = 'Tiradentes'
		ELSE 
		IF (@mes = 5 AND @dia = 1)
			SET @nomeFeriado = 'Dia do Trabalhador'
		ELSE 
		IF (@mes = 9 AND @dia = 7)
			SET @nomeFeriado = 'Independência do Brasil'
		ELSE 
		IF (@mes = 10 AND @dia = 12)
			SET @nomeFeriado = 'Nossa Senhora Aparecida'
		ELSE 
		IF (@mes = 11 AND @dia = 2)
			SET @nomeFeriado = 'Finados'
		ELSE 
		IF (@mes = 11 AND @dia = 15)
			SET @nomeFeriado = 'Proclamação da República'
		ELSE 
		IF (@mes = 12 AND @dia = 25)
			SET @nomeFeriado = 'Natal'
		ELSE 
			SET @nomeFeriado = NULL
		
			
		/* DATAS QUE SÃO FERIADOS */	
		IF 	(@mes = 1 AND @dia = 1) OR 
			(@mes = 12 AND @dia = 31) OR 
			(@mes = 4 AND @dia = 21) OR 
			(@mes = 5 AND @dia = 1) OR
			(@mes = 9 AND @dia = 7) OR 
			(@mes = 10 AND @dia = 12) OR 
			(@mes = 11 AND @dia = 2) OR 
			(@mes = 11 AND @dia = 15) OR 
			(@mes = 12 AND @dia = 25)
		 	
			SET @feriado = 'S'
		ELSE 
			SET @feriado = 'N'
			
			
		/* NOME DO MÊS COMPLETO */
		SET @nomeMes = 	CASE 
							WHEN @mes = 1 THEN 'Janeiro'
							WHEN @mes = 2 THEN 'Fevereiro'
							WHEN @mes = 3 THEN 'Março'
							WHEN @mes = 4 THEN 'Abril'
							WHEN @mes = 5 THEN 'Maio'
							WHEN @mes = 6 THEN 'Junho'
							WHEN @mes = 7 THEN 'Julho'
							WHEN @mes = 8 THEN 'Agosto'
							WHEN @mes = 9 THEN 'Setembro'
							WHEN @mes = 10 THEN 'Outubro'
							WHEN @mes = 11 THEN 'Novembro'
							WHEN @mes = 12 THEN 'Dezembro'
					   	END
		
					   
		/* NOME DO MÊS ABREVIADO */					   
		SET @nomeMesAbrev = CASE 
								WHEN @mes = 1 THEN 'Jan'
								WHEN @mes = 2 THEN 'Fev'
								WHEN @mes = 3 THEN 'Mar'
								WHEN @mes = 4 THEN 'Abr'
								WHEN @mes = 5 THEN 'Mai'
								WHEN @mes = 6 THEN 'Jun'
								WHEN @mes = 7 THEN 'Jul'
								WHEN @mes = 8 THEN 'Ago'
								WHEN @mes = 9 THEN 'Set'
								WHEN @mes = 10 THEN 'Out'
								WHEN @mes = 11 THEN 'Nov'
								WHEN @mes = 12 THEN 'Dez'
					   		END
		
					   		
		/* VERIFICANDO SE É DIA UTIL */
		IF (@fimSemana = 'S') OR (@feriado = 'S')
			SET @diaUtil = 'N'
		ELSE 
			SET @diaUtil = 'S'
		
			
		/* VERIFICANDO NOME COMPLETO DIA DA SEMANA */
		SET @nomeDiaSemana = CASE 
								WHEN @diaSemana = 1 THEN 'Domingo'
								WHEN @diaSemana = 2 THEN 'Segunda-feira'
								WHEN @diaSemana = 3 THEN 'Terça-feira'
								WHEN @diaSemana = 4 THEN 'Quarta-feira'
								WHEN @diaSemana = 5 THEN 'Quinta-feira'
								WHEN @diaSemana = 6 THEN 'Sexta-feira'
								ELSE 'Sábado'
							 END 
		
		
		/* VERIFICANDO NOME ABREVIADO DIA DA SEMANA */
		SET @nomeDiaSemanaAbrev = 	CASE 
										WHEN @diaSemana = 1 THEN 'Dom'
										WHEN @diaSemana = 2 THEN 'Seg'
										WHEN @diaSemana = 3 THEN 'Ter'
										WHEN @diaSemana = 4 THEN 'Qua'
										WHEN @diaSemana = 5 THEN 'Qui'
										WHEN @diaSemana = 6 THEN 'Sex'
										ELSE 'Sáb'
							 	  	END
						
		
		/* VERIFICANDO BIMESTRE */
		SET @bimestre =	CASE 
							WHEN @mes IN (1,2) THEN 1
							WHEN @mes IN (3,4) THEN 2
							WHEN @mes IN (5,6) THEN 3
							WHEN @mes IN (7,8) THEN 4
							WHEN @mes IN (9,10) THEN 5
							ELSE 6
						END
		
						
		/* VERIFICANDO TRIMESTRE */
		SET @trimestre=	CASE 
							WHEN @mes IN (1,2,3) THEN 1
							WHEN @mes IN (4,5,6) THEN 3
							WHEN @mes IN (7,8,9) THEN 4
							ELSE 4
						END
			
			
		/* VERIFICANDO NÚMERO DA SEMANA DO MÊS */
		SET @nrSemanaMes =	CASE 
								WHEN @dia < 8 THEN 1
								WHEN @dia < 15 THEN 2
								WHEN @dia < 22 THEN 3
								WHEN @dia < 29 THEN 4
								ELSE 5
							END	
			
		
		/* VERIFICANDO ESTAÇÃO DO ANO */					
		IF (@data BETWEEN CAST('23/09/'+CONVERT(CHAR(4),@ano) AS DATE) AND CAST('20/12/'+CONVERT(CHAR(4),@ano) AS DATE))
			SET @estacaoAno = 'Primavera'
		ELSE 
		IF (@data BETWEEN CAST('21/03/'+CONVERT(CHAR(4),@ano) AS DATE) AND CAST('20/06/'+CONVERT(CHAR(4),@ano) AS DATE))
			SET @estacaoAno = 'Outono'
		ELSE 
		IF (@data BETWEEN CAST('21/06/'+CONVERT(CHAR(4),@ano) AS DATE) AND CAST('22/09/'+CONVERT(CHAR(4),@ano) AS DATE))
			SET @estacaoAno = 'Inverno'
		ELSE 
			SET @estacaoAno = 'Verão'
							
			
		/* ALIMENTANDO A TABELA CALENDÁRIO */
		INSERT INTO CALENDARIO
			SELECT	@data,
					@ano,
					@mes,
					@dia,
					@diaSemana,
					DATEPART(DAYOFYEAR,@data), --dia do ano
					CASE WHEN (@ano % 4) = 0 THEN 'S' ELSE 'N' END, --ano bissexto
					@diaUtil,
					@fimSemana,
					@feriado,
					@nomeFeriado,
					@nomeDiaSemana,
					@nomeDiaSemanaAbrev,
					@nomeMes,
					@nomeMesAbrev,
					CASE WHEN @dia < 16 THEN 1 ELSE 2 END, --quinzena
					@bimestre,
					@trimestre,
					CASE WHEN @mes < 7 THEN 1 ELSE 2 END, --semestre
					@nrSemanaMes,
					DATEPART(wk,@data), --nr semana ano
					@estacaoAno,
					LOWER(@nomeDiaSemana + ', ' + CAST(@dia AS VARCHAR) + ' de ' + @nomeMes + ' de ' + CAST(@ano AS VARCHAR)), --data por extenso
					null		
										
					
	  SET @dataInicial = DATEADD(DAY,1,@dataInicial)			
	END





