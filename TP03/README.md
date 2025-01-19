# TP03: Gestion et Création Dynamique de Tables

## Organisation du Projet

Le projet TP03 est structuré de la manière suivante :

- **creatab.sql** : Script SQL pour créer les tables nécessaires à la base de données.
- **instab.sql** : Script SQL pour insérer les données initiales dans les tables sans gestion des exceptions.
- **PL_SQL.sql** : Scripts PL/SQL pour diverses opérations sur la base de données sans gestion des exceptions.
- **PL_SQL_exp.sql** : Scripts PL/SQL pour diverses opérations sur la base de données avec gestion des exceptions.
- **README.md** : Ce document expliquant l'organisation et les instructions d'exécution.

## Instructions d'Exécution

Pour initialiser et manipuler la base de données, suivez les étapes ci-dessous dans l'ordre indiqué.

### 1. Création des Tables

Commencez par créer les tables nécessaires en exécutant le script `creatab.sql`.

```sql
@creatab.sql
```

### 2. Insertion des Données

Ensuite, insérez les données initiales dans les tables :

  Exécutez le script `instab.sql` pour insérer les données.

  ```sql
  @instab.sql
  ```

### 3. Exécution des Scripts PL/SQL

Après l'insertion des données, vous pouvez exécuter les scripts PL/SQL pour effectuer diverses opérations sur la base de données.

- **Sans gestion des exceptions** :

  ```sql
  @PL_SQL.sql
  ```

- **Avec gestion des exceptions** :

  ```sql
  @PL_SQL_exp.sql
  ```

## Contenu des Scripts

### creatab.sql

Ce script crée toutes les tables nécessaires utilisées dans ce TP. Il définit les schémas et les contraintes de base de données.

### instab.sql

Insère les données initiales dans les tables..

### PL_SQL.sql


### PL_SQL_exp.sql

Contient plusieurs blocs PL/SQL couvrant les opérations avec gestion des exceptions.