-- Nom: Boualil 
-- Prénom: Youcef
-- L3 Informatique

-- *****************************************************************************
-- *********** 1.6 MISE À JOUR et suppression d’enregistrements ****************
-- *****************************************************************************

-- Supprimer l’hypermarché ‘Marrefour Market’.
DELETE FROM HYPERMARCHE WHERE NOM = 'Marrefour Market';

-- Résultat:
-- 1 row deleted.

-- REMARQUE: 
-- Après la suppression d'un hypermarché, il est crucial de vérifier si des données dans 
-- d'autres tables référencent encore cet hypermarché (clés étrangères non mises à jour).
-- Si ces références existent, elles pourraient provoquer des incohérences dans la base.
-- SELECT * FROM RAYON WHERE NUMEROHYPER NOT IN (SELECT NUMERO FROM HYPERMARCHE);
-- SELECT * FROM EMPLOYE WHERE NUMEROHYPER NOT IN (SELECT NUMERO FROM HYPERMARCHE);


-- Ici on voit bien qu'il a été supprimer
SELECT * FROM HYPERMARCHE;

/*
SQL> SELECT * FROM HYPERMARCHE;

NUMERO     NOM
---------- ------------------------------
ADRESSE
--------------------------------------------------------------------------------
VILLE                          CODEPOSTAL NUMERODIRE
------------------------------ ---------- ----------
HYP12      Marrefour
12 Bd du Kent
Coquelles                      62231      EMP1090

HYP56      DO-SPORT
45 AV Blue
Calais                         62100      EMP1208

NUMERO     NOM
---------- ------------------------------
ADRESSE
--------------------------------------------------------------------------------
VILLE                          CODEPOSTAL NUMERODIRE
------------------------------ ---------- ----------

HYP43      Dealer Price
52, Bd Hugo
Calais                         62100      EMP8765
*/



-- M RICHARD Philipe est remplacé par M VASSEUR Jacque pour gérer le rayon
-- Poissonerie de l’hypermarché Marrefour coquelle.
UPDATE RAYON 
SET NUMERORESPONSABLE = 'EMP1505'
WHERE NUMERO ='RAY86' AND NUMEROHYPER = 'HYP12' 

-- REMARQUE :
-- J'ai ajouter la condition `AND NUMEROHYPER = 'HYP12' pour s'assurer que l'opération cible
-- le bon rayon de l'hypermarché spécifique. Cela garantit que si un rayon avec le même numéro (NUMERO)
-- existe dans un autre hypermarché, il ne sera pas impacté par cette mise à jour.

-- Resultat:
-- 1 row updated.

-- Verification:
SELECT * FROM RAYON WHERE NUMERO ='RAY86' ;

/*
SQL> SELECT * FROM RAYON WHERE NUMERO ='RAY86' ;

NUMERO     NOM
---------- ------------------------------
DESCRIPTIF
--------------------------------------------------------------------------------
CHIFFREAFFAIRE NUMEROHYPE NUMERORESP
-------------- ---------- ----------
RAY86      Poissonnerie
Poissonnerie traiteur, plateau de fruits de mer.
        950000 HYP12      EMP1505
*/


-- 1) Descriptifs des rayons dont les chiffres d'affaires sont supérieurs à 1 000 000
SELECT DESCRIPTIF
FROM RAYON
WHERE CHIFFREAFFAIRE > 1000000; -- Supérieur strict a 1 000 000
/*
DESCRIPTIF
--------------------------------------------------------------------------------
V├¬tements
*/

-- 2) Les noms des hypermarchés se trouvant à Calais.
SELECT NOM
FROM HYPERMARCHE
WHERE VILLE = 'Calais';

/*
NOM
------------------------------
DO-SPORT
Dealer Price
*/

--3) Les noms des hypermarchés se trouvant dans le Pas de Calais (code postal commençant par 62).
SELECT NOM
FROM HYPERMARCHE
WHERE CODEPOSTAL LIKE '62%';
/*
NOM
------------------------------
Marrefour
DO-SPORT
Dealer Price
*/

-- Les noms et prénoms des responsables de rayons dont les chiffres d'affaires sont supérieurs à 1000000.
SELECT EMPLOYE.NOM, EMPLOYE.PRENOM
FROM EMPLOYE
JOIN RAYON ON EMPLOYE.NUMERO = RAYON.NUMERORESPONSABLE
WHERE RAYON.CHIFFREAFFAIRE > 1000000;

/*
NOM                            PRENOM
------------------------------ --------------------
VASSEUR                        Jacques
*/

