class LocalTaricController < ApplicationController

    before_action(only: [:index, :search, :show, :administration]) {
      searcher_for(
        default_order: "kncode asc",
        paginate: true
      );
    }

    before_action(only: :create) { create_action permitted_pars }

    before_action(only: :update) { update_action permitted_pars }

  	private

    def permitted_pars
      params[:local_taric].permit(:kncode, :description, :additional_info)
    end

end
