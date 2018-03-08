class TradeTypesController < ApplicationController

    private

    def _parent_controller
        :settings
    end

    def _allowed_params
        [:id, :type, :description]
    end

end
