-- -----------------------------------------------------------------------------
--       Création des tables
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
--       TABLE : AUTEUR
-- -----------------------------------------------------------------------------

CREATE TABLE AUTEUR
   (
    AUT_ID 	NUMBER(8) NOT NULL,
    AUT_NOM 	VARCHAR2(50) NOT NULL,
    AUT_PRENOM 	VARCHAR2(50) NOT NULL,
    AUT_SEXE 	CHAR(1) NULL,
    AUT_DATE_NAISSANCE DATE NULL
   )
   TABLESPACE BD50_DATA ;

-- -----------------------------------------------------------------------------
--       TABLE : CATEGORIE
-- -----------------------------------------------------------------------------

CREATE TABLE CATEGORIE
   (
    CAT_ID NUMBER(3)  		NOT NULL,
    CAT_LIBELLE VARCHAR2(50)  	NOT NULL
   )
   TABLESPACE BD50_DATA ;

-- -----------------------------------------------------------------------------
--       TABLE : FACTURE
-- -----------------------------------------------------------------------------

CREATE TABLE FACTURE
   (
    FCT_NUM NUMBER(4)  NOT NULL,
    CMD_NUM NUMBER(8)  NOT NULL,
    FCT_DATE DATE  NOT NULL,
    FCT_MODE VARCHAR2(50)  NOT NULL,
    FCT_MONTANT NUMBER(15,2)  NOT NULL
   )
   TABLESPACE BD50_DATA ;

-- -----------------------------------------------------------------------------
--       TABLE : FOURNISSEUR
-- -----------------------------------------------------------------------------

CREATE TABLE FOURNISSEUR
   (
    FRN_ID NUMBER(8)  NOT NULL,
    FRN_NOM VARCHAR2(50)  NOT NULL,
    FRN_TEL VARCHAR2(13)  NOT NULL,
    FRN_RUE VARCHAR2(50)  NOT NULL,
    FRN_COMP_ADRESSE VARCHAR2(40)  NOT NULL,
    FRN_CP VARCHAR2(8)  NOT NULL,
    FRN_VILLE VARCHAR2(30)  NOT NULL,
    FRN_PAYS VARCHAR2(30)  NOT NULL
   )
   TABLESPACE BD50_DATA ;

-- -----------------------------------------------------------------------------
--       TABLE : PROMOTION
-- -----------------------------------------------------------------------------

CREATE TABLE PROMOTION
   (
    PRM_ID NUMBER(4)  NOT NULL,
    PRM_LIBELLE VARCHAR2(50)  NOT NULL,
    PRM_DUREE NUMBER(8)  NOT NULL,
    PRM_DATE_FIN DATE  NULL
   )
   TABLESPACE BD50_DATA ;

-- -----------------------------------------------------------------------------
--       TABLE : GENRE
-- -----------------------------------------------------------------------------

CREATE TABLE GENRE
   (
    GNR_ID NUMBER(3)  NOT NULL,
    GNR_LIB VARCHAR2(50)  NOT NULL
   )
   TABLESPACE BD50_DATA ;

-- -----------------------------------------------------------------------------
--       TABLE : ARTICLE
-- -----------------------------------------------------------------------------

CREATE TABLE ARTICLE
   (
    ART_ISBN NUMBER(13)  NOT NULL,
    EDT_ID NUMBER(8)  NOT NULL,
    ART_TITRE VARCHAR2(50)  NOT NULL,
    ART_DATE_SORTIE DATE  NOT NULL,
    ART_PRIX_HT NUMBER(15,2)  NOT NULL,
    ART_TVA NUMBER(5,2)  NOT NULL,
    ART_QTE_DISPO NUMBER(10)  NOT NULL,
    ART_RESUME VARCHAR2(500)  NULL,
    ART_NB_PAGES NUMBER(5)  NULL,
    ART_LANGUE VARCHAR2(20)  NULL,
    ART_IMAGE BLOB  NULL,
    EDT_LIB VARCHAR2(100)
   )
   TABLESPACE BD50_DATA ;

-- -----------------------------------------------------------------------------
--       TABLE : EDITEUR
-- -----------------------------------------------------------------------------

CREATE TABLE EDITEUR
   (
    EDT_ID NUMBER(8)  NOT NULL,
    EDT_LIB VARCHAR2(100)  NOT NULL 
   )
   TABLESPACE BD50_DATA ;

-- -----------------------------------------------------------------------------
--       TABLE : LIVRER
-- -----------------------------------------------------------------------------

CREATE TABLE LIVRER
   (
    LIV_NUM NUMBER(8)  NOT NULL,
    ART_ISBN NUMBER(13)  NOT NULL,
    QUANTITE_LIVREE NUMBER(4)  NULL,
    QUANTITE_RESTANTE NUMBER(4)  NULL
   )
   TABLESPACE BD50_DATA ;

-- -----------------------------------------------------------------------------
--       TABLE : CLASSIFIER
-- -----------------------------------------------------------------------------

CREATE TABLE CLASSIFIER
   (
    ART_ISBN NUMBER(13)  NOT NULL,
    CAT_ID NUMBER(3)  NOT NULL
   )
   TABLESPACE BD50_DATA ;

-- -----------------------------------------------------------------------------
--       TABLE : APPARTENIR
-- -----------------------------------------------------------------------------

CREATE TABLE APPARTENIR
   (
    GNR_ID NUMBER(3)  NOT NULL,
    ART_ISBN NUMBER(13)  NOT NULL
   )
   TABLESPACE BD50_DATA ;

-- -----------------------------------------------------------------------------
--       TABLE : AVOIR
-- -----------------------------------------------------------------------------

CREATE TABLE AVOIR
   (
    FCT_NUM NUMBER(4)  NOT NULL,
    ART_ISBN NUMBER(13)  NOT NULL,
    QUANTITE NUMBER(4)  NOT NULL,
    PRIX NUMBER(15,2)  NOT NULL
   )
   TABLESPACE BD50_DATA ;

-- -----------------------------------------------------------------------------
--       TABLE : ECRIRE
-- -----------------------------------------------------------------------------

CREATE TABLE ECRIRE
   (
    ART_ISBN NUMBER(13)  NOT NULL,
    AUT_ID NUMBER(8)  NOT NULL
   )
   TABLESPACE BD50_DATA ;

-- -----------------------------------------------------------------------------
--       TABLE : CONTENIR
-- -----------------------------------------------------------------------------

CREATE TABLE CONTENIR
   (
    CMD_NUM NUMBER(8)  NOT NULL,
    ART_ISBN NUMBER(13)  NOT NULL,
    CNT_QUANTITE NUMBER(4)  NOT NULL,
    PRIX NUMBER(15,2)  NOT NULL
   )
   TABLESPACE BD50_DATA ;