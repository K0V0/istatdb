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
		#@good.manufacturers.build
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
			:kn_code, 
			:kn_code_description, 
			:client, 
			:description,
			:client_office,
			:manufacturer_name
		)
	end

	def reload_vars
		@taric = LocalTaric.where(
			"kncode LIKE ? AND description LIKE ?", 
			"#{params[:good][:kn_code]}%",
			"%#{params[:good][:kn_code_description]}%"
		)
		@clients = Impexpcompany.where("company_name LIKE ?", "%#{params[:good][:client]}%")
	end

end
