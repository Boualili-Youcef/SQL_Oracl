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
