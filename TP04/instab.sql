-- Nom: Boualil 
-- Prénom: Youcef
-- L3 Informatique

 
-- *****************************************************************************
-- ***************                     TP 03                 *******************
-- *****************************************************************************

-- 1.1 ROLLBACK et COMMIT
--_______________________ 
INSERT ALL
  INTO EMPLOYE (NUMERO, NOM, PRENOM, ADRESSE) VALUES ('EMP1090', 'DUPONT', 'Jean', '332, rue jean-dupont, Calais')
  INTO EMPLOYE (NUMERO, NOM, PRENOM, ADRESSE) VALUES ('EMP1301', 'DUVIVIER', 'Renaud', '345, rue renaud-duviver, Paris')
  INTO EMPLOYE (NUMERO, NOM, PRENOM, ADRESSE) VALUES ('EMP1208', 'GODART', 'Claude', '674, rue claude-godart, Ardre')
  INTO EMPLOYE (NUMERO, NOM, PRENOM, ADRESSE) VALUES ('EMP2025', 'FONTAINE', 'Fabien', '456, rue jean-louis, Calais')
  INTO EMPLOYE (NUMERO, NOM, PRENOM, ADRESSE) VALUES ('EMP1505', 'VASSEUR', 'Jacques', '778, rue vasseur, Saint-Omer')
  INTO EMPLOYE (NUMERO, NOM, PRENOM, ADRESSE) VALUES ('EMP7645', 'BERNARD', 'Martin', '876, rue martin, Sangatte')
  INTO EMPLOYE (NUMERO, NOM, PRENOM, ADRESSE) VALUES ('EMP2341', 'RICHARD', 'Philipe', '955, rue bernard, Coudekerque')
  INTO EMPLOYE (NUMERO, NOM, PRENOM, ADRESSE) VALUES ('EMP8765', 'Hugo', 'Victor', '432, rue victor-hugo, Frethun')
  INTO EMPLOYE (NUMERO, NOM, PRENOM, ADRESSE) VALUES ('EMP4328', 'Stevenson', 'Max', '874, rue max-stevenson, Cologne')
  INTO EMPLOYE (NUMERO, NOM, PRENOM, ADRESSE) VALUES ('EMP7862', 'DURAND', 'Christophe', '543, rue durand, Calais')
  -- Ajouter les deux enregistrements suivants dans la table EMPLOYE
  INTO EMPLOYE (NUMERO, NOM, PRENOM, ADRESSE) VALUES ('EMP1190', 'ROGER', 'Stéphane', '362, rue stéphane-roger, Ardre')
  INTO EMPLOYE (NUMERO, NOM, PRENOM, ADRESSE) VALUES ('EMP1401', 'ROUSSELLE', 'Nicolas', '397, rue noclas-rousselle, St-Omer')
SELECT * FROM dual;

/*
 10 rows created.
*/

-- Insertion des enregistrements dans la table HYPERMARCHE
INSERT ALL
  INTO HYPERMARCHE (NUMERO, NOM, ADRESSE, VILLE, CODEPOSTAL, NUMERODIRECTEUR) VALUES ('HYP12', 'Marrefour', '12 Bd du Kent', 'Coquelles', '62231', 'EMP1090')
  INTO HYPERMARCHE (NUMERO, NOM, ADRESSE, VILLE, CODEPOSTAL, NUMERODIRECTEUR) VALUES ('HYP56', 'DO-SPORT', '45 AV Blue', 'Calais', '62100', 'EMP1208')
  INTO HYPERMARCHE (NUMERO, NOM, ADRESSE, VILLE, CODEPOSTAL, NUMERODIRECTEUR) VALUES ('HYP76', 'Marrefour Market', '68 AV Bleriot', 'Lille', '59160', 'EMP1301')
  INTO HYPERMARCHE (NUMERO, NOM, ADRESSE, VILLE, CODEPOSTAL, NUMERODIRECTEUR) VALUES ('HYP43', 'Dealer Price', '52, Bd Hugo', 'Calais', '62100', 'EMP8765')
SELECT * FROM dual;

/*
 4 rows created.
*/

-- OR:

