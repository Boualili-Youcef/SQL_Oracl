-- Nom: Boualil 
-- Prénom: Youcef
-- L3 Informatique

-- _____________________________________________________________________________
--
-- *****************************************************************************
--                                  1.2 Création dynamique de tables
-- *****************************************************************************

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

-- _____________________________________________________________________________
-- 
-- *****************************************************************************
-- Créer la table HYPERMARCHE_RAYON à partir des tables HYPERMARCHE et RAYON
-- *****************************************************************************
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

-- _____________________________________________________________________________
--
-- *****************************************************************************
-- 1.3 Bloc PL/SQL
-- *****************************************************************************

-- Activer l'affichage des messages
SET SERVEROUTPUT ON;

-- *****************************************************************************
-- 1.3.1 Bloc PL/SQL pour insérer un employé
-- *****************************************************************************

-- Bloc PL/SQL pour insérer un employé
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

EXCEPTION
    -- Pour verifier que le numero n'existe pas
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : Le numero ' || v_numero || ' existe deja.');
    -- Pour verifier que les valeurs sont correctes
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : Valeur incorrecte fournie.');
    -- Autres erreurs
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Une erreur s est produite : ' || SQLERRM);
END;
/

/*
RESULTAT:
Enter value for numero: EMP1090    
old   8:     v_numero := '&numero';
new   8:     v_numero := 'EMP1090';
Enter value for nom: White 
old   9:     v_nom := '&nom';
new   9:     v_nom := 'White';
Enter value for prenom: Walter
old  10:     v_prenom := '&prenom';
new  10:     v_prenom := 'Walter';
Enter value for adresse: 125, STREET, Albuquerquie
old  11:     v_adresse := '&adresse';
new  11:     v_adresse := '125, STREET, Albuquerquie';
Erreur : Le numero EMP1090 existe deja.

PL/SQL procedure successfully completed.
*/

-- _____________________________________________________________________________
--
-- *****************************************************************************
-- 1.3.2 Bloc PL/SQL pour insérer un employé
-- Bloc PL/SQL pour afficher les informations d'un employé
-- *****************************************************************************
DECLARE
    v_numero EMPLOYE.NUMERO%TYPE := '&numero';
    v_nom EMPLOYE.NOM%TYPE;
    v_prenom EMPLOYE.PRENOM%TYPE;
    v_adresse EMPLOYE.ADRESSE%TYPE;
BEGIN
    -- Sélectionner l'employé avec le numéro v_numero
    SELECT NOM, PRENOM, ADRESSE
    INTO v_nom, v_prenom, v_adresse
    FROM EMPLOYE
    WHERE NUMERO = v_numero;

    -- Afficher les informations de l'employé
    DBMS_OUTPUT.PUT_LINE('Informations de l employe :');
    DBMS_OUTPUT.PUT_LINE('Numero : ' || v_numero);
    DBMS_OUTPUT.PUT_LINE('Nom : ' || v_nom);
    DBMS_OUTPUT.PUT_LINE('Prenom : ' || v_prenom);
    DBMS_OUTPUT.PUT_LINE('Adresse : ' || v_adresse);

EXCEPTION
    -- Pour verifier que le numero n'existe pas
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Aucun employe trouve avec le numero ' || v_numero || '.');
    -- Plusieurs employes trouves avec le meme numero
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : Plusieurs employes trouves avec le numero ' || v_numero || '.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Une erreur s est produite : ' || SQLERRM);
END;
/

/*
RESULTAT:
Enter value for numero: 4556
old   2:     v_numero EMPLOYE.NUMERO%TYPE := '&numero';
new   2:     v_numero EMPLOYE.NUMERO%TYPE := '4556';
Aucun employe trouve avec le numero 4556.

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

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Aucun produit trouve pour l hypermarche ' || v_numero_hyper);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Une erreur s est produite : ' || SQLERRM);
END;
/

/*
RESULTAT:
Enter value for numero_hyper: hi
old   6:     v_numero_hyper := '&numero_hyper';
new   6:     v_numero_hyper := 'hi';
Le numero d hypermarche hi n existe pas.
*/


-- _____________________________________________________________________________
--
-- *****************************************************************************
-- 1.3.4 Bloc PL/SQL pour créer une promotion
-- *****************************************************************************
 
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
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : Une promotion avec le numero ' || v_promotion_num || ' existe deja.');
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : Valeur incorrecte fournie.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Une erreur s est produite : ' || SQLERRM);
END;
/

/*
RESULTAT:
Enter value for numproduit: 456
old   9:     v_numproduit := '&numproduit';
new   9:     v_numproduit := '456';
Enter value for pourcentage_remise:
old  10:     v_pourcentage_remise := '&pourcentage_remise';
new  10:     v_pourcentage_remise := '';

Le numero de produit 456 n existe pas.
*/


-- _____________________________________________________________________________
--
-- *****************************************************************************
-- 1.3.5 mettre à jour le stock d'un produit dont le numéro est saisi au clavier.
-- *****************************************************************************
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
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Le numero de produit ' || v_num_produit || ' n existe pas.');
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : Valeur incorrecte fournie.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Une erreur s est produite : ' || SQLERRM);
END;
/

/*
RESULTAT:

Enter value for v_num_produit: 456 
old   6:     v_num_produit := '&v_num_produit';
new   6:     v_num_produit := '456';
Enter value for v_nouveau_stock:
old   7:     v_nouveau_stock := '&v_nouveau_stock';
new   7:     v_nouveau_stock := '';
Le numero de produit 456 n existe pas.
*/
