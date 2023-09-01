
```text
     ____.                                 .__         __________               __    
    |    |__ ______________    ______ _____|__| ____   \______   \_____ _______|  | __
    |    |  |  \_  __ \__  \  /  ___//  ___/  |/ ___\   |     ___/\__  \\_  __ \  |/ /
/\__|    |  |  /|  | \// __ \_\___ \ \___ \|  \  \___   |    |     / __ \|  | \/    < 
\________|____/ |__|  (____  /____  >____  >__|\___  >  |____|    (____  /__|  |__|_ \
                           \/     \/     \/        \/                  \/           \/
```

# Jurassic Park Setup
### Setup and Server Start
1. Run `bundle install` to install all gems
2. Run `rake db:create` to create the database
3. Run `rake db:migrate` to run migrations
4. Run `rake db:seed` to seed the database
5. Run `rails s` to start the server
6. Navigate to `localhost:3000` in your browser
7. Enjoy!
---

### Notes
- The seed file will create 5 users. Please see 'db/seeds.rb' for login and API credentials.
- To connect to the API, use the following headers:
  - `Accept: application/json`
  - `X-User-Email`
  - `X-User-Token`

**API Request Example**
```
curl --location --request GET 'localhost:3000/cages' \
--header 'X-User-Email: grant@jp-park.net' \
--header 'X-User-Token: A4BpSG' \
--header 'Accept: application/json'
```

**User Roles**
- All Users: Can create, update, and delete dinosaurs.
- Builders: Can create, cages.

---

## Testing
- Run `rails test` to run all tests

---
## API Endpoints
### Dinosaurs
- `GET /dinosaurs` - Returns all dinosaurs
- - Filter by species: `GET /dinosaurs?species=0`
- - Filter by diet: `GET /dinosaurs?diet=0`

**Species Values**

| Species | Value |
| --- | --- |
| Tyrannosaurus | 0 |
| Velociraptor | 1 |
| Spinosaurus | 2 |
| Megalosaurus | 3 |
| Brachiosaurus | 4 |
| Stegosaurus | 5 |
| Ankylosaurus | 6 |
| Triceratops | 7 |

**Diet Values**

| Diet | Value |
| --- | --- |
| Herbivore | 0 |
| Carnivore | 1 |

- `GET /dinosaurs/:id` - Returns a single dinosaur
- `POST /dinosaurs` - Creates a new dinosaur Required Params: `name`, `species`, `cage_id`
- - species: `Tyrannosaurus`, `Velociraptor`, `Spinosaurus`, `Megalosaurus`, `Brachiosaurus`, `Stegosaurus`, `Ankylosaurus`, `Triceratops`
- `PUT /dinosaurs/:id` - Updates a dinosaur
- `DELETE /dinosaurs/:id` - Deletes a dinosaur

### Cages
- `GET /cages` - Returns all cages
- - Filter by cage type: `GET /cages?cage_type=0`
- - Filter by max capacity: `GET /cages?max_capacity=0`
- - Filter by power status: `GET /cages?power=false`

**Cage Type Values**

| Cage Type | Value |
| --- | --- |
| Herbivore | 0 |
| Carnivore | 1 |

**Power Values**

| Power Status | Value |
| --- | --- |
| Active | true |
| Down | false |

- `GET /cages/:id` - Returns a single cage
- `POST /cages` - Creates a new cage Required Params: `name`, `max_capacity`, `cage_type`
- - cage_types: `herbivore`, `carnivore`
- `PUT /cages/:id` - Updates a cage
- `DELETE /cages/:id` - Deletes a cage


### API Examples

**Access Error**
```
{
    "error": "Ah, ah, ah! You didn't say the magic word!"
}
```

**Cage Example**
```
// Create a new cage
curl --location 'localhost:3000/cages' \
--header 'X-User-Email: nedry@jp-park.net' \
--header 'X-User-Token: IALVOP' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data '{
    "cage": {
        "name": "My cage that is very safe",
        "max_capacity": 8,
        "power": true,
        "cage_type": 1
    }
}'
```

**Dinosaur Example**
```
// Create a new dinosaur
curl --location 'localhost:3000/dinosaurs' \
--header 'X-User-Email: nedry@jp-park.net' \
--header 'X-User-Token: IALVOP' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data '{
    "dinosaur": {
        "name": "Dino Mite",
        "species": 0,
        "cage_id": 5
    }
}'
```