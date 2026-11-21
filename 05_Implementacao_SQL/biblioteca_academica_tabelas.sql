CREATE DATABASE biblioteca_academica;

USE biblioteca_academica;



CREATE TABLE Leitor (
    leitor_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    email VARCHAR(254) NOT NULL UNIQUE,
    telefone VARCHAR(30),
    data_cadastro DATETIME NOT NULL DEFAULT (CURRENT_TIMESTAMP),
    ativo BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE Livro (
    livro_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR (20) NOT NULL UNIQUE,
    titulo VARCHAR(200) NOT NULL,
    ano_publicacao SMALLINT,
    editora VARCHAR(120),
    CHECK (ano_publicacao IS NULL OR ano_publicacao BETWEEN 1400 AND 2100)
);

CREATE TABLE Autor (
    autor_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR (120) NOT NULL
);

CREATE TABLE Livro_autor(
    livro_id BIGINT UNSIGNED NOT NULL,
    autor_id BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (livro_id, autor_id),
    CONSTRAINT fk_livro_autor_livro
        FOREIGN KEY (livro_id)
        REFERENCES livro (livro_id),
    CONSTRAINT fk_livro_autor_autor
        FOREIGN KEY (autor_id)
        REFERENCES Autor (autor_id)

);

CREATE TABLE Exemplar (
    exemplar_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    livro_id BIGINT UNSIGNED NOT NULL,
    codigo_tombo VARCHAR(12) NOT NULL UNIQUE,
    situacao VARCHAR(12) NOT NULL DEFAULT 'DISPONIVEL',
    CONSTRAINT fk_exemplar_livro FOREIGN KEY (livro_id) REFERENCES Livro(livro_id) ON DELETE RESTRICT,
    CONSTRAINT chk_exemplar_situacao CHECK (SITUACAO IN ('DISPONIVEL','DANIFICADO','BAIXADO'))
   
);

CREATE TABLE Emprestimo(
    emprestimo_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    leitor_id BIGINT UNSIGNED NOT NULL,
    data_emprestimo DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_prevista_devolucao DATE NOT NULL,
    CONSTRAINT fk_emprestimo_leitor FOREIGN KEY (leitor_id) REFERENCES Leitor(leitor_id) ON DELETE RESTRICT,
    CONSTRAINT chk_emprestimo_datas CHECK (data_prevista_devolucao >= DATE(data_emprestimo))
);

CREATE TABLE Item_emprestimo(
    emprestimo_id BIGINT UNSIGNED NOT NULL,
    exemplar_id BIGINT UNSIGNED NOT NULL,
    data_devolucao DATETIME NULL,
    exemplar_ativo_id BIGINT UNSIGNED AS (IF(data_devolucao IS NULL, exemplar_id, NULL)) VIRTUAL,
    PRIMARY KEY (emprestimo_id, exemplar_id),
    CONSTRAINT fk_item_emprestimo FOREIGN KEY (emprestimo_id) REFERENCES Emprestimo(emprestimo_id) ON DELETE RESTRICT,
    CONSTRAINT fk_item_exemplar FOREIGN KEY (exemplar_id) REFERENCES Exemplar(exemplar_id) ON DELETE RESTRICT,
    UNIQUE INDEX uq_item_exemplar_ativo (exemplar_ativo_id)
);

CREATE INDEX ix_emprestimo_leitor_data ON Emprestimo (leitor_id, data_emprestimo);
CREATE INDEX ix_item_exemplar ON Item_emprestimo (exemplar_id);









