/* 
-- Nom: Boualil 
-- Prenom: Youcef
-- L3 Informatique
 */

-- *****************************************************************************
-- ***************                  TP 04                  *********************
-- *****************************************************************************

-- _____________________________________________________________________________
--
-- ***************************************************************************** 
-- 1. Fonction stockée Get_Emp_Name qui prend en paramètre un numéro d'employé et
-- retourne une chaîne de caractères correspondant à la concaténation du nom et du prénom
-- de l'employé correspondant. Gère les exceptions.
-- *****************************************************************************

CREATE OR REPLACE FUNCTION Get_Emp_Name (p_empno IN EMPLOYE.NUMERO%TYPE)
RETURN VARCHAR2
IS
    v_emp_name VARCHAR2(100);
BEGIN
    -- Récupérer le nom et le prénom de l'employé
    SELECT NOM || ' ' || PRENOM
    INTO v_emp_name
    FROM EMPLOYE
    WHERE NUMERO = p_empno;

    RETURN v_emp_name;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Employee not found';
    WHEN OTHERS THEN
        RETURN 'An error occurred. Precision erreur : ' || SQLERRM;
END;
/

/*
SQL> @fct_procedures.sql

Function created.
*/

-- TESTS de la fonction Get_Emp_Name:

-- Appel de la fonction avec un numéro d'employé existant
DECLARE
    v_emp_name VARCHAR2(100);
BEGIN
    v_emp_name := Get_Emp_Name('EMP1090'); 
    DBMS_OUTPUT.PUT_LINE('Nom de l''employe : ' || v_emp_name);
END;
/

/*
Nom de l'employe : DUPONT Jean

PL/SQL procedure successfully completed.
*/

-- Appel de la fonction avec un numero d'employe inexistant
DECLARE
    v_emp_name VARCHAR2(100);
BEGIN
    v_emp_name := Get_Emp_Name('9999'); 
    DBMS_OUTPUT.PUT_LINE('Nom de l''employe : ' || v_emp_name);
END;
/

/*
Nom de l'employe : Employee not found

PL/SQL procedure successfully completed.
*/

-- _____________________________________________________________________________
--
-- ***************************************************************************** 
-- 2. Afficher les noms et chiffres d'affaires (ainsi que le nom du responsable) des 3 rayons
-- les plus performants de l'hypermarché dont le numéro est passé en paramètre.
-- Utilisation d'un curseur et de la fonction Get_Emp_Name pour récupérer le nom du responsable.
-- *****************************************************************************

CREATE OR REPLACE PROCEDURE Afficher_Top3_Rayons (
    p_num_hyper IN HYPERMARCHE.NUMERO%TYPE
)
IS
    CURSOR c_top_rayons IS
        SELECT R.NOM, R.CHIFFREAFFAIRE, R.NUMERORESPONSABLE
        FROM RAYON R
        WHERE R.NUMEROHYPER = p_num_hyper
        ORDER BY R.CHIFFREAFFAIRE DESC
        FETCH FIRST 3 ROWS ONLY;

    v_rayon_nom RAYON.NOM%TYPE;
    v_rayon_ca RAYON.CHIFFREAFFAIRE%TYPE;
    v_responsable_num RAYON.NUMERORESPONSABLE%TYPE;
    v_responsable_nom VARCHAR2(100);
    v_found BOOLEAN := FALSE;
BEGIN
    OPEN c_top_rayons;
    LOOP
        FETCH c_top_rayons INTO v_rayon_nom, v_rayon_ca, v_responsable_num;
        EXIT WHEN c_top_rayons%NOTFOUND;

        v_found := TRUE;
        v_responsable_nom := Get_Emp_Name(v_responsable_num);

        DBMS_OUTPUT.PUT_LINE('Rayon: ' || v_rayon_nom || ', CA: ' || v_rayon_ca || ', Responsable: ' || v_responsable_nom);
    END LOOP;
    CLOSE c_top_rayons;

    IF NOT v_found THEN
        DBMS_OUTPUT.PUT_LINE('Aucune donnée trouvée pour l hypermarché ' || p_num_hyper);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erreur: ' || SQLERRM);
