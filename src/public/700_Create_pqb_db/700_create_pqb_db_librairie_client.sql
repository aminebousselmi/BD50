--------------------------------------------------------
--	PACKAGE BODY DB_CLIENT
--------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY DB_CLIENT AS
 
	PROCEDURE addClient (
        	p_nom 	 	IN 	CLIENT.CLN_NOM%TYPE
        	,p_prenom  	IN 	CLIENT.CLN_PRENOM%TYPE
		,p_sexe		IN	CLIENT.CLN_SEXE%TYPE
        	,p_email  	IN 	CLIENT.CLN_EMAIL%TYPE
        	,p_password	IN 	CLIENT.CLN_MOT_PASSE%TYPE
        	,p_rue 	 	IN 	CLIENT.CLN_RUE%TYPE
        	,p_cp 	 	IN 	CLIENT.CLN_CP%TYPE
        	,p_ville 	IN 	CLIENT.CLN_VILLE%TYPE
        	,p_pays 	IN 	CLIENT.CLN_PAYS%TYPE
		,p_comp_add	IN	CLIENT.CLN_COMP_ADRESSE%TYPE      
	) IS
  	BEGIN
    		INSERT INTO CLIENT 
			(
			CLN_NOM
			,CLN_PRENOM
			,CLN_SEXE
			,CLN_EMAIL
			,CLN_MOT_PASSE
			,CLN_RUE
			,CLN_CP
			,CLN_VILLE
			,CLN_PAYS
			,CLN_COMP_ADRESSE 
			)
    		   VALUES 
			(
			p_nom
			,p_prenom
			,p_sexe
			,p_email
			,p_password
			,p_rue
			,p_cp
			,p_ville
			,p_pays
			,p_comp_add
		);

    		COMMIT;
    	END addClient;

 	FUNCTION getClientById(
		p_id		CLIENT.CLN_ID%TYPE
	) RETURN CLIENT%ROWTYPE AS
  		f_client CLIENT%ROWTYPE;
	BEGIN
  		SELECT
			*
  		INTO   
			f_client
  		FROM   
			CLIENT CLN
  		WHERE  
			CLN.CLN_ID = p_id
		;
  		
		RETURN (f_client);
	END getClientById;

	PROCEDURE updateClientById(
		p_id		CLIENT.CLN_ID%TYPE
		,p_nom	 	CLIENT.CLN_NOM%TYPE
        	,p_prenom	CLIENT.CLN_PRENOM%TYPE
		,p_sexe		CLIENT.CLN_SEXE%TYPE
        	,p_email  	CLIENT.CLN_EMAIL%TYPE
        	,p_password	CLIENT.CLN_MOT_PASSE%TYPE
        	,p_rue 	 	CLIENT.CLN_RUE%TYPE
        	,p_cp 	 	CLIENT.CLN_CP%TYPE
        	,p_ville 	CLIENT.CLN_VILLE%TYPE
        	,p_pays 	CLIENT.CLN_PAYS%TYPE
		,p_comp_add	CLIENT.CLN_COMP_ADRESSE%TYPE   
	) AS
	BEGIN
		UPDATE 
			CLIENT CLN
		SET
			CLN.CLN_NOM = p_nom
			,CLN.CLN_PRENOM = p_prenom
			,CLN.CLN_SEXE = p_sexe
			,CLN.CLN_EMAIL = p_email
			,CLN.CLN_MOT_PASSE = p_password
			,CLN.CLN_RUE = p_rue
			,CLN.CLN_CP = p_cp
			,CLN.CLN_VILLE = p_ville
			,CLN.CLN_PAYS = p_pays
			,CLN.CLN_COMP_ADRESSE = p_comp_add
		WHERE
			CLN.CLN_ID = p_id
		;
		COMMIT;
		owa_util.redirect_url('UI_CLIENT.displayAndEditClientInfo');
	END updateClientById;

	FUNCTION login(
		p_email 	CLIENT.CLN_EMAIL%TYPE 
		,p_password 	CLIENT.CLN_MOT_PASSE%TYPE
	) RETURN NUMBER AS
		f_id 		NUMBER(4)  DEFAULT 0;
	BEGIN
		SELECT 
			CLN.CLN_ID  
		INTO 
			f_id 
		FROM 
			CLIENT CLN
		WHERE 
			CLN.CLN_EMAIL = p_email
		AND 
			CLN_MOT_PASSE = p_password
		;
		
		RETURN NVL(f_id, 0);
	END login;

END DB_CLIENT;


/