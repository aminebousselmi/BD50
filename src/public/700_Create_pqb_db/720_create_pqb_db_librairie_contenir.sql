--------------------------------------------------------
--	PACKAGE BODY DB_CONTENIR
--------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY DB_CONTENIR AS
	PROCEDURE addArtPanier(p_cmd NUMBER, p_id_cln NUMBER, p_isbn NUMBER, p_quantite NUMBER, p_prix NUMBER) AS
	BEGIN

		INSERT INTO CONTENIR
			(
			CMD_NUM
			,ART_ISBN
			,CNT_QUANTITE
			,PRIX
			)
		   VALUES
			(
			p_cmd
			,p_isbn
			,p_quantite
			,p_prix
			)
		;
		
		UPDATE 
			COMMANDE CMD
		SET
			CMD.CMD_PRIX_TTC = CMD.CMD_PRIX_TTC + p_prix
		WHERE
			CMD.CMD_NUM = p_cmd
		;

		COMMIT;
		htp.print('Vous venez d ajouter un article');
	EXCEPTION
		WHEN OTHERS THEN
			owa_util.redirect_url('UI_ARTICLE.getAllUI');
	END addArtPanier;
	
	PROCEDURE updateQuantityByCommande(
		p_cmd_id	CONTENIR.CMD_NUM%TYPE
		,p_art_isbn	CONTENIR.ART_ISBN%TYPE
		,p_quantite	CONTENIR.CNT_QUANTITE%TYPE
	) AS
		quantiteExc	Exception;
		quantiteDispo	NUMBER;
	BEGIN
		SELECT
			ART.ART_QTE_DISPO
		INTO
			quantiteDispo
		FROM
			ARTICLE ART
		WHERE
			ART.ART_ISBN = p_art_isbn
		;
		
		IF quantiteDispo < p_quantite THEN
			RAISE quantiteExc;
		END IF;

		UPDATE
			CONTENIR CNT
		SET
			CNT.CNT_QUANTITE = p_quantite
		WHERE
			CNT.CMD_NUM = p_cmd_id
		AND
			CNT.ART_ISBN = p_art_isbn
		;

		COMMIT;

		owa_util.redirect_url('UI_COMMANDE.getAllUI');
	EXCEPTION
		WHEN quantiteExc THEN
			htp.br;
			htp.br;
			htp.print('La quantite disponible est inferieur a la quantite demander');
		WHEN OTHERS THEN
                	htp.br;
			htp.br;
			htp.print('Probleme lors de ajout');
			htp.br;
			htp.print('Erreur : '|| TO_CHAR(SQLCODE) || ' : ' || SQLERRM);
	END updateQuantityByCommande;

END DB_CONTENIR;
/