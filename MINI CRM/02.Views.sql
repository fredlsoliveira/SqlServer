--VIEW CANAL DE VENDAS

CREATE VIEW V_CRM_CANAL_VENDAS
AS
SELECT * FROM MINIERP.DBO.V_CANAL_VENDAS

GO

--VIEW CONTAS A PAGAR
CREATE VIEW V_CRM_CONTAS_RECEBER
AS
SELECT * FROM MINIERP.DBO.V_CONTAS_RECEBER

GO

--VIEW PEDIDO  VENDAS DETALHE
CREATE VIEW V_CRM_PED_VENDAS_DETALHE
AS
SELECT A.NUM_PEDIDO,A.DATA_PEDIDO,
       A.COD_CLIENTE,B.RAZAO_SOCIAL,
 A.TOTAL_PED,A.SITUACAO,
CASE WHEN A.SITUACAO='F' THEN 'FATURADO'
     WHEN A.SITUACAO='P' THEN 'PLANEJADO'
	 END SITUA
 FROM MINIERP.DBO.PEDIDO_VENDA A
 INNER JOIN MINIERP.DBO.CLIENTE B
 ON A.COD_CLIENTE=B.COD_CLIENTE

GO

--VIEW FATURAMENTO DETALHE
CREATE VIEW V_CRM_FAT_DETALHE
AS
SELECT * FROM MINIERP.DBO.V_FATURAMENTO

GO

---VIEW FATURAMENTO RESUMO
CREATE VIEW V_CRM_FAT_RESUMO
AS
SELECT A.COD_CLIFOR,A.RAZAO_SOCIAL,
       MONTH(A.DATA_EMISSAO) MES,
       YEAR(A.DATA_EMISSAO) ANO,
	   SUM(A.TOTAL) TOTAL
	   FROM MINIERP.DBO.V_FATURAMENTO A
	   GROUP BY A.COD_CLIFOR,A.RAZAO_SOCIAL,MONTH(A.DATA_EMISSAO),YEAR(A.DATA_EMISSAO)

GO

--CRIACAO DE VIEW META X REALIZADO 2017
--VERIFICANDO TABELAS DE METAS
-- SELECT * FROM MINIERP.DBO.META_VENDAS A
 --ATUALIZANDO VALORES
--UPDATE MINIERP.DBO.META_VENDA  SET VALOR=VALOR*10000

--SELECT * FROM V_CRM_CANAL_VENDAS

CREATE VIEW V_CRM_META_2017
AS
SELECT A.COD_VENDEDOR,
       B.NOME_VEND,
	   A.ANO,
	   A.MES,
	   A.VALOR META,
	   SUM(ISNULL(C.TOTAL,0))REALIZ,
       CAST(100/A.VALOR*SUM(ISNULL(C.TOTAL,0)) AS DECIMAL(10,2))PCT
  FROM MINIERP.DBO.META_VENDA A
  LEFT JOIN V_CRM_CANAL_VENDAS B
  ON A.COD_VENDEDOR=B.ID_VEND
  LEFT JOIN  V_CRM_FAT_RESUMO C
  ON B.COD_CLIENTE=C.COD_CLIFOR
  AND A.MES=C.MES
  AND A.ANO=C.ANO
  WHERE A.ANO=2017
  GROUP BY  A.COD_VENDEDOR,
       B.NOME_VEND,
	   A.ANO,
	   A.MES,
	   A.VALOR,
	   100/A.VALOR