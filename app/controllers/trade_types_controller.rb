class TradeTypesController < ApplicationController

    private

    def searcher_settings
    	{ paginate: true, autoshow: false }
    end

    def permitted_params
      params[:trade_type].permit(:id, :type, :description)
    end

end