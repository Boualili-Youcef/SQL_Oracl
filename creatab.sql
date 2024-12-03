/* 
-- Nom: Boualil 
-- Prénom: Youcef
-- L3 Informatique
 */

 
-- *****************************************************************************
-- *************** Part 1 : DDL (Data Definition Language) *********************
-- *****************************************************************************

-- 1.1 Création des tables:
-- Suppression des tables existantes
DROP TABLE PRODUITS CASCADE CONSTRAINTS;

DROP TABLE RAYON CASCADE CONSTRAINTS;

DROP TABLE HYPERMARCHE CASCADE CONSTRAINTS;

DROP TABLE EMPLOYE CASCADE CONSTRAINTS;

/*
-- Résultat après l'exécution des commandes : 
-- Si une table n'existe pas (première fois qu'on execute le script), une erreur de type "table or view 'nom_de_table' does not exist" est renvoyée,
-- car les tables doivent exister pour être supprimées.
-- Sinon:

Table dropped.

Table dropped.

Table dropped.

Table dropped.

--  
-- L'ordre des commandes est essentiel : 
-- supprimer d'abord les tables dépendantes (référencées par des clés étrangères) pour éviter des erreurs de dépendance. 
-- CASCADE CONSTRAINTS supprime aussi les contraintes.
 */
-- Création de la table EMPLOYE
CREATE TABLE
    EMPLOYE (
        NUMERO VARCHAR2 (10) PRIMARY KEY NOT NULL, -- Clé primaire, ne peut pas être NULL
        NOM VARCHAR2 (30) NOT NULL,
        PRENOM VARCHAR2 (20) NOT NULL,
        ADRESSE VARCHAR2 (150)
    );

-- Création de la table HYPERMARCHE
CREATE TABLE
    HYPERMARCHE (
        NUMERO VARCHAR2 (10) PRIMARY KEY NOT NULL, -- Clé primaire, ne peut pas être NULL
        NOM VARCHAR2 (30) NOT NULL,
        ADRESSE VARCHAR2 (150),
        VILLE VARCHAR2 (30),
        CODEPOSTAL VARCHAR2 (10),
        NUMERODIRECTEUR VARCHAR2 (10) NOT NULL,
        CONSTRAINT fk_directeur FOREIGN KEY (NUMERODIRECTEUR) REFERENCES EMPLOYE (NUMERO)
    );

-- Création de la table RAYON
CREATE TABLE
    RAYON (
        NUMERO VARCHAR2 (10) PRIMARY KEY NOT NULL, -- Clé primaire, ne peut pas être NULL
        NOM VARCHAR2 (30) NOT NULL,
        DESCRIPTIF VARCHAR2 (255),
        CHIFFREAFFAIRE NUMBER, -- Pour stocker aussi les decimaux
        NUMEROHYPER VARCHAR2 (10) NOT NULL,
        NUMERORESPONSABLE VARCHAR2 (10) NOT NULL,
        CONSTRAINT fk_hyper FOREIGN KEY (NUMEROHYPER) REFERENCES HYPERMARCHE (NUMERO),
        CONSTRAINT fk_responsable FOREIGN KEY (NUMERORESPONSABLE) REFERENCES EMPLOYE (NUMERO)
    );

-- Création de la table PRODUITS
CREATE TABLE
    PRODUITS (
        NUMERO VARCHAR2 (10) PRIMARY KEY NOT NULL, -- Clé primaire, ne peut pas être NULL
        LIBELLE VARCHAR2 (30) NOT NULL,
        NUMERORAYON VARCHAR2 (10) NOT NULL,
        PRIXUNITAIRE NUMBER (10, 2) NOT NULL,
        UNITE VARCHAR2 (20) NOT NULL,
        QUANTITESTOCKHYPER NUMBER NOT NULL,
        CONSTRAINT fk_rayon FOREIGN KEY (NUMERORAYON) REFERENCES RAYON (NUMERO)
    );

/*

-- Résultat après l'exécution des commandes :

Table created.


Table created.


Table created.


Table created.

-- Remarque : 
-- J'ai ajouté les contraintes "NOT NULL" pour garantir l'intégrité des données. 
-- Les clés primaires (PRIMARY KEY) et clés étrangères (FOREIGN KEY) ne peuvent pas contenir de valeurs NULL. 
-- Cela renforce la cohérence et l'intégrité référentielle dans la base de données. 
 */

