--------------------------------------------------------
--	PACKAGE BODY UI_ARTICLE
--------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY UI_ARTICLE AS 
	PROCEDURE getAllUI  IS
		articles 	sqlcur;
		
		TYPE TYPE_ARTICLE IS RECORD
		(
		isbn	NUMBER(13)
		,titre	VARCHAR2(50)
		,dateS	DATE
		,lib	VARCHAR2(100)
		,prix	NUMBER(15,2)
		,genre	VARCHAR2(50)
		,qte	NUMBER(10)
		);
		clientIdCK 	owa_cookie.cookie :=owa_cookie.get('CLN_ID');
		clientId  	NUMBER:= clientIdCK.vals(1);
		rec_articles 	TYPE_ARTICLE;
		qte_saisie	NUMBER := 1;
	BEGIN
		htp.htmlopen;
			HTP.headopen;
				htp.title('Liste des Articles');
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
							htp.print('<thead>');
								htp.tableRowOpen;
									htp.print('<th scope="col">Titre</th>');
									htp.print('<th scope="col">Date de sortie</th>');
									htp.print('<th scope="col">Editeur</th>');
									htp.print('<th scope="col">Prix (Euro)</th>');
									htp.print('<th scope="col">Genre</th>');
									htp.print('<th scope="col">Quantite</th>');
									htp.print('<th scope="col">Ajouter au panier</th>');
								htp.tableRowClose;
							htp.print('</thead>');
							htp.print('<tbody>');
								articles := DB_ARTICLE.getAll;
								FETCH articles INTO rec_articles;
						
								WHILE articles%FOUND LOOP
									htp.print('<tr style="text-align:center;">');
										htp.tabledata(rec_articles.titre);
										htp.tabledata(rec_articles.dateS);
										htp.tabledata(rec_articles.lib);
										htp.tabledata(rec_articles.prix);
										htp.tabledata(rec_articles.genre);
										htp.tabledata(rec_articles.qte);
										IF (DB_COMMANDE.clientHasCommande(clientId) != 0) THEN
											htp.tabledata('<FONT COLOR="#000000">' || htf.anchor('DB_CONTENIR.addArtPanier?p_cmd=' || DB_COMMANDE.clientHasCommande(clientId) || '&' || 'p_id_cln=' || clientId || '&' ||'p_isbn=' || rec_articles.isbn || '&' ||'p_quantite=' || qte_saisie ||'&' || 'p_prix=' || rec_articles.prix, 'ajouter') || '</FONT>');
										ELSE
											htp.tabledata('<FONT COLOR="#000000">' || htf.anchor('UI_COMMANDE.createCommande?p_isbn=' || rec_articles.isbn || '&' ||'p_quantite=' || qte_saisie ||'&' || 'p_prix='|| rec_articles.prix, 'ajouter') || '</FONT>');
										END IF;
										FETCH articles INTO rec_articles;
									htp.print('</tr>');
								END LOOP;
							htp.print('</tbody>');
						htp.print('</table>');
			htp.bodyclose;
		htp.htmlclose;
	EXCEPTION
		WHEN OTHERS THEN
                	htp.br;
			htp.br;
			htp.print('Erreur : '|| TO_CHAR(SQLCODE) || ' : ' || SQLERRM);
	END getAllUI;

	 PROCEDURE getAllArticles(p_id COMMANDE.CMD_NUM%TYPE) IS
  		cli CLIENT.CLN_ID%TYPE;
  		r_article ARTICLE%ROWTYPE;
  		clientCookie owa_cookie.cookie :=owa_cookie.get('CLN_ID');
  		numClient NUMBER := clientCookie.vals(1);
		prixtotal	NUMBER := 0;	
  		CURSOR c_contenir IS 
      			SELECT 
          			* 
      			from 
           			CONTENIR CONT
      			WHERE CONT.CMD_NUM = p_id;
  	BEGIN
  		HTP.htmlopen;
  			HTP.headopen;
  				HTP.title('Details de la commande ');
  				HTP.print('<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">');
  				HTP.print('<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">');
  				HTP.print('<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>');
  				HTP.print(' <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>');
  				HTP.print('<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>');
  			HTP.headclose;

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

				htp.print('<table class="table" style="margin-top:3% !important;width: 98%;margin: 0 auto">');
							htp.print('<thead class="thead-dark">');
								htp.tableRowOpen;
									htp.print('<th scope="col">ISBN</th>');
									htp.print('<th scope="col">Titre</th>');
									htp.print('<th scope="col">Date de sortie</th>');
									htp.print('<th scope="col">Quantite achetee</th>');
									htp.print('<th scope="col">Langue</th>');
									htp.print('<th scope="col">Total paye (Euro)</th>');
									htp.print('<th scope="col">TVA</th>');
								htp.tableRowClose;
							htp.print('</thead>');
							htp.print('<tbody>');
								FOR  r_contenir IN c_contenir LOOP
									r_article := DB_ARTICLE.getArticleById(r_contenir.ART_ISBN);
									htp.print('<tr style="text-align:center;">');
										htp.tabledata(r_article.ART_ISBN);
										htp.tabledata(r_article.ART_TITRE);
										htp.tabledata(r_article.ART_DATE_SORTIE);
										htp.tabledata(htf.anchor('UI_COMMANDE.updateQuantityByCommande?p_cmd_id=' || p_id || '&' || 'p_art_isbn=' || r_article.ART_ISBN || '&' || 'p_quantite=' || r_contenir.CNT_QUANTITE, TO_CHAR(r_contenir.CNT_QUANTITE)));
										htp.tabledata(r_article.ART_LANGUE);
										htp.tabledata(r_contenir.PRIX);
										htp.tabledata(r_article.ART_TVA);
									htp.print('</tr>');
									prixtotal := prixtotal + (r_contenir.PRIX + (r_contenir.PRIX * (r_article.ART_TVA / 100))) * r_contenir.CNT_QUANTITE ;
								END LOOP;
							htp.print('</tbody>');
						htp.print('</table>');
						htp.print('<hr>');
						IF DB_ARTICLE.getArticlesByCommande(p_id).CMD_PAYE = 0 THEN
  							htp.print('<tr style="text-align:center;"><td colspan=4></td><td ><h2 style="text-align:center;">Total : '|| ROUND(prixtotal,2) ||' Euro <a href="DB_COMMANDE.payerCommande?cmd_num='||p_id||'"><button  type="submit" class="btn btn-outline-primary" >Paye</button></h2> </td></tr>');
  						ELSE
							htp.print('<tr style="text-align:center;"><td colspan=4></td><td ><h2 style="text-align:center;">Total : '|| ROUND(prixtotal,2) ||' Euro</h2> </td></tr>');
						END IF;
			htp.bodyclose;
  	EXCEPTION
		WHEN OTHERS THEN
                	htp.br;
			htp.br;
			htp.print('Probleme lors de ajout');
			htp.br;
			htp.print('Erreur : '|| TO_CHAR(SQLCODE) || ' : ' || SQLERRM);
  
  END getAllArticles;
END UI_ARTICLE;


/
