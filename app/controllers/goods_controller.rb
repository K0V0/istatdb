class GoodsController < ApplicationController

	before_action :searcher_for, only: [:index, :search, :show]

	before_action(only: :create) { 
		reload_tables_for_select
		create_action permitted_pars
	}

	def index

	end

	def search
		
	end

	def show
		
	end

	def new
		@good = Good.new
		@local_tarics = LocalTaric.all
		@impexpcompanies = Impexpcompany.all
		@manufacturers = Manufacturer.all
	end

	def create

	end

	private 

	def permitted_pars
		params[:good].permit(
			:ident, 
			:description,
			:local_taric_kncode,
			:local_taric_description,
			:impexpcompany_company_name,
			:manufacturer_name
		)
	end

	def reload_tables_for_select
		reload_result_by_params_nested(
			LocalTaric: {
				kncode: :starts,
				description: :contains
			},
			Impexpcompany: { company_name: :contains },
			Manufacturer: { name: :contains }
		)
	end

	# model: {
	# 	field: :method
	# }
	def reload_result_by_params_nested(**options)
		options.each do |option|
			settings = {}
			option[1].each do |setting|
				settings[setting[0]] = { 
					param: (option[0].to_s.underscore + '_' + setting[0].to_s).to_sym,
					search_method: setting[1]
				}
			end 
			reload_result_by_params(option[0].to_s.constantize, settings)
		end
	end

end
