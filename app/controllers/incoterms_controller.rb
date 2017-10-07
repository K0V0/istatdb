class IncotermsController < ApplicationController

	before_action do 
		is_subsection_of(parent_controller: :settings)
	end

    private

    def permitted_params
      params[:incoterm].permit(:id, :shortland)
    end

end