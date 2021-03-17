CREATE DATABASE SENAI_HROADS_TARDE

USE SENAI_HROADS_TARDE

CREATE TABLE Classe(
	idClasse INT PRIMARY KEY IDENTITY,
	Nome VARCHAR(200) NOT NULL
);

CREATE TABLE TipoHabilidade(
	idTipoHabilidade INT PRIMARY KEY IDENTITY,
	Descricao VARCHAR(200) NOT NULL
);

CREATE TABLE Habilidade(
	idHabilidade INT PRIMARY KEY IDENTITY,
	idTipoHabilidade INT FOREIGN KEY REFERENCES TipoHabilidade(idTipoHabilidade),
	Nome VARCHAR(200) NOT NULL
);

CREATE TABLE ClasseHabilidade(
	idClasse INT FOREIGN KEY REFERENCES Classe(idClasse),
	idHabilidade INT FOREIGN KEY REFERENCES Habilidade(idHabilidade)
);

CREATE TABLE Personagem(
	idPersonagem INT PRIMARY KEY IDENTITY,
	idClasse INT FOREIGN KEY REFERENCES Classe(idClasse),
	Nome VARCHAR(200) NOT NULL,
	MaxVida INT NOT NULL,
	MaxMana INT NOT NULL,
	DataAtualizacao DATE NOT NULL,
	DataCriacao DATE NOT NULL
);

UPDATE Personagem -- Mudar o Nome do personagem Fer8
SET Personagem.Nome = 'Fer7'
WHERE Personagem.idPersonagem = 3;

UPDATE Classe -- Mudar o Nome da classe do Necromante
SET Classe.Nome = 'Necromancer'
WHERE Classe.idClasse = 5;