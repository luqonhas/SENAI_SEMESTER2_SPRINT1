USE Optus;

INSERT INTO Artistas (Nome)
VALUES		('Saulo')
		   ,('Vitor');

INSERT INTO Estilos (Nome)
VALUES		('Pop')
		   ,('Rock');

INSERT INTO Albuns (idArtista, Titulo, DataLancamento, Localizacao, QtsMinutos, Ativo)
VALUES		(1, 'DanceDance', '05/09/2009', 'EUA', 50, 1)
		   ,(2, 'MetalNM', '15/06/2016', 'Brasil', 90, 0);

INSERT INTO AlbumEstilos (idAlbum, idEstilo)
VALUES		(1, 1)
		   ,(2, 2);

INSERT INTO Usuarios (Nome, Email, Senha, Permissao)
VALUES		('Caique', 'caique@gmail.com', 12345, 'admin')
		   ,('Thiago', 'thiago@gmail.com', 123456, 'user');

UPDATE Albuns
SET QtsMinutos = 60
WHERE idAlbum = 1;

DELETE FROM AlbumEstilos
WHERE idAlbum = 1;