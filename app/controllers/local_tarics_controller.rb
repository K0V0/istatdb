class LocalTaricsController < ApplicationController

    before_action(only: [:index, :search, :show, :administrative]) {
      searcher_for(
        paginate: true,
        autoshow: false
      )
    }

    private

    def permitted_params
      params[:local_taric].permit(:id, :kncode, :description, :additional_info)
    end

end
