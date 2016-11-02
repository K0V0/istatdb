class GoodsController < ApplicationController

	before_action :searcher_for, only: [:index, :search, :show]

	def index

	end

	def search
		
	end

	def show
		
	end

	def new
		@good = Good.new
	end

end
