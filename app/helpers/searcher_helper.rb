module SearcherHelper

	def searched_from_mem
		mem_val = @MEM
					.send("q_#{controller_name.singularize.underscore}")
					.try(:[], :search_cont)
        mem_val.blank? ? "" : mem_val
	end

	def prefill_for_new_local_taric
		regex = /^([0-9]+)$/
		if searched_from_mem =~ regex
			return { kncode: searched_from_mem }
		else
			return { description: searched_from_mem }
		end
	end

end
