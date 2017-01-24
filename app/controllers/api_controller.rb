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
		tmp = @MEM.uomscalc
		log tmp
 		@MEM.uomscalc = [] if @MEM.uomscalc.nil?
 		tmp = @MEM.uomscalc
 		log tmp
 		tmp << params
 		log tmp
 		@MEM.uomscalc = tmp
 		log @MEM.uomscalc
		#@MEM.kokot = "pica"
		#log @MEM.kokot.nil?
		#log @MEM.uomscalc
		#@MEM.uomscalc ||= []
		#vals = @MEM.uomscalc
		#log params
		#vals ||= [] 
		#vals << params
		#@MEM.uomscalc = vals
		#log @MEM.uomscalc.nil?
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

end