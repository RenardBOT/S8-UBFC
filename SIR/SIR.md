# SCHEMA DE DONNEES

PC14 :
* achat1 : FV (NA Nom NP Prix)
* tva : FH Taux Normal, Taux Particulier (Taux Valeur)
* produit : FHD en accord avec TVA (NP NomP PrixHT Taux NbStock)
* personne : Dupliquee (Nom Prenom Adresse)

PC07 :
* achat2 : FV (NA Prenom Nb)
* tva : FH Taux Intermediaire, Taux Reduit (Taux Valeur)
* produit : FHD En accord avec TVA (NP NomP PrixHT Taux NbStock)
* personne : Dupliquee (Nom Prenom Adresse)