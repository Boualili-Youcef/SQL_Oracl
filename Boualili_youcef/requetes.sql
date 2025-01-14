-- Nom: Boualil 
-- Prénom: Youcef
-- L3 Informatique
-- TP2
-- *****************************************************************************
-- 4) Part 4: 
-- a) Liste des étudiants (Nom, Sexe) appartenant à la formation L3 Info et triée dans l’ordre
-- décroissant des noms. Visualiser le plan d’exécution de cette requête (faire une copie
-- d’écran du plan d’exécution)
SELECT
    NomE,
    Sexe
FROM
    Etudiant
WHERE
    CodeF = 3
ORDER BY
    NomE DESC;

/*
NOME                     S
------------------------ -
Yang                     M
Martin                   F
Gros                     F
Dupond                   M
Dubois                   M
 */
-- Génère le plan d'exécution pour la requête 
EXPLAIN PLAN FOR
SELECT
    NomE,
    Sexe
FROM
    Etudiant
WHERE
    CodeF = 3
ORDER BY
    NomE DESC;

SELECT
    *
FROM
    TABLE (DBMS_XPLAN.DISPLAY);

/*
Explained.


PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------
Plan hash value: 3071750747

-------------------------------------------------------------------------------
| Id  | Operation          | Name     | Rows  | Bytes | Cost (%CPU)| Time     |
-------------------------------------------------------------------------------
|   0 | SELECT STATEMENT   |          |     5 |   150 |     4  (25)| 00:00:01 |
|   1 |  SORT ORDER BY     |          |     5 |   150 |     4  (25)| 00:00:01 |
|*  2 |   TABLE ACCESS FULL| ETUDIANT |     5 |   150 |     3   (0)| 00:00:01 |
-------------------------------------------------------------------------------

Predicate Information (identified by operation id):

PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------
---------------------------------------------------

2 - filter("CODEF"=3)

Note
-----
- dynamic statistics used: dynamic sampling (level=2)

18 rows selected.

 */
/*
-- Analyse de la sortie du plan d'exécution
-- 1. SORT ORDER BY : Les résultats sont triés.
-- 2. TABLE ACCESS FULL : Un accès complet à la table ETUDIANT.
-- 3. Filtre : Le filtre "CODEF = 3".
-- 5. Coût : Le coût total estimé de l'exécution est de 4.
 */
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- b) Répartition des étudiants selon le sexe
SELECT
    Sexe,
    COUNT(*) AS Repartition
FROM
    Etudiant
GROUP BY
    Sexe;

/*
S REPARTITION
- -----------
M           6
F           5
 */
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- c) Liste des étudiants absents (Nom, Matiere) à certaines matières (ils n'ont pas été notés)
SELECT
    E.nomE AS Nom,
    M.nomM AS Matiere
FROM
    Etudiant E
    CROSS JOIN Matiere M -- C'est pour obtenir toutes les combinaisons possibles d'étudiants et de matières.
    LEFT JOIN Noter N ON E.numEtu = N.numEtu
    AND M.numMat = N.numMat -- Utilisation de LEFT JOIN pour inclure toutes les combinaisons, même celles sans correspondance dans Noter.
WHERE
    N.numEtu IS NULL;

/*
NOM                      MATIERE
------------------------ ------------------------
Humbert                  Programmation
Romain                   Programmation
Romain                   Base de donnees
Gros                     G.P.A.O
Paris                    G.P.A.O
Romain                   G.P.A.O
Romain                   Logique
Humbert                  Statistiques
Paris                    Statistiques
Romain                   Statistiques

10 rows selected.
 */
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- d) Liste des étudiants (Nom) qui ont tous une note dans les matières
SELECT
    E.nomE AS Nom
FROM
    Etudiant E
    JOIN Noter N ON E.numEtu = N.numEtu
    JOIN Matiere M ON N.numMat = M.numMat
GROUP BY
    E.nomE
HAVING
    -- Ici je compare le nombre de matieres d'un etudiant avec le nombre total de matieres
    COUNT(DISTINCT M.numMat) = (
        SELECT
            COUNT(*)
        FROM
            Matiere
    );

/*
NOM
------------------------
Dupond
Dubois
Favier
Henri
Bouziane
Martin
Yang

7 rows selected.
 */
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- e) Liste des étudiants (Nom) qui n’ont aucune note dans les matières
SELECT
    E.nomE AS Nom
FROM
    Etudiant E
    LEFT JOIN Noter N ON E.numEtu = N.numEtu
    -- utilisation d'un left join pour selectionner 
    -- les etudiants qui n'ont pas de note
WHERE
    N.numEtu IS NULL
GROUP BY
    E.nomE;

/*
NOM
------------------------
Romain
 */
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- f) Liste des étudiants (Nom) qui ont la plus basse note en Programmation
SELECT
    E.nomE AS Nom
FROM
    Etudiant E
    JOIN Noter N ON E.numEtu = N.numEtu
    JOIN Matiere M ON N.numMat = M.numMat