-- *****************************************************************************
-- ****** 1.2 Exécution d’un fichier de commande avec SQL*Plus d’Oracle ********
-- *****************************************************************************

set echo on;

-- *****************************************************************************
-- ********************** 1.3 Description des tables ***************************
-- *****************************************************************************
/*
 -- 5. La structure des tables Oracle que vous avez implantées dans le SGBD avec la commande « desc
 nom_de_table ». Vérifier chacune de vos tables (nom, ordre et type des attributs)
*/
DESC PRODUITS;

DESC RAYON;

DESC HYPERMARCHE;

DESC EMPLOYE;

/*
SQL> DESC PRODUITS
Name                                      Null?    Type
----------------------------------------- -------- ----------------------------
NUMERO                                    NOT NULL VARCHAR2(10)
LIBELLE                                   NOT NULL VARCHAR2(30)
NUMERORAYON                               NOT NULL VARCHAR2(10)
PRIXUNITAIRE                              NOT NULL NUMBER(10,2)
UNITE                                     NOT NULL VARCHAR2(20)
QUANTITESTOCKHYPER                        NOT NULL NUMBER

SQL> DESC RAYON
Name                                      Null?    Type
----------------------------------------- -------- ----------------------------
NUMERO                                    NOT NULL VARCHAR2(10)
NOM                                       NOT NULL VARCHAR2(30)
DESCRIPTIF                                         VARCHAR2(255)
CHIFFREAFFAIRE                                     NUMBER
NUMEROHYPER                               NOT NULL VARCHAR2(10)
NUMERORESPONSABLE                         NOT NULL VARCHAR2(10)

SQL> DESC HYPERMARCHE
Name                                      Null?    Type
----------------------------------------- -------- ----------------------------
NUMERO                                    NOT NULL VARCHAR2(10)
NOM                                       NOT NULL VARCHAR2(30)
ADRESSE                                            VARCHAR2(150)
VILLE                                              VARCHAR2(30)
CODEPOSTAL                                         VARCHAR2(10)
NUMERODIRECTEUR                           NOT NULL VARCHAR2(10)

SQL> DESC EMPLOYE
Name                                      Null?    Type
----------------------------------------- -------- ----------------------------
NUMERO                                    NOT NULL VARCHAR2(10)
NOM                                       NOT NULL VARCHAR2(30)
PRENOM                                    NOT NULL VARCHAR2(20)
ADRESSE                                            VARCHAR2(150)
 */


/*
-- 6. L’état des tables Oracle que vous avez implantées dans le SGBD avec la commande « SELECT ». Vérifier que vos
-- tables n’ont aucun enregistrement.
*/

select * from PRODUITS;
select * from  EMPLOYE;
select * from HYPERMARCHE;
select * from RAYON;

/*
SQL> select * from PRODUITS;

no rows selected

SQL> select * from  EMPLOYE;

no rows selected

SQL> select * from HYPERMARCHE;

no rows selected

SQL> select * from RAYON;

no rows selected
*/


-- *****************************************************************************
-- ********************** 1.4 Dictionnaire des données *************************
-- *****************************************************************************

DESC SYS.USER_TABLES;

