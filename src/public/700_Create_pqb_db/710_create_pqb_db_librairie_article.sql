--------------------------------------------------------
--	PACKAGE BODY DB_ARTICLE
--------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY DB_ARTICLE AS

	FUNCTION getArticleById(p_isbn ARTICLE.ART_ISBN%TYPE) RETURN ARTICLE%ROWTYPE AS
  		f_article ARTICLE%ROWTYPE;
	BEGIN
  		SELECT 
			*
  		INTO   
			f_article
  		FROM   
			ARTICLE ART
  		WHERE  
			ART.ART_ISBN = p_isbn;

  		RETURN (f_article); 
	END getArticleById;

	FUNCTION getAll RETURN sqlcur AS
	    articles sqlcur;
	BEGIN
        	OPEN articles For SELECT
					ART.ART_ISBN
					,ART.ART_TITRE
					,ART.ART_DATE_SORTIE
					,ART.EDT_LIB
					,ART.ART_PRIX_HT
					,GNR.GNR_LIB
					,ART.ART_QTE_DISPO
				  FROM 
					ARTICLE ART INNER JOIN APPARTENIR APT
						ON APT.ART_ISBN = ART.ART_ISBN
							INNER JOIN GENRE GNR
						ON GNR.GNR_ID = APT.GNR_ID
		;
        	RETURN(articles);
	END getAll;
	
	FUNCTION getArticlesByCommande(
   	 p_id COMMANDE.CMD_NUM%TYPE
	) RETURN COMMANDE%ROWTYPE AS
  		r_commande COMMANDE%ROWTYPE;
  	BEGIN
    		SELECT
      			*
    		INTO
      			r_commande
    		FROM
      			COMMANDE CMD
    		WHERE
      			CMD.CMD_NUM = p_id
		;
		RETURN r_commande;
	END getArticlesByCommande;
END DB_ARTICLE;


/
