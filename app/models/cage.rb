class Cage < ApplicationRecord
	has_many :dinosaurs, dependent: :restrict_with_error

	enum cage_type: [:Herbivore, :Carnivore]
	enum power: { "ACTIVE": true, "DOWN": false }

	validates :name, presence: true
	validates :max_capacity, presence: true, numericality: { greater_than: 0 }
	validate :check_empty_before_destroy, on: :destroy
	validate :cannot_power_off_with_dinosaurs

	after_initialize :set_default_cage_type, if: :new_record?

	def current_capacity
		dinosaurs.size
	end

	def as_json(options = {})
		super(options.merge(methods: :current_capacity, include: :dinosaurs))
	end

	private

	def cannot_power_off_with_dinosaurs
		if power_changed? && power == "DOWN" && dinosaurs.any?
			errors.add(:power, "Oops, looks like our tech team just discovered that powering down a cage with dinosaurs inside leads to some truly wild scenarios. Let's keep the cage charged and the chaos at bay!")
		end
	end

	def set_default_cage_type
		self.cage_type ||= :Herbivore
	end

	def check_empty_before_destroy
		if dinosaurs.any?
			errors.add(:errors, "Whoa there, hold your raptors! Attempting to destroy a cage while there are dinosaurs around is like challenging a T-Rex to a game of hide and seek. Safety first, please!")
		end
	end
end
