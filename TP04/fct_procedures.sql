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