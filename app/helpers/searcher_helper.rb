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

	def timesort_method
		tm = 'created_at_or_updated_at_gteq'
		if params.has_key?(:timesort_method) 
			if !(p = params[:timesort_method]).blank?
				tm = p
			end
		end
		return tm
	end

	def datetime_param(i)
		return params[:q]["#{timesort_method}(#{i}i)"]
	end

end
