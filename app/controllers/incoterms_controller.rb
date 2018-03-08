class IncotermsController < ApplicationController

    private

    def _parent_controller
        :settings
    end

    def _allowed_params
        [ :id, :description, :shortland ]
    end

end
