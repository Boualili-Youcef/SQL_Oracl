/* 
-- Nom: Boualil 
-- Prenom: Youcef
-- L3 Informatique
 */

-- _____________________________________________________________________________
-- *****************************************************************************
-- ***************************** TP 05 *****************************************
-- **********************************************************************²*******
-- _____________________________________________________________________________


-- Exercice 1: 
-- Ecrire une procédure qui permet de désactiver (mettre « encours » à 0) les promotions dont la date est
-- dépassée.

CREATE OR REPLACE PROCEDURE Desactiver_Promotions_Expirees IS
BEGIN
    UPDATE promotions
    SET encours = 0
    WHERE date_fin < SYSDATE AND encours = 1;
    
    DBMS_OUTPUT.PUT_LINE('Nombre de promotions desactivees : ' || SQL%ROWCOUNT);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erreur lors de la desactivation des promotions : ' || SQLERRM);
END;
/

-- Insérer des promotions de test
INSERT INTO Promotions (numero, numproduit, pourcentage_remise, date_debut, date_fin, encours, qteVendue)
VALUES ('PRO002', 'PR1234', 10, TO_DATE('01-DEC-2024', 'DD-MON-YYYY'), TO_DATE('15-DEC-2024', 'DD-MON-YYYY'), 1, 0);

INSERT INTO Promotions (numero, numproduit, pourcentage_remise, date_debut, date_fin, encours, qteVendue)
VALUES ('PRO003', 'PR1234', 15, TO_DATE('01-JAN-2025', 'DD-MON-YYYY'), TO_DATE('5-FEB-2025', 'DD-MON-YYYY'), 1, 0);

INSERT INTO Promotions (numero, numproduit, pourcentage_remise, date_debut, date_fin, encours, qteVendue)
VALUES ('PRO004', 'PR1234', 20, TO_DATE('01-FEB-2025', 'DD-MON-YYYY'), TO_DATE('25-FEB-2025', 'DD-MON-YYYY'), 1, 0);

SELECT * FROM Promotions;

-- Test de la procedure
BEGIN
    Desactiver_Promotions_Expirees;
END;
/

-- Vérifier les promotions désactivées
SELECT * FROM Promotions WHERE encours = 0;
SELECT * FROM Promotions WHERE encours = 1;

-- Supprimer les promotions de test
DELETE FROM Promotions WHERE numero IN ('PRO002', 'PRO003', 'PRO004');

/*
SQL> @tp5_triggers_procedures.sql

Procedure created.


1 row created.


1 row created.


1 row created.


NUMERO NUMPRO POURCENTAGE_REMISE DATE_DEBU DATE_FIN     ENCOURS  QTEVENDUE
------ ------ ------------------ --------- --------- ---------- ----------
PRO003 PR1234                 15 01-JAN-25 05-FEB-25          1          0
PRO004 PR1234                 20 01-FEB-25 25-FEB-25          1          0
PRO002 PR1234                 10 01-DEC-24 15-DEC-24          1          0

Nombre de promotions desactivees : 1

PL/SQL procedure successfully completed.


NUMERO NUMPRO POURCENTAGE_REMISE DATE_DEBU DATE_FIN     ENCOURS  QTEVENDUE
------ ------ ------------------ --------- --------- ---------- ----------
PRO002 PR1234                 10 01-DEC-24 15-DEC-24          0          0


NUMERO NUMPRO POURCENTAGE_REMISE DATE_DEBU DATE_FIN     ENCOURS  QTEVENDUE
------ ------ ------------------ --------- --------- ---------- ----------
PRO003 PR1234                 15 01-JAN-25 05-FEB-25          1          0
PRO004 PR1234                 20 01-FEB-25 25-FEB-25          1          0


3 rows deleted.
*/


-- __________________________________________________________________________________________________
--**************************************************************************************************
-- Exercice 2:
-- Déclencheur pour mettre en majuscule les champs NOM et PRENOM lors de l'insertion d'un employé
-- **************************************************************************************************

/*
Le déclencheur trg_emp_upper est conçu pour convertir les champs NOM et PRENOM 
en majuscules avant l'insertion d'un nouvel employé dans la table EMPLOYE
*/
CREATE OR REPLACE TRIGGER trg_emp_upper
BEFORE INSERT ON EMPLOYE
FOR EACH ROW
BEGIN
    :new.NOM := UPPER(:new.NOM);
    :new.PRENOM := UPPER(:new.PRENOM);