-- Insertion des enregistrements dans la table RAYON
INSERT INTO RAYON (NUMERO, NOM, DESCRIPTIF, CHIFFREAFFAIRE, NUMEROHYPER, NUMERORESPONSABLE) VALUES ('RAY34', 'Boucherie', 'Vente de viandes, volailles etc.', 1000000, 'HYP12', 'EMP7862');
INSERT INTO RAYON (NUMERO, NOM, DESCRIPTIF, CHIFFREAFFAIRE, NUMEROHYPER, NUMERORESPONSABLE) VALUES ('RAY45', 'Textile', 'Vêtements', 50000000, 'HYP56', 'EMP1505');
INSERT INTO RAYON (NUMERO, NOM, DESCRIPTIF, CHIFFREAFFAIRE, NUMEROHYPER, NUMERORESPONSABLE) VALUES ('RAY67', 'Chaussure', 'Des chaussures de cuir, des chaussures de marche.', 800000, 'HYP56', 'EMP7645');
INSERT INTO RAYON (NUMERO, NOM, DESCRIPTIF, CHIFFREAFFAIRE, NUMEROHYPER, NUMERORESPONSABLE) VALUES ('RAY86', 'Poissonnerie', 'Poissonnerie traiteur, plateau de fruits de mer.', 950000, 'HYP12', 'EMP2341');
INSERT INTO RAYON (NUMERO, NOM, DESCRIPTIF, CHIFFREAFFAIRE, NUMEROHYPER, NUMERORESPONSABLE) VALUES ('RAY19', 'Légumes', 'Fruits et Légumes', 450000, 'HYP43', 'EMP4328');
INSERT INTO RAYON (NUMERO, NOM, DESCRIPTIF, CHIFFREAFFAIRE, NUMEROHYPER, NUMERORESPONSABLE) VALUES ('RAY98', 'Boucherie', 'Vente de viandes, volailles, etc.', 500000, 'HYP43', 'EMP2025');

/*
 1 rows created.
 1 rows created.
 1 rows created.
 1 rows created.
 1 rows created.
 1 rows created.
*/
-- Insertion des enregistrements dans la table PRODUITS
INSERT INTO PRODUITS (NUMERO, LIBELLE, NUMERORAYON, PRIXUNITAIRE, UNITE, QUANTITESTOCKHYPER) VALUES ('PR1234', 'Côtes de bœuf', 'RAY34', 12.50, 'kg', 345);
INSERT INTO PRODUITS (NUMERO, LIBELLE, NUMERORAYON, PRIXUNITAIRE, UNITE, QUANTITESTOCKHYPER) VALUES ('PR5783', 'Chaussure Mike', 'RAY67', 109.99, 'unité', 56660);
INSERT INTO PRODUITS (NUMERO, LIBELLE, NUMERORAYON, PRIXUNITAIRE, UNITE, QUANTITESTOCKHYPER) VALUES ('PR6765', 'SWEAT CORERUNNER', 'RAY45', 59.00, 'unité', 87778);
/*
 1 rows created.
 1 rows created.
 1 rows created.
*/



-- *****************************************************************************
-- ******************************* Vérification ********************************
-- *****************************************************************************
-- 1.1.1 Étude du ROLLBACK

-- *****************************************************************************
-- Faire à nouveau un SELECT de cette table pour vérifier.
-- Faire :
-- SQL> rollback;
-- Faire un SELECT de la table EMPLOYE, quelles sont vos conclusions ?
-- *****************************************************************************

-- Conclusions:
-- Après avoir effectué le ROLLBACK, les ajouts seront supprimés de la table EMPLOYE.
-- Le ROLLBACK annule toutes les modifications effectuées depuis le dernier COMMIT.


-- *****************************************************************************
-- Faire un COMMIT.
-- Faire un SELECT de cette table pour vérifier.
-- Faire :
-- SQL> commit;
-- Faire un SELECT de la table EMPLOYE, quelles sont vos conclusions ?
-- Maintenant est-ce que le ROLLBACK peut annuler les insertions précédentes ?
-- *****************************************************************************

-- Conclusions:
-- Après avoir effectué le COMMIT, les ajouts seront enregistrés dans la table EMPLOYE.
-- Cela signifie que les modifications sont permanentes et ne peuvent plus être annulées par un ROLLBACK.
-- Le ROLLBACK ne peut pas annuler les insertions précédentes après un COMMIT.

select * from  EMPLOYE;

/*
NUMERO     NOM                            PRENOM
---------- ------------------------------ --------------------
ADRESSE
--------------------------------------------------------------------------------
EMP1090    DUPONT                         Jean
332, rue jean-dupont, Calais

EMP1301    DUVIVIER                       Renaud
345, rue renaud-duviver, Paris

EMP1208    GODART                         Claude
674, rue claude-godart, Ardre


NUMERO     NOM                            PRENOM
---------- ------------------------------ --------------------
ADRESSE
--------------------------------------------------------------------------------
EMP2025    FONTAINE                       Fabien
456, rue jean-louis, Calais

EMP1505    VASSEUR                        Jacques
778, rue vasseur, Saint-Omer

EMP7645    BERNARD                        Martin
876, rue martin, Sangatte


NUMERO     NOM                            PRENOM
---------- ------------------------------ --------------------
ADRESSE
--------------------------------------------------------------------------------
EMP2341    RICHARD                        Philipe
955, rue bernard, Coudekerque

EMP8765    Hugo                           Victor
432, rue victor-hugo, Frethun

EMP4328    Stevenson                      Max
874, rue max-stevenson, Cologne


NUMERO     NOM                            PRENOM
---------- ------------------------------ --------------------
ADRESSE
--------------------------------------------------------------------------------
EMP7862    DURAND                         Christophe
543, rue durand, Calais

EMP1190    ROGER                          St├®phane
362, rue st├®phane-roger, Ardre

EMP1401    ROUSSELLE                      Nicolas
397, rue noclas-rousselle, St-Omer


12 rows selected.
*/


-- SQL> rollback;

-- Rollback complete.


