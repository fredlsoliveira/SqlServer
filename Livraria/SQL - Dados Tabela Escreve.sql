SELECT * FROM escreve

INSERT INTO escreve VALUES (1,1)
INSERT INTO escreve VALUES (2,2)
INSERT INTO escreve VALUES (3,3)
INSERT INTO escreve VALUES (4,4)
INSERT INTO escreve VALUES (5,5)
INSERT INTO escreve VALUES (6,6)
INSERT INTO escreve VALUES (7,7)
INSERT INTO escreve VALUES (8,8)
INSERT INTO escreve VALUES (9,9)
INSERT INTO escreve VALUES (10,10)
INSERT INTO escreve VALUES (11,11)
INSERT INTO escreve VALUES (12,12)
INSERT INTO escreve VALUES (13,13)
INSERT INTO escreve VALUES (14,14)
INSERT INTO escreve VALUES (15,15)
INSERT INTO escreve VALUES (16,16)
INSERT INTO escreve VALUES (17,17)
INSERT INTO escreve VALUES (18,18)
INSERT INTO escreve VALUES (19,19)


SELECT l.titulo AS Titulo, 
	a.nome		AS Autor, 
	g.descricao AS Genero, 
	l.idLivro	AS [Codigo do Livro]
FROM livro l
INNER JOIN escreve e ON e.idLivro = l.idLivro
INNER JOIN autor   a ON a.idAutor = e.idAutor
INNER JOIN genero  g ON g.idGenero = l.idGenero
ORDER BY l.titulo