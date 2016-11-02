class ManufacturersController < ApplicationController

	  before_action :searcher, only: [:index, :search, :show]
    before_action :new_action, only: :new
    before_action(only: :create) { create_action permitted_pars }

  	def index

  	end

  	def new

  	end

    def create

    end

    def show

    end

  	private

  	def searcher
  		searcher_for autoshow:false
  	end

    def permitted_pars
      params[:manufacturer].permit(:name)
    end

end
