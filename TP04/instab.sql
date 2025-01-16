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


-- 1.2 Création dynamique de tables

-- Création de la table Habitant_Calais à partir de la table EMPLOYE
CREATE TABLE Habitant_Calais AS
SELECT *
FROM EMPLOYE
WHERE adresse LIKE '%Calais%';

-- Table created.

-- Vérification de la création et des insertions
SELECT * FROM Habitant_Calais;

/*
NUMERO     NOM                            PRENOM
---------- ------------------------------ --------------------
ADRESSE
--------------------------------------------------------------------------------
EMP1090    DUPONT                         Jean
332, rue jean-dupont, Calais

EMP2025    FONTAINE                       Fabien
456, rue jean-louis, Calais

EMP7862    DURAND                         Christophe
543, rue durand, Calais
*/

-- Créer la table HYPERMARCHE_RAYON à partir des tables HYPERMARCHE et RAYON
CREATE TABLE HYPERMARCHE_RAYON AS
SELECT HYPERMARCHE.NOM AS NOM_HYPERMARCHE, RAYON.NOM AS NOM_RAYON, RAYON.CHIFFREAFFAIRE
FROM HYPERMARCHE, RAYON 
WHERE HYPERMARCHE.NUMERO = RAYON.NUMEROHYPER;

-- Table created.

-- Vérification de la création et des insertions
SELECT * FROM HYPERMARCHE_RAYON;

/*
NOM_HYPERMARCHE                NOM_RAYON                      CHIFFREAFFAIRE
------------------------------ ------------------------------ --------------
Marrefour                      Boucherie                             1000000
DO-SPORT                       Textile                              50000000
DO-SPORT                       Chaussure                              800000
Marrefour                      Poissonnerie                           950000
Dealer Price                   L├®gumes                               450000
Dealer Price                   Boucherie                              500000

6 rows selected.
*/

-- 1.3 Bloc PL/SQL

-- Activer l'affichage des messages
SET SERVEROUTPUT ON;

-- *****************************************************************************
-- 1.3.1 Bloc PL/SQL pour insérer un employé

DECLARE
    v_numero EMPLOYE.NUMERO%TYPE;
    v_nom EMPLOYE.NOM%TYPE;
    v_prenom EMPLOYE.PRENOM%TYPE;
    v_adresse EMPLOYE.ADRESSE%TYPE;
BEGIN
    -- Lire les champs de l'employé depuis le clavier
    v_numero := '&numero';
    v_nom := '&nom';
    v_prenom := '&prenom';
    v_adresse := '&adresse';

    -- Insérer l'employé dans la table EMPLOYE
    INSERT INTO EMPLOYE (NUMERO, NOM, PRENOM, ADRESSE) VALUES (v_numero, v_nom, v_prenom, v_adresse);

    DBMS_OUTPUT.PUT_LINE('Employe Insere');
END;
/

/*
Resultat:

Enter value for numero: EMP0587
old   8:     v_numero := '&numero';
new   8:     v_numero := 'EMP0587';
Enter value for nom: Boualili
old   9:     v_nom := '&nom';
new   9:     v_nom := 'Boualili';
Enter value for prenom: Youcef
old  10:     v_prenom := '&prenom';
new  10:     v_prenom := 'Youcef';
Enter value for adresse: 18, toto , Calais
old  11:     v_adresse := '&adresse';
new  11:     v_adresse := '18, toto , Calais';
Employe Insere

PL/SQL procedure successfully completed.    
*/

-- Vérification de l'insertion

/*
SQL> SELECT * FROM EMPLOYE WHERE NUMERO = 'EMP0587';

NUMERO     NOM                            PRENOM
---------- ------------------------------ --------------------
ADRESSE
--------------------------------------------------------------------------------
EMP0587    Boualili                       Youcef
18, toto , Calais
*/

-- *****************************************************************************
-- 1.3.2 Bloc PL/SQL pour insérer un employé
-- Bloc PL/SQL pour afficher les informations d'un employé

DECLARE
    v_numero EMPLOYE.NUMERO%TYPE;
    v_nom EMPLOYE.NOM%TYPE;
    v_prenom EMPLOYE.PRENOM%TYPE;
    v_adresse EMPLOYE.ADRESSE%TYPE;
