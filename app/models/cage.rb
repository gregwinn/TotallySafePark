class Cage < ApplicationRecord
	has_many :dinosaurs, dependent: :restrict_with_error

	enum cage_type: [:Herbivore, :Carnivore]

	validates :name, presence: true
	validates :max_capacity, presence: true, numericality: { greater_than: 0 }
	validate :check_empty_before_destroy

	after_initialize :set_default_cage_type, if: :new_record?

	private

	def set_default_cage_type
		self.cage_type ||= :Herbivore
	end

	def check_empty_before_destroy
		if dinosaurs.any?
			errors.add(:base, "Cannot destroy cage with dinosaurs inside!")
		end
	end
end
