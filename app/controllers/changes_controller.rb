class ChangesController < ApplicationController

    before_action do
        is_subsection_of(parent_controller: :others)
    end

    private

    def _ban_admin_tasks!
        true
    end

    def permitted_params
      params[:change].permit(:id, :version_num, :change)
    end

end
