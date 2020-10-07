--------------------------------------------------------
--	PACKAGE DB_COMMANDE
--------------------------------------------------------

CREATE OR REPLACE PACKAGE DB_COMMANDE AS
 	
	TYPE sqlcur IS REF CURSOR;

	FUNCTION clientHasCommande(
		p_cln_id	CLIENT.CLN_ID%TYPE
	) RETURN NUMBER;

	FUNCTION addCommande(
		p_client	COMMANDE.CLN_ID%TYPE
		,p_desc		COMMANDE.CMD_DESC%TYPE
		,p_prix		COMMANDE.CMD_PRIX_TTC%TYPE
		,p_mode		COMMANDE.FCT_MODE%TYPE
	) RETURN NUMBER;

	FUNCTION allCommandesClient(
		p_client	COMMANDE.CLN_ID%TYPE
	) RETURN sqlcur;

	PROCEDURE payerCommande(cmd_num COMMANDE.CMD_NUM%TYPE);

END DB_COMMANDE;


/