END;
/

-- Test de la procédure Afficher_Top3_Rayons
BEGIN
    Afficher_Top3_Rayons('HYP12'); 
END;
/
/*
Procedure created.

Rayon: Boucherie, CA: 1000000, Responsable: DURAND Christophe
Rayon: Poissonnerie, CA: 950000, Responsable: RICHARD Philipe

PL/SQL procedure successfully completed.
*/

-- Test de la procédure Afficher_Top3_Rayons avec un hypermarché sans données
BEGIN
    Afficher_Top3_Rayons('HYP76'); 
END;
/

/*
Aucune donnée trouvée pour l hypermarché HYP76

PL/SQL procedure successfully completed.
*/



-- _____________________________________________________________________________
--
-- ***************************************************************************** 
-- 3. Mettre à jour la quantité de produits en stock et le chiffre d'affaires du rayon
-- pour un produit vendu. Gérer les exceptions.
-- *****************************************************************************
CREATE OR REPLACE PROCEDURE Produit_vendu (
    p_num_produit IN PRODUITS.NUMERO%TYPE,
    p_quantite_vendue IN NUMBER
)
IS
    v_quantite_stock PRODUITS.QUANTITESTOCKHYPER%TYPE;
    v_prix_unitaire PRODUITS.PRIXUNITAIRE%TYPE;
    v_num_rayon PRODUITS.NUMERORAYON%TYPE;
    v_chiffre_affaire RAYON.CHIFFREAFFAIRE%TYPE;
BEGIN
    SELECT QUANTITESTOCKHYPER, PRIXUNITAIRE, NUMERORAYON
    INTO v_quantite_stock, v_prix_unitaire, v_num_rayon
    FROM PRODUITS
    WHERE NUMERO = p_num_produit;

    -- je vérifie si la quantité en stock est suffisante
    IF v_quantite_stock < p_quantite_vendue THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : Quantité en stock insuffisante pour le produit ' || p_num_produit);
        RETURN;
    END IF;

    UPDATE PRODUITS
    SET QUANTITESTOCKHYPER = v_quantite_stock - p_quantite_vendue
    WHERE NUMERO = p_num_produit;

    -- Calculer le chiffre d'affaires 
    v_chiffre_affaire := p_quantite_vendue * v_prix_unitaire;

    -- Mettre à jour le chiffre d'affaires du rayon
    UPDATE RAYON
    SET CHIFFREAFFAIRE = CHIFFREAFFAIRE + v_chiffre_affaire
    WHERE NUMERO = v_num_rayon;

    DBMS_OUTPUT.PUT_LINE('Le produit ' || p_num_produit || ' a ete vendu. Quantite vendue : ' || p_quantite_vendue || '. Chiffre d affaires genere : ' || v_chiffre_affaire);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : Le produit ' || p_num_produit || ' n existe pas.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Une erreur s est produite : ' || SQLERRM);
END;
/

-- Test avant la vente du produit:
--
-- quantité en stock du produit PR1234
SELECT NUMERO, LIBELLE, QUANTITESTOCKHYPER
FROM PRODUITS
WHERE NUMERO = 'PR1234';

-- chiffre d'affaires du rayon 1234
SELECT R.NUMERO, R.NOM, R.CHIFFREAFFAIRE
FROM RAYON R
JOIN PRODUITS P ON R.NUMERO = P.NUMERORAYON
WHERE P.NUMERO = 'PR1234';

/*
NUMERO     LIBELLE                        QUANTITESTOCKHYPER
---------- ------------------------------ ------------------
PR1234     C├┤tes de b┼ôuf                               345


NUMERO     NOM                            CHIFFREAFFAIRE
---------- ------------------------------ --------------
RAY34      Boucherie                             1000000
*/

