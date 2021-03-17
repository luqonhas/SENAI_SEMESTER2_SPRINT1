
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


-- INÍCIO FUNCIONALIDADES:

	-- aqui mostrará as contas(seus emails) com seus "cargos"(admistrador, médico e prontuário);
	SELECT tituloTipoUsuario AS TipoUsuario, email AS Email FROM tipoUsuarios
	INNER JOIN usuarios
	ON tipoUsuarios.idTipoUsuario = usuarios.idTipoUsuario;



	-- aqui será informado o paciente, data do agendamento e qual médico irá atender a consulta (o médico possuirá sua determinada especialidade);
	SELECT nomeProntuario AS Paciente, nomeMedico AS Médico, tituloEspecialidades AS Especialidade, dataConsulta AS DiaAgendamento, horaConsulta AS HoraAgendamento, tituloSituacao AS Situação FROM consultas
	INNER JOIN prontuarios
	ON consultas.idProntuario = prontuarios.idProntuario
	INNER JOIN medicos
	ON consultas.idMedico = medicos.idMedico
	INNER JOIN especialidades
	ON especialidades.idEspecialidade = medicos.idEspecialidade
	INNER JOIN situacoes
	ON consultas.idSituacao = situacoes.idSituacao;



	-- aqui deverá informar os dados da clínica (como endereço, horário de funcionamento, CNPJ, nome fantasia e razão social);
	SELECT nomeFantasia, razaoSocial, cnpj, endereco, horarioAbertura, horarioFechamento FROM clinicas;



	-- aqui o médico poderá ver os agendamentos (consultas) associados a ele;
	SELECT nomeMedico AS Médico, nomeProntuario AS Prontuário, descricao AS Descrição, dataConsulta AS DataAgendamento, horaConsulta AS HoraAgendamento, tituloSituacao AS Agendamento FROM medicos
	INNER JOIN consultas
	ON medicos.idMedico = consultas.idMedico
	INNER JOIN prontuarios
	ON consultas.idProntuario = prontuarios.idProntuario
	INNER JOIN situacoes
	ON consultas.idSituacao = situacoes.idSituacao
	WHERE medicos.idMedico = 2; -- Roberto Possarle



	-- aqui o prontuário poderá visualizar suas próprias consultas;
	SELECT nomeProntuario AS Prontuário, nomeMedico AS Médico, descricao AS Descrição, dataConsulta AS DataAgendamento, horaConsulta AS HoraAgendamento, tituloSituacao AS Agendamento FROM medicos
	INNER JOIN consultas
	ON medicos.idMedico = consultas.idMedico
	INNER JOIN prontuarios
	ON consultas.idProntuario = prontuarios.idProntuario
	INNER JOIN situacoes
	ON consultas.idSituacao = situacoes.idSituacao
	WHERE prontuarios.idProntuario = 7; -- Mariana



	-- aqui temos um simulador de login básico;
	SELECT tituloTipoUsuario AS TipoUsuario, email AS Emails, senha AS Senhas FROM usuarios
	INNER JOIN tipoUsuarios
	ON usuarios.idTipoUsuario = tipoUsuarios.idTipoUsuario
	WHERE email = 'adm@adm.com' AND senha = 'adm123';


