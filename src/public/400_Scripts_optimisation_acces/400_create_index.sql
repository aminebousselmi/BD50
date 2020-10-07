-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE AUTEUR
-- -----------------------------------------------------------------------------

CREATE  INDEX I_AUTEUR_NOM
     ON AUTEUR (AUT_NOM ASC)
   TABLESPACE BD50_IND ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE FACTURE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_DATE
     ON FACTURE (FCT_DATE ASC)
   TABLESPACE BD50_IND ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE FOURNISSEUR
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FOURNISSEUR_NOM
     ON FOURNISSEUR (FRN_NOM ASC)
   TABLESPACE BD50_IND ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE COMMANDE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_CMD_DATE_MODIF
     ON COMMANDE (CMD_DATE_MODIF ASC)
   TABLESPACE BD50_IND ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE LIVRAISON
-- -----------------------------------------------------------------------------

CREATE  INDEX I_LIVRAISON_DATE
     ON LIVRAISON (LIV_DATE ASC)
   TABLESPACE BD50_IND ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE CLIENT
-- -----------------------------------------------------------------------------

CREATE  INDEX I_IDENTIFIANTS
     ON CLIENT (CLN_EMAIL ASC, CLN_MOT_PASSE ASC)
   TABLESPACE BD50_IND ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE ARTICLE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_ARTICLE_TITRE
     ON ARTICLE (ART_TITRE ASC)
   TABLESPACE BD50_IND ;

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE LIVRER
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_LIVRER_ARTICLE
     ON LIVRER (ART_ISBN ASC)
   TABLESPACE BD50_IND ;