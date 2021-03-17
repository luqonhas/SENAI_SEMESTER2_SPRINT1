
-- DQL

USE SPMG;
GO

SELECT * FROM tipoUsuarios;

SELECT * FROM usuarios

SELECT * FROM prontuarios;

SELECT * FROM medicos;

SELECT * FROM especialidades;

SELECT * FROM clinicas;

SELECT * FROM situacoes;

SELECT * FROM consultas;


-- IN�CIO FUNCIONALIDADES:

	-- aqui mostrar� as contas(seus emails) com seus "cargos"(admistrador, m�dico e prontu�rio);
	SELECT tituloTipoUsuario AS TipoUsuario, email AS Email FROM tipoUsuarios
	INNER JOIN usuarios
	ON tipoUsuarios.idTipoUsuario = usuarios.idTipoUsuario;



	-- aqui ser� informado o paciente, data do agendamento e qual m�dico ir� atender a consulta (o m�dico possuir� sua determinada especialidade);
	SELECT nomeProntuario AS Paciente, nomeMedico AS M�dico, tituloEspecialidades AS Especialidade, dataConsulta AS DiaAgendamento, horaConsulta AS HoraAgendamento, tituloSituacao AS Situa��o FROM consultas
	INNER JOIN prontuarios
	ON consultas.idProntuario = prontuarios.idProntuario
	INNER JOIN medicos
	ON consultas.idMedico = medicos.idMedico
	INNER JOIN especialidades
	ON especialidades.idEspecialidade = medicos.idEspecialidade
	INNER JOIN situacoes
	ON consultas.idSituacao = situacoes.idSituacao;



	-- aqui dever� informar os dados da cl�nica (como endere�o, hor�rio de funcionamento, CNPJ, nome fantasia e raz�o social);
	SELECT nomeFantasia, razaoSocial, cnpj, endereco, horarioAbertura, horarioFechamento FROM clinicas;



	-- aqui o m�dico poder� ver os agendamentos (consultas) associados a ele;
	SELECT nomeMedico AS M�dico, nomeProntuario AS Prontu�rio, descricao AS Descri��o, dataConsulta AS DataAgendamento, horaConsulta AS HoraAgendamento, tituloSituacao AS Agendamento FROM medicos
	INNER JOIN consultas
	ON medicos.idMedico = consultas.idMedico
	INNER JOIN prontuarios
	ON consultas.idProntuario = prontuarios.idProntuario
	INNER JOIN situacoes
	ON consultas.idSituacao = situacoes.idSituacao
	WHERE medicos.idMedico = 2; -- Roberto Possarle



	-- aqui o prontu�rio poder� visualizar suas pr�prias consultas;
	SELECT nomeProntuario AS Prontu�rio, nomeMedico AS M�dico, descricao AS Descri��o, dataConsulta AS DataAgendamento, horaConsulta AS HoraAgendamento, tituloSituacao AS Agendamento FROM medicos
	INNER JOIN consultas
	ON medicos.idMedico = consultas.idMedico
	INNER JOIN prontuarios
	ON consultas.idProntuario = prontuarios.idProntuario
	INNER JOIN situacoes
	ON consultas.idSituacao = situacoes.idSituacao
	WHERE prontuarios.idProntuario = 7; -- Mariana



	-- aqui temos um simulador de login b�sico;
	SELECT tituloTipoUsuario AS TipoUsuario, email AS Emails, senha AS Senhas FROM usuarios
	INNER JOIN tipoUsuarios
	ON usuarios.idTipoUsuario = tipoUsuarios.idTipoUsuario
	WHERE email = 'adm@adm.com' AND senha = 'adm123';


