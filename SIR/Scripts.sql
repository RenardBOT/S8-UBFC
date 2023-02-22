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
      NbStock NUMBER,
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

CREATE VIEW v_tva AS 
SELECT * 
FROM tva
UNION
SELECT *
FROM tva@dbalbra;

CREATE VIEW v_produit AS 
SELECT * 
FROM produit
UNION
SELECT *
FROM produit@ens0907;


-- SEQUENCES POUR ID

CREATE SEQUENCE produit_seq START WITH 1;
CREATE SEQUENCE achat_seq START WITH 1;


-- TRIGGER FHD PRODUIT

CREATE OR REPLACE TRIGGER new_produit_t
      INSTEAD OF INSERT ON v_produit
      FOR EACH ROW
DECLARE
      var_seq INTEGER := produit_seq.nextval;
BEGIN
      -- inserer dans produit@renardbot si le taux de TVA est N ou P
      IF :NEW.Taux = 'N' OR :NEW.Taux = 'P' THEN
            INSERT INTO produit VALUES(var_seq,:NEW.NomP,:NEW.PrixHT,:NEW.Taux,:NEW.NbStock);
      END IF;
      
      -- inserer dans produit@dbalbra si le taux de TVA est I ou R
      IF :NEW.Taux = 'I' OR :NEW.Taux = 'R' THEN
            INSERT INTO produit@ens0907 VALUES(var_seq,:NEW.NomP,:NEW.PrixHT,:NEW.Taux,:NEW.NbStock);
      END IF;
END;
/