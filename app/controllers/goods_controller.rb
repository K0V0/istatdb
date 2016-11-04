class GoodsController < ApplicationController

	before_action(only: :create) { create_action permitted_pars }
	before_action :searcher_for, only: [:index, :search, :show]

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
		params[:good].permit(:ident, :kn_code)
	end

end
