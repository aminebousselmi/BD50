-- -----------------------------------------------------------------------------
--       Rebuild des index
-- -----------------------------------------------------------------------------

ALTER INDEX I_AUTEUR_NOM REBUILD;

ALTER INDEX I_DATE REBUILD;

ALTER INDEX I_FOURNISSEUR_NOM REBUILD;

ALTER INDEX I_CMD_DATE_MODIF REBUILD;

ALTER INDEX I_LIVRAISON_DATE REBUILD;

ALTER INDEX I_IDENTIFIANTS REBUILD;

ALTER INDEX I_ARTICLE_TITRE REBUILD;