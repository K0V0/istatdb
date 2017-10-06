class ImpexpcompaniesController < ApplicationController

	private

	def searcher_settings
		{ disabled: true, paginate: true }
	end

	def permitted_params
   		params[:impexpcompany].permit(:company_name)
 	end

end
