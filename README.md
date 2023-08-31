# Jurassic Park Setup
### Setup and Server Start
1. Run `bundle install` to install all gems
2. Run `rake db:create` to create the database
3. Run `rake db:migrate` to run migrations
4. Run `rake db:seed` to seed the database
5. Run `rails s` to start the server
6. Navigate to `localhost:3000` in your browser
7. Enjoy!

### API Endpoints
#### Dinosaurs
- `GET /dinosaurs` - Returns all dinosaurs
- `GET /dinosaurs/:id` - Returns a single dinosaur
- `POST /dinosaurs` - Creates a new dinosaur Required Params: `name`, `species`, `cage_id`
- - species: `Tyrannosaurus`, `Velociraptor`, `Spinosaurus`, `Megalosaurus`, `Brachiosaurus`, `Stegosaurus`, `Ankylosaurus`, `Triceratops`
- `PUT /dinosaurs/:id` - Updates a dinosaur
- `DELETE /dinosaurs/:id` - Deletes a dinosaur

#### Cages
- `GET /cages` - Returns all cages
- `GET /cages/:id` - Returns a single cage
- `POST /cages` - Creates a new cage Required Params: `name`, `max_capacity`, `cage_type`
- - cage_types: `herbivore`, `carnivore`
- `PUT /cages/:id` - Updates a cage
- `DELETE /cages/:id` - Deletes a cage