-- 5) Les noms et prénoms des responsables de rayons de l'hypermarché 'Marrefour coquelles'
-- et dont le chiffre d'affaire est inférieur à 500000.
SELECT EMPLOYE.NOM, EMPLOYE.PRENOM
FROM EMPLOYE
JOIN RAYON ON EMPLOYE.NUMERO = RAYON.NUMERORESPONSABLE
JOIN HYPERMARCHE ON RAYON.NUMEROHYPER = HYPERMARCHE.NUMERO
WHERE HYPERMARCHE.NOM = 'Marrefour Coquelles'
  AND RAYON.CHIFFREAFFAIRE < 500000;

/* no rows selected */

-- 6) Le nom du directeur de l’hypermarché se trouvant à Calais et dans lequel existe un rayon
-- dont le chiffre d'affaire est inférieur à 500000 et dont le responsable est Max Stevenson
SELECT EMPLOYE.NOM
FROM HYPERMARCHE
JOIN RAYON ON HYPERMARCHE.NUMERO = RAYON.NUMEROHYPER
JOIN EMPLOYE ON HYPERMARCHE.NUMERODIRECTEUR = EMPLOYE.NUMERO
WHERE HYPERMARCHE.VILLE = 'Calais'
  AND RAYON.CHIFFREAFFAIRE < 500000
  AND RAYON.NUMERORESPONSABLE = 'EMP4328';  -- Numéro de Max Stevenson

-- Numéro de Max Stevenson directement sinon la deuxieme version plus bas 

/*
SELECT EMPLOYE.NOM AS NOM_DIRECTEUR
FROM HYPERMARCHE
JOIN RAYON ON HYPERMARCHE.NUMERO = RAYON.NUMEROHYPER
JOIN EMPLOYE ON HYPERMARCHE.NUMERODIRECTEUR = EMPLOYE.NUMERO
WHERE HYPERMARCHE.VILLE = 'Calais'
  AND RAYON.CHIFFREAFFAIRE < 500000
  AND RAYON.NUMERORESPONSABLE = (
      SELECT NUMERO
      FROM EMPLOYE
      WHERE NOM = 'Stevenson' AND PRENOM = 'Max'
  );
*/
/*
Resultat avec la 2 eme version avec les ALIAS:

NOM_DIRECTEUR
------------------------------
Hugo
*/

-- 7) Le nom de l'hypermarché contenant un rayon dont le chiffre d'affaire est le plus haut (le
-- plus haut de tous les rayons pas seulement de ceux de l'hypermarché en question). Pour
-- cette requête deux versions vous sont demandées. 

-- Version 01:
/*
Cette requête retourne le nom de l'hypermarché dont le rayon a 
le chiffre d'affaires le plus élevé parmi tous les rayons, en utilisant une sous-requête pour obtenir le chiffre
d'affaires maximal de tous les rayons.Elle fonctionne bien, mais elle ne permet pas de gérer 
plusieurs hypermarchés ayant un rayon avec le chiffre d'affaires maximal identique.
*/
SELECT HYPERMARCHE.NOM
FROM HYPERMARCHE
JOIN RAYON ON HYPERMARCHE.NUMERO = RAYON.NUMEROHYPER
WHERE RAYON.CHIFFREAFFAIRE = (SELECT MAX(CHIFFREAFFAIRE) FROM RAYON);

/*
NOM
------------------------------
DO-SPORT
*/

-- Version 02:
/*
Cette version utilise une agrégation (MAX) et une clause HAVING pour s'assurer que
l'hypermarché retourné a le chiffre d'affaires maximal parmi tous les rayons.
Elle permet de gérer plusieurs hypermarchés qui pourraient avoir un rayon avec le même
chiffre d'affaires maximal. Cette méthode est plus robuste, surtout si plusieurs résultats sont attendus.
*/
SELECT HYPERMARCHE.NOM
FROM HYPERMARCHE
JOIN RAYON ON HYPERMARCHE.NUMERO = RAYON.NUMEROHYPER
GROUP BY HYPERMARCHE.NOM
HAVING MAX(RAYON.CHIFFREAFFAIRE) = (
    SELECT MAX(CHIFFREAFFAIRE) FROM RAYON
);

/*
NOM
------------------------------
DO-SPORT
*/


-- 8) Le nom du responsable de rayon de l'hypermarché Marrefour Coquelles dont le chiffre
-- d'affaire est le plus haut (le plus haut des rayons de l'hypermarché en question
-- seulement). Pour cette requête deux versions vous sont demandées.