END;
/

-- Insérer des employés de test
INSERT INTO EMPLOYE (NUMERO, NOM, PRENOM, ADRESSE)
VALUES (1, 'white', 'walter', '123 rue du nord');

INSERT INTO EMPLOYE (NUMERO, NOM, PRENOM, ADRESSE)
VALUES (2, 'pinkman', 'jesse', '456 rue du sud');

INSERT INTO EMPLOYE (NUMERO, NOM, PRENOM, ADRESSE)
VALUES (3, 'fring', 'gustavo', '789 rue de l''est');

-- Vérifier les employés insérés
SELECT * FROM EMPLOYE;

-- Resultat attendu:
/*
NUMERO     NOM                            PRENOM
---------- ------------------------------ --------------------
ADRESSE
--------------------------------------------------------------------------------
1          WHITE                          WALTER
123 rue du nord

2          PINKMAN                        JESSE
456 rue du sud

3          FRING                          GUSTAVO
789 rue de l'est
*/

-- __________________________________________________________________________________________________
--**************************************************************************************************
-- Exercice 3:
-- DEcrire un trigger qui permet de renseigner le champ « encours » d'une promotion lors de son insertion
-- dans la table Promotions.
-- **************************************************************************************************

CREATE OR REPLACE TRIGGER trg_set_encours
BEFORE INSERT ON promotions
FOR EACH ROW
BEGIN
    IF SYSDATE BETWEEN :new.date_debut AND :new.date_fin THEN
        :new.encours := 1;
    ELSE
        :new.encours := 0;
    END IF;
END;
/

-- Insérer des promotions de test
INSERT INTO Promotions (numero, numproduit, pourcentage_remise, date_debut, date_fin, encours, qteVendue)
VALUES ('PRO005', 'PR1234', 10, TO_DATE('01-DEC-2022', 'DD-MON-YYYY'), TO_DATE('15-DEC-2022', 'DD-MON-YYYY'), NULL, 0);

INSERT INTO Promotions (numero, numproduit, pourcentage_remise, date_debut, date_fin, encours, qteVendue)
VALUES ('PRO006', 'PR1234', 15, TO_DATE('01-JAN-2025', 'DD-MON-YYYY'), TO_DATE('15-JAN-2025', 'DD-MON-YYYY'), NULL, 0);

INSERT INTO Promotions (numero, numproduit, pourcentage_remise, date_debut, date_fin, encours, qteVendue)
VALUES ('PRO007', 'PR1234', 20, TO_DATE('01-FEB-2025', 'DD-MON-YYYY'), TO_DATE('25-FEB-2025', 'DD-MON-YYYY'), NULL, 0);

-- Vérifier les promotions insérées
SELECT * FROM Promotions;

DELETE FROM Promotions WHERE numero IN ('PRO005', 'PRO006', 'PRO007');

-- Resultat attendu:
/*

Trigger created.


1 row created.


1 row created.


1 row created.


NUMERO NUMPRO POURCENTAGE_REMISE DATE_DEBU DATE_FIN     ENCOURS  QTEVENDUE
------ ------ ------------------ --------- --------- ---------- ----------
PRO006 PR1234                 15 01-JAN-25 15-JAN-25          0          0
PRO007 PR1234                 20 01-FEB-25 25-FEB-25          1          0
PRO005 PR1234                 10 01-DEC-22 15-DEC-22          0          0


3 rows deleted.

SQL>
*/


-- __________________________________________________________________________________________________
--**************************************************************************************************
-- Exercice 4:
-- Trigger qui annule l'insertion d'une promotion déjà dépassée
-- **************************************************************************************************
CREATE OR REPLACE TRIGGER trg_annule_promotion
BEFORE INSERT ON promotions
FOR EACH ROW
BEGIN
    IF :new.date_fin < SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20001, 'Impossible d''inserer une promotion deja expiroe.');
    END IF;
END;
/

-- Insérer des promotions de test
-- Cette insertion devrait échouer car la date de fin est passée
BEGIN
    INSERT INTO Promotions (numero, numproduit, pourcentage_remise, date_debut, date_fin, encours, qteVendue)
    VALUES ('PRO008', 'PR1234', 10, TO_DATE('01-DEC-2022', 'DD-MON-YYYY'), TO_DATE('15-DEC-2022', 'DD-MON-YYYY'), 0, 0);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

