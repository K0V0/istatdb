class TaskTypesController < ApplicationController

    private

    def _parent_controller
        :others
    end

    def _allowed_params
         [ :task_typ, :id ]
    end

end
