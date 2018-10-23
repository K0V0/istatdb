class ChangesController < ApplicationController

    before_action :reset_ver_num, only: [:edit, :create]

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

    def reset_ver_num
        session[:APP_VER_NUM] = session[:APP_VER_BUILD] = nil
    end

end