-- SQL> select * from  EMPLOYE;

-- no rows selected

-- SQL> commit;

-- Commit complete.

/*
SQL> select * from EMPLOYE;

NUMERO     NOM                            PRENOM
---------- ------------------------------ --------------------
ADRESSE
--------------------------------------------------------------------------------
EMP1090    DUPONT                         Jean
332, rue jean-dupont, Calais

EMP1301    DUVIVIER                       Renaud
345, rue renaud-duviver, Paris

EMP1208    GODART                         Claude
674, rue claude-godart, Ardre


NUMERO     NOM                            PRENOM
---------- ------------------------------ --------------------
ADRESSE
--------------------------------------------------------------------------------
EMP2025    FONTAINE                       Fabien
456, rue jean-louis, Calais

EMP1505    VASSEUR                        Jacques
778, rue vasseur, Saint-Omer

EMP7645    BERNARD                        Martin
876, rue martin, Sangatte


NUMERO     NOM                            PRENOM
---------- ------------------------------ --------------------
ADRESSE
--------------------------------------------------------------------------------
EMP2341    RICHARD                        Philipe
955, rue bernard, Coudekerque

EMP8765    Hugo                           Victor
432, rue victor-hugo, Frethun

EMP4328    Stevenson                      Max
874, rue max-stevenson, Cologne


NUMERO     NOM                            PRENOM
---------- ------------------------------ --------------------
ADRESSE
--------------------------------------------------------------------------------
EMP7862    DURAND                         Christophe
543, rue durand, Calais

EMP1190    ROGER                          St├®phane
362, rue st├®phane-roger, Ardre

EMP1401    ROUSSELLE                      Nicolas
397, rue noclas-rousselle, St-Omer


12 rows selected.

SQL> rollback;

Rollback complete.

SQL> select * from EMPLOYE;

NUMERO     NOM                            PRENOM
---------- ------------------------------ --------------------
ADRESSE
--------------------------------------------------------------------------------
EMP1090    DUPONT                         Jean
332, rue jean-dupont, Calais

EMP1301    DUVIVIER                       Renaud
345, rue renaud-duviver, Paris

EMP1208    GODART                         Claude
674, rue claude-godart, Ardre


NUMERO     NOM                            PRENOM
---------- ------------------------------ --------------------
ADRESSE
--------------------------------------------------------------------------------
EMP2025    FONTAINE                       Fabien
456, rue jean-louis, Calais

EMP1505    VASSEUR                        Jacques
778, rue vasseur, Saint-Omer

EMP7645    BERNARD                        Martin
876, rue martin, Sangatte


NUMERO     NOM                            PRENOM
---------- ------------------------------ --------------------
ADRESSE
--------------------------------------------------------------------------------
EMP2341    RICHARD                        Philipe
955, rue bernard, Coudekerque

EMP8765    Hugo                           Victor
432, rue victor-hugo, Frethun

EMP4328    Stevenson                      Max
874, rue max-stevenson, Cologne


NUMERO     NOM                            PRENOM
---------- ------------------------------ --------------------
ADRESSE
--------------------------------------------------------------------------------
EMP7862    DURAND                         Christophe
543, rue durand, Calais

EMP1190    ROGER                          St├®phane
362, rue st├®phane-roger, Ardre

EMP1401    ROUSSELLE                      Nicolas
397, rue noclas-rousselle, St-Omer


12 rows selected.

*/

-- SQL> rollback;

-- Rollback complete.

/*
SQL> select * from EMPLOYE;

NUMERO     NOM                            PRENOM
---------- ------------------------------ --------------------
ADRESSE
--------------------------------------------------------------------------------
EMP1090    DUPONT                         Jean
332, rue jean-dupont, Calais

EMP1301    DUVIVIER                       Renaud
345, rue renaud-duviver, Paris

EMP1208    GODART                         Claude
674, rue claude-godart, Ardre


NUMERO     NOM                            PRENOM
---------- ------------------------------ --------------------
ADRESSE
--------------------------------------------------------------------------------
EMP2025    FONTAINE                       Fabien
456, rue jean-louis, Calais

EMP1505    VASSEUR                        Jacques
778, rue vasseur, Saint-Omer

EMP7645    BERNARD                        Martin
876, rue martin, Sangatte


NUMERO     NOM                            PRENOM
---------- ------------------------------ --------------------
ADRESSE
--------------------------------------------------------------------------------
EMP2341    RICHARD                        Philipe
955, rue bernard, Coudekerque

EMP8765    Hugo                           Victor
432, rue victor-hugo, Frethun

EMP4328    Stevenson                      Max
874, rue max-stevenson, Cologne


NUMERO     NOM                            PRENOM
---------- ------------------------------ --------------------
ADRESSE
--------------------------------------------------------------------------------
EMP7862    DURAND                         Christophe
543, rue durand, Calais

EMP1190    ROGER                          St├®phane
362, rue st├®phane-roger, Ardre

EMP1401    ROUSSELLE                      Nicolas
397, rue noclas-rousselle, St-Omer


12 rows selected.

SQL>
*/
