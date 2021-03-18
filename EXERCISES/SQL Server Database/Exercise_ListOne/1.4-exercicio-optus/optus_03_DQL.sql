USE Optus;

SELECT * FROM Artistas;

SELECT * FROM Albuns;

SELECT * FROM Estilos;

SELECT * FROM AlbumEstilos;

SELECT * FROM Usuarios;


-- listar todos os usuários administradores, sem exibir suas senhas

SELECT Usuarios.Nome, Usuarios.Email, Usuarios.Permissao FROM Usuarios
WHERE Usuarios.Permissao = 'admin';


-- listar todos os álbuns lançados após o um determinado ano de lançamento

SELECT Albuns.Titulo, Artistas.Nome AS Nome_Artista, Albuns.DataLancamento, Albuns.Localizacao, Albuns.QtsMinutos, Albuns.Ativo FROM Albuns
INNER JOIN Artistas
ON Albuns.idArtista = Artistas.idArtista
WHERE Albuns.DataLancamento > '10/10/2010';


-- listar os dados de um usuário através do e-mail e senha
SELECT Usuarios.Nome, Usuarios.Email, Usuarios.Permissao FROM Usuarios
WHERE Usuarios.Email = 'caique@gmail.com'
AND Usuarios.Senha = 12345;


-- listar todos os álbuns ativos, mostrando o nome do artista e os estilos do álbum

SELECT Albuns.Titulo, Artistas.Nome, Estilos.Nome AS Estilo FROM Albuns
INNER JOIN Artistas
ON Albuns.idArtista = Artistas.idArtista
INNER JOIN AlbumEstilos
ON AlbumEstilos.idAlbum = Albuns.idAlbum
INNER JOIN Estilos
ON Estilos.idEstilo = AlbumEstilos.idEstilo
WHERE Albuns.Ativo = 1;