-- Cette insertion devrait réussir car la date de fin est dans le futur
INSERT INTO Promotions (numero, numproduit, pourcentage_remise, date_debut, date_fin, encours, qteVendue)
VALUES ('PRO009', 'PR1234', 15, TO_DATE('01-JAN-2025', 'DD-MON-YYYY'), TO_DATE('25-FEB-2025', 'DD-MON-YYYY'), 0, 0);

-- Vérifier les promotions insérées
SELECT * FROM Promotions;

-- Supprimer les promotions de test
DELETE FROM Promotions WHERE numero IN ('PRO008', 'PRO009');

-- resultat attendu
/*
Trigger created.

ORA-20001: Impossible d'inserer une promotion deja expiroe.
ORA-06512: at
"C##YOUCEF.TRG_ANNULE_PROMOTION", line 3
ORA-04088: error during execution of
trigger 'C##YOUCEF.TRG_ANNULE_PROMOTION'

PL/SQL procedure successfully completed.


1 row created.


NUMERO NUMPRO POURCENTAGE_REMISE DATE_DEBU DATE_FIN     ENCOURS  QTEVENDUE
------ ------ ------------------ --------- --------- ---------- ----------
PRO009 PR1234                 15 01-JAN-25 25-FEB-25          1          0


1 row deleted.

SQL>
*/


-- __________________________________________________________________________________________________
--**************************************************************************************************
-- Exercice 5:
-- Trigger qui met à jour le chiffre d'affaires du rayon lorsqu'une vente est réalisée (baisse du stock)
-- **************************************************************************************************
CREATE OR REPLACE TRIGGER trg_update_rayon_ca
AFTER UPDATE OF QUANTITESTOCKHYPER ON PRODUITS
FOR EACH ROW
DECLARE
    v_quantity_sold NUMBER;
    v_sale_amount   NUMBER;
BEGIN
    IF :new.QUANTITESTOCKHYPER < :old.QUANTITESTOCKHYPER THEN
        v_quantity_sold := :old.QUANTITESTOCKHYPER - :new.QUANTITESTOCKHYPER;
        v_sale_amount := v_quantity_sold * :old.PRIXUNITAIRE;
        
        UPDATE RAYON
        SET CHIFFREAFFAIRE = NVL(CHIFFREAFFAIRE, 0) + v_sale_amount
        WHERE NUMERO = :old.NUMERORAYON;
    END IF;
END;
/

-- Insérer des rayons de test
INSERT INTO RAYON (NUMERO, NOM, DESCRIPTIF, CHIFFREAFFAIRE, NUMEROHYPER, NUMERORESPONSABLE)
VALUES ('RAY555', 'Viandes', 'Viandes et volailles', 0, 'HYP43', 'EMP4328');

-- Insérer des produits de test
INSERT INTO PRODUITS (NUMERO, LIBELLE, NUMERORAYON, PRIXUNITAIRE, UNITE, QUANTITESTOCKHYPER)
VALUES ('PR1', 'Côtes de bœuf', 'RAY555', 12.50, 'kg', 345);

SELECT * FROM RAYON WHERE NUMERO = 'RAY555';

-- Mettre à jour la quantité en stock d'un produit
UPDATE PRODUITS
SET QUANTITESTOCKHYPER = 90
WHERE NUMERO = 'PR1';

-- Vérifier les rayons mis à jour
SELECT * FROM RAYON WHERE NUMERO = 'RAY555';

-- Supprimer les données de test
DELETE FROM PRODUITS WHERE NUMERO = 'PR1';
DELETE FROM RAYON WHERE NUMERO = 'RAY555';

-- Resultat attendu:

/*
Trigger created.


1 row created.


1 row created.


NUMERO     NOM
---------- ------------------------------
DESCRIPTIF
--------------------------------------------------------------------------------
CHIFFREAFFAIRE NUMEROHYPE NUMERORESP
-------------- ---------- ----------
RAY555     Viandes
Viandes et volailles
             0 HYP43      EMP4328



1 row updated.


NUMERO     NOM
---------- ------------------------------
DESCRIPTIF
--------------------------------------------------------------------------------
CHIFFREAFFAIRE NUMEROHYPE NUMERORESP
-------------- ---------- ----------
RAY555     Viandes
Viandes et volailles
        3187.5 HYP43      EMP4328



1 row deleted.


1 row deleted.

SQL>
*/