-- Test de la procédure Produit_vendu
BEGIN
    Produit_vendu('PR1234', 10); 
END;
/

-- Test après la vente du produit 10 unités:
-- quantité en stock du produit PR1234
SELECT NUMERO, LIBELLE, QUANTITESTOCKHYPER
FROM PRODUITS
WHERE NUMERO = 'PR1234';

-- chiffre d'affaires du rayon associé au produit PR1234
SELECT R.NUMERO, R.NOM, R.CHIFFREAFFAIRE
FROM RAYON R
JOIN PRODUITS P ON R.NUMERO = P.NUMERORAYON
WHERE P.NUMERO = 'PR1234';

/*
NUMERO     LIBELLE                        QUANTITESTOCKHYPER
---------- ------------------------------ ------------------
PR1234     C├┤tes de b┼ôuf                               335


NUMERO     NOM                            CHIFFREAFFAIRE
---------- ------------------------------ --------------
RAY34      Boucherie                             1000125
*/

-- _____________________________________________________________________________ 

-- ***************************************************************************** 
-- 4. Attribuer des primes aux chefs des 3 rayons les plus performants pour les hypermarchés
-- de la région Nord/Pas-de-Calais. Deux versions : avec IF et avec CASE.
-- *****************************************************************************

-- Remarque : 
-- Ce que j'ai fait ici , pour chaque hypermarché de cette région, les rayons sont triés par chiffre d'affaires décroissant.
-- Les trois premiers chefs de rayon reçoivent des primes selon les montants en paramètres.
-- 
-- La procédure Accorder_Primes_IF utilise des instructions IF pour déterminer le montant de la prime
-- en fonction du rang du chef de rayon. La procédure Accorder_Primes_CASE utilise des instructions CASE
-- pour la même logique.
-- 
-- J'ai utiliser séquence (SEQ_PRIME_NUM) pour générer des numéros uniques pour chaque prime attribuée.
-- Les informations sur les primes (numéro, numéro de l'employé, numéro du rayon, montant de la prime, mois/année)
-- sont ensuite insérées dans la table Primes.

-- Ajout de la séquence SEQ_PRIME_NUM
DECLARE
    v_seq_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_seq_count
    FROM USER_SEQUENCES
    WHERE SEQUENCE_NAME = 'SEQ_PRIME_NUM';

    IF v_seq_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE SEQUENCE SEQ_PRIME_NUM START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE';
        DBMS_OUTPUT.PUT_LINE('Sequence SEQ_PRIME_NUM cree avec succes.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Sequence SEQ_PRIME_NUM existe deja.');
    END IF;
END;
/

-- Avec IF:
CREATE OR REPLACE PROCEDURE Accorder_Primes_IF (
    p_prime1 IN NUMBER,
    p_prime2 IN NUMBER,
    p_prime3 IN NUMBER
)
IS
    CURSOR c_top_rayons IS
        SELECT R.NUMERO, R.NUMERORESPONSABLE, R.CHIFFREAFFAIRE
        FROM RAYON R
        JOIN HYPERMARCHE H ON R.NUMEROHYPER = H.NUMERO
        WHERE H.VILLE IN ('Calais', 'Lille', 'Saint-Omer', 'Coquelles', 'Ardre', 'Sangatte', 'Coudekerque', 'Frethun')
        ORDER BY R.CHIFFREAFFAIRE DESC
        FETCH FIRST 3 ROWS ONLY;

    v_rayon_num RAYON.NUMERO%TYPE;
    v_responsable_num RAYON.NUMERORESPONSABLE%TYPE;
    v_chiffre_affaire RAYON.CHIFFREAFFAIRE%TYPE;
    v_montant_prime NUMBER(10, 2);
    v_mois_annee VARCHAR2(7) := TO_CHAR(SYSDATE, 'MM/YYYY');
    v_prime_num VARCHAR2(20); 
    v_counter NUMBER := 0;
BEGIN
    OPEN c_top_rayons;
    LOOP
        FETCH c_top_rayons INTO v_rayon_num, v_responsable_num, v_chiffre_affaire;
        EXIT WHEN c_top_rayons%NOTFOUND;
        v_counter := v_counter + 1;

        IF v_counter = 1 THEN
            v_montant_prime := p_prime1;
        ELSIF v_counter = 2 THEN
            v_montant_prime := p_prime2;
        ELSIF v_counter = 3 THEN
            v_montant_prime := p_prime3;
        END IF;

        v_prime_num := 'PRIME' || TO_CHAR(SEQ_PRIME_NUM.NEXTVAL);

        INSERT INTO Primes (numero, numeroEmploye, numeroRayon, montantPrime, moisAnnee)
        VALUES (v_prime_num, v_responsable_num, v_rayon_num, v_montant_prime, v_mois_annee);
    END LOOP;
    CLOSE c_top_rayons;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erreur: ' || SQLERRM);
END;
/

-- Avec CASE:
CREATE OR REPLACE PROCEDURE Accorder_Primes_CASE (
    p_prime1 IN NUMBER,
    p_prime2 IN NUMBER,
    p_prime3 IN NUMBER
)
IS
    CURSOR c_top_rayons IS
        SELECT R.NUMERO, R.NUMERORESPONSABLE, R.CHIFFREAFFAIRE
        FROM RAYON R
        JOIN HYPERMARCHE H ON R.NUMEROHYPER = H.NUMERO
        WHERE H.VILLE IN ('Calais', 'Lille', 'Saint-Omer', 'Coquelles', 'Ardre', 'Sangatte', 'Coudekerque', 'Frethun')
        ORDER BY R.CHIFFREAFFAIRE DESC
        FETCH FIRST 3 ROWS ONLY;

    v_rayon_num RAYON.NUMERO%TYPE;
    v_responsable_num RAYON.NUMERORESPONSABLE%TYPE;
    v_chiffre_affaire RAYON.CHIFFREAFFAIRE%TYPE; 
    v_montant_prime NUMBER(10, 2);
    v_mois_annee VARCHAR2(7) := TO_CHAR(SYSDATE, 'MM/YYYY');
    v_prime_num VARCHAR2(20); 
    v_counter NUMBER := 0;
BEGIN
    OPEN c_top_rayons;
    LOOP
        FETCH c_top_rayons INTO v_rayon_num, v_responsable_num, v_chiffre_affaire;
        EXIT WHEN c_top_rayons%NOTFOUND;
        v_counter := v_counter + 1;

        v_montant_prime := CASE v_counter
            WHEN 1 THEN p_prime1
            WHEN 2 THEN p_prime2
            WHEN 3 THEN p_prime3
            ELSE 0
        END;

        v_prime_num := 'PRIME' || TO_CHAR(SEQ_PRIME_NUM.NEXTVAL);

        INSERT INTO Primes (numero, numeroEmploye, numeroRayon, montantPrime, moisAnnee)
        VALUES (v_prime_num, v_responsable_num, v_rayon_num, v_montant_prime, v_mois_annee);
    END LOOP;
    CLOSE c_top_rayons;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erreur: ' || SQLERRM);
END;
/

-- Test Accorder_Primes_IF
BEGIN
    Accorder_Primes_IF(1000, 750, 500);
END;
/


-- Test Accorder_Primes_CASE
BEGIN
    Accorder_Primes_CASE(1000, 750, 500);
END;
/

-- insertions dans la table Primes
SELECT * FROM Primes;

/*
PL/SQL procedure successfully completed.


NUMERO     NUMEROEMPL NUMERORAYO MONTANTPRIME MOISANN
---------- ---------- ---------- ------------ -------
PRIME1     EMP1505    RAY45              1000 01/2025
PRIME2     EMP7862    RAY34               750 01/2025
PRIME3     EMP2341    RAY86               500 01/2025
*/

-- _____________________________________________________________________________

-- ***************************************************************************** 
-- 5. Afficher la liste des responsables de rayon avec le cumul des primes 
-- pour un magasin donné, incluant ceux sans primes (cumul = 0). 
-- Version triée par ordre décroissant du cumul des primes incluse.
-- *****************************************************************************
CREATE OR REPLACE PROCEDURE Afficher_Cumul_Primes (
    p_num_hyper IN HYPERMARCHE.NUMERO%TYPE
)
IS
    v_count INTEGER;
BEGIN
    -- Vérifie qu'un responsable existe pour cet hypermarché
    SELECT COUNT(*)
    INTO v_count
    FROM RAYON
    WHERE NUMEROHYPER = p_num_hyper;

    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Aucun responsable trouvé pour cet hypermarché.');
        RETURN;
    END IF;

    FOR rec IN (
        SELECT R.NUMERORESPONSABLE, E.NOM, E.PRENOM, NVL(SUM(P.MONTANTPRIME), 0) AS CUMUL_PRIMES
        FROM RAYON R
        LEFT JOIN EMPLOYE E ON R.NUMERORESPONSABLE = E.NUMERO
        LEFT JOIN PRIMES P ON R.NUMERORESPONSABLE = P.NUMEROEMPLOYE
        WHERE R.NUMEROHYPER = p_num_hyper
        GROUP BY R.NUMERORESPONSABLE, E.NOM, E.PRENOM
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Responsable: ' || rec.NOM || ' ' || rec.PRENOM || ', Cumul des primes: ' || rec.CUMUL_PRIMES);
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erreur: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE Afficher_Cumul_Primes_Desc (
    p_num_hyper IN HYPERMARCHE.NUMERO%TYPE
)
IS
    v_count INTEGER;
BEGIN
    -- Vérifie qu'un responsable existe
    SELECT COUNT(*)
    INTO v_count
    FROM RAYON
    WHERE NUMEROHYPER = p_num_hyper;

    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Aucun responsable trouvé pour cet hypermarché.');
        RETURN;
    END IF;

    FOR rec IN (
        SELECT R.NUMERORESPONSABLE, E.NOM, E.PRENOM, NVL(SUM(P.MONTANTPRIME), 0) AS CUMUL_PRIMES
        FROM RAYON R
        LEFT JOIN EMPLOYE E ON R.NUMERORESPONSABLE = E.NUMERO
        LEFT JOIN PRIMES P ON R.NUMERORESPONSABLE = P.NUMEROEMPLOYE
        WHERE R.NUMEROHYPER = p_num_hyper
        GROUP BY R.NUMERORESPONSABLE, E.NOM, E.PRENOM
        ORDER BY CUMUL_PRIMES DESC
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Responsable: ' || rec.NOM || ' ' || rec.PRENOM || ', Cumul des primes: ' || rec.CUMUL_PRIMES);
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erreur: ' || SQLERRM);
END;
/
-- Test de la procédure Afficher_Cumul_Primes
BEGIN
    Afficher_Cumul_Primes('HYP12'); 
END;
/
/*
Procedure created.

Responsable: DURAND Christophe, Cumul des primes: 750
Responsable: RICHARD Philipe, Cumul des primes: 500

PL/SQL procedure successfully completed.
*/

-- Test de la procédure Afficher_Cumul_Primes_Desc
BEGIN
    Afficher_Cumul_Primes_Desc('HYP76'); 
END;
/

/*
SQL> BEGIN
  2      Afficher_Cumul_Primes_Desc('HYP76'); 
  3  END;
  4  /
Aucun responsable trouvé pour cet hypermarché.

PL/SQL procedure successfully completed.
*/

