class ImpexpcompaniesController < ApplicationController

	before_action :new_action, only: :new
    before_action(only: :create) { create_action permitted_pars }

	def index
		@impexpcompanies = Impexpcompany.all
	end

	def new
		
	end

	def create
		
	end

	private

	def permitted_pars
      params[:impexpcompany].permit(:company_name)
    end

end
