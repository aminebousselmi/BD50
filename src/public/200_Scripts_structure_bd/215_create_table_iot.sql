-- -----------------------------------------------------------------------------
--       Création des tables IOT
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
--       TABLE : CONCERNER
-- -----------------------------------------------------------------------------

CREATE TABLE CONCERNER
   (
    ART_ISBN NUMBER(13)  NOT NULL,
    PRM_ID NUMBER(4)  NOT NULL,
    DATE_DEBUT DATE  NOT NULL,
    CON_POURCENTAGE NUMBER(3,2)  NOT NULL,
    CONSTRAINT PK_CONCERNER PRIMARY KEY (ART_ISBN, PRM_ID, DATE_DEBUT)
   )
   ORGANIZATION INDEX
   TABLESPACE BD50_DATA;

-- -----------------------------------------------------------------------------
--       TABLE : FOURNIR
-- -----------------------------------------------------------------------------

CREATE TABLE FOURNIR
   (
    FRN_ID NUMBER(8)  NOT NULL,
    ART_ISBN NUMBER(13)  NOT NULL,
    FOU_DATE DATE  NOT NULL,
    FOU_HEURE DATE  NOT NULL,
    FOU_QUANTITE NUMBER(4)  NOT NULL,
    FOU_PRIX_UNITAIRE NUMBER(15,2)  NOT NULL,
    CONSTRAINT PK_FOURNIR PRIMARY KEY (FRN_ID, ART_ISBN, FOU_DATE, FOU_HEURE)
   )
   ORGANIZATION INDEX
   TABLESPACE BD50_DATA ;