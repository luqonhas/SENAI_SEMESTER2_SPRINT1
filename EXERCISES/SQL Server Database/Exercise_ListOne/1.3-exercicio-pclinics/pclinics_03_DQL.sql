 USE Pclinics;

SELECT * FROM Clinica;

SELECT * FROM Veterinario;

SELECT * FROM Dono;

SELECT * FROM TipoPet;

SELECT * FROM Raca;

SELECT * FROM Pet;

SELECT * FROM Consulta;


-- listar todos os veterinários (nome e CRMV) de uma clínica (razão social)

SELECT Veterinario.Nome, Clinica.RazaoSocial FROM Veterinario
INNER JOIN Clinica
ON Veterinario.idClinica = Clinica.idClinica
WHERE   Clinica.idClinica = Veterinario.idClinica;


-- listar todas as raças que começam com a letra S

SELECT Raca.Nome FROM Raca
WHERE Raca.Nome LIKE 'S%';


-- listar todos os tipos de pet que terminam com a letra O

SELECT TipoPet.Nome FROM TipoPet
WHERE TipoPet.Nome LIKE '%O';


-- listar todos os pets mostrando os nomes dos seus donos

SELECT Pet.Nome AS Nome_Pet, Dono.Nome AS Nome_Dono FROM Pet
INNER JOIN Dono
ON Pet.idDono = Dono.idDono;


--listar todos os atendimentos mostrando o nome do veterinário que atendeu, o pet foi atendido
--o nome, a raça e o tipo do pet que foi atendido, o nome do dono do pet e o nome da clínica onde
--o pet foi atendido

SELECT Veterinario.Nome AS Nome_Veterinario, Pet.Nome AS Nome_Pet, Raca.Nome AS Raca, TipoPet.Nome AS Tipo_Pet, Dono.Nome AS Dono, CLinica.RazaoSocial FROM Clinica, Consulta
INNER JOIN Veterinario
ON Veterinario.idVeterinario = Consulta.idVeterinario
INNER JOIN Pet
ON Pet.idPet = Consulta.idPet
INNER JOIN Raca
ON Pet.idRaca = Raca.idRaca
INNER JOIN TipoPet
ON Raca.idTipoPet = TipoPet.idTipoPet
INNER JOIN Dono
ON Dono.idDono = Pet.idDono;