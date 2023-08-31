module CagesHelper

	def cage_status(cage)
		if is_cage_full?(cage)
			"<span class='text-danger'>#{icon('fa-solid', 'xmark')} full</span>".html_safe
		else
			"<span class='text-info'>has #{cage_spots_left(cage).to_s} spots left</span>".html_safe
		end
	end

	def cage_spots_left(cage)
		cage.max_capacity - cage.current_capacity
	end

	def is_cage_full?(cage)
		cage.current_capacity >= cage.max_capacity
	end

	def cage_power(cage)
		if cage.power == "ACTIVE"
			"<span class='text-success'>#{icon('fa-solid', 'bolt')} POWERED ON</span>".html_safe
		else
			"<span class='text-danger'>#{icon('fa-solid', 'triangle-exclamation')} POWERED DOWN</span>".html_safe
		end
	end
end
