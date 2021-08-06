use curso

--INNER JOIN
SELECT a.nome, d.nome_disc, m.periodo
FROM aluno a
INNER JOIN matricula m	ON a.id_aluno = m.id_aluno
INNER JOIN disciplina d ON m.id_disciplina = d.id_disciplina

--LEFT JOIN
SELECT a.nome, d.nome_disc, m.periodo
FROM aluno a
LEFT JOIN matricula m	ON a.id_aluno = m.id_aluno
LEFT JOIN disciplina d	ON m.id_disciplina = d.id_disciplina

--RIGHT JOIN
SELECT a.nome, d.nome_disc, m.periodo
FROM aluno a
RIGHT JOIN matricula m	ON a.id_aluno = m.id_aluno
RIGHT JOIN disciplina d	ON m.id_disciplina = d.id_disciplina

--FULL JOIN
SELECT a.nome, d.nome_disc, m.periodo
FROM aluno a
FULL JOIN matricula m	ON a.id_aluno = m.id_aluno
FULL JOIN disciplina d	ON m.id_disciplina = d.id_disciplina