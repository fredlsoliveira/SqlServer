
--CRIACAO TRIGGER AUDITA SALARIO
--DROP TRIGGER TG_AUDIT_SAL 
--TRIGGER PARA AUDITAR ALTERACOES DE SALARIO

CREATE TRIGGER TG_AUDIT_SAL
ON SALARIO 
AFTER UPDATE 
AS 
  BEGIN 
      DECLARE @MATRICULA_AUX INT 
      DECLARE CURSOR_AUDITORIA CURSOR FOR 
       
	  SELECT MATRICULA  FROM   INSERTED /*TABELA VIRTUAL INSERT */

      OPEN CURSOR_AUDITORIA 

      FETCH NEXT FROM CURSOR_AUDITORIA INTO @MATRICULA_AUX 

      WHILE @@FETCH_STATUS = 0 
        BEGIN 
            INSERT INTO AUDITORIA_SALARIO 
            SELECT       i.MATRICULA, 
                         d.SALARIO, 
                         i.SALARIO, 
                         SYSTEM_USER, 
                         Getdate() 
            FROM   deleted d, 
                   inserted i 
            WHERE  d.MATRICULA = i.MATRICULA 
                   AND @MATRICULA_AUX= i.MATRICULA 

            FETCH next FROM CURSOR_AUDITORIA 
			INTO @MATRICULA_AUX 
        END 

      CLOSE CURSOR_AUDITORIA 

      DEALLOCATE CURSOR_AUDITORIA 
  END 

/*
TESTANDO
---------------------------------------------------
SELECT * FROM SALARIO

---------------------------------------------------

UPDATE SALARIO SET SALARIO = SALARIO * 1.05
WHERE MATRICULA = 12


---------------------------------------------------
SELECT * FROM AUDITORIA_SALARIO
WHERE MATRICULA = 12

*/