-- CAPACIDADES E CRIT�RIOS:

	-- aqui mostra a quantidade de usu�rios cadastrados;
	SELECT COUNT (usuarios.idUsuario) AS QtdUsuarios FROM usuarios;



	-- aqui converte a data de nascimento dos usu�rios para o formato (mm-dd-yyyy) na exibi��o;
	SELECT nomeProntuario AS Nomes, CONVERT (VARCHAR, dataNascimento, 101) AS DataNascimento FROM prontuarios; -- o 101 � meio que o "id" de convers�o de data pra cada pa�s, por exemplo, esse 101 � o padr�o de data dos EUA



	-- aqui foi calculado a idade dos prontu�rios a partir da data de nascimento; || 8766 � o n�mero de horas que tem um ano
	SELECT nomeProntuario AS Nomes, DATEDIFF(HOUR, dataNascimento,GETDATE())/8766 AS Idades FROM prontuarios;



	-- aqui foi criado um evento para que a idade do usu�rio seja calculada todos os dias;
	SELECT prontuarios.nomeProntuario, prontuarios.dataNascimento,
	CASE -- esse CASE funciona tipo um if no C#, caso a primeira condi��o for atendida, vai retornar tal "valor"
	WHEN DATEPART(MONTH, prontuarios.dataNascimento) <= DATEPART(MONTH, GETDATE()) -- o DATEPART retorna uma parte espec�fica de uma data
	AND DATEPART(DAY, prontuarios.dataNascimento) <= DATEPART(DAY, GETDATE())
	THEN (DATEDIFF(YEAR, prontuarios.dataNascimento,GETDATE())) -- o DATEDIFF retorna a diferen�a entre duas datas
	ELSE (DATEDIFF(YEAR, prontuarios.dataNascimento,GETDATE())) - 1 -- caso nenhuma das outras condi��es forem verdadeiras, o ELSE retorna um valor
	END AS IdadeAtual
	FROM prontuarios
	WHERE prontuarios.idProntuario = 7


	-- aqui foi criado um evento para que a idade do usu�rio seja calculada todos os anos;
	SELECT prontuarios.nomeProntuario, prontuarios.dataNascimento,
	DATEDIFF(YEAR, prontuarios.dataNascimento,GETDATE()) AS IdadeAtual
	FROM prontuarios;



	-- FUN��O
		-- aqui foi criado uma fun��o para retornar a quantidade de m�dicos de uma determinada especialidade;
		CREATE FUNCTION QntdMedicos(@idEspecialidade VARCHAR(200)) -- vai ser tipo um m�todo, o @idEspecialidade vai ser um "atributo" vazio pra pegar outro valor depois
		RETURNS INT -- no final vai ser retornado um valor INT
		AS -- como
		BEGIN -- in�cio
			DECLARE @qntd AS INT -- vai ser declarado um outro "atributo" INT vazio pra pegar o resultado final
			SET @qntd = -- vai "setar" dentro de @qntd
			(
			SELECT COUNT(nomeMedico) FROM medicos -- vai contar os nomes dos m�dicos
			INNER JOIN especialidades -- vai relacionar os nomes dos m�dicos com as especialidades
			ON medicos.idEspecialidade = especialidades.idEspecialidade
			WHERE especialidades.tituloEspecialidades = @idEspecialidade -- isso vai ocorrer onde o tituloEspecialidade for igual ao "atributo" @idEspecialidade
			)
			RETURN @qntd -- no fim vai retornar o valor com todas as informa��es
		END -- fim
		GO
		SELECT qntd = dbo.QntdMedicos('Psiquiatria'); -- vai exibir o valor do dbo.QntdMedicos('ESPECIALIDADE'), s� que com o nome do atributo onde foi reunido todas os dados, que � o @qntd

		SELECT dbo.QntdMedicos('Psiquiatria') AS QuantidadeMedicos; -- mesma coisa do de cima, mas com outro nome na tabela



	-- STORED PROCEDURE

		-- aqui foi criado uma fun��o para que retorne a idade do usu�rio a partir de uma determinada stored procedure;
		-- calcular a idade de todos os usu�rios
		CREATE PROCEDURE CalcularIdadeTodos
		AS
		SELECT prontuarios.nomeProntuario, prontuarios.dataNascimento,
		DATEDIFF(YEAR, prontuarios.dataNascimento,GETDATE()) AS IdadeAtual
		FROM prontuarios;
		GO
		-- aqui executa o stored procedure "CalcularIdade"
		EXECUTE CalcularIdadeTodos;



		-- aqui foi criado uma fun��o para que retorne a idade do usu�rio a partir de uma determinada stored procedure;
		-- calcular a idade de um usu�rio espec�fico
		CREATE PROCEDURE CalcularIdadeEspecifica(@nomeProntuario VARCHAR(100))
		AS
		SELECT prontuarios.nomeProntuario, prontuarios.dataNascimento,
		DATEDIFF(YEAR, prontuarios.dataNascimento,GETDATE()) AS IdadeAtual
		FROM prontuarios
		WHERE prontuarios.nomeProntuario = @nomeProntuario;
		GO
		-- aqui executa o stored procedure "CalcularIdade" pelo nome do prontu�rio:
		EXECUTE CalcularIdadeEspecifica @nomeProntuario = 'Mariana';