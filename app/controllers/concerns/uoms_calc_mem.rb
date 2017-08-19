module UomsCalcMem

	def add_to_calculator_mem
 		@MEM.uomscalc = [] if @MEM.uomscalc.nil?
 		tmp = @MEM.uomscalc
 		next_id = tmp.blank? ? 1 : (tmp.last)[:id].to_i + 1
 		tmp.push(params.merge({ id: next_id }))
 		@MEM.uomscalc = tmp
 		calculate_results tmp
 		render('/goods/show/calculator_list')
	end

	def clear_calculator_mem
		@MEM.uomscalc = nil
		@MEM.uomscalc_results = nil
		render('/goods/show/calculator_list')
	end

	def remove_from_calculator_mem
		tmp = @MEM.uomscalc
		tmp.each_with_index do |t, index|
			if params[:id] == t[:id].to_s
				tmp.delete_at(index)
			end
		end
		calculate_results tmp
		@MEM.uomscalc = tmp

		render('/goods/show/calculator_list')
	end

	def edit_rec_in_calculator_mem
		render('/goods/show/calculator_list')
	end

	def calculate_results obj
		@MEM.uomscalc_results = [] if (@MEM.uomscalc_results.nil?)||(!@MEM.uomscalc_results.is_a?(Array))
		types = []
		result = {}
		obj.each do |o|
			types << o[:uom_type] if !(types.include? o[:uom_type])
		end
		types.each do |type|
			result[type.to_sym] = 0 
		end
		obj.each do |o|
			result[(o[:uom_type].to_sym)] += o[:result].to_f
		end
		@MEM.uomscalc_results = result
	end

end