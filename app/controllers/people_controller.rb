class PeopleController < ApplicationController

    private

    def _parent_controller
        :settings
    end

    def _allowed_params
         [ :id, :first_name, :last_name, :email, :phone ]
    end

end