--SELECT * FROM CONTAS_PAGAR
--SELECT * FROM CONTAS_RECEBER
--PROCEDURE INTEGRA CAP E CRE
--ORIGEM NOTA_FISCAL ENTRADA SAIDA
--SE SAIDA DESTINO CONTAS A RECEBER
--SE ENTRADA DESTINO CONTAS A PAGAR
--SEM PARAMETROS EXTERNOS, APENAS INTERNOS

--EXEC PROC_INTEGR_FIN
CREATE PROCEDURE PROC_INTEGR_FIN 
AS 
    SET NOCOUNT ON 
	SET IMPLICIT_TRANSACTIONS OFF
DECLARE @TIP_NF CHAR(1),
        @NUM_NF INT,
		@ID_CLIFOR DECIMAL(10,2),
		@COD_PAGTO INT,
		@DATA_EMISSAO DATE,
		@VENCIMENTO DATE,
		@TOTAL_NF DECIMAL(10,2),
		@VALOR_PARC DECIMAL(10,2),
		@PARC INT,
		@CONT_PARC INT,
		@ErrorState INT
BEGIN
 BEGIN TRANSACTION
--ABRINDO PRIMEIRO IF
	IF (SELECT COUNT(*) FROM NOTA_FISCAL WHERE INTEGRADA_FIN='N')=0
	BEGIN
		SET @ErrorState=1;
	END
	ELSE
	BEGIN
--DECLARANDO CURSOR CONTA PARCELAS
 DECLARE CONTPARC CURSOR FOR
 --LENDO TABELA QTD PARCELAS POR NF
 SELECT A.NUM_NF,COUNT(*) CONT_PARC
   FROM NOTA_FISCAL A
   INNER JOIN CONDICAO_PGTO_DETALHE B
     ON A.COD_PGTO=B.COD_CONDICAO_PGTO_DETALHE
   WHERE A.INTEGRADA_FIN='N'
   GROUP BY A.NUM_NF
   --ABRINDO CURSOR
   OPEN CONTPARC
   --LENDO PRIMEIRO REGISTRO
   FETCH NEXT FROM CONTPARC
   --INSERINDO VALORES NA VARIAVEL
   INTO @NUM_NF,@CONT_PARC
   -- Percorrendo linhas do cursor (enquanto houverem)
   WHILE @@FETCH_STATUS = 0
	BEGIN
   --DECLARANDO CURSOR PARA INTEGRAR PARCELAS
   DECLARE INTEGRA_FIN CURSOR FOR
   --SELECIONANDO REGISTROS
   SELECT A.TIPO_NF,A.NUM_NF,A.COD_CLIFOR,A.COD_PGTO,
		  A.DATA_EMISSAO,
		  CAST(DATEADD(dd,B.DIAS,A.DATA_EMISSAO) AS DATE)VENCIMENTO,
		  A.TOTAL_NF,
		  CAST(A.TOTAL_NF/100*B.PERCENTUAL AS DECIMAL(10,2)) VALOR_PARC,
		  B.PARCELA
   FROM NOTA_FISCAL A  
   INNER JOIN CONDICAO_PGTO_DETALHE B
     ON A.COD_PGTO=B.COD_CONDICAO_PGTO_DETALHE
   WHERE A.INTEGRADA_FIN='N'
   AND NUM_NF=@NUM_NF
   --ABRINDO CURSOR 
   OPEN INTEGRA_FIN
   --LENDO PROXIMA LINHA
   FETCH NEXT FROM INTEGRA_FIN
   --INSERINDO VALORES NA VARIAVEL
   INTO @TIP_NF,@NUM_NF,@ID_CLIFOR,@COD_PAGTO,@DATA_EMISSAO,
		@VENCIMENTO,@TOTAL_NF,@VALOR_PARC,@PARC
  -- Percorrendo linhas do cursor (enquanto NAO houverem ERROS)
  WHILE @@FETCH_STATUS = 0
	BEGIN
	--IF PARA INTEGRAR NOTAS DE VENDAS SAIDAS
	IF @TIP_NF='S'
	 BEGIN 
		INSERT INTO CONTAS_RECEBER VALUES (@ID_CLIFOR,@NUM_NF,@PARC,@VENCIMENTO,NULL,@VALOR_PARC);
		SELECT  'DOCTO  VENDAS',@NUM_NF ,'INTEGRADO COM SUCESSO ','PARCELA ',@PARC,'VALOR ', @VALOR_PARC	
	 END
	--IF PARA INTEGRAR NOTAS DE COMPRAS ENTRADASS
	ELSE IF @TIP_NF='E'
	BEGIN 
		 INSERT INTO CONTAS_PAGAR VALUES (@ID_CLIFOR,@NUM_NF,@PARC,@VENCIMENTO,NULL,@VALOR_PARC);
		 SELECT  'DOCTO  COMPRAS',@NUM_NF ,'INTEGRADO COM SUCESSO ','PARCELA ',@PARC,'VALOR ', @VALOR_PARC			
	END
    --IF PARA ATUALIZAR STATUS NA NF
	IF @CONT_PARC=@PARC
	BEGIN
	  --ATUALIZANDO STATUS DE NOTA FISCAL PARA INTEGRADA_FIN=S
	SELECT 'ATUALIZA '+CAST(@NUM_NF AS VARCHAR(100))
    UPDATE NOTA_FISCAL SET INTEGRADA_FIN='S' WHERE NUM_NF=@NUM_NF;
	END 
	--LENDO PROXIMAS LINHAS DO CURSOR
	FETCH NEXT FROM INTEGRA_FIN
    INTO @TIP_NF,@NUM_NF,@ID_CLIFOR,@COD_PAGTO,@DATA_EMISSAO,
		@VENCIMENTO,@TOTAL_NF,@VALOR_PARC,@PARC;

   END --FINAL WHILE
  
   CLOSE INTEGRA_FIN
   DEALLOCATE INTEGRA_FIN
   --LENDO PROXIMA LINHA DO CURSOR
   FETCH NEXT FROM CONTPARC
   INTO @NUM_NF,@CONT_PARC

  END --FINAL WHILE
   CLOSE CONTPARC
   DEALLOCATE CONTPARC
   
END --END DO PRIMEIRO ELSE IF

--VERIFICACOES FINAIS
   IF @@ERROR <> 0 
		BEGIN
		  ROLLBACK
		  PRINT @@error
		  PRINT 'OPERACAO CANCELADA' 
		END
	ELSE IF @ErrorState=1
	BEGIN 
	    ROLLBACK
		PRINT 'NAO A DOCUMENTOS PARA SEREM PROCESSADOS'
	END
	ELSE
		BEGIN
			COMMIT
		     PRINT 'INTEGRACAO CONCLUIDA'
		END 
END

