# Exercice 1

## Créer une collection « ventes » 
```shell
db.createCollection("ventes")
```

## Ajout de documents centrés sur les ventes

Exemple

```json
{
      "id_vente" : "10",
      "date" : "02/06/2017",
      "livre" : {
            "isbn" : "2154889522",
            "titre" : "Astérix et Cléopâtre",
            "auteur" : {
                  "id_auteur" : "154",
                  "nom" : "Gosciny",
                  "prenom" : "René"
            }
      }
}

etc...
```

Et on l'insère avec 
```db.ventes.insertOne(<document>)```

## Liste de commandes : 
Montrer la liste des collections : ```show collections```

Afficher le contenu de la collection ventes : ```db.ventes.find()```

Afficher la vente d'ISBN 2154889522 : ```db.ventes.find({"livre.isbn" : "2154889522"})```