BEGIN
    -- Lire le numéro de l'employé depuis le clavier
    v_numero := '&numero';

    -- Selectionner l'employe avec le numero v_numero
    SELECT NOM, PRENOM, ADRESSE
    INTO v_nom, v_prenom, v_adresse
    FROM EMPLOYE
    WHERE NUMERO = v_numero;

    -- Afficher les informations de l'employe
    DBMS_OUTPUT.PUT_LINE('Informations de l employe :');
    DBMS_OUTPUT.PUT_LINE('Numero : ' || v_numero);
    DBMS_OUTPUT.PUT_LINE('Nom : ' || v_nom);
    DBMS_OUTPUT.PUT_LINE('Prenom : ' || v_prenom);
    DBMS_OUTPUT.PUT_LINE('Adresse : ' || v_adresse);

END;
/

/*
resultat:
Enter value for numero: EMP7862
old   8:     v_numero := '&numero';
new   8:     v_numero := 'EMP7862';
Informations de l employe :
Numero : EMP7862
Nom : DURAND
Prenom : Christophe
Adresse : 543, rue durand, Calais

PL/SQL procedure successfully completed.
*/


-- *****************************************************************************
-- 1.3.3 Bloc PL/SQL affiche la moyenne des prix des produits d'un hypermarché

DECLARE
    v_numero_hyper HYPERMARCHE.NUMERO%TYPE;
    v_moyenne_prix NUMBER;
    v_count NUMBER;
BEGIN 
    v_numero_hyper := '&numero_hyper';

    -- je vérifier que l'hypermarché existe
    SELECT COUNT(*)
    INTO v_count
    FROM HYPERMARCHE
    WHERE NUMERO = v_numero_hyper;

    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Le numero d hypermarche ' || v_numero_hyper || ' n existe pas.');
    ELSE
        -- Calculer la moyenne 
        SELECT AVG(PRIXUNITAIRE)
        INTO v_moyenne_prix
        FROM PRODUITS
        WHERE NUMERORAYON IN (SELECT NUMERO FROM RAYON WHERE NUMEROHYPER = v_numero_hyper);

        -- je erifier si la moyenne est NULL sinon si on veut on peut juste afficher 0
        DBMS_OUTPUT.PUT_LINE('La moyenne des prix des produits de l hypermarche ' || v_numero_hyper || ' est : ' || v_moyenne_prix);

    END IF;
END;
/

/*
resultat: (si existant)
Enter value for numero_hyper: HYP12
old   6:     v_numero_hyper := '&numero_hyper';
new   6:     v_numero_hyper := 'HYP12';
La moyenne des prix des produits de l hypermarche HYP12 est : 12.5

PL/SQL procedure successfully completed.

(si inexistant):
Enter value for numero_hyper: 555
old   6:     v_numero_hyper := '&numero_hyper';
new   6:     v_numero_hyper := '555';
Le numero d hypermarche 555 n existe pas.

PL/SQL procedure successfully completed.
*/

-- *****************************************************************************
-- 1.3.4 Bloc PL/SQL pour créer une promotion

-- je créer une séquence pour générer les numéros de promotion
-- je vérifie si la séquence existe sinon je la crée
DECLARE 
    v_promo_seq NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_promo_seq
    FROM USER_SEQUENCES
    WHERE SEQUENCE_NAME = 'PROMO_SEQ';

    IF v_promo_seq = 0 THEN
        -- je crée la séquence promo_seq si elle n'existe pas
        EXECUTE IMMEDIATE 'CREATE SEQUENCE promo_seq
            START WITH 1
            INCREMENT BY 1
            NOCACHE
            NOCYCLE';
        DBMS_OUTPUT.PUT_LINE('Sequence promo_seq cree avec succes.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Sequence promo_seq existe deja.');
    END IF;
END;
/

/*
RESULTAT:

Sequence promo_seq existe deja.
ou 
Sequence promo_seq cree avec succes.

PL/SQL procedure successfully completed. 
*/

DECLARE
    v_numproduit PRODUITS.NUMERO%TYPE;
    v_pourcentage_remise PROMOTIONS.POURCENTAGE_REMISE%TYPE; 
    v_promotion_num PROMOTIONS.NUMERO%TYPE;
    v_count NUMBER;
    v_date_debut DATE;
    v_date_fin DATE;
