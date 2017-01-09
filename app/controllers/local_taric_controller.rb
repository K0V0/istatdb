class LocalTaricController < ApplicationController

    before_action(only: [:index, :search, :show, :administration]) {
      searcher_for(
        #object: Good, 
        #preload: :local_taric,
        default_order: "kncode asc",
        paginate: true
      );
    }

    before_action :new_action, only: :new

    before_action(only: :create) { create_action permitted_pars }

  	private

    def permitted_pars
      params[:local_taric].permit(:kncode, :description, :additional_info)
    end

end
