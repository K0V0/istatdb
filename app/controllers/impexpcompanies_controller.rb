class ImpexpcompaniesController < ApplicationController

	  before_action(only: [:index, :search, :show, :administration, :delete]) {
      searcher_for(
        autoshow:false,
        paginate: true
      ); 
    }

    before_action(only: :create) { create_action permitted_pars }

   	before_action(only: :update) { update_action permitted_pars }

  def csv_export
    
  end

	private

	def permitted_pars
    params[:impexpcompany].permit(:company_name)
  end

end
