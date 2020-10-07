-- -----------------------------------------------------------------------------
--       Scripts pour générer l'application
-- -----------------------------------------------------------------------------

connect / as sysdba
set define off

Start ../100_Install_compte/100_create_schema.sql
Start ../100_Install_compte/101_grant_schema.sql
Start ../100_Install_compte/102_connect_schema.sql

Start ../200_Scripts_structure_bd/200_create_table.sql
Start ../200_Scripts_structure_bd/205_create_table_partitionnement.sql
Start ../200_Scripts_structure_bd/210_create_pk.sql
Start ../200_Scripts_structure_bd/215_create_table_iot.sql
Start ../200_Scripts_structure_bd/220_create_fk.sql
Start ../200_Scripts_structure_bd/230_create_check.sql
Start ../200_Scripts_structure_bd/240_create_sequence.sql
Start ../200_Scripts_structure_bd/250_create_trigger.sql
Start ../200_Scripts_structure_bd/291_purge_recyclebin.sql

Start ../300_Scripts_insertion_donnees/300_insert_data.sql

Start ../400_Scripts_optimisation_acces/400_create_index.sql

Start 500_create_param_commun.sql

Start ../700_Create_pqb_db/700_create_pqi_db_librairie_client.sql
Start ../700_Create_pqb_db/700_create_pqb_db_librairie_client.sql
Start ../700_Create_pqb_db/710_create_pqi_db_librairie_article.sql
Start ../700_Create_pqb_db/710_create_pqb_db_librairie_article.sql
Start ../700_Create_pqb_db/720_create_pqi_db_librairie_contenir.sql
Start ../700_Create_pqb_db/720_create_pqb_db_librairie_contenir.sql
Start ../700_Create_pqb_db/730_create_pqi_db_librairie_commande.sql
Start ../700_Create_pqb_db/730_create_pqb_db_librairie_commande.sql

Start ../600_Create_pqb_ui/600_create_pqi_ui_librairie_client.sql
Start ../600_Create_pqb_ui/600_create_pqb_ui_librairie_client.sql
Start ../600_Create_pqb_ui/610_create_pqi_ui_librairie_article.sql
Start ../600_Create_pqb_ui/610_create_pqb_ui_librairie_article.sql
Start ../600_Create_pqb_ui/620_create_pqi_ui_librairie_commande.sql
Start ../600_Create_pqb_ui/620_create_pqb_ui_librairie_commande.sql