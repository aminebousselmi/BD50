--------------------------------------------------------
--	PACKAGE INTERFACE DB_CLIENT
--------------------------------------------------------

CREATE OR REPLACE PACKAGE DB_CLIENT AS

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
	);

	FUNCTION getClientById(
		p_id		CLIENT.CLN_ID%TYPE
	) RETURN CLIENT%ROWTYPE;

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
	);

	FUNCTION login(
		p_email 	CLIENT.CLN_EMAIL%TYPE 
		,p_password 	CLIENT.CLN_MOT_PASSE%TYPE
	) RETURN NUMBER;

END DB_CLIENT;


/
