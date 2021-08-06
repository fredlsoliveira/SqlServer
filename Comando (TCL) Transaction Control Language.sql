--CRIANDO TABELA PARA EXEMPLO
use curso
CREATE TABLE cadastro
(
    nome    VARCHAR(50) NOT NULL,
    docto   VARCHAR(50) NOT NULL
)

--INICIA TRANSAÇÃO
BEGIN TRANSACTION

--INSERIR REGISTRO
INSERT INTO cadastro (nome,docto) VALUES ('Romario','123')
INSERT INTO cadastro (nome,docto) VALUES ('Maria', '456')
INSERT INTO cadastro (nome,docto) VALUES ('João', '789')

--LISTAR REGISTROS INSERIDOS
SELECT * FROM cadastro

--RETORNANDO A TABELA AO ESTADO ANTERIOR DO BEGIN TRANSACTION
ROLLBACK

--EFETIVA AS INFORMAÇÕES NA TABELA DO BANCO DE DADOS
COMMIT TRANSACTION

-- ******* USANDO PONTOS DE RECUPERAÇÃO *******

--INICIA TRANSAÇÃO
BEGIN TRANSACTION

--INSERINDO 1° REGISTRO
INSERT INTO cadastro (nome,docto) VALUES ('Karla','987')

--CRIANDO 1° PONTO DE RECUPERAÇÃO
SAVE TRANSACTION A1

--INSERINDO 2° REGISTRO
INSERT INTO cadastro(nome,docto) VALUES ('Francisco','654')

--CRIANDO 2° PONTO DE RECUPERAÇÃO
SAVE TRANSACTION A2

--RECUPERANDO ATE O PONTO A1
ROLLBACK TRANSACTION A1

--EFETIVA AS INFORMAÇÕES NA TABELA DO BANCO DE DADOS
COMMIT TRANSACTION