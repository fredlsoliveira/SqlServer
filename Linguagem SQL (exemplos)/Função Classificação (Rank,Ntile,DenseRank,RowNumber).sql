use curso

/* (RANK) RETORNA A CLASSIFICACAO EM VALOR DE ACORDO COM EXPRESSAO */ 
SELECT RANK() OVER (ORDER BY estado ASC) AS RankUf,
	estado
FROM uf

SELECT RANK() OVER (ORDER BY regiao ASC) AS RankUf,
	regiao,
	estado
FROM regiao_uf

/* (NTILE) RETORNA A CLASSIFICACAO EM CIMA DO VALOR DE AGRUPAMENTO ESPECIFICADO NA EXPRESSAO */
SELECT NTILE(10) OVER (ORDER BY regiao ASC) AS NtileUf,
	regiao,
	estado
FROM regiao_uf

/* (DENSE_RANK) RETORNA A CLASSIFICACAO EM CIMA DE UM GRUPO ESPECIFICADO NA EXPRESSAO */
SELECT DENSE_RANK() OVER (ORDER BY regiao ASC) AS DenseRankUf,
	regiao,
	estado
FROM regiao_uf

/* (ROW_NUMBER) RETORNA A CLASSIFICACAO POR LINHA */
SELECT ROW_NUMBER() OVER (ORDER BY regiao ASC) AS RowNuberUf,
	regiao,
	estado
FROM regiao_uf

/* RANK | NTILE | DENSE_RANK | ROW_NUMBER */
SELECT RANK() OVER (ORDER BY regiao ASC) AS RankUf,
	NTILE(10) OVER (ORDER BY regiao ASC) AS NtileUf,
	DENSE_RANK() OVER (ORDER BY regiao ASC) AS DenseRankUf,
	ROW_NUMBER() OVER (ORDER BY regiao ASC) AS RowNuberUf,
	regiao,
	estado
FROM regiao_uf
ORDER BY 5,6

/**** AREA DE EXEMPLO ****/

CREATE TABLE campeaonato
(
	nomeTime VARCHAR(30) NOT NULL,
	pontos INT NOT NULL 
)

INSERT INTO campeaonato(nomeTime,pontos) VALUES ('CENTRAL',15)
INSERT INTO campeaonato(nomeTime,pontos) VALUES ('SPORT',25)
INSERT INTO campeaonato(nomeTime,pontos) VALUES ('NAUTICO',28)
INSERT INTO campeaonato(nomeTime,pontos) VALUES ('IBIS',11)
INSERT INTO campeaonato(nomeTime,pontos) VALUES ('SANTA CRUZ',30)
INSERT INTO campeaonato(nomeTime,pontos) VALUES ('SALGUEIRO',25)

SELECT RANK() OVER (ORDER BY pontos DESC) AS Class,
	nomeTime,
	pontos 
FROM campeaonato