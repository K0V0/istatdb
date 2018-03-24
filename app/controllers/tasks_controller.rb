class TasksController < ApplicationController

    def change_status
        custom_render :index
    end

    private

    def _parent_controller
        :others
    end

end
