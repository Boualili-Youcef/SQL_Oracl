-- Nom: Boualil 
-- Prénom: Youcef
-- L3 Informatique
-- TP2

/* insertion dans la table Formation */
INSERT INTO Formation VALUES (1,'L1 Info');
INSERT INTO Formation VALUES (2,'L2 Info');
INSERT INTO Formation VALUES (3,'L3 Info');

/* insertion dans la table Etudiant*/

ALTER SESSION set NLS_DATE_FORMAT = 'dd-mm-yyyy';

INSERT INTO Etudiant VALUES (1,'Dupond','18-03-1994','M',3);
INSERT INTO Etudiant VALUES (2,'Dubois','11-02-1994','M',3);
INSERT INTO Etudiant VALUES (3,'Favier','02-02-1995','F',2);
INSERT INTO Etudiant VALUES (4,'Gros','21-06-1994','F',3);
INSERT INTO Etudiant VALUES (5,'Henri','12-10-1996','M',2);
INSERT INTO Etudiant VALUES (6,'Humbert','19-03-1996','F',1);
INSERT INTO Etudiant VALUES (7,'Bouziane','10-08-1996','M',1);
INSERT INTO Etudiant VALUES (8,'Martin','25-04-1993','F',3);
INSERT INTO Etudiant VALUES (9,'Paris','03-01-1995','F',2);
INSERT INTO Etudiant VALUES (10,'Yang','25-09-1994','M',3);
INSERT INTO Etudiant VALUES (11,'Romain','21-06-1994','M',2);

/* insertion dans la table Matiere */

INSERT INTO Matiere VALUES (1,'Programmation',5);
INSERT INTO Matiere VALUES (2,'Base de donnees',6);
INSERT INTO Matiere VALUES (3,'G.P.A.O',3);
INSERT INTO Matiere VALUES (4,'Logique',2);
INSERT INTO Matiere VALUES (5,'Statistiques',1);

/* insertion dans la table Noter */

INSERT INTO Noter VALUES (1,1,7);
INSERT INTO Noter VALUES (1,2,9);
INSERT INTO Noter VALUES (1,3,12.5);
INSERT INTO Noter VALUES (1,4,13);
INSERT INTO Noter VALUES (1,5,7);

INSERT INTO Noter VALUES (2,1,11);
INSERT INTO Noter VALUES (2,2,14.5);
INSERT INTO Noter VALUES (2,3,8.5);
INSERT INTO Noter VALUES (2,4,10);
INSERT INTO Noter VALUES (2,5,13);

INSERT INTO Noter VALUES (3,1,14);
INSERT INTO Noter VALUES (3,2,9);
INSERT INTO Noter VALUES (3,3,5);
INSERT INTO Noter VALUES (3,4,7.5);
INSERT INTO Noter VALUES (3,5,12);

INSERT INTO Noter VALUES (4,1,11.5);
INSERT INTO Noter VALUES (4,2,10);
INSERT INTO Noter VALUES (4,4,13);
INSERT INTO Noter VALUES (4,5,10);

INSERT INTO Noter VALUES (5,1,7);
INSERT INTO Noter VALUES (5,2,13);
INSERT INTO Noter VALUES (5,3,10);
INSERT INTO Noter VALUES (5,4,16);
INSERT INTO Noter VALUES (5,5,6);

INSERT INTO Noter VALUES (6,2,13);
INSERT INTO Noter VALUES (6,3,10);
INSERT INTO Noter VALUES (6,4,11);

INSERT INTO Noter VALUES (7,1,12.5);
INSERT INTO Noter VALUES (7,2,11.5);
INSERT INTO Noter VALUES (7,3,9);
INSERT INTO Noter VALUES (7,4,8);
INSERT INTO Noter VALUES (7,5,NULL);

INSERT INTO Noter VALUES (8,1,18);
INSERT INTO Noter VALUES (8,2,16);
INSERT INTO Noter VALUES (8,3,12);
INSERT INTO Noter VALUES (8,4,13);
INSERT INTO Noter VALUES (8,5,10);

INSERT INTO Noter VALUES (9,1,8);
INSERT INTO Noter VALUES (9,2,12);
INSERT INTO Noter VALUES (9,4,8);

INSERT INTO Noter VALUES (10,1,NULL);
INSERT INTO Noter VALUES (10,2,16);
INSERT INTO Noter VALUES (10,3,11.5);
INSERT INTO Noter VALUES (10,4,9);
INSERT INTO Noter VALUES (10,5,9);

/*
SQL> @insertion_tp.sql

1 row created.


1 row created.


1 row created.


Session altered.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.


1 row created.
*/
