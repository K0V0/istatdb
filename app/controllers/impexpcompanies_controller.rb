class ImpexpcompaniesController < ApplicationController

	before_action(only: [:index, :search, :show, :administration, :delete]) {
    searcher_for(
        autoshow:false,
        paginate: true
      ); 
    }

	private

	def permitted_pars
   		params[:impexpcompany].permit(:company_name)
 	end

end
