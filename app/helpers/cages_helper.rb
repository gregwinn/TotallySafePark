module CagesHelper

	def cage_status(cage)
		if is_cage_full?(cage)
			"<span class='text-danger'>#{icon('fa-solid', 'xmark')} full</span>".html_safe
		else
			"<span class='text-info'>has #{cage_spots_left(cage).to_s} spots left</span>".html_safe
		end
	end

	def cage_spots_left(cage)
		cage.max_capacity - cage.dinosaurs.count
	end

	def is_cage_full?(cage)
		cage.dinosaurs.count >= cage.max_capacity
	end
end
