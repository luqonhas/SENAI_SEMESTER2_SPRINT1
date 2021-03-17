USE SENAI_HROADS_TARDE;

-- Selecionar todos os personagens (6)
SELECT * FROM Personagem;

-- Selecionar todos as classes (7)
SELECT * FROM Classe; 

-- Selecionar somente os nomes das classes (8)
SELECT Nome AS Classe FROM Classe; 

-- Selecionar todos as habilidades (9)
SELECT * FROM Habilidade; 

-- Realizar contagem de quantas habilidades estão cadastradas (10)
-- Para contar todas as linhas (registros), podemos usar o "SELECT COUNT (id)" para contar o número de linhas(registros)
SELECT COUNT (Habilidade.idHabilidade) AS QtdHabilidade FROM Habilidade; -- Realizar contagem de quantas habilidades estão cadastradas (10)

-- Selecionar somente os id's, classificando-os por ordem decrescente (11)
-- Para colocar os registros na ordem crescente, colocamos o "ORDER BY (o que você quiser colocar na ordem, nesse caso, o id)
SELECT * FROM Habilidade
ORDER BY idHabilidade DESC

-- Selecionar somente os id's, classificando-os por ordem crescente (12)
-- Para colocar os registros na ordem crescente, colocamos o "ORDER BY (o que você quiser colocar na ordem, nesse caso, o id)
SELECT * FROM Habilidade
ORDER BY idHabilidade ASC

-- Selecionar habilidades e tipos de habilidades em uma tabela só (13)
SELECT Habilidade.Nome AS Habilidade, TipoHabilidade.Descricao AS TipoHabilidade FROM TipoHabilidade
INNER JOIN Habilidade
ON TipoHabilidade.idTipoHabilidade = Habilidade.idTipoHabilidade; 

-- Selecionar personagem e classes em uma tabela só (14)
SELECT Personagem.Nome AS Personagem, Personagem.MaxVida, Personagem.MaxMana, Personagem.DataAtualizacao, Personagem.DataCriacao, Classe.Nome AS Classe FROM Classe
INNER JOIN Personagem
ON Classe.idClasse = Personagem.idClasse;

-- Selecionar todas classes com os personagens, mesmo que não tenha personagens para as classes (15)
SELECT Personagem.Nome AS Personagem, Personagem.MaxVida, Personagem.MaxMana, Personagem.DataAtualizacao, Personagem.DataCriacao, Classe.Nome FROM Classe
LEFT JOIN Personagem
ON Classe.idClasse = Personagem.idClasse;

-- Selecionar todas as classes e suas respectivas habilidades (16)
SELECT Classe.Nome AS Classe, Habilidade.Nome AS Habilidade FROM Classe
INNER JOIN ClasseHabilidade
ON Classe.idClasse = ClasseHabilidade.idClasse
LEFT JOIN Habilidade
ON Habilidade.idHabilidade = ClasseHabilidade.idHabilidade;

-- Selecionar todas as classes e suas respectivas habilidades (17)
SELECT Habilidade.Nome AS Habilidade, Classe.Nome AS Classe FROM Classe
INNER JOIN ClasseHabilidade
ON Classe.idClasse = ClasseHabilidade.idClasse
INNER JOIN Habilidade
ON Habilidade.idHabilidade = ClasseHabilidade.idHabilidade;

-- Selecionar todas as classes e suas respectivas habilidades (18)
SELECT Habilidade.Nome AS Habilidade, Classe.Nome AS Classe FROM Classe
FULL OUTER JOIN ClasseHabilidade
ON Classe.idClasse = ClasseHabilidade.idClasse
FULL OUTER JOIN Habilidade
ON Habilidade.idHabilidade = ClasseHabilidade.idHabilidade;