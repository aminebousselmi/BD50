-- -----------------------------------------------------------------------------
--       Création et configuration du DAD
-- -----------------------------------------------------------------------------

	BEGIN
		DBMS_EPG.CREATE_DAD (
			DAD_NAME => 'book_dad'
			,PATH => '/book/*'
		);
	END;
	/

	BEGIN
		DBMS_EPG.SET_DAD_ATTRIBUTE(
			DAD_NAME => 'book_dad'
			,ATTR_NAME => 'default-page'
			,ATTR_VALUE => 'UI_CLIENT.loginUI' 
		);

		DBMS_EPG.SET_DAD_ATTRIBUTE(
			DAD_NAME => 'book_dad'
			,ATTR_NAME => 'authentication-mode'
			,ATTR_VALUE => 'Basic'
		);

		DBMS_EPG.SET_DAD_ATTRIBUTE(
			DAD_NAME => 'book_dad'
			,ATTR_NAME => 'database-username'
			,ATTR_VALUE => 'G04_BOOK'
		);
	END;
	/