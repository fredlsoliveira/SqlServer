/* MOSTRA DETALHES DO ARQUIVO A SER RESTAURADO */
RESTORE FILELISTONLY FROM DISK = N'/home/fredoliveira/Documentos/curso_bk1.bak'

/* RESTAURANDO O BACKUP */
RESTORE DATABASE curso
FROM DISK = N'/home/fredoliveira/Documentos/curso_bk1.bak'
WITH MOVE 'curso' TO '/var/opt/mssql/data/curso.mdf',
MOVE 'curso_log' TO '/var/opt/mssql/data/curso_log.ldf'