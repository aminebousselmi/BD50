--------------------------------------------------------
--	PACKAGE UI_ARTICLE
--------------------------------------------------------

CREATE OR REPLACE PACKAGE UI_ARTICLE AS 
	TYPE sqlcur IS REF CURSOR;

	PROCEDURE getAllUI;

	PROCEDURE getAllArticles(p_id COMMANDE.CMD_NUM%TYPE);
END UI_ARTICLE;


/
