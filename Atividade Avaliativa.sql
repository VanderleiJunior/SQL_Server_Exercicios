CREATE DATABASE ClinicaVeterinaria
USE ClinicaVeterinaria

CREATE TABLE Veterinario (
	CodMed INT IDENTITY (1,1) PRIMARY KEY,
	Nome VARCHAR(40),
	DataNasc DATE
)

CREATE TABLE Animal (
	CodPac INT IDENTITY (1,1) PRIMARY KEY,
	NomeAnimal VARCHAR(40),
	Especie VARCHAR(30)
)

SELECT * FROM Animal

CREATE TABLE Consulta (
	CodCons INT IDENTITY (1,1) PRIMARY KEY,
	DataCons DATE,
	Valor MONEY,
	CodMed INT FOREIGN KEY REFERENCES Veterinario(CodMed),
	CodPac INT FOREIGN KEY REFERENCES Animal(CodPac)
)

SELECT * FROM Veterinario

--1 - Cadastrar 5 médicos (veterinários) para esta clínica
INSERT INTO Veterinario VALUES('João', '2000/12/25')
INSERT INTO Veterinario VALUES('Mathias', '1980/02/28')
INSERT INTO Veterinario VALUES('Mariana', '1967/04/30')
INSERT INTO Veterinario VALUES('Bruna', '1996/08/18')
INSERT INTO Veterinario VALUES('Solange', '1987/09/23')

--2 - Cadastrar 10 pacientes (animais) para a clínica de pelo menos 3 espécies diferentes
INSERT INTO Animal VALUES('Abudabi', 'Cachorro')
INSERT INTO Animal VALUES('Caramelo', 'Cachorro')
INSERT INTO Animal VALUES('Belinha', 'Cachorro')
INSERT INTO Animal VALUES('Thor', 'Cachorro')
INSERT INTO Animal VALUES('Bixano', 'Gato')
INSERT INTO Animal VALUES('Felino', 'Gato')
INSERT INTO Animal VALUES('Tom', 'Gato')
INSERT INTO Animal VALUES('Frajola', 'Gato')
INSERT INTO Animal VALUES('Pirata', 'Papagaio')
INSERT INTO Animal VALUES('Omen', 'Calopsita')
INSERT INTO Animal VALUES('Rex', 'Cachorro')
INSERT INTO Animal VALUES('Bolinha', 'Cachorro')

--3 - Cadastre 20 consultas para estes médicos e pacientes com datas e valores diferentes
INSERT INTO Consulta VALUES('2022/06/05', 60, 1, 10)
INSERT INTO Consulta VALUES('2022/06/01', 150, 1, 5)
INSERT INTO Consulta VALUES('2022/05/25', 300, 1, 10)
INSERT INTO Consulta VALUES('2022/06/08', 180, 1, 5)
INSERT INTO Consulta VALUES('2022/06/05', 160, 2, 6)
INSERT INTO Consulta VALUES('2022/06/05', 50, 2, 9)
INSERT INTO Consulta VALUES('2022/06/03', 175, 2, 6)
INSERT INTO Consulta VALUES('2022/05/07', 130, 2, 9)
INSERT INTO Consulta VALUES('2022/06/08', 180, 3, 1)
INSERT INTO Consulta VALUES('2022/06/01', 75, 3, 3)
INSERT INTO Consulta VALUES('2022/05/10', 125, 3, 1)
INSERT INTO Consulta VALUES('2022/05/16', 135, 3, 3)
INSERT INTO Consulta VALUES('2022/06/06', 140, 4, 2)
INSERT INTO Consulta VALUES('2022/06/07', 75, 4, 4)
INSERT INTO Consulta VALUES('2022/06/08', 75, 4, 2)
INSERT INTO Consulta VALUES('2022/05/22', 150, 4, 4)
INSERT INTO Consulta VALUES('2022/06/06', 60, 5, 7)
INSERT INTO Consulta VALUES('2022/05/26', 160, 5, 8)
INSERT INTO Consulta VALUES('2022/06/02', 180, 5, 7)
INSERT INTO Consulta VALUES('2022/06/10', 200, 5, 8)
INSERT INTO Consulta VALUES('2022/06/11', 250, 3, 11)
INSERT INTO Consulta VALUES ('2022/05/05', 100, 4, 11)

--4 - Atualize o nome do médico cujo código é 3 para o seu nome
UPDATE Veterinario SET Nome =	'Vanderlei'
	WHERE CodMed = 3

