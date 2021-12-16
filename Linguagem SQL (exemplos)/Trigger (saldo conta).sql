--DROP TABLE conta_corrente
create table conta_corrente
( conta_c varchar(20) not null,
  valor   decimal(10,2) not null,
  operacao char(1) not null
  )
--drop table saldo_conta
  create table saldo_conta
  (conta_c varchar(20) not null,
   saldo   decimal(10,2) not null
  )

  

CREATE TRIGGER tgr_atualiza_saldo_cc 
ON conta_corrente 
FOR INSERT 
AS 
  BEGIN 
      DECLARE @CONTA_C VARCHAR(20), 
              @VALOR   DECIMAL(10, 2), 
              @OPER    CHAR(1) 

      SELECT @CONTA_C = I.conta_c, 
             @VALOR = I.valor, 
             @OPER = I.operacao 
      FROM   inserted I 
	  /* D=debito C=credito*/
      IF @OPER NOT IN ( 'D', 'C' ) 
        BEGIN 
            PRINT 'OPERACAO NAO PERMITIDA' 

            ROLLBACK TRANSACTION 
        END 
      ELSE IF (SELECT Count(*) 
          FROM   saldo_conta 
          WHERE  conta_c = @conta_c) = 0 
         AND @OPER = 'D' 
        BEGIN 
            INSERT INTO saldo_conta 
            VALUES      (@CONTA_C, 
                         @VALOR *- 1) 
        END 
      ELSE IF (SELECT Count(*) 
          FROM   saldo_conta 
          WHERE  conta_c = @conta_c) = 0 
         AND @OPER = 'C' 
        BEGIN 
            INSERT INTO saldo_conta 
            VALUES      (@CONTA_C, 
                         @VALOR) 
        END 
      ELSE IF (SELECT Count(*) 
          FROM   saldo_conta 
          WHERE  conta_c = @conta_c) > 0 
         AND @OPER = 'C' 
        BEGIN 
            UPDATE saldo_conta 
            SET    saldo = saldo + @VALOR 
            WHERE  conta_c = @CONTA_C 
        END 
      ELSE IF (SELECT Count(*) 
          FROM   saldo_conta 
          WHERE  conta_c = @conta_c) > 0 
         AND @OPER = 'D' 
        BEGIN 
            UPDATE saldo_conta 
            SET    saldo = saldo - @VALOR 
            WHERE  conta_c = @CONTA_C 
        END 
  END 

 

--testando trigger
--PARAMETROS   CONTA CORRENTE, VALOR , OPERACAO

insert into conta_corrente values (123478,1500,'X')
insert into conta_corrente values (123479,2000,'Y')

insert into conta_corrente values (123478,3000,'D')--TESTADO
insert into conta_corrente values (123478,3000,'C')--TESTADO
insert into conta_corrente values (123478,1500,'C')--TESTADO

insert into conta_corrente values (123479,3000,'C')
insert into conta_corrente values (123479,2000,'D')




select * from conta_corrente
select * from saldo_conta
/*
delete from conta_corrente
delete from  saldo_conta
*/