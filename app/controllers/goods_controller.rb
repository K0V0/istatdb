class GoodsController < ApplicationController

	before_action :searcher_for, only: [:index, :search, :show, :administration]

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

	def administration
		#@edit_mode = true
		render 'index'
	end

	def edit
		@good = Good.find(params[:id])
	end

	def update

	end

	def delete

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

end
