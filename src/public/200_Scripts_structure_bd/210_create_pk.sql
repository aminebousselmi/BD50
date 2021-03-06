-- -----------------------------------------------------------------------------
--       CREATION DES PRIMARY KEY DE TABLE
-- -----------------------------------------------------------------------------

ALTER TABLE AUTEUR ADD (
     CONSTRAINT PK_AUTEUR 
	PRIMARY KEY (AUT_ID)  USING INDEX TABLESPACE BD50_IND);

ALTER TABLE CATEGORIE ADD (
     CONSTRAINT PK_CATEGORIE 
	PRIMARY KEY (CAT_ID)  USING INDEX TABLESPACE BD50_IND);

ALTER TABLE FACTURE ADD (
     CONSTRAINT PK_FACTURE 
	PRIMARY KEY (FCT_NUM)  USING INDEX TABLESPACE BD50_IND);

ALTER TABLE FOURNISSEUR ADD (
     CONSTRAINT PK_FOURNISSEUR 
	PRIMARY KEY (FRN_ID)  USING INDEX TABLESPACE BD50_IND);

ALTER TABLE COMMANDE ADD (
     CONSTRAINT PK_COMMANDE 
	PRIMARY KEY (CMD_NUM)  USING INDEX TABLESPACE BD50_IND);

ALTER TABLE LIVRAISON ADD (
     CONSTRAINT PK_LIVRAISON 
	PRIMARY KEY (LIV_NUM)  USING INDEX TABLESPACE BD50_IND);

ALTER TABLE PROMOTION ADD (
     CONSTRAINT PK_PROMOTION 
	PRIMARY KEY (PRM_ID)  USING INDEX TABLESPACE BD50_IND);

ALTER TABLE CLIENT ADD (
     CONSTRAINT PK_CLIENT 
	PRIMARY KEY (CLN_ID)  USING INDEX TABLESPACE BD50_IND);

ALTER TABLE GENRE ADD (
     CONSTRAINT PK_GENRE 
	PRIMARY KEY (GNR_ID)  USING INDEX TABLESPACE BD50_IND);

ALTER TABLE ARTICLE ADD (
     CONSTRAINT PK_ARTICLE 
	PRIMARY KEY (ART_ISBN)  USING INDEX TABLESPACE BD50_IND);

ALTER TABLE EDITEUR ADD (
     CONSTRAINT PK_EDITEUR 
	PRIMARY KEY (EDT_ID)  USING INDEX TABLESPACE BD50_IND);

ALTER TABLE LIVRER ADD (
     CONSTRAINT PK_LIVRER 
	PRIMARY KEY (LIV_NUM, ART_ISBN)  USING INDEX TABLESPACE BD50_IND);

ALTER TABLE CLASSIFIER ADD (
     CONSTRAINT PK_CLASSIFIER 
	PRIMARY KEY (ART_ISBN, CAT_ID)  USING INDEX TABLESPACE BD50_IND);

ALTER TABLE APPARTENIR ADD (
     CONSTRAINT PK_APPARTENIR 
	PRIMARY KEY (GNR_ID, ART_ISBN)  USING INDEX TABLESPACE BD50_IND);

ALTER TABLE AVOIR ADD (
     CONSTRAINT PK_AVOIR 
	PRIMARY KEY (FCT_NUM, ART_ISBN)  USING INDEX TABLESPACE BD50_IND);

ALTER TABLE ECRIRE ADD (
     CONSTRAINT PK_ECRIRE 
	PRIMARY KEY (ART_ISBN, AUT_ID)  USING INDEX TABLESPACE BD50_IND);

ALTER TABLE CONTENIR ADD (
     CONSTRAINT PK_CONTENIR 
	PRIMARY KEY (CMD_NUM, ART_ISBN)  USING INDEX TABLESPACE BD50_IND);