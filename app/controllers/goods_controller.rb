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
	end

	def create
		
	end

	private 

	def permitted_pars
		params[:good].permit(:ident, :kn_code, :kn_code_description, :client, :manufacturer)
	end

	def reload_vars
		@taric = LocalTaric.where(
			"kncode LIKE ? AND description LIKE ?", 
			"#{params[:good][:kn_code]}%",
			"%#{params[:good][:kn_code_description]}%"
		)
	end

end
