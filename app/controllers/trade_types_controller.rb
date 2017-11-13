class TradeTypesController < ApplicationController

	before_action do 
		is_subsection_of(parent_controller: :settings)
	end

    private

    def permitted_params
      params[:trade_type].permit(:id, :type, :description)
    end

end