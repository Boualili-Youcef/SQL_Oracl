/* 
-- Nom: Boualil 
-- Prénom: Youcef
-- L3 Informatique
 */

-- *****************************************************************************
-- ***************                  TP 04                  *********************
-- *****************************************************************************

/*
1. Écrire une fonction stockée Get_Emp_Name, qui prend en paramètre un numéro d'employé et
retourne une chaîne de caractères correspondant à la concaténation du nom et du prénom de
l'employé correspondant.
*/


CREATE OR REPLACE FUNCTION Get_Emp_Name (p_empno IN EMPLOYE.NUMERO%TYPE)
RETURN VARCHAR2
IS
    v_emp_name VARCHAR2(100);
BEGIN
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

-- *****************************************************************************
/*
2. Écrire une procédure stockée qui affiche les noms et chiffres d'affaires (ainsi que le nom du
responsable) des 3 rayons les plus performants de l'hypermarché dont le numéro est passé en
paramètre. On vous demande d'utiliser un curseur, ainsi que la fonction écrite à la question 1
pour récupérer le nom du responsable du rayon. 
*/

CREATE OR REPLACE PROCEDURE Afficher_Top3_Rayons (
    p_hypermarche_num IN HYPERMARCHE.NUMERO%TYPE
)
IS
    CURSOR c_top_rayons IS
        SELECT R.NOM, R.CHIFFREAFFAIRE, R.NUMERORESPONSABLE
        FROM RAYON R
        WHERE R.NUMEROHYPER = p_hypermarche_num
        ORDER BY R.CHIFFREAFFAIRE DESC
        FETCH FIRST 3 ROWS ONLY; -- je fetch les 3 premières lignes

    v_rayon_nom RAYON.NOM%TYPE;
    v_rayon_ca RAYON.CHIFFREAFFAIRE%TYPE;
    v_responsable_num RAYON.NUMERORESPONSABLE%TYPE;
    v_responsable_nom VARCHAR2(100);
BEGIN
    OPEN c_top_rayons;
    LOOP
        FETCH c_top_rayons INTO v_rayon_nom, v_rayon_ca, v_responsable_num;
        EXIT WHEN c_top_rayons%NOTFOUND;

        v_responsable_nom := Get_Emp_Name(v_responsable_num);

        DBMS_OUTPUT.PUT_LINE('Rayon: ' || v_rayon_nom || ', CA: ' || v_rayon_ca || ', Responsable: ' || v_responsable_nom);
    END LOOP;
    CLOSE c_top_rayons;
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