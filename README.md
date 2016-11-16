# FileDB

Le but de ce kata est de créer une base de données simplifiée reposant sur des fichiers JSON.
Ce projet peut servir de première étape pour le kata [file-to-api]


## DSL

```rb
require 'lib/file_db'

db = FileDb::Database.new("fixtures/data.json")

db.table_names
# => ["movies", "directors"]

movies = db.table("movies")
# => FileDb::Table

movies.select
# => [{ ... },{ ... }, ...] # tous les movies

movies.select(where: { id: 1 })
# => [{ id: 1, title: "The Gold Rush", year:1925, director_id:1 }]

movies.select(where: { director_id: 1 })
# => [{ id: 1, ..., director_id: 1 }, { id: 2, ..., director_id: 1 }, { id: 4, ..., director_id: 1 }, ]

table.insert({ title: "Birds", year: 1962, director_id: 2 })
# => { id: 7, title: "Birds", year: 1962, director_id: 2 } (id 7 est auto incrémenté)

table.update(where: { id: 7 }, values: { year: 1963 })
# => { id: 7, title: "Birds", year: 1963, director_id: 2 }

table.delete(where: { id: 7 })
# => { id: 7, title: "Birds", year: 1963, director_id: 2 }
```

## Setup

1. Fork ce repository
2. `bundle install`

## Usage
Deux commandes rake sont à ta disposition:
* `rake console` ouvre une console ruby dans laquelle `FileDb` est chargé
* `rake test` lance la suite de test


## Extension

- Persister les changement dans le fichier JSON
- méthode `.where`
- Ajouter une méthode `join` 

[file-to-api]: https://github.com/ParisRubyWorkshop/file-to-api-kata