-- Version 01:
/*
Elle utilise une sous-requête pour obtenir le chiffre d'affaires maximal du rayon 
et le compare à chaque rayon de l'hypermarché. Cette approche fonctionne bien mais peut ne pas être optimale 
si plusieurs rayons dans l'hypermarché ont un chiffre d'affaires égal au maximum.
*/
SELECT EMPLOYE.NOM
FROM EMPLOYE
JOIN RAYON ON EMPLOYE.NUMERO = RAYON.NUMERORESPONSABLE
JOIN HYPERMARCHE ON RAYON.NUMEROHYPER = HYPERMARCHE.NUMERO
WHERE HYPERMARCHE.NOM = 'Marrefour' -- J'assume que vous parler de "Marrefour" car l'hypermarché "Marrefour Coquelles" n'existe pas 
  AND RAYON.CHIFFREAFFAIRE = (SELECT MAX(CHIFFREAFFAIRE) 
                               FROM RAYON WHERE NUMEROHYPER = HYPERMARCHE.NUMERO);

/*
NOM
------------------------------
DURAND
*/

-- Version 02:
/*
Cette version utilise une agrégation (MAX) et une clause HAVING pour s'assurer que le responsable du rayon 
ayant le chiffre d'affaires le plus élevé parmi ceux de l'hypermarché "Marrefour Coquelles" est sélectionné. 
Elle gère également les cas où plusieurs rayons ont le même chiffre d'affaires maximal, en retournant tous les responsables 
des rayons avec le chiffre d'affaires maximal.
*/
SELECT EMPLOYE.NOM
FROM EMPLOYE
JOIN RAYON ON EMPLOYE.NUMERO = RAYON.NUMERORESPONSABLE
JOIN HYPERMARCHE ON RAYON.NUMEROHYPER = HYPERMARCHE.NUMERO
WHERE HYPERMARCHE.NOM = 'Marrefour'
GROUP BY EMPLOYE.NOM, HYPERMARCHE.NUMERO 
HAVING MAX(RAYON.CHIFFREAFFAIRE) = (
    SELECT MAX(CHIFFREAFFAIRE)
    FROM RAYON
    WHERE NUMEROHYPER = HYPERMARCHE.NUMERO
);

/*
NOM
------------------------------
DURAND
*/


-- 9) Le nom de l'hypermarché contenant un rayon dont le chiffre d'affaire n'est pas le plus
-- phaut (le plus haut de tous les rayons pas seulement de ceux de l'hypermarché en
-- question). Pour cette requête deux versions vous sont demandées. 

-- Version 01:

SELECT HYPERMARCHE.NOM
FROM HYPERMARCHE
JOIN RAYON ON HYPERMARCHE.NUMERO = RAYON.NUMEROHYPER
WHERE RAYON.CHIFFREAFFAIRE != (SELECT MAX(CHIFFREAFFAIRE) FROM RAYON);

-- Version 02:

SELECT HYPERMARCHE.NOM
FROM HYPERMARCHE
JOIN RAYON ON HYPERMARCHE.NUMERO = RAYON.NUMEROHYPER
GROUP BY HYPERMARCHE.NOM
HAVING MAX(RAYON.CHIFFREAFFAIRE) != (SELECT MAX(CHIFFREAFFAIRE) FROM RAYON);


SELECT HYPERMARCHE.NOM, SUM(RAYON.CHIFFREAFFAIRE) AS CA_TOTAL
FROM HYPERMARCHE
JOIN RAYON ON HYPERMARCHE.NUMERO = RAYON.NUMEROHYPER
GROUP BY HYPERMARCHE.NOM;

SELECT SUM(RAYON.CHIFFREAFFAIRE) AS CA_TOTAL
FROM HYPERMARCHE
JOIN RAYON ON HYPERMARCHE.NUMERO = RAYON.NUMEROHYPER
JOIN EMPLOYE ON HYPERMARCHE.NUMERODIRECTEUR = EMPLOYE.NUMERO
WHERE EMPLOYE.NOM = 'Dupont' AND EMPLOYE.PRENOM = 'Jean'
  AND EXISTS (
    SELECT 1
    FROM RAYON R
    JOIN EMPLOYE E ON R.NUMERORESPONSABLE = E.NUMERO
    WHERE R.NUMEROHYPER = HYPERMARCHE.NUMERO
      AND E.NOM = 'Durand' AND E.PRENOM = 'Christophe'
  );


SELECT HYPERMARCHE.NOM, SUM(RAYON.CHIFFREAFFAIRE) AS CA_TOTAL
FROM HYPERMARCHE
JOIN RAYON ON HYPERMARCHE.NUMERO = RAYON.NUMEROHYPER
GROUP BY HYPERMARCHE.NOM
HAVING AVG(RAYON.CHIFFREAFFAIRE) > 1500000;


