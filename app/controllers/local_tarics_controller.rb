class LocalTaricsController < ApplicationController

    before_action(only: [:index, :search, :show, :administration]) {
      searcher_for(
        paginate: true,
        autoshow: false
      )
    }

    #before_action(only: :create) { create_action permitted_pars }

    #before_action(only: :update) { update_action permitted_pars }

    def new

    end

    def new_select_search
      apicall_render(:belongs_to)
    end

    def csv_export
    
    end

  	private

    def permitted_pars
      params[:local_taric].permit(:kncode, :description, :additional_info)
    end

end
