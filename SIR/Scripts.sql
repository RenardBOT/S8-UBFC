CREATE TABLE achat1(
      NA INTEGER,
      Nom VARCHAR(15),
      NP INTEGER,
      Prix NUMBER,
      CONSTRAINT pk_achat1_na PRIMARY KEY(NA)
);

CREATE TABLE achat2(
      NA INTEGER,
      Prenom VARCHAR(15),
      Nb NUMBER,
      CONSTRAINT pk_achat2_na PRIMARY KEY(NA)
);

CREATE TABLE tva(
      Taux CHAR(1),
      Valeur NUMBER,
      CONSTRAINT pk_tva_taux PRIMARY KEY(Taux)
);

CREATE TABLE produit(
      NP INTEGER,
      NomP VARCHAR(20),
      PrixHT NUMBER,
      Taux CHAR(1),
      Nb NUMBER,
      CONSTRAINT pk_produit_np PRIMARY KEY(NP)
);

CREATE TABLE personne(
      Nom VARCHAR(15),
      Prenom VARCHAR(15),
      Adresse VARCHAR(20),
      CONSTRAINT pk_personne_nom_prenom PRIMARY KEY (Nom,Prenom) 
);

ALTER TABLE produit
ADD CONSTRAINT fk_taux_produit_tva
FOREIGN KEY (Taux) REFERENCES tva(Taux); 

ALTER TABLE achat1
ADD CONSTRAINT fk_np_achat1_produit
FOREIGN KEY (NP) REFERENCES produit(NP); 