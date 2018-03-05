class ChangesController < ApplicationController

    before_action do
        is_subsection_of(parent_controller: :others)
    end

    #before_action :ban_admin_tasks!
    #before_action :task_banned_for_user?
    #
    def _ban_admin_tasks!
        true
    end

    private

    #def _ban_admin_tasks!
     #   true
    #end

    def permitted_params
      params[:change].permit(:id, :version_num, :change)
    end

end
