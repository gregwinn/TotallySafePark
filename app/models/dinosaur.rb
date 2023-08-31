class Dinosaur < ApplicationRecord
	belongs_to :cage

	enum species: {
		"Tyrannosaurus": 0,
		"Velociraptor": 1,
		"Spinosaurus": 2,
		"Megalosaurus": 3,
		"Brachiosaurus": 4,
		"Stegosaurus": 5,
		"Ankylosaurus": 6,
		"Triceratops": 7
	}

	enum diet: [:Herbivore, :Carnivore]

	validates :species, inclusion: { in: species.keys }
	validate :determine_diet
	validate :match_cage_type_with_diet
	validate :carnivore_species_match
	validates :name, presence: { message: "Dinosaurs must have a name or they will get lost!" }
	validates :species, :diet, presence: true
	validates :cage_id, presence: { message: "This dinosaur must be assigned to a cage or it might eat the visitors!" }, if: -> { cage_id.present? }
	validate :cage_powered_on

	# Check to make sure there is room for the Dino in the cage
	validate do |dinosaur|
		if dinosaur.cage_id_changed? && dinosaur.cage.present? && dinosaur.cage.dinosaurs.count >= dinosaur.cage.max_capacity
			dinosaur.errors.add(:cage, "This cage is stuffed full of dinosaurs! You must pick or build a new cage before adding more dinosaurs!")
		end
	end


	private

	def cage_powered_on
		if cage.present? && cage.power == "DOWN"
			errors.add(:cage, "It appears you're attempting to unleash the mighty lizards in a powered-off cage. Power up that cage before you embark on your dino escapade!")
		end
	end

	def determine_diet
		if species_in_carnivore_list?
			self.diet = :Carnivore
		else
			self.diet = :Herbivore
		end
	end

	def species_in_carnivore_list?
		%w[Tyrannosaurus Velociraptor Spinosaurus Megalosaurus].include?(species)
	end

	def match_cage_type_with_diet
		if cage.present? && cage.cage_type != diet
			errors.add(:cage, "Hey! You can't put a #{diet} in a #{cage.cage_type} cage! That's just cruel!")
		end
	end

	def carnivore_species_match
		if diet == "Carnivore" && cage.present? && cage.dinosaurs.where(diet: "Carnivore").where.not(species: species).exists?
			errors.add(:cage, "Are you crazy? Carnivores must be in a cage with dinosaurs of the same species or they will eat each other!")
		end
	end
end
