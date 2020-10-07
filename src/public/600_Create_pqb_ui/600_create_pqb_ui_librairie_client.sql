--------------------------------------------------------
--	PACKAGE BODY UI_CLIENT
--------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY UI_CLIENT AS
	
	PROCEDURE login(
			p_email 	CLIENT.CLN_EMAIL%TYPE 
			,p_password 	CLIENT.CLN_MOT_PASSE%TYPE
	) AS
		p_cln_id CLIENT.CLN_ID%TYPE;
	BEGIN
		p_cln_id := DB_CLIENT.login(p_email, p_password);

		IF p_cln_id != 0 THEN
			owa_cookie.send('CLN_ID', p_cln_id);
			owa_util.redirect_url('UI_ARTICLE.getAllUI');
		END IF;
	EXCEPTION
		WHEN OTHERS THEN
                	htp.br;
			htp.br;
			htp.print('Probleme lors de la connexion');
			htp.br;
			htp.print('Erreur : '|| TO_CHAR(SQLCODE) || ' : ' || SQLERRM);
	END login;


	PROCEDURE loginUI AS
	BEGIN
		HTP.htmlopen;
			HTP.headopen;
				htp.title('Login');
				htp.print('<meta charset="utf-8">');
				htp.print('<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">');
				htp.print('<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">');
				htp.print('<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>');
				htp.print('<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>');
				htp.print('<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>');
 			htp.headclose;
			
			htp.bodyOpen;
				htp.print('<div class="card">');
					htp.print('<div class="card-header"> Se connecter');
					htp.print('</div>');
					htp.print('<div class="card-body">');
						htp.formOpen(owa_util.get_owa_service_path || 'UI_CLIENT.login', 'POST');
							htp.print('<div class="form-group">');
								htp.print('<label for="p_email">Email</label>');
								htp.print('<input type="email" class="form-control" name="p_email" id="p_email" aria-describedby="emailHelp" placeholder="Entrez votre email" required="required">');
							htp.print('</div>');	
						
							htp.print('<div class="form-group">');
								htp.print('<label for="p_password">Mot de passe</label>');
								htp.print('<input type="password" class="form-control" name="p_password" id="p_password" aria-describedby="passwordHelp" placeholder="Entrez votre mot de passe" required="required">');
							htp.print('</div>');
						
							htp.print('<button type="submit" class="btn btn-secondary">Login</button>');
						htp.formClose;
					htp.print('</div>');
				htp.print('</div>');
			htp.bodyClose;
		HTP.htmlclose;
	 EXCEPTION
        	WHEN OTHERS THEN
                	htp.br;
			htp.br;
			htp.print('Probleme lors de la connexion');
			htp.br;
			htp.print('Erreur : '|| TO_CHAR(SQLCODE) || ' : ' || SQLERRM);
	END loginUI;

	PROCEDURE logout AS
		p_sess_cookie 	owa_cookie.cookie := owa_cookie.get('CLN_ID');
		p_cln_id 	NUMBER := p_sess_cookie.vals(1);
	BEGIN
    		owa_cookie.remove('CLN_ID', p_cln_id, NULL);
	    	owa_util.redirect_url('UI_CLIENT.loginUI');
	END logout;
	
	PROCEDURE displayAndEditClientInfo AS
		currClient	CLIENT%ROWTYPE;
		clientIdCK 	owa_cookie.cookie :=owa_cookie.get('CLN_ID');
		clientId  	NUMBER:= clientIdCK.vals(1);
	BEGIN
		currClient := DB_CLIENT.getClientById(clientId);

		HTP.htmlopen;
			HTP.headopen;
				htp.title('Informations client');
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
					htp.print('<div class="card-header"> Modifier mes informations');
					htp.print('</div>');
					htp.print('<div class="card-body">');
						htp.formOpen(owa_util.get_owa_service_path || 'DB_CLIENT.updateClientById', 'POST');
							htp.print('<input type="hidden" name="p_id" id="p_id" value="' || clientId ||'">');
							htp.print('<div class="form-row">');
								htp.print('<div class="form-group col-md-4">');
									htp.print('<label for="p_nom">Nom</label>');
									htp.print('<input type="text" class="form-control" name="p_nom" value="' || currClient.CLN_NOM ||'" id="p_nom" required="required" />');
								htp.print('</div>');

								htp.print('<div class="form-group col-md-4">');
									htp.print('<label for="p_prenom">Prenom</label>');
									htp.print('<input type="text" class="form-control" name="p_prenom" value="' || currClient.CLN_PRENOM ||'" id="p_prenom" required="required" />');
								htp.print('</div>');
								
								htp.print('<div class="form-group col-md-4">');
									htp.print('<label for="p_sexe">Sexe</label>');
									htp.print('<select class="custom-select" name="p_sexe" id="inputGroupSelect01">');
										IF currClient.CLN_SEXE = 'M' THEN
											htp.print('<option value="M" selected="selected">Male</option>');
											htp.print(' <option value="F">Female</option>');
										ELSE
											htp.print('<option value="M">Male</option>');
											htp.print(' <option value="F" selected="selected">Female</option>');
										END IF;
									htp.print('</select>');
								htp.print('</div>');
							htp.print('</div>');
							
							htp.print('<div class="form-row">');

								htp.print('<div class="form-group col-md-4">');
									htp.print('<label for="p_email">Email</label>');
									htp.print('<input type="email" class="form-control" name="p_email" value="' || currClient.CLN_EMAIL ||'" id="p_email" required="required" />');
								htp.print('</div>');
								
								htp.print('<div class="form-group col-md-4">');
									htp.print('<label for="p_password">Mot de passe</label>');
									htp.print('<input type="password" class="form-control" name="p_password" value="' || currClient.CLN_MOT_PASSE ||'" id="p_password" required="required"/>');
								htp.print('</div>');

								htp.print('<div class="form-group col-md-4">');
									htp.print('<label for="p_rue">Rue</label>');
									htp.print('<input type="text" class="form-control" value="' || currClient.CLN_RUE ||'" name="p_rue" id="p_rue" required="required" />');
								htp.print('</div>');	
							htp.print('</div">');

							htp.print('<div class="form-row">');
								htp.print('<div class="form-group col-md-3">');
									htp.print('<label for="p_cp">Code postal</label>');
									htp.print('<input type="text" class="form-control" value="' || currClient.CLN_CP ||'" name="p_cp" id="p_cp" required="required" />');
								htp.print('</div>');

								htp.print('<div class="form-group col-md-3">');
									htp.print('<label for="p_ville">Ville</label>');
									htp.print('<input type="text" class="form-control" value="' || currClient.CLN_VILLE ||'" name="p_ville" id="p_ville" required="required" />');
								htp.print('</div>');

								htp.print('<div class="form-group col-md-3">');
									htp.print('<label for="p_pays">Pays</label>');
									htp.print('<input type="text" class="form-control" value="' || currClient.CLN_PAYS ||'" name="p_pays" id="p_pays" required="required">');
								htp.print('</div>');
								
								htp.print('<div class="form-group col-md-3">');
									htp.print('<label for="p_comp_add">Complement adresse</label>');
									htp.print('<input type="text" class="form-control" value="' || currClient.CLN_COMP_ADRESSE ||'" name="p_comp_add" id="p_comp_add" required="required">');
								htp.print('</div>');
							htp.print('</div">');			

							htp.print('<button type="submit" class="btn btn-secondary">Modifier</button>');
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
	END displayAndEditClientInfo;
END UI_CLIENT;


/
