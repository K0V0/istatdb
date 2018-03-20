class ChangesController < ApplicationController

    private

    def _parent_controller
        :others
    end

    def _ban_admin_tasks!
        true
    end

    def _allowed_params
      [ :id, :version_num, :change, :change_typ ]
    end

end
