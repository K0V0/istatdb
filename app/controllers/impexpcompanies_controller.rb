class ImpexpcompaniesController < ApplicationController

	before_action :new_action, only: :new

    before_action(only: :create) { create_action permitted_pars }

    before_action(only: [:new_good_client_search]) {
      searcher_for autoshow:false 
    }

	def index
		@impexpcompanies = Impexpcompany.all
	end

	def new
		
	end

	def create
		
	end

	def new_good_client_search
      render('impexpcompanies/api/client_search')
    end

	private

	def permitted_pars
      params[:impexpcompany].permit(:company_name)
    end

end
