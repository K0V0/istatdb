class LocalTaricController < ApplicationController

  	before_action(only: [:index, :search, :show]) {  searcher_for autoshow:false }
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

  	private

    def permitted_pars
      params[:local_taric].permit(:kncode, :description, :additional_info)
    end

end