WHERE
    M.nomM = 'Programmation'
    AND N.note = (
        SELECT
            MIN(N2.note) -- je sélectionne la note minimale
        FROM
            Noter N2
            JOIN Matiere M2 ON N2.numMat = M2.numMat
        WHERE
            M2.nomM = 'Programmation'
    );

/*
NOM
------------------------
Dupond
Henri
 */
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- g) Liste des étudiants (Nom, Moyenne générale) triée du moins bon au meilleur. On utilisera
-- la fonction ROUND(Valeur,NbDecimales) pour arrondir la moyenne générale à 2
-- décimales
--Exemple : ROUND(12.67578, 3) à 12.676
-- g) Liste des étudiants (Nom, Moyenne générale) triée du moins bon au meilleur
SELECT
    E.nomE AS Nom,
    ROUND(AVG(N.note), 2) AS Moyenne_Generale -- arrondie 
FROM
    Etudiant E
    JOIN Noter N ON E.numEtu = N.numEtu
GROUP BY
    E.nomE
ORDER BY
    Moyenne_Generale ASC;

/*
NOM                      MOYENNE_GENERALE
------------------------ ----------------
Paris                                9.33
Favier                                9.5
Dupond                                9.7
Bouziane                            10.25
Henri                                10.4
Gros                                11.13
Humbert                             11.33
Yang                                11.38
Dubois                               11.4
Martin                               13.8

10 rows selected.
 */
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- h) Liste des étudiants (Nom, Note) qui ont une note de programmation supérieure à toutes
-- les notes (de toutes les matières) de l’étudiant Dubois
SELECT
    E.nomE AS Nom,
    N.note AS Note
FROM
    Etudiant E
    JOIN Noter N ON E.numEtu = N.numEtu
    JOIN Matiere M ON N.numMat = M.numMat
WHERE
    M.nomM = 'Programmation'
    AND N.note > (
        SELECT
            MAX(N2.note) -- Sélectionne la note maximale de Dubois
        FROM
            Noter N2
            JOIN Etudiant E2 ON N2.numEtu = E2.numEtu
        WHERE
            E2.nomE = 'Dubois'
    );

/*
NOM                            NOTE
------------------------ ----------
Martin                           18
 */
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- i) Une erreur a été commise dans la saisie des notes, il faut augmenter de 2 pts les notes de
-- Programmation de tous les étudiants présents.
-- Afficher les notes de Programmation avant la mise à jour pour comparer 
SELECT
    E.nomE AS Nom,
    N.note AS Note
FROM
    Etudiant E
    JOIN Noter N ON E.numEtu = N.numEtu
    JOIN Matiere M ON N.numMat = M.numMat
WHERE
    M.nomM = 'Programmation';

/*
NOM                            NOTE
------------------------ ----------
Dupond                            7
Dubois                           11
Favier                           14
Gros                           11.5
Henri                             7
Bouziane                       12.5
Martin                           18
Paris                             8
Yang

9 rows selected.*/
-- Mise à jour des notes de Programmation
UPDATE Noter N
SET
    N.note = LEAST (N.note + 2, 20) -- LEAST pour s'assurer que la note ne dépasse pas 20 après l'augmentation.
WHERE
    N.numMat = (
        SELECT
            M.numMat
        FROM
            Matiere M
        WHERE
            M.nomM = 'Programmation'
    );

-- 9 rows updated.
-- Afficher les notes de Programmation apres la mise à jour
SELECT
    E.nomE AS Nom,
    N.note AS Note
FROM
    Etudiant E
    JOIN Noter N ON E.numEtu = N.numEtu
    JOIN Matiere M ON N.numMat = M.numMat
WHERE
    M.nomM = 'Programmation';

/*
NOM                            NOTE
------------------------ ----------
Dupond                            9
Dubois                           13
Favier                           16
Gros                           13.5
Henri                             9
Bouziane                       14.5
Martin                           20
Paris                            10
Yang

9 rows selected.
 */
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- j) Créer la vue VueF qui permet de visualiser les noms et sexes des étudiants avec le libellé
-- de leur formation. A partir de la vue, lister les étudiants (Nom) masculins de la formation L3 Info.
-- Création de la vue VueF pour visualiser les noms et sexes des étudiants avec le libellé de leur formation
CREATE VIEW
    VueF AS
SELECT
    E.NomE AS Nom,
    E.Sexe AS Sexe,
    F.Libelle AS Formation
FROM
    Etudiant E
    JOIN Formation F ON E.CodeF = F.CodeF;

-- View created.
SELECT
    Nom
FROM
    VueF
WHERE
    Sexe = 'M'
    AND Formation = 'L3 Info';

/*
NOM
------------------------
Dupond
Dubois
Yang
 */
/*
On a fait ca pour simplifier la requete en encapsulant des requêtes complexes et simplifient l'accès aux données
la view VueF est créée pour visualiser les noms et sexes des étudiants avec le libellé de leur formation. 
Ensuite, la vue est utilisée pour lister les étudiants masculins de la formation L3 Info.
*/