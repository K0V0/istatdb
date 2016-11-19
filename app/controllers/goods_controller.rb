class GoodsController < ApplicationController

	before_action :searcher_for, only: [:index, :search, :show, :administration]

	before_action :form_searchfields_vars, only: [:new, :edit, :update]

	before_action(only: :create) { 
		reload_tables_for_select
		create_action permitted_pars
	}

	def index

	end

	def search
		render 'index'
	end

	def show
		
	end

	def new
		@good = Good.new
	end

	def create

	end

	def administration
		render 'index'
	end

	def edit
		@good = Good.find(params[:id])
	end

	def update
		@good = Good.find(params[:id])

	    if @good.update(permitted_pars)
	      redirect_to @good
	    else
	      render :action => 'edit'
	    end
	end

	def delete

	end

	private 

	def form_searchfields_vars 
		@local_tarics = LocalTaric.all
		@impexpcompanies = Impexpcompany.all
		@manufacturers = Manufacturer.all
	end

	def permitted_pars
		params.require(:good).permit(
			:ident, 
			:description,
			:local_taric_kncode,
			:local_taric_description,
			:impexpcompany_company_name,
			:manufacturer_name,
			local_taric_attributes: [:id, :kncode, :description]
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
