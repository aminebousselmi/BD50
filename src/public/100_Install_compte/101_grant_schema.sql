-- -----------------------------------------------------------------------------
--       Attribuer les permissions
-- -----------------------------------------------------------------------------

GRANT 
	CONNECT
	,RESOURCE
	,CREATE VIEW
	,CREATE SYNONYM
	,CREATE USER
	,ALTER USER 
	,PLUSTRACE
	,CREATE PROCEDURE
	,XDBADMIN
TO 
	G04_BOOK
WITH 
	ADMIN OPTION ;

GRANT 
	EXECUTE 
ON 
	DBMS_EPG 
TO 
	G04_BOOK
WITH 
	GRANT OPTION;