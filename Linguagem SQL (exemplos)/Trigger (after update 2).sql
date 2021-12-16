--multiplos registros
--DISABLE TRIGGER TG_aud_sal on salario
--ENABLE TRIGGER TG_aud_sal on salario
use curso
--drop trigger TG_aud_sal2
CREATE TRIGGER tg_aud_sal2 
ON salario 
after UPDATE 
AS 
  BEGIN 
      DECLARE @matricula_aux INT 
      DECLARE cursor_processo CURSOR FOR 
       
	    SELECT matricula  FROM   inserted /*TABELA VIRTUAL INSERT */

      OPEN cursor_processo 

      FETCH next FROM cursor_processo INTO @matricula_aux 

      WHILE @@FETCH_STATUS = 0 
        BEGIN 
            INSERT INTO auditoria_salario 
            SELECT       i.matricula, 
                         d.salario, 
                         i.salario, 
                         SYSTEM_USER, 
                         Getdate() 
            FROM   deleted d, 
                   inserted i 
            WHERE  d.matricula = i.matricula 
                   AND @matricula_aux = i.matricula 

            FETCH next FROM cursor_processo INTO @matricula_aux 
        END 

      CLOSE cursor_processo 

      DEALLOCATE cursor_processo 
  END 
/*	
    delete from auditoria_salario
	
	update salario set salario=salario*1.15
	
	select * from auditoria_salario
	select * from salario
*/

