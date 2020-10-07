--------------------------------------------------------
--	PACKAGE BODY UI_COMMANDE
--------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY UI_COMMANDE AS 
	PROCEDURE createCommande(p_isbn NUMBER, p_quantite NUMBER, p_prix NUMBER)  IS
	BEGIN
		HTP.htmlopen;
			HTP.headopen;
				htp.title('Ajouter une commande');
				htp.print('<meta charset="utf-8">');
				htp.print('<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">');
				htp.print('<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">');
				htp.print('<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>');
				htp.print('<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>');
				htp.print('<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>');
 			htp.headclose;
			
			htp.bodyOpen;
				htp.print('<nav class="navbar navbar-expand-lg navbar-light bg-light">');
					htp.print('<a class="navbar-brand">LIVREL</a>');
					htp.print('<div class="collapse navbar-collapse" id="navbarSupportedContent">');
						htp.print('<ul class="navbar-nav mr-auto">');
							htp.print('<li class="nav-item active">');
								htp.print('<a class="nav-link"  href="UI_ARTICLE.getAllUI">Articles</a>');
							htp.print('</li>');

							htp.print('<li class="nav-item active">');
								htp.print('<a class="nav-link"  href="UI_COMMANDE.getAllUI">Commandes <span class="sr-only">(current)</span></a>');
							htp.print('</li>');

							htp.print('<li class="nav-item">');
								htp.print('<a class="nav-link"  href="UI_CLIENT.displayAndEditClientInfo">Profil</a>');
							htp.print('</li>');
						htp.print('</ul>');
						
						htp.print('<a class="nav-link" href="UI_CLIENT.logout">Se deconnecter <span class="sr-only">(current)</span></a>');
						
					htp.print('</div>');
				htp.print('</nav>');

				htp.print('<div class="card">');
					htp.print('<div class="card-header"> Ajouter une commande');
					htp.print('</div>');
					htp.print('<div class="card-body">');
						htp.formOpen(owa_util.get_owa_service_path || 'UI_COMMANDE.addCurrentCommande', 'POST');
						
							htp.print('<div class="form-group">');
								htp.print('<label for="c_descr">Description</label>');
								htp.print('<input type="text" class="form-control" name="c_descr" id="c_descr" placeholder="Description" required="required">');
							htp.print('</div>');	
							
							htp.print('<div class="form-group">');
								htp.print('<label for="c_mode">Mode de paiement</label>');
								htp.print('<input type="text" class="form-control" name="c_mode" id="c_mode" placeholder="Mode de paiement" required="required">');
							htp.print('</div>');
							
							htp.print('<div class="form-group">');
								htp.print('<input type="hidden" class="form-control" value="' || p_prix ||'" name="c_prix" id="c_prix" placeholder="Prix">');
								htp.print('<div class="alert alert-info" role="alert"> Prix initial : ' || p_prix || ' Euro </div>');
							htp.print('</div>');
							htp.print('<input type="hidden" name="c_isbn" id="c_isbn" value="' || p_isbn ||'">');
							htp.print('<input type="hidden" name="c_quantite" id="c_quantite" value="' || p_quantite ||'">');
					
							htp.print('<button type="submit" class="btn btn-secondary">Ajouter une commande</button>');
						htp.formClose;
					htp.print('</div>');
				htp.print('</div>');
			htp.bodyClose;
		HTP.htmlclose;
	 EXCEPTION
        	WHEN OTHERS THEN
                	htp.br;
			htp.br;
			htp.print('Probleme lors de ajout');
			htp.br;
			htp.print('Erreur : '|| TO_CHAR(SQLCODE) || ' : ' || SQLERRM);
	END createCommande;

	PROCEDURE addCurrentCommande(
			c_descr		VARCHAR2
			,c_mode		VARCHAR2
			,c_prix		VARCHAR2
			,c_isbn		VARCHAR2
			,c_quantite	VARCHAR2
	) AS
		clientIdCK 	owa_cookie.cookie :=owa_cookie.get('CLN_ID');
		clientId  	NUMBER:= clientIdCK.vals(1);
		currComm	NUMBER;
	BEGIN
		
		currComm := DB_COMMANDE.addCommande(clientId, c_descr, TO_NUMBER(c_prix), c_mode);
		DB_CONTENIR.addArtPanier(currComm, clientId,TO_NUMBER(c_isbn), TO_NUMBER(c_quantite), TO_NUMBER(c_prix));
	EXCEPTION
		WHEN OTHERS THEN
                	htp.br;
			htp.br;
			htp.print('Probleme lors de ajout');
			htp.br;
			htp.print('Erreur : '|| TO_CHAR(SQLCODE) || ' : ' || SQLERRM);
	END addCurrentCommande;
  PROCEDURE getAllUI  AS
		commandes sqlcur;	
		TYPE TYPE_COMMANDE IS RECORD
		(
    cmd_num COMMANDE.CMD_NUM%TYPE
		,date_modif	COMMANDE.CMD_DATE_MODIF%TYPE
		,description	COMMANDE.CMD_DESC%TYPE
		,prix_ttc	COMMANDE.CMD_PRIX_TTC%TYPE
		,paye	COMMANDE.CMD_PAYE%TYPE
		,fct_mode	COMMANDE.FCT_MODE%TYPE
		);
		clientIdCK 	owa_cookie.cookie :=owa_cookie.get('CLN_ID');
		clientId  	NUMBER:= clientIdCK.vals(1);
		rec_commande 	TYPE_COMMANDE;
	BEGIN
		htp.htmlopen;
			HTP.headopen;
				htp.title('Liste des commandes');
				htp.print('<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />');
				htp.print('<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">');
				htp.print('<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">');
				htp.print('<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>');
				htp.print('<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>');
				htp.print('<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>');
 			htp.headclose;
			htp.bodyopen;
				
				htp.print('<nav class="navbar navbar-expand-lg navbar-light bg-light">');
					htp.print('<a class="navbar-brand">LIVREL</a>');
					htp.print('<div class="collapse navbar-collapse" id="navbarSupportedContent">');
						htp.print('<ul class="navbar-nav mr-auto">');
							htp.print('<li class="nav-item active">');
								htp.print('<a class="nav-link"  href="UI_ARTICLE.getAllUI">Articles</a>');
							htp.print('</li>');

							htp.print('<li class="nav-item active">');
								htp.print('<a class="nav-link"  href="UI_COMMANDE.getAllUI">Commandes <span class="sr-only">(current)</span></a>');
							htp.print('</li>');

							htp.print('<li class="nav-item">');
								htp.print('<a class="nav-link"  href="UI_CLIENT.displayAndEditClientInfo">Profil</a>');
							htp.print('</li>');
						htp.print('</ul>');
						
						htp.print('<a class="nav-link" href="UI_CLIENT.logout">Se deconnecter <span class="sr-only">(current)</span></a>');
						
					htp.print('</div>');
				htp.print('</nav>');
				
				htp.print('<table class="table table-striped" style="margin-top:3%;">');
							htp.print('<thead align=center>');
								htp.tableRowOpen;
									htp.print('<th scope="col">Date de commande</th>');
									htp.print('<th scope="col">Description</th>');
									htp.print('<th scope="col">Prix T.T.C (Euro)</th>');
									htp.print('<th scope="col">Payee</th>');
									htp.print('<th scope="col">Mode de facturation</th>');
									htp.print('<th scope="col">Action</th>');
								htp.tableRowClose;
							htp.print('</thead>');
							htp.print('<tbody>');
								commandes := DB_COMMANDE.allCommandesClient(clientId);
								FETCH commandes INTO rec_commande;
						
								WHILE commandes%FOUND LOOP
									htp.print('<tr style="text-align:center;">');
										htp.tabledata(rec_commande.date_modif);
										htp.tabledata(rec_commande.description);
										htp.tabledata(rec_commande.prix_ttc);
                    								IF rec_commande.paye = 1 THEN
                     	 								htp.tabledata('oui');
                    								ELSE
                      									htp.tabledata('non');
                      								END IF;
										htp.tabledata(rec_commande.fct_mode);
                    								htp.tabledata('<a  class="btn btn-outline-primary" href="UI_ARTICLE.getAllArticles?p_id='||rec_commande.cmd_num ||'" >Details</a>');
										FETCH commandes INTO rec_commande;
									htp.print('</tr>');
								END LOOP;
							htp.print('</tbody>');
						htp.print('</table>');
			htp.bodyclose;
		htp.htmlclose;
	END getAllUI;

	PROCEDURE updateQuantityByCommande(p_cmd_id CONTENIR.CMD_NUM%TYPE,p_art_isbn CONTENIR.ART_ISBN%TYPE, p_quantite CONTENIR.CNT_QUANTITE%TYPE) AS
	BEGIN
		HTP.htmlopen;
			HTP.headopen;
				htp.title('Modifier la quantite');
				htp.print('<meta charset="utf-8">');
				htp.print('<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">');
				htp.print('<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">');
				htp.print('<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>');
				htp.print('<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>');
				htp.print('<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>');
 			htp.headclose;
			
			htp.bodyOpen;
				htp.print('<nav class="navbar navbar-expand-lg navbar-light bg-light">');
					htp.print('<a class="navbar-brand">LIVREL</a>');
					htp.print('<div class="collapse navbar-collapse" id="navbarSupportedContent">');
						htp.print('<ul class="navbar-nav mr-auto">');
							htp.print('<li class="nav-item active">');
								htp.print('<a class="nav-link"  href="UI_ARTICLE.getAllUI">Articles</a>');
							htp.print('</li>');

							htp.print('<li class="nav-item active">');
								htp.print('<a class="nav-link"  href="UI_COMMANDE.getAllUI">Commandes <span class="sr-only">(current)</span></a>');
							htp.print('</li>');

							htp.print('<li class="nav-item">');
								htp.print('<a class="nav-link"  href="UI_CLIENT.displayAndEditClientInfo">Profil</a>');
							htp.print('</li>');
						htp.print('</ul>');
						
						htp.print('<a class="nav-link" href="UI_CLIENT.logout">Se deconnecter</a>');
						
					htp.print('</div>');
				htp.print('</nav>');

				htp.print('<div class="card">');
					htp.print('<div class="card-header"> Modifier la quantite commande');
					htp.print('</div>');
					htp.print('<div class="card-body">');
						htp.formOpen(owa_util.get_owa_service_path || 'DB_CONTENIR.updateQuantityByCommande', 'POST');

							htp.print('<input type="hidden" name="p_cmd_id" id="p_cmd_id" value="' || p_cmd_id ||'">');
							htp.print('<input type="hidden" name="p_art_isbn" id="p_art_isbn" value="' || p_art_isbn ||'">');

							htp.print('<div class="form-group">');
								htp.print('<label for="p_quantite">Quantite</label>');
								htp.print('<input type="number" class="form-control" name="p_quantite" id="p_quantite" placeholder="Quantite" required="required">');
							htp.print('</div>');	

							htp.print('<button type="submit" class="btn btn-secondary">Modifier la quantite</button>');
						htp.formClose;
					htp.print('</div>');
				htp.print('</div>');
			htp.bodyClose;
		HTP.htmlclose;
	 EXCEPTION
        	WHEN OTHERS THEN
                	htp.br;
			htp.br;
			htp.print('Probleme lors de la modification');
			htp.br;
			htp.print('Erreur : '|| TO_CHAR(SQLCODE) || ' : ' || SQLERRM);
	END updateQuantityByCommande;

END UI_COMMANDE;
/