/*
SQL> DESC SYS.USER_TABLES;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 TABLE_NAME                                NOT NULL VARCHAR2(128)
 TABLESPACE_NAME                                    VARCHAR2(30)
 CLUSTER_NAME                                       VARCHAR2(128)
 IOT_NAME                                           VARCHAR2(128)
 STATUS                                             VARCHAR2(8)
 PCT_FREE                                           NUMBER
 PCT_USED                                           NUMBER
 INI_TRANS                                          NUMBER
 MAX_TRANS                                          NUMBER
 INITIAL_EXTENT                                     NUMBER
 NEXT_EXTENT                                        NUMBER
 MIN_EXTENTS                                        NUMBER
 MAX_EXTENTS                                        NUMBER
 PCT_INCREASE                                       NUMBER
 FREELISTS                                          NUMBER
 FREELIST_GROUPS                                    NUMBER
 LOGGING                                            VARCHAR2(3)
 BACKED_UP                                          VARCHAR2(1)
 NUM_ROWS                                           NUMBER
 BLOCKS                                             NUMBER
 EMPTY_BLOCKS                                       NUMBER
 AVG_SPACE                                          NUMBER
 CHAIN_CNT                                          NUMBER
 AVG_ROW_LEN                                        NUMBER
 AVG_SPACE_FREELIST_BLOCKS                          NUMBER
 NUM_FREELIST_BLOCKS                                NUMBER
 DEGREE                                             VARCHAR2(10)
 INSTANCES                                          VARCHAR2(10)
 CACHE                                              VARCHAR2(5)
 TABLE_LOCK                                         VARCHAR2(8)
 SAMPLE_SIZE                                        NUMBER
 LAST_ANALYZED                                      DATE
 PARTITIONED                                        VARCHAR2(3)
 IOT_TYPE                                           VARCHAR2(12)
 TEMPORARY                                          VARCHAR2(1)
 SECONDARY                                          VARCHAR2(1)
 NESTED                                             VARCHAR2(3)
 BUFFER_POOL                                        VARCHAR2(7)
 FLASH_CACHE                                        VARCHAR2(7)
 CELL_FLASH_CACHE                                   VARCHAR2(7)
 ROW_MOVEMENT                                       VARCHAR2(8)
 GLOBAL_STATS                                       VARCHAR2(3)
 USER_STATS                                         VARCHAR2(3)
 DURATION                                           VARCHAR2(15)
 SKIP_CORRUPT                                       VARCHAR2(8)
 MONITORING                                         VARCHAR2(3)
 CLUSTER_OWNER                                      VARCHAR2(128)
 DEPENDENCIES                                       VARCHAR2(8)
 COMPRESSION                                        VARCHAR2(8)
 COMPRESS_FOR                                       VARCHAR2(30)
 DROPPED                                            VARCHAR2(3)
 READ_ONLY                                          VARCHAR2(3)
 SEGMENT_CREATED                                    VARCHAR2(3)
 RESULT_CACHE                                       VARCHAR2(7)
 CLUSTERING                                         VARCHAR2(3)
 ACTIVITY_TRACKING                                  VARCHAR2(23)
 DML_TIMESTAMP                                      VARCHAR2(25)
 HAS_IDENTITY                                       VARCHAR2(3)
 CONTAINER_DATA                                     VARCHAR2(3)
 INMEMORY                                           VARCHAR2(8)
 INMEMORY_PRIORITY                                  VARCHAR2(8)
 INMEMORY_DISTRIBUTE                                VARCHAR2(15)
 INMEMORY_COMPRESSION                               VARCHAR2(17)
 INMEMORY_DUPLICATE                                 VARCHAR2(13)
 DEFAULT_COLLATION                                  VARCHAR2(100)
 DUPLICATED                                         VARCHAR2(1)
 SYNCHRONOUS_DUPLICATED                             VARCHAR2(1)
 SHARDED                                            VARCHAR2(1)
 EXTERNALLY_SHARDED                                 VARCHAR2(1)
 EXTERNALLY_DUPLICATED                              VARCHAR2(1)
 EXTERNAL                                           VARCHAR2(3)
 HYBRID                                             VARCHAR2(3)
 CELLMEMORY                                         VARCHAR2(24)
 CONTAINERS_DEFAULT                                 VARCHAR2(3)
 CONTAINER_MAP                                      VARCHAR2(3)
 EXTENDED_DATA_LINK                                 VARCHAR2(3)
 EXTENDED_DATA_LINK_MAP                             VARCHAR2(3)
 INMEMORY_SERVICE                                   VARCHAR2(12)
 INMEMORY_SERVICE_NAME                              VARCHAR2(1000)
 CONTAINER_MAP_OBJECT                               VARCHAR2(3)
 MEMOPTIMIZE_READ                                   VARCHAR2(8)
 MEMOPTIMIZE_WRITE                                  VARCHAR2(8)
 HAS_SENSITIVE_COLUMN                               VARCHAR2(3)
 ADMIT_NULL                                         VARCHAR2(3)
 DATA_LINK_DML_ENABLED                              VARCHAR2(3)
 LOGICAL_REPLICATION                                VARCHAR2(8)
 STAGING                                            VARCHAR2(3)
 ROW_CHANGE_TRACKING                                VARCHAR2(3)
 HAS_RESERVABLE_COLUMN                              VARCHAR2(3)
 */

