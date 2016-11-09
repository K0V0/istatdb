class GoodsController < ApplicationController

	before_action :searcher_for, only: [:index, :search, :show]

	before_action :reload_vars, only: :create

	before_action(only: :create) { create_action permitted_pars }

	def index

	end

	def search
		
	end

	def show
		
	end

	def new
		@good = Good.new
		@taric = LocalTaric.all
		@clients = Impexpcompany.all
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

	### TODO
	def reload_vars
		@taric = LocalTaric.where(
			"kncode LIKE ? AND description LIKE ?", 
			"#{params[:good][:local_taric_kncode]}%",
			"%#{params[:good][:local_taric_description]}%"
		) 
		@clients = Impexpcompany.where(
			"company_name LIKE ?", "%#{params[:good][:impexpcompany_company_name]}%"
		)
		@manufacturers = Manufacturer.where(
			"name LIKE ?", "%#{params[:good][:manufacturer_name]}%"
		)
	end

end
