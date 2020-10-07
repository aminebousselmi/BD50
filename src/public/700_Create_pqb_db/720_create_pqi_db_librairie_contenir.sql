--------------------------------------------------------
--	PACKAGE DB_CONTENIR
--------------------------------------------------------

CREATE OR REPLACE PACKAGE DB_CONTENIR AS

	PROCEDURE addArtPanier(p_cmd NUMBER, p_id_cln NUMBER,p_isbn NUMBER, p_quantite NUMBER, p_prix NUMBER);
 	
	PROCEDURE updateQuantityByCommande(
		p_cmd_id	CONTENIR.CMD_NUM%TYPE
		,p_art_isbn	CONTENIR.ART_ISBN%TYPE
		,p_quantite	CONTENIR.CNT_QUANTITE%TYPE
	);

END DB_CONTENIR;


/
