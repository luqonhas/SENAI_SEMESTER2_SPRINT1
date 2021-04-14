-- DML

USE Filmes;

INSERT INTO Generos(Nome)
VALUES	('Ação'), 
		('Aventura'),
		('Suspense');


INSERT INTO Filmes(idGenero, Titulo)
VALUES	(1, 'Spider-Man: No Way Home'),
		(2, 'Indiana Jones'),
		(3, 'Corra');

INSERT INTO Usuarios(email, senha, permissao)
VALUES	('lucas@email.com', '1234', 'comum'),
		('adm@email.com', '1234', 'administrador');