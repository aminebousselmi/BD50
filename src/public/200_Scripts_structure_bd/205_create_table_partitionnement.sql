-- -----------------------------------------------------------------------------
--       Création des table de partitionnement
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
--       TABLE : COMMANDE
-- -----------------------------------------------------------------------------

CREATE TABLE COMMANDE
   (
    CMD_NUM NUMBER(8)  NOT NULL,
    CLN_ID NUMBER(8)  NOT NULL,
    CMD_DATE_MODIF DATE  NOT NULL,
    CMD_DESC VARCHAR2(500)  NULL,
    CMD_PRIX_TTC NUMBER(15,2)  NOT NULL,
    CMD_PAYE NUMBER(1)  NOT NULL,
    FCT_MODE VARCHAR2(50)
   )
PARTITION BY RANGE (CMD_DATE_MODIF) 
INTERVAL(NUMTOYMINTERVAL(1, 'YEAR')) 
(  
   PARTITION p1_2000 VALUES LESS THAN (TO_DATE('01/01/2000', 'DD-MM-YYYY')),
   PARTITION p2_2001 VALUES LESS THAN (TO_DATE('01/01/2001', 'DD-MM-YYYY')) 
)
   TABLESPACE BD50_DATA ;

ALTER TABLE COMMANDE ENABLE ROW MOVEMENT;

-- -----------------------------------------------------------------------------
--       TABLE : LIVRAISON
-- -----------------------------------------------------------------------------

CREATE TABLE LIVRAISON
   (
    LIV_NUM NUMBER(8)  NOT NULL,
    CMD_NUM NUMBER(8)  NOT NULL,
    LIV_DATE DATE  NOT NULL,
    LIV_FRAIS NUMBER(15,2)  NOT NULL,
    LIV_RUE VARCHAR2(50)  NOT NULL,
    LIV_COMP_ADRESSE VARCHAR2(40)  NOT NULL,
    LIV_CP VARCHAR2(8)  NOT NULL,
    LIV_VILLE VARCHAR2(30)  NOT NULL,
    LIV_PAYS VARCHAR2(30)  NOT NULL
   )
PARTITION BY RANGE (LIV_DATE) 
INTERVAL(NUMTOYMINTERVAL(1, 'YEAR')) 
(  
   PARTITION p1_2000 VALUES LESS THAN (TO_DATE('01/01/2000', 'DD-MM-YYYY')),
   PARTITION p2_2001 VALUES LESS THAN (TO_DATE('01/01/2001', 'DD-MM-YYYY')) 
)
   TABLESPACE BD50_DATA ;

ALTER TABLE LIVRAISON ENABLE ROW MOVEMENT;
-- -----------------------------------------------------------------------------
--       TABLE : CLIENT
-- -----------------------------------------------------------------------------

CREATE TABLE CLIENT
   (
    CLN_ID NUMBER(8)  NOT NULL,
    CLN_NOM VARCHAR2(50)  NOT NULL,
    CLN_PRENOM VARCHAR2(50)  NOT NULL,
    CLN_SEXE CHAR(1)  NULL,
    CLN_EMAIL VARCHAR2(50)  NOT NULL,
    CLN_MOT_PASSE VARCHAR2(30)  NOT NULL,
    CLN_RUE VARCHAR2(50)  NOT NULL,
    CLN_CP VARCHAR2(8)  NOT NULL,
    CLN_VILLE VARCHAR2(30)  NOT NULL,
    CLN_PAYS VARCHAR2(30)  NOT NULL,
    CLN_COMP_ADRESSE VARCHAR2(40)  NOT NULL
   )
   PARTITION BY LIST(CLN_VILLE)
			(
			partition 	ville_1 values ('PARIS')
			,partition	ville_2 values ('MARSEILLE')
			,partition 	ville_3 values ('LYON')
			,partition 	ville_4 values ('TOULOUSE')
			,partition 	ville_5 values ('NICE')
			,partition 	ville_6 values ('NANTES')
			,partition 	ville_7 values ('MONTPELLIER')
			,partition	ville_8 values ('STRASBOURG')
			,partition 	ville_9 values ('BORDEAUX')
			,partition 	ville_10 values ('LILLE')
			,partition 	ville_11 values ('RENNES')
			,partition 	ville_12 values ('REIMS')
			,partition 	ville_13 values ('SAINT-ETIENNE')
			,partition	ville_14 values ('TOULON')
			,partition 	ville_15 values ('HAVRE')
			,partition 	ville_16 values ('GRENOBLE')
			,partition 	ville_17 values ('DIJON')
			,partition 	ville_18 values ('ANGERS')		
			)
   TABLESPACE BD50_DATA ;

ALTER TABLE CLIENT ENABLE ROW MOVEMENT;