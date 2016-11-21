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

	def edit

	end

	def update

	end

	def new_good_client_search
      	render('impexpcompanies/api/client_search')
    end

    def edit_good_client_using_search
    	searcher_for(
    		object: Good.find(params[:other_data][:good_id]).impexpcompanies,
    		autoshow: false
    	)
      	render('impexpcompanies/api/client_search_using')
    end

    def edit_good_client_free_search
    	ids = Good.find(params[:other_data][:good_id]).impexpcompanies.pluck(:id)
    	searcher_for(
    		object: Impexpcompany.where.not(id: ids),
    		autoshow: false
    	)
      	render('impexpcompanies/api/client_search_free')
    end

	private

	def permitted_pars
      params[:impexpcompany].permit(:company_name)
    end

end
