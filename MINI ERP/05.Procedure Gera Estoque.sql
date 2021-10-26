
--EXEC PROC_GERA_ESTOQUE  'E',4,'ABF',50,'2017-01-31'
--EXEC PROC_GERA_ESTOQUE  'S',4,'ABF',15,'2017-01-31'
--EXEC PROC_GERA_ESTOQUE  'S',4,'ABF',5,'2017-01-31'
--EXEC PROC_GERA_ESTOQUE  'E',4,'ABF',50,'2017-01-31'
--drop PROCEDURE Atualiza_estoque
--Ajuste realizado na linha 49 --trocar tabela ESTOQUE_MOV POR ESTOQUE_LOTE
CREATE PROCEDURE PROC_GERA_ESTOQUE (@TIPO_MOV VARCHAR(1), --E ENTRADA, S-SAIDA
                                   @COD_MAT INT, 
                                   @LOTE VARCHAR(15), 
                                   @QTD_MOV DECIMAL(10, 2),
								   @DATA_MOVTO DATE) 
AS 
 BEGIN 
    SET NOCOUNT ON 
	DECLARE @ErrorState INT;

    BEGIN TRANSACTION 
	-- VERIFICANDO SE MATERIAL EXISTE
	IF (SELECT COUNT(*) from MATERIAL WHERE  COD_MATERIAL=@COD_MAT )=0
		BEGIN
		RAISERROR ('MATERIAL NAO EXISTE', -- Message text.  
                    10, -- Severity.  
                    1 -- State.  
                   ); 
		SET @ErrorState=2
		END 
		ELSE
		BEGIN
			IF (@tipo_mov <> 'S' AND @tipo_mov <> 'E' )
				BEGIN
					SET @ErrorState=3
				END 
			--SE MATERIA SAIDA
			ELSE IF ( @tipo_mov = 'S' ) 
				BEGIN 
				--SE SALDO<QTD MOV OR
				--SE SALDO LOTE< QTD MOV
				--SE REGISTRO NAO EXISTE NEM ESTOQUE NEM ESTOQUE LOTE
				--ATRIBUI ERROR =1  
					IF ( (SELECT TOP 1 QTD_SALDO 
					FROM   ESTOQUE 
					WHERE  @COD_MAT = COD_MATERIAL) < @QTD_MOV 
					OR (SELECT TOP 1 QTD_LOTE
						FROM   ESTOQUE_LOTE 
						WHERE  @COD_MAT = COD_MATERIAL 
							   AND LOTE = @LOTE) < @QTD_MOV 
					OR (SELECT Count(*) 
						FROM   ESTOQUE 
						WHERE  @COD_MAT = COD_MATERIAL) = 0 
					OR (SELECT Count(*) 
						FROM   ESTOQUE_LOTE 
						WHERE  @COD_MAT = COD_MATERIAL 
							   AND LOTE = @LOTE) = 0 ) 
						BEGIN 
							SET @ErrorState=1
						END 
					ELSE 
				   BEGIN 
				   --ATUALIZA ESTOQUE
					UPDATE ESTOQUE 
					SET    QTD_SALDO = QTD_SALDO - @QTD_MOV 
					WHERE  @COD_MAT = COD_MATERIAL
					--ATUALIZA ESTOQUE_LOTE
					UPDATE ESTOQUE_LOTE 
					SET    QTD_LOTE = QTD_LOTE - @QTD_MOV 
					WHERE  @COD_MAT = COD_MATERIAL 
						   AND LOTE = @LOTE 
                    --INSERT DE MOVIMENTACAO
					INSERT ESTOQUE_MOVIMENTACAO
					VALUES (@TIPO_MOV, 
							@COD_MAT, 
							@LOTE, 
							@QTD_MOV,
							@DATA_MOVTO, 
							Getdate(),
							SYSTEM_USER)
                        

                PRINT 'Baixa Realizada' 
            END 
      END 

    IF ( @TIPO_MOV = 'E' ) 
      BEGIN 
	      --SE EXISTE MATERIAL ESTOQUE ATUALIZA SALDO
          IF (SELECT Count(*) 
              FROM   ESTOQUE 
              WHERE  COD_MATERIAL = @COD_MAT) > 0 
            BEGIN 
                UPDATE ESTOQUE 
                SET    QTD_SALDO = QTD_SALDO + @QTD_MOV
                WHERE  COD_MATERIAL = @COD_MAT

                PRINT 'tem estoque faz update' 
            END 
          ELSE 
		    --SENAO REALIZA INSERT
            BEGIN 
                INSERT INTO ESTOQUE 
                VALUES      (@COD_MAT, 
                             @QTD_MOV) 

                PRINT 'insert estoque' 
            END 
          --SE EXISTE MATERIAL ESTOQUE_LOTE ATUALIZA SALDO
          IF (SELECT Count(*) 
              FROM   ESTOQUE_LOTE 
              WHERE  COD_MATERIAL = @COD_MAT
                     AND LOTE = @LOTE) > 0 
            BEGIN 
                UPDATE ESTOQUE_LOTE 
                SET    QTD_LOTE = QTD_LOTE + @QTD_MOV
                WHERE  COD_MATERIAL = @COD_MAT 
                       AND LOTE = @LOTE

                PRINT 'tem estoque_lote faz update' 
            END 
          ELSE 
		  -- SENAO FAZ INSERT
            BEGIN 
                INSERT INTO ESTOQUE_LOTE 
                VALUES      (@COD_MAT, 
                             @LOTE, 
                             @QTD_MOV) 

                PRINT 'insert estoque_lote' 
            END 
          --INSERE MOVIMENTACAO 
          INSERT ESTOQUE_MOVIMENTACAO 
          VALUES (@TIPO_MOV, 
                  @COD_MAT, 
                  @LOTE, 
                  @QTD_MOV,
				  @DATA_MOVTO,  
                  Getdate(),
				  SYSTEM_USER); 
		 PRINT 'insert Mov_estoque' 
      END 
END
 --VALIDACOES FINAIS
	IF @@ERROR <> 0 
		BEGIN
		  ROLLBACK
		  PRINT @@error
		  PRINT 'OPERACAO CANCELADA' 
		END
	ELSE IF @ErrorState=1
		BEGIN
		 ROLLBACK
		 RAISERROR ('Estoque Negativo', -- Message text.  
                      10, -- Severity.  
                      1 -- State.  
                      ); 
		  PRINT 'Operacao Cancelada Rollback'	
        END
	ELSE IF @ErrorState=2
		BEGIN
		 ROLLBACK
		 RAISERROR ('Material nao existe', -- Message text.  
                      10, -- Severity.  
                      1 -- State.  
                      ); 
		  PRINT 'Operacao Cancelada Rollback'	
        END
	ELSE IF @ErrorState=3
		BEGIN
		 ROLLBACK
		 RAISERROR ('OPERACAO NAO PERMITIDA', -- Message text.  
                      10, -- Severity.  
                      1 -- State.  
                      ); 
		  PRINT 'Operacao Cancelada Rollback'	
        END
	ELSE
		BEGIN
			COMMIT
		    PRINT 'Operacao Concluida com Sucesso'
		END 
 END   