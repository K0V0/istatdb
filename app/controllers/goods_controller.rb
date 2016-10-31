class GoodsController < ApplicationController

	before_action :searcher, only: [:index, :search, :show]

	def index
		#@goods = Good.all
	end

	def show
		#@good = @result.find(params[:id])
	end

	def new
		@good = Good.new
	end

	private

	def searcher
		searcher_for  
	end

end
