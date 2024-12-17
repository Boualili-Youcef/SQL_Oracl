/* 
-- Nom: Boualil 
-- Prénom: Youcef
-- L3 Informatique
-- TP2
 */
-- *****************************************************************************
-- *************** Part 1 : DDL (Data Definition Language) *********************
-- *****************************************************************************
-- 1.1 Création des tables:
-- Suppression des tables existantes

DROP TABLE Noter CASCADE CONSTRAINTS;

DROP TABLE Etudiant CASCADE CONSTRAINTS;

DROP TABLE Matiere CASCADE CONSTRAINTS;

DROP TABLE Formation CASCADE CONSTRAINTS;


/*
Table dropped.


Table dropped.


Table dropped.


Table dropped.
*/

CREATE TABLE
    Formation (
        CodeF Number (2) PRIMARY KEY,
        Libelle Varchar2 (10) NOT NULL -- Renseigné
    );

-- Création de la table Etudiant
CREATE TABLE
    Etudiant (
        NumEtu Number (2) PRIMARY KEY,
        NomE Varchar2 (24) NOT NULL UNIQUE, -- Renseigné et pas d’homonyme
        DateNais Date NOT NULL, -- Renseigné
        Sexe Char(1) DEFAULT 'M' CHECK (Sexe IN ('M', 'F')), --Renseigné/ Uniquement les caractères F et M /Valeur par défaut M
        CodeF Number (2),
        FOREIGN KEY (CodeF) REFERENCES Formation (CodeF) ON DELETE SET NULL
    );

-- Création de la table Matiere
CREATE TABLE
    Matiere (
        NumMat Number (2) PRIMARY KEY,
        NomM VARCHAR2 (24) NOT NULL, -- Renseigné
        Coefficient Number (2) NOT NULL CHECK (Coefficient > 0) -- Renseigné et Coefficient positif non null
    );

-- Création de la table Matiere
CREATE TABLE
    Noter (
        NumEtu Number (2),
        NumMat Number (2),
        Note Number (4, 2) DEFAULT NULL CHECK (
            Note IS NULL
            OR (
                Note >= 0
                AND Note <= 20
            ) -- compris entre 0 et 20
        ),
        PRIMARY KEY (NumEtu, NumMat),
        FOREIGN KEY (NumEtu) REFERENCES Etudiant (NumEtu) ON DELETE CASCADE,
        FOREIGN KEY (NumMat) REFERENCES Matiere (NumMat) ON DELETE CASCADE
    );


/*
Table created.


Table created.


Table created.


Table created.*
*/