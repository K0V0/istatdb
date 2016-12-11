class LocalTaricController < ApplicationController

  	before_action(only: [:index, :search, :show, :new_good_knnumber_search, :administration]) {
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

    def administration
      render 'index'
    end

    def create

    end

  	private

    def permitted_pars
      params[:local_taric].permit(:kncode, :description, :additional_info)
    end

end