BEGIN
    v_numproduit := '&numproduit';
    v_pourcentage_remise := '&pourcentage_remise';
    v_date_debut := SYSDATE;
    v_date_fin := ADD_MONTHS(SYSDATE, 1);

    -- Vérifier que le numéro de produit existe
    SELECT COUNT(*)
    INTO v_count
    FROM PRODUITS
    WHERE NUMERO = v_numproduit;

    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Le numero de produit ' || v_numproduit || ' n existe pas.');
    ELSE
        -- Generer le num de promotion
        v_promotion_num := 'PRO' || TO_CHAR(promo_seq.NEXTVAL, 'FM000');

        -- Inserer promotion
        INSERT INTO PROMOTIONS (numero, numproduit, pourcentage_remise, date_debut, date_fin)
        VALUES (v_promotion_num, v_numproduit, v_pourcentage_remise, v_date_debut, v_date_fin);

        DBMS_OUTPUT.PUT_LINE('Promotion cree avec succes.');
        DBMS_OUTPUT.PUT_LINE('Numero Promotion : ' || v_promotion_num);
        DBMS_OUTPUT.PUT_LINE('Produit : ' || v_numproduit);
        DBMS_OUTPUT.PUT_LINE('Pourcentage de remise : ' || v_pourcentage_remise || '%');
        DBMS_OUTPUT.PUT_LINE('Date de debut : ' || TO_CHAR(v_date_debut, 'DD/MM/YYYY'));
        DBMS_OUTPUT.PUT_LINE('Date de fin : ' || TO_CHAR(v_date_fin, 'DD/MM/YYYY'));
    END IF;

END;
/

/*
resultat:
Sequence created.

Enter value for numproduit: PR1234
old   9:     v_numproduit := '&numproduit';
new   9:     v_numproduit := 'PR1234';
Enter value for pourcentage_remise: 5
old  10:     v_pourcentage_remise := '&pourcentage_remise';
new  10:     v_pourcentage_remise := '5';
Promotion cree avec succes.
Numero Promotion : PRO001
Produit : PR1234
Pourcentage de remise : 5%
Date de debut : 14/01/2025
Date de fin : 14/02/2025

PL/SQL procedure successfully completed.
*/

-- Vérification de l'insertion
/*
SQL> SELECT * FROM PROMOTIONS;

NUMERO NUMPRO POURCENTAGE_REMISE DATE_DEBU DATE_FIN
------ ------ ------------------ --------- ---------
PRO001 PR1234                  5 15-JAN-25 15-FEB-25
PRO002 PR6765                 10 15-JAN-25 15-FEB-25
*/

-- *****************************************************************************
-- 1.3.5 mettre à jour le stock d'un produit dont le numéro est saisi au clavier.

-- Bloc PL/SQL pour mettre à jour le stock d'un produit
DECLARE
    v_num_produit PRODUITS.NUMERO%TYPE;
    v_nouveau_stock PRODUITS.QUANTITESTOCKHYPER%TYPE;
    v_count NUMBER;
BEGIN
    v_num_produit := '&v_num_produit';
    v_nouveau_stock := '&v_nouveau_stock';

    -- Vérifier si le produit existe
    SELECT COUNT(*)
    INTO v_count
    FROM PRODUITS
    WHERE NUMERO = v_num_produit;

    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Le numero de produit ' || v_num_produit || ' n existe pas.');
    ELSE
        -- Mettre à jour le stock
        UPDATE PRODUITS
        SET QUANTITESTOCKHYPER = v_nouveau_stock
        WHERE NUMERO = v_num_produit;

        DBMS_OUTPUT.PUT_LINE('Le stock du produit ' || v_num_produit || ' a ete mis a jour a ' || v_nouveau_stock || '.');
    END IF;
END;
/

/* 
RESULTAT:

Enter value for v_num_produit: PR1234
old   6:     v_num_produit := '&v_num_produit';
new   6:     v_num_produit := 'PR1234';
Enter value for v_nouveau_stock: 5000
old   7:     v_nouveau_stock := '&v_nouveau_stock';
new   7:     v_nouveau_stock := '5000';
Le stock du produit PR1234 a ete mis a jour a 5000.

PL/SQL procedure successfully completed.

SQL> select * FROM PRODUITS; 

NUMERO     LIBELLE                        NUMERORAYO PRIXUNITAIRE
---------- ------------------------------ ---------- ------------
UNITE                QUANTITESTOCKHYPER
-------------------- ------------------
PR1234     C├┤tes de b┼ôuf                RAY34              12.5
kg                                  120

PR5783     Chaussure Mike                 RAY67            109.99
unit├®                            56660

PR6765     SWEAT CORERUNNER               RAY45                59
unit├®                            87778
*/

