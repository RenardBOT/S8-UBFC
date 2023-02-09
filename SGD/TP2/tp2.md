# Exercice 2

## A partir de Q5

```json
db.getCollection('dblp').aggregate([
    {
        $match:{
            "type": {$ne:null},
            "year": {$gte:2011}
        }
    },
    {
        $group:{
            "_id": "$type",
            "NombreDocuments":{
                  $sum:NumberInt(1)
            }
        }
    }
])
```

```json
db.getCollection('dblp').aggregate([
    {
        $match:{
            "authors": {$ne:null},
            "year": 2011
        }
    },
    {
        $unwind:"$authors"
    },
    {
        $group:{
            "_id": "$authors",
            "NbPublications":{
                $sum:NumberInt(1)
            }
        }
    }
])
```   

```json
db.getCollection('dblp').aggregate([
    {
        $match:{
            "authors": {$ne:null},
            "year": 2011
        }
    },
    {
        $unwind:"$authors"
    },
    {
        $group:{
            "_id": "$authors",
            "NbPublications":{
                $sum:NumberInt(1)
            }
        }
    },
    {
        $sort:{"NbPublications":-1}
    },
    {
        $limit:1
    }
])
```   

```json
db.getCollection('dblp').aggregate([
    {
        $unwind:"$authors"
    },
    {
        $group:{
            "_id": "$authors",
        }
    },
    {
      $group:{ 
            "_id": null, "NbAuteurs": {$sum:1} 
      }
}
])
```   

```json
db.getCollection('dblp').aggregate([
    {
        $unwind:"$authors"
    },
    {
        $match:{
            "authors":/^Thomas*/
        }
    },
    {
        $group:{
            "_id":"$authors"
        }
    },
    {
        $group:{
            "_id":null,
            "NbThomas": {$sum:1}
        }
    }
])
```   