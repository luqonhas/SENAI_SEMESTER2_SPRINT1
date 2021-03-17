USE Gufi;
GO

INSERT INTO tiposUsuarios(tituloTipoUsuario)
VALUES	('Administrador'),
		('Comum');
GO

INSERT INTO usuarios(idTipoUsuario, nomeUsuario, email, senha)
VALUES	(1, 'Administrador', 'adm@adm.com', 'adm123'),
		(2, 'Lucas', 'lucas@lucas.com', 'lucas123'),
		(2, 'Saulo', 'saulo@saulo.com', 'saulo123');
GO

INSERT INTO tiposEventos(tituloTipoEvento)
VALUES  ('C#'),
		('ReactJs'),
		('SQL');
GO

INSERT INTO instituicoes(cnpj, nomeFantasia, endereco)
VALUES	('12345678910121', 'Escola SENAI de Inform�tica', 'Al. Bar�o de Limeira, 538')
GO

INSERT INTO eventos(idTipoEvento, idInstituicao, nomeEvento, acessoLivre, dataEvento, descricao)
VALUES	(1, 1, 'POO', 1, '07/04/2021', 'Conceitos sobre os pilares da progama��o orientada a objetos.'),
		(2, 1, 'Ciclo de Vida', 0, '08/04/2021', 'Como utilizar os ciclos de vida com a biblioteca ReactJs.'),
		(3, 1, 'Introdu��o a SQL', 1, '09/04/2021', 'Comandos b�sicos utilizando SQL Server.');
GO

INSERT INTO presencas(idUsuario, idEvento, situacao)
VALUES	(2, 2, 'n�o confirmada'),
		(2, 3, 'confirmada'),
		(3, 1, 'confirmada');
GO