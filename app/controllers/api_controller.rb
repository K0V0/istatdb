class ApiController < ApplicationController

	before_action(only: [
		:local_taric_search,
		:impexpcompany_search,
		:manufacturer_search
	]) {
		searcher
		get_cols_to_display_from_search_params
		cols_highlighted_matches_during_typing
	}


	def local_taric_search
		render('/layouts/add_edit_searchtable')
	end

	def impexpcompany_search
		render('/layouts/add_edit_searchtable')
	end

	def manufacturer_search
		render('/layouts/add_edit_searchtable')
	end

	def good_search_ident_exists
		searcher_for object: Good, autoshow: false
		render('/goods/new/search_good_exists')
	end

	def manufacturer_search_name_exists
		searcher_for object: Manufacturer, autoshow: false
		render('/manufacturers/new/search_manufacturer_exists')
	end

	def add_to_calculator_mem
 		@MEM.uomscalc = [] if @MEM.uomscalc.nil?
 		tmp = @MEM.uomscalc
 		tmp.push(params)
 		@MEM.uomscalc = tmp
 		calculate_results tmp
 		
 		render('/layouts/calculator_list')
	end

	private

	def searcher
		searcher_for(
			object: action_name.sub("_search", "").classify.constantize,
			autoshow: false,
			generate_single_result_var: true
		)
	end

	def get_cols_to_display_from_search_params
		@cols = []
		params[:q].each do |k, v|
			@cols << k.to_s.sub(/_[a-z]+$/, "").to_sym
		end
	end

	def cols_highlighted_matches_during_typing
		@cols_highlighted = {}
		@cols.each { |col| @cols_highlighted[col] = col }
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