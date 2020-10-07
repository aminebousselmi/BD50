--------------------------------------------------------
--	PACKAGE INTERFACE UI_CLIENT
--------------------------------------------------------

CREATE OR REPLACE PACKAGE UI_CLIENT AS

	PROCEDURE login(
		p_email 	CLIENT.CLN_EMAIL%TYPE 
		,p_password 	CLIENT.CLN_MOT_PASSE%TYPE
	);

	PROCEDURE loginUI;

	PROCEDURE logout;
	
	PROCEDURE displayAndEditClientInfo;
END UI_CLIENT;


/