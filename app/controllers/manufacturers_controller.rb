class ManufacturersController < ApplicationController

    before_action(only: [:index, :search, :show, :new_good_manufacturer_search]) {
      searcher_for autoshow:false 
    }

    before_action :new_action, only: :new
    
    before_action(only: :create) { create_action permitted_pars }

  	def index

  	end

    def search

    end

  	def new

  	end

    def create

    end

    def show

    end

    def new_good_manufacturer_search
      render('manufacturers/api/manufacturer_search')
    end

  	private

    def permitted_pars
      params[:manufacturer].permit(:name)
    end

end
