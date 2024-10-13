/*QUESTÃO 1*/

CREATE TABLE Professores (
  id INT PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  especialidade VARCHAR(50) NOT NULL
);

CREATE TABLE Cursos (
  id INT PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  carga_horaria INT NOT NULL,
  descricao VARCHAR(100) NOT NULL,
  professor_id INT,
  FOREIGN KEY (professor_id) REFERENCES Professores(id)
);

CREATE TABLE Alunos (
  id INT PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL
);

CREATE TABLE Matriculas (
  aluno_id INT,
  curso_id INT,
  PRIMARY KEY (aluno_id, curso_id),
  FOREIGN KEY (aluno_id) REFERENCES Alunos(id),
  FOREIGN KEY (curso_id) REFERENCES Cursos(id)
);

/*QUESTÃO 2*/

INSERT INTO Professores (id, nome, especialidade)
VALUES
  (1, 'João Silva', 'Programação'),
  (2, 'Maria Nunes', 'Banco de Dados'),
  (3, 'Joana Fagundes', 'Lógica'),
  (4, 'Paulo Nunes', 'Biologia');

/*QUESTÃO 3*/

INSERT INTO Cursos (id, nome, carga_horaria, descricao, professor_id)
VALUES
  (100, 'Programação OO', 60, 'Curso de Programação Orientada a Objetos', 1),
  (101, 'Programação Estruturada', 40, 'Curso de Programação Estruturada', 1),
  (102, 'BD Relacional', 80, 'Curso de Banco de Dados Relacional', 2),
  (103, 'BD NoSQL', 30, 'Curso de Banco de Dados Not Only SQL', 2),
  (104, 'Lógica de Programação', 60, 'Curso de Lógica de Programação', 3),
  (105, 'Estrutura de Dados', 80, 'Curso de Estrutura de Dados', 3);

/*QUESTÃO 4*/

INSERT INTO Alunos (id, nome, email)
VALUES
  (1000, 'Ana Souza', 'ana.souza@exemplo.com'),
  (1001, 'Marcos Alves', 'marcos.alves@exemplo.com'),
  (1002, 'Patricia Rangel', 'patricia.rangel@exemplo.com'),
  (1003, 'Geraldo Nascimento', 'geraldo.nascimento@exemplo.com'),
  (1004, 'Nanci Neves', 'nanci.neves@exemplo.com');

/*QUESTÃO 5*/

INSERT INTO Matriculas (aluno_id, curso_id)
VALUES
  (1000, 100),
  (1000, 101),
  (1000, 102),
  (1001, 101),
  (1001, 102),
  (1002, 103),
  (1002, 104),
  (1003, 104),
  (1004, 101);

/*QUESTÃO 6*/
SELECT * FROM Cursos;

/*QUESTÃO 7*/
SELECT A.nome
FROM Alunos A
JOIN Matriculas M ON A.id = M.aluno_id
JOIN Cursos C ON M.curso_id = C.id
WHERE C.nome = 'Programação Estruturada';

/*QUESTÃO 8*/
UPDATE Professores
SET especialidade = 'Programação Fullstack'
WHERE id = 1;

/*QUESTÃO 9*/
DELETE FROM Cursos
WHERE id = 105;