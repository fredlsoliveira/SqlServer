CREATE DATABASE livraria

CREATE TABLE genero
(
	idGenero	INT PRIMARY KEY IDENTITY(1,1),
	descricao	VARCHAR(50) NOT NULL
)

CREATE TABLE livro
(
	idLivro		INT PRIMARY KEY IDENTITY(1,1),
	titulo		VARCHAR(80) NOT NULL,
	preco		DECIMAL(5,2),
	estoque		INT,
	idGenero	INT NOT NULL,
	FOREIGN KEY(idGenero) REFERENCES genero(idGenero)
)

CREATE TABLE autor
(
	idAutor INT PRIMARY KEY IDENTITY(1,1),
	nome	VARCHAR(50) NOT NULL,
	email	VARCHAR(50) NOT NULL
)

CREATE TABLE escreve
(
	idEscreve	INT PRIMARY KEY IDENTITY(1,1),
	idLivro		INT NOT NULL,
	idAutor		INT NOT NULL,
	FOREIGN KEY(idLivro) REFERENCES livro(idLivro),
	FOREIGN KEY(idAutor) REFERENCES autor(idAutor)
)

CREATE TABLE cliente
(
	idCliente	INT PRIMARY KEY IDENTITY(1,1),
	nome		VARCHAR(50) NOT NULL,
	telefone	VARCHAR(20) NOT NULL
)

CREATE TABLE venda
(
	idVenda		INT PRIMARY KEY IDENTITY(1,1),
	data		DATETIME NOT NULL,
	total		DECIMAL(10,2) NOT NULL,
	idCliente	INT NOT NULL,
	FOREIGN KEY(idCliente) REFERENCES cliente(idCliente)
)

CREATE TABLE venda_item
(
	idVendaItem	INT PRIMARY KEY IDENTITY(1,1),	
	idVenda		INT NOT NULL,
	idLivro		INT NOT NULL,
	quantidade	INT NOT NULL,
	subtotal	DECIMAL(8,2) NOT NULL,
	FOREIGN KEY(idVenda) REFERENCES venda(idVenda),
	FOREIGN KEY(idLivro) REFERENCES livro(idLivro) 
)