--5 - Cadastre um novo médico e crie 3 consultas para ele de pacientes que já estão cadastrados
INSERT INTO Veterinario VALUES('Aparecido', '1970/05/26')

INSERT INTO Consulta VALUES('2022/06/10', 75, 6, 6)
INSERT INTO Consulta VALUES('2022/06/10', 100, 6, 8)
INSERT INTO Consulta VALUES('2022/06/10', 150, 6, 10)
--===================================
--1 - Liste os nomes e as datas de nascimentos dos médicos, a data e os valores das consultas que eles fizeram ordenadas da consulta mais cara para a mais barata.
Select V.Nome [Medico], V.DataNasc as [MedDtNasc], C.DataCons as [DtConsulta], C.Valor as [valor] 
	FROM Consulta AS C
	INNER JOIN Veterinario AS V ON C.CodMed = V.CodMed
	ORDER BY C.Valor DESC

--2 - Sobre o paciente REX, liste o nome do paciente, o valor e as datas das consultas que ele já fez.
SELECT A.NomeAnimal [Nome], C.Valor AS [Valor], C.DataCons AS [DataCons]
	FROM Consulta AS C
	INNER JOIN Animal AS A ON C.CodPac = 11 AND A.CodPac = 11

--3 - Liste o seu nome e os nomes dos pacientes que você atendeu, ordenados pela data da consulta.
SELECT V.Nome AS [Nome], A.NomeAnimal AS [NomePasciente]
	FROM Consulta AS C
	INNER JOIN  Animal AS A ON C.CodPac = A.CodPac AND C.CodMed = 3
	INNER JOIN Veterinario AS V ON V.CodMed = 3
	ORDER BY C.DataCons DESC

--4 - Qual o nome dos médicos que consultaram gatos ou cachorros nos últimos 4 meses?
SELECT V.Nome AS [NomeMedico], A.Especie AS [EspecieDoPasciente]
	FROM Veterinario AS V
	INNER JOIN Animal AS A ON A.Especie = 'Cachorro' OR A.Especie = 'Gato'
	INNER JOIN Consulta AS C ON C.CodMed = V.CodMed AND A.CodPac = C.CodPac 
	WHERE YEAR(C.DataCons) = 2022
	AND MONTH(C.DataCons) >= 02

--5 - Liste as espécies de pacientes que foram atendidos pelos médicos JOÃO, ANA ou BEATRIZ (use o comando IN).
SELECT A.Especie AS [EspecieDoPasciente]
	FROM Animal AS A
	INNER JOIN Consulta AS C ON A.CodPac = C.CodPac
	INNER JOIN Veterinario AS V ON C.CodMed = V.CodMed 
	WHERE V.Nome IN ('João', 'Ana', 'Beatriz')

--6 - Liste o nome dos médicos que tem idade entre 30 e 45 anos, os nomes dos paciente atendidos, as datas e valores de todas as consultas. Ordenadas pelo nome do paciente.
SELECT V.Nome AS [NomeMedico], A.NomeAnimal AS [NomeDoPasciente], C.DataCons AS [DataCons], C.Valor AS [Valor]
	FROM Veterinario AS V
	INNER JOIN Animal AS A ON A.Especie = 'Cachorro' OR A.Especie = 'Gato'
	INNER JOIN Consulta AS C ON C.CodMed = V.CodMed AND A.CodPac = C.CodPac 
	WHERE YEAR(V.DataNasc) <= 1992 AND YEAR(V.DataNasc) >= 1977
	ORDER BY A.NomeAnimal

--7 - Liste os nomes de todos os cachorros, independente se fizeram consultas ou não.
SELECT NomeAnimal FROM Animal
	WHERE Especie = 'Cachorro'

--8 - Quais pacientes pagaram consulta com preço abaixo da média da clínica?
SELECT A.NomeAnimal AS [NomeDoPasciente]
	FROM Animal AS A
	INNER JOIN Consulta AS C ON C.CodPac = A.CodPac
	WHERE C.Valor < (SELECT AVG(VALOR) FROM Consulta)

--9 - Liste os nomes de todos os pacientes que não fizeram consultas
SELECT A.NomeAnimal AS [NomeDoPasciente]
	FROM Animal AS A
	FULL OUTER JOIN Consulta AS C ON C.CodPac = A.CodPac
	WHERE C.CodPac IS NULL OR A.CodPac IS NULL