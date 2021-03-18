USE Pclinics;

INSERT INTO Clinica (CNPJ, Endereco, RazaoSocial)
VALUES	(4494951312, 'Av. Barão de Limeira, 539', 'PetSeventy');

INSERT INTO Veterinario (idClinica, Nome)
VALUES		(1, 'Caique')
		   ,(1, 'Saulo');

INSERT INTO Dono (Nome)
VALUES		('Vitor')
		   ,('Thiago');

INSERT INTO TipoPet (Nome)
VALUES		('Cachorro')
		   ,('Gato')
		   ,('Pássaro');

INSERT INTO Raca (Nome, idTipoPet)
VALUES		('Poodle', 1)
		   ,('Labrador', 1);

INSERT INTO Pet (Nome, idRaca, idDono, DataNasc)
VALUES		('DogLaranja', 1, 2, '10/05/2015')
		   ,('Shine', 2, 1, '25/01/2021');

INSERT INTO Consulta (idVeterinario, idPet, Descricao, DataAtendimento)
VALUES		(1, 1, 'Saudável', '07/02/2021')
		   ,(2, 2, 'OK', '20/02/2021')
		   ,(1, 1, 'Saudável', '25/02/2021');

UPDATE Consulta
SET DataAtendimento = '24/02/2021', idVeterinario = 2
WHERE idConsulta = 3;

DELETE FROM TipoPet
WHERE idTipoPet = 3;