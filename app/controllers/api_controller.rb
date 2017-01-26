class ApiController < ApplicationController

	before_action(only: [
		:local_taric_search,
		:client_search,
		:manufacturer_search
	]) {
		strip_ransack_from_params
		prelighted_cols
	}


	def local_taric_search
		searcher_for object: LocalTaric, autoshow: false
		render('/layouts/add_edit_searchtable')
	end

	def client_search
		searcher_for object: Impexpcompany, autoshow: false
		render('/layouts/add_edit_searchtable')
	end

	def manufacturer_search
		searcher_for object: Manufacturer, autoshow: false
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

	def strip_ransack_from_params
		@stripped_params = []
		params[:q].each do |k, v|
			@stripped_params << k.to_s.sub(/_[a-z]+$/, "").to_sym
		end
	end

	def prelighted_cols
		@cols_highlighted = nil
		if params.deep_has_key? :other_data, :cols_highlighted
			@cols_highlighted = params[:other_data][:cols_highlighted]
		end
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