DESC SYS.USER_OBJECTS;

/*
SQL> DESC SYS.USER_OBJECTS;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 OBJECT_NAME                                        VARCHAR2(128)
 SUBOBJECT_NAME                                     VARCHAR2(128)
 OBJECT_ID                                          NUMBER
 DATA_OBJECT_ID                                     NUMBER
 OBJECT_TYPE                                        VARCHAR2(23)
 CREATED                                            DATE
 LAST_DDL_TIME                                      DATE
 TIMESTAMP                                          VARCHAR2(19)
 STATUS                                             VARCHAR2(7)
 TEMPORARY                                          VARCHAR2(1)
 GENERATED                                          VARCHAR2(1)
 SECONDARY                                          VARCHAR2(1)
 NAMESPACE                                          NUMBER
 EDITION_NAME                                       VARCHAR2(128)
 SHARING                                            VARCHAR2(18)
 EDITIONABLE                                        VARCHAR2(1)
 ORACLE_MAINTAINED                                  VARCHAR2(1)
 APPLICATION                                        VARCHAR2(1)
 DEFAULT_COLLATION                                  VARCHAR2(100)
 DUPLICATED                                         VARCHAR2(1)
 SHARDED                                            VARCHAR2(1)
 IMPORTED_OBJECT                                    VARCHAR2(1)
 SYNCHRONOUS_DUPLICATED                             VARCHAR2(1)
 CREATED_APPID                                      NUMBER
 CREATED_VSNID                                      NUMBER
 MODIFIED_APPID                                     NUMBER
 MODIFIED_VSNID                                     NUMBER
*/

DESC SYS.USER_CONSTRAINTS;

/*
SQL> DESC SYS.USER_CONSTRAINTS;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 OWNER                                              VARCHAR2(128)
 CONSTRAINT_NAME                           NOT NULL VARCHAR2(128)
 CONSTRAINT_TYPE                                    VARCHAR2(1)
 TABLE_NAME                                NOT NULL VARCHAR2(128)
 SEARCH_CONDITION                                   LONG
 SEARCH_CONDITION_VC                                VARCHAR2(4000)
 R_OWNER                                            VARCHAR2(128)
 R_CONSTRAINT_NAME                                  VARCHAR2(128)
 DOMAIN_OWNER                                       VARCHAR2(128)
 DOMAIN_NAME                                        VARCHAR2(128)
 DOMAIN_CONSTRAINT_NAME                             VARCHAR2(128)
 DELETE_RULE                                        VARCHAR2(9)
 STATUS                                             VARCHAR2(8)
 DEFERRABLE                                         VARCHAR2(14)
 DEFERRED                                           VARCHAR2(9)
 VALIDATED                                          VARCHAR2(13)
 GENERATED                                          VARCHAR2(14)
 BAD                                                VARCHAR2(3)
 RELY                                               VARCHAR2(4)
 PRECHECK                                           VARCHAR2(10)
 LAST_CHANGE                                        DATE
 INDEX_OWNER                                        VARCHAR2(128)
 INDEX_NAME                                         VARCHAR2(128)
 INVALID                                            VARCHAR2(7)
 VIEW_RELATED                                       VARCHAR2(14)
 ORIGIN_CON_ID                                      NUMBER
*/

desc user_cons_columns;

/*
SQL> desc user_cons_columns;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 OWNER                                     NOT NULL VARCHAR2(128)
 CONSTRAINT_NAME                           NOT NULL VARCHAR2(128)
 TABLE_NAME                                NOT NULL VARCHAR2(128)
 COLUMN_NAME                                        VARCHAR2(4000)
 POSITION                                           NUMBER
 DOMAIN_OWNER                                       VARCHAR2(128)
 DOMAIN_NAME                                        VARCHAR2(128)
 */