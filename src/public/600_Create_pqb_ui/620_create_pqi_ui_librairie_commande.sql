--------------------------------------------------------
--	PACKAGE UI_COMMANDE
--------------------------------------------------------

CREATE OR REPLACE PACKAGE UI_COMMANDE AS 

	TYPE sqlcur IS REF CURSOR;

	PROCEDURE createCommande(p_isbn NUMBER, p_quantite NUMBER, p_prix NUMBER);

	PROCEDURE addCurrentCommande(
			c_descr		VARCHAR2
			,c_mode		VARCHAR2
			,c_prix		VARCHAR2
			,c_isbn		VARCHAR2
			,c_quantite	VARCHAR2
	);
	
	PROCEDURE getAllUI;
	
	PROCEDURE updateQuantityByCommande(p_cmd_id CONTENIR.CMD_NUM%TYPE,p_art_isbn CONTENIR.ART_ISBN%TYPE, p_quantite CONTENIR.CNT_QUANTITE%TYPE);
END UI_COMMANDE;


/
