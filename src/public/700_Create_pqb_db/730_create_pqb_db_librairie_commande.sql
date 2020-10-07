--------------------------------------------------------
--	PACKAGE BODY DB_COMMANDE
--------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY DB_COMMANDE AS

	FUNCTION clientHasCommande(p_cln_id CLIENT.CLN_ID%TYPE) RETURN NUMBER AS
		f_result NUMBER;
	BEGIN
		SELECT
			CMD.CMD_NUM
		INTO
			f_result
		FROM
			COMMANDE CMD
		WHERE
			CMD.CLN_ID = p_cln_id
		AND
			CMD.CMD_PAYE = 0
		;
		
		RETURN(f_result);
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RETURN 0;
	END clientHasCommande;
	
	FUNCTION addCommande(
		p_client	COMMANDE.CLN_ID%TYPE
		,p_desc		COMMANDE.CMD_DESC%TYPE
		,p_prix		COMMANDE.CMD_PRIX_TTC%TYPE
		,p_mode		COMMANDE.FCT_MODE%TYPE
	) RETURN NUMBER AS
		numeroC 	NUMBER;
	BEGIN
		INSERT INTO COMMANDE
				(
				CLN_ID
				,CMD_DATE_MODIF
				,CMD_DESC
				,CMD_PRIX_TTC
				,CMD_PAYE
				,FCT_MODE
				)
			   VALUES
				(
				p_client
				,SYSDATE
				,p_desc
				,p_prix
				,0
				,p_mode
				)
		RETURNING CMD_NUM INTO numeroC
		;
		COMMIT;
		owa_util.redirect_url('UI_ARTICLE.getAllUI');
		RETURN numeroC;
	END addCommande;

	FUNCTION allCommandesClient(p_client	COMMANDE.CLN_ID%TYPE) RETURN sqlcur AS
	    my_cursor sqlcur;
	BEGIN
        	OPEN my_cursor For 
			SELECT
				CMD.CMD_NUM
        			,CMD.CMD_DATE_MODIF
        			,CMD.CMD_DESC
        			,CMD.CMD_PRIX_TTC
        			,CMD.CMD_PAYE
        			,CMD.FCT_MODE
      			FROM
        			COMMANDE CMD
			WHERE
				CMD.CLN_ID = p_client
			;
        	RETURN(my_cursor);
	END allCommandesClient;

	PROCEDURE payerCommande(cmd_num COMMANDE.CMD_NUM%TYPE) AS
	BEGIN
		UPDATE
			COMMANDE CMD
		SET
			CMD.CMD_PAYE = 1
		WHERE
			CMD.CMD_NUM = cmd_num
		;

		COMMIT;
		owa_util.redirect_url('UI_COMMANDE.getAllUI');
	END payerCommande;

END DB_COMMANDE;


/
