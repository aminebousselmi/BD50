--------------------------------------------------------
--	PACKAGE DB_ARTICLE
--------------------------------------------------------

CREATE OR REPLACE PACKAGE DB_ARTICLE AS

	TYPE sqlcur IS REF CURSOR;

	FUNCTION getArticleById(p_isbn ARTICLE.ART_ISBN%TYPE) RETURN ARTICLE%ROWTYPE;

	FUNCTION getAll RETURN sqlcur;
 	
	FUNCTION getArticlesByCommande(
   	 p_id COMMANDE.CMD_NUM%TYPE
	)
  	RETURN COMMANDE%ROWTYPE;
END DB_ARTICLE;


/
