use curso

--CONHECENDO AS TABELAS
SELECT * FROM cidades
SELECT * FROM senso_2013
SELECT * FROM uf
SELECT * FROM regiao_uf

/*********************************************************/
--(AVG) MEDIA DOS VALORES DE UM GRUPO (SEM NULO)
SELECT AVG(populacao) FROM cidades

--(AVG) MEDIA POR ESTADO
SELECT UF, AVG(populacao) AS MediaPopulacao 
FROM cidades
GROUP BY UF
ORDER BY 2

--(AVG) MEDIA POR REGIAO
SELECT r.regiao, AVG(c.populacao) AS MediaPopulacao
FROM cidades c 
INNER JOIN regiao_uf r	ON c.cod_uf = r.regiao
GROUP BY r.regiao
ORDER BY 2


/*********************************************************/
--(MIN) RETORNA VALOR MINIMO NA EXPRESSAO
SELECT MIN(populacao) AS MenorPopulacao
FROM cidades

--(MIN) RETORNAR MENOR POPULACAO POR ESTADO
SELECT c.uf, MIN(populacao) AS MenorPopulacao
FROM cidades c
GROUP BY c.uf
ORDER BY 2

--(MIN) RETORNAR MENOR POPULACAO POR REGIAO
SELECT r.regiao, MIN(populacao) AS MenorPopulacao
FROM cidades c
INNER JOIN regiao_uf r ON c.cod_uf = r.regiao
GROUP BY r.regiao
ORDER BY 2


/*********************************************************/
--(MAX) RETORNA VALOR MINIMO NA EXPRESSAO
SELECT MAX(populacao) AS MenorPopulacao
FROM cidades

--(MAX) RETORNAR MENOR POPULACAO POR ESTADO
SELECT c.uf, MAX(populacao) AS MenorPopulacao
FROM cidades c
GROUP BY c.uf
ORDER BY 2

--(MAX) RETORNAR MENOR POPULACAO POR REGIAO
SELECT r.regiao, MAX(populacao) AS MenorPopulacao
FROM cidades c
INNER JOIN regiao_uf r ON c.cod_uf = r.regiao
GROUP BY r.regiao
ORDER BY 2


/*********************************************************/
--(SUM) RETORNA SOMA VALORES NA EXPRESSAO
SELECT SUM(populacao) FROM cidades

--(SUM) RETORNAR SOMA POPULACAO POR ESTADO
SELECT uf, SUM(populacao) FROM cidades
GROUP BY uf
ORDER BY 2

--(SUM) RETORNAR SOMA POPULACAO POR REGIAO
SELECT r.regiao, SUM(populacao) AS MenorPopulacao
FROM cidades c
INNER JOIN regiao_uf r ON c.cod_uf = r.regiao
GROUP BY r.regiao
ORDER BY 2


/*********************************************************/
--(COUNT) RETORNA QUANTIDADE REGISTRO NA TABELA
SELECT COUNT(*) FROM cidades

--(COUNT) RETORNA QUANTIDADE REGISTRO DISTINTOS NA TABELA
SELECT COUNT(distinct uf) FROM cidades

--(COUNT) RETORNAR QUANTIDADE POPULACAO POR ESTADO
SELECT uf, COUNT(*) FROM cidades
GROUP BY uf
ORDER BY 2

--(COUNT) RETORNAR QUANTIDADE POPULACAO POR REGIAO
SELECT r.regiao, COUNT(*) AS MenorPopulacao
FROM cidades c
INNER JOIN regiao_uf r ON c.cod_uf = r.regiao
GROUP BY r.regiao
ORDER BY 2


/*********************************************************/
/*********************************************************/
--AVG | MIN | MAX | SUM | COUNT
SELECT	AVG(populacao)	AS MediaPopulacao, 
		MIN(populacao)	AS MinimoPopulacao, 
		MAX(populacao)	AS MaximoPopulacao, 
		SUM(populacao)	AS SomaPopulacao, 
		COUNT(*)		AS QtdePopulacao 
FROM cidades

--AVG | MIN | MAX | SUM | COUNT - POR ESTADO
SELECT	uf,
		AVG(populacao)	AS MediaPopulacao, 
		MIN(populacao)	AS MinimoPopulacao, 
		MAX(populacao)	AS MaximoPopulacao, 
		SUM(populacao)	AS SomaPopulacao, 
		COUNT(*)		AS QtdePopulacao 
FROM cidades
GROUP BY uf
ORDER BY 2

--AVG | MIN | MAX | SUM | COUNT - POR REGIAO
SELECT	r.regiao, 
		AVG(populacao)	AS MediaPopulacao, 
		MIN(populacao)	AS MinimoPopulacao, 
		MAX(populacao)	AS MaximoPopulacao, 
		SUM(populacao)	AS SomaPopulacao, 
		COUNT(*)		AS QtdePopulacao 
FROM cidades c
INNER JOIN regiao_uf r ON c.cod_uf = r.regiao
GROUP BY r.regiao
ORDER BY 2