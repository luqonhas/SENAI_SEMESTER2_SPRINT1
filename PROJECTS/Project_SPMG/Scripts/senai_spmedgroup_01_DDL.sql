-- DDL

CREATE DATABASE SPMG;
GO

USE SPMG;
GO


CREATE TABLE tipoUsuarios
(
	idTipoUsuario INT PRIMARY KEY IDENTITY,
	tituloTipoUsuario VARCHAR(200) UNIQUE NOT NULL
);
GO



CREATE TABLE usuarios
(
	idUsuario INT PRIMARY KEY IDENTITY,
	idTipoUsuario INT FOREIGN KEY REFERENCES tipoUsuarios(idTipoUsuario),
	email VARCHAR(200) UNIQUE NOT NULL,
	senha VARCHAR(200) NOT NULL
);
GO



CREATE TABLE especialidades
(
	idEspecialidade INT PRIMARY KEY IDENTITY,
	tituloEspecialidades VARCHAR(200) UNIQUE NOT NULL
);
GO



CREATE TABLE clinicas
(
	idClinica INT PRIMARY KEY IDENTITY,
	cnpj CHAR(14) UNIQUE NOT NULL,
	nomeFantasia VARCHAR(255) UNIQUE NOT NULL,
	razaoSocial VARCHAR(255) NOT NULL,
	endereco VARCHAR(255) NOT NULL,
	horarioAbertura TIME NOT NULL,
	horarioFechamento TIME NOT NULL
);
GO



CREATE TABLE prontuarios
(
	idProntuario INT PRIMARY KEY IDENTITY,
	idUsuario INT FOREIGN KEY REFERENCES usuarios(idUsuario),
	nomeProntuario VARCHAR(200) NOT NULL,
	rg CHAR(9) UNIQUE NOT NULL,
	cpf CHAR(11) UNIQUE NOT NULL,
	dataNascimento DATE NOT NULL,
	telefoneProntuario CHAR(11) UNIQUE NOT NULL,
	endereco VARCHAR(200) NOT NULL
);
GO



CREATE TABLE medicos
(
	idMedico INT PRIMARY KEY IDENTITY,
	idUsuario INT FOREIGN KEY REFERENCES usuarios(idUsuario),
	idClinica INT FOREIGN KEY REFERENCES clinicas(idClinica),
	idEspecialidade INT FOREIGN KEY REFERENCES especialidades(idEspecialidade),
	nomeMedico VARCHAR(200) NOT NULL,
	crm CHAR(8) UNIQUE NOT NULL
);
GO



CREATE TABLE situacoes
(
	idSituacao INT PRIMARY KEY IDENTITY,
	tituloSituacao VARCHAR(100) UNIQUE  NOT NULL
);
GO



CREATE TABLE consultas
(
	idConsulta INT PRIMARY KEY IDENTITY,
	idMedico INT FOREIGN KEY REFERENCES medicos(idMedico),
	idProntuario INT FOREIGN KEY REFERENCES prontuarios(idProntuario),
	idSituacao INT FOREIGN KEY REFERENCES situacoes(idSituacao),
	dataConsulta DATE NOT NULL,
	horaConsulta TIME NOT NULL,
	descricao VARCHAR(200) DEFAULT ('Descrição não informada...') -- se não tiver nada preenchido na descrição, ficará como padrão o "descrição não informada..." para que o médico possa preencher depois
);
GO