-- CAPACIDADES E CRITÉRIOS:

	-- aqui mostra a quantidade de usuários cadastrados;
	SELECT COUNT (usuarios.idUsuario) AS QtdUsuarios FROM usuarios;



	-- aqui converte a data de nascimento dos usuários para o formato (mm-dd-yyyy) na exibição;
	SELECT nomeProntuario AS Nomes, CONVERT (VARCHAR, dataNascimento, 101) AS DataNascimento FROM prontuarios; -- o 101 é meio que o "id" de conversão de data pra cada país, por exemplo, esse 101 é o padrão de data dos EUA



	-- aqui foi calculado a idade dos prontuários a partir da data de nascimento; || 8766 é o número de horas que tem um ano
	SELECT nomeProntuario AS Nomes, DATEDIFF(HOUR, dataNascimento,GETDATE())/8766 AS Idades FROM prontuarios;



	-- aqui foi criado um evento para que a idade do usuário seja calculada todos os dias;
	SELECT prontuarios.nomeProntuario, prontuarios.dataNascimento,
	CASE -- esse CASE funciona tipo um if no C#, caso a primeira condição for atendida, vai retornar tal "valor"
	WHEN DATEPART(MONTH, prontuarios.dataNascimento) <= DATEPART(MONTH, GETDATE()) -- o DATEPART retorna uma parte específica de uma data
	AND DATEPART(DAY, prontuarios.dataNascimento) <= DATEPART(DAY, GETDATE())
	THEN (DATEDIFF(YEAR, prontuarios.dataNascimento,GETDATE())) -- o DATEDIFF retorna a diferença entre duas datas
	ELSE (DATEDIFF(YEAR, prontuarios.dataNascimento,GETDATE())) - 1 -- caso nenhuma das outras condições forem verdadeiras, o ELSE retorna um valor
	END AS IdadeAtual
	FROM prontuarios
	WHERE prontuarios.idProntuario = 7


	-- aqui foi criado um evento para que a idade do usuário seja calculada todos os anos;
	SELECT prontuarios.nomeProntuario, prontuarios.dataNascimento,
	DATEDIFF(YEAR, prontuarios.dataNascimento,GETDATE()) AS IdadeAtual
	FROM prontuarios;



	-- FUNÇÃO
		-- aqui foi criado uma função para retornar a quantidade de médicos de uma determinada especialidade;
		CREATE FUNCTION QntdMedicos(@idEspecialidade VARCHAR(200)) -- vai ser tipo um método, o @idEspecialidade vai ser um "atributo" vazio pra pegar outro valor depois
		RETURNS INT -- no final vai ser retornado um valor INT
		AS -- como
		BEGIN -- início
			DECLARE @qntd AS INT -- vai ser declarado um outro "atributo" INT vazio pra pegar o resultado final
			SET @qntd = -- vai "setar" dentro de @qntd
			(
			SELECT COUNT(nomeMedico) FROM medicos -- vai contar os nomes dos médicos
			INNER JOIN especialidades -- vai relacionar os nomes dos médicos com as especialidades
			ON medicos.idEspecialidade = especialidades.idEspecialidade
			WHERE especialidades.tituloEspecialidades = @idEspecialidade -- isso vai ocorrer onde o tituloEspecialidade for igual ao "atributo" @idEspecialidade
			)
			RETURN @qntd -- no fim vai retornar o valor com todas as informações
		END -- fim
		GO
		SELECT qntd = dbo.QntdMedicos('Psiquiatria'); -- vai exibir o valor do dbo.QntdMedicos('ESPECIALIDADE'), só que com o nome do atributo onde foi reunido todas os dados, que é o @qntd

		SELECT dbo.QntdMedicos('Psiquiatria') AS QuantidadeMedicos; -- mesma coisa do de cima, mas com outro nome na tabela



	-- STORED PROCEDURE

		-- aqui foi criado uma função para que retorne a idade do usuário a partir de uma determinada stored procedure;
		-- calcular a idade de todos os usuários
		CREATE PROCEDURE CalcularIdadeTodos
		AS
		SELECT prontuarios.nomeProntuario, prontuarios.dataNascimento,
		DATEDIFF(YEAR, prontuarios.dataNascimento,GETDATE()) AS IdadeAtual
		FROM prontuarios;
		GO
		-- aqui executa o stored procedure "CalcularIdade"
		EXECUTE CalcularIdadeTodos;



		-- aqui foi criado uma função para que retorne a idade do usuário a partir de uma determinada stored procedure;
		-- calcular a idade de um usuário específico
		CREATE PROCEDURE CalcularIdadeEspecifica(@nomeProntuario VARCHAR(100))
		AS
		SELECT prontuarios.nomeProntuario, prontuarios.dataNascimento,
		DATEDIFF(YEAR, prontuarios.dataNascimento,GETDATE()) AS IdadeAtual
		FROM prontuarios
		WHERE prontuarios.nomeProntuario = @nomeProntuario;
		GO
		-- aqui executa o stored procedure "CalcularIdade" pelo nome do prontuário:
		EXECUTE CalcularIdadeEspecifica @nomeProntuario = 'Mariana';