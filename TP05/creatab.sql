/* 
-- Nom: Boualil 
-- Prénom: Youcef
-- L3 Informatique
 */
-- *****************************************************************************
-- *************** Part 1 : DDL (Data Definition Language) *********************
-- *****************************************************************************
-- 1.1 Création des tables:
-- Suppression des tables existantes
DROP SEQUENCE promo_seq;

DROP SEQUENCE SEQ_PRIME_NUM ;

DROP Table Primes CASCADE CONSTRAINTS;

DROP TABLE promotions CASCADE CONSTRAINTS;

DROP TABLE HYPERMARCHE_RAYON CASCADE CONSTRAINTS;

DROP TABLE Habitant_Calais CASCADE CONSTRAINTS;

DROP TABLE PRODUITS CASCADE CONSTRAINTS;

DROP TABLE RAYON CASCADE CONSTRAINTS;

DROP TABLE HYPERMARCHE CASCADE CONSTRAINTS;

DROP TABLE EMPLOYE CASCADE CONSTRAINTS;

/*
-- Résultat après l'exécution des commandes : 
-- Si une table n'existe pas (première fois qu'on execute le script), une erreur de type "table or view 'nom_de_table' does not exist" est renvoyée,
-- car les tables doivent exister pour être supprimées.
-- Sinon:

Table dropped.

Table dropped.

Table dropped.

Table dropped.

--  
-- L'ordre des commandes est essentiel : 
-- supprimer d'abord les tables dépendantes (référencées par des clés étrangères) pour éviter des erreurs de dépendance. 
-- CASCADE CONSTRAINTS supprime aussi les contraintes.
 */
-- Création de la table EMPLOYE
CREATE TABLE
    EMPLOYE (
        NUMERO VARCHAR2 (10) PRIMARY KEY NOT NULL, -- Clé primaire, ne peut pas être NULL
        NOM VARCHAR2 (30) NOT NULL,
        PRENOM VARCHAR2 (20) NOT NULL,
        ADRESSE VARCHAR2 (150)
    );

-- Création de la table HYPERMARCHE
CREATE TABLE
    HYPERMARCHE (
        NUMERO VARCHAR2 (10) PRIMARY KEY NOT NULL, -- Clé primaire, ne peut pas être NULL
        NOM VARCHAR2 (30) NOT NULL,
        ADRESSE VARCHAR2 (150),
        VILLE VARCHAR2 (30),
        CODEPOSTAL VARCHAR2 (10),
        NUMERODIRECTEUR VARCHAR2 (10) NOT NULL,
        CONSTRAINT fk_directeur FOREIGN KEY (NUMERODIRECTEUR) REFERENCES EMPLOYE (NUMERO)
    );

-- Création de la table RAYON
CREATE TABLE
    RAYON (
        NUMERO VARCHAR2 (10) PRIMARY KEY NOT NULL, -- Clé primaire, ne peut pas être NULL
        NOM VARCHAR2 (30) NOT NULL,
        DESCRIPTIF VARCHAR2 (255),
        CHIFFREAFFAIRE NUMBER, -- Pour stocker aussi les decimaux
        NUMEROHYPER VARCHAR2 (10) NOT NULL,
        NUMERORESPONSABLE VARCHAR2 (10) NOT NULL,
        CONSTRAINT fk_hyper FOREIGN KEY (NUMEROHYPER) REFERENCES HYPERMARCHE (NUMERO),
        CONSTRAINT fk_responsable FOREIGN KEY (NUMERORESPONSABLE) REFERENCES EMPLOYE (NUMERO)
    );

-- Création de la table PRODUITS
CREATE TABLE
    PRODUITS (
        NUMERO VARCHAR2 (10) PRIMARY KEY NOT NULL, -- Clé primaire, ne peut pas être NULL
        LIBELLE VARCHAR2 (30) NOT NULL,
        NUMERORAYON VARCHAR2 (10) NOT NULL,
        PRIXUNITAIRE NUMBER (10, 2) NOT NULL,
        UNITE VARCHAR2 (20) NOT NULL,
        QUANTITESTOCKHYPER NUMBER NOT NULL,
        CONSTRAINT fk_rayon FOREIGN KEY (NUMERORAYON) REFERENCES RAYON (NUMERO)
    );

-- Création de la table promotions
CREATE TABLE
    promotions (
        numero VARCHAR(6),
        numproduit VARCHAR(6),
        pourcentage_remise NUMBER (4, 2),
        date_debut DATE,
        date_fin DATE,
        CONSTRAINT pk_promotions PRIMARY KEY (numero),
        CONSTRAINT fk_promotions_produits FOREIGN KEY (numproduit) REFERENCES produits (numero)
    );

-- Création de la table
CREATE TABLE
    Primes (
        numero VARCHAR2 (10) PRIMARY KEY,
        numeroEmploye VARCHAR2 (10) NOT NULL,
        numeroRayon VARCHAR2 (10) NOT NULL,
        montantPrime NUMBER (10, 2) NOT NULL,
        moisAnnee VARCHAR2 (7) NOT NULL
    );