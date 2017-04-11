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
      if !@MEM.q_local_taric.blank?
        @local_taric.assign_attributes(
          kncode: 
            @MEM.q_local_taric[:kncode_start],
          description:
             @MEM.q_local_taric[:description_cont],
        )
      end
    end

    def new_search

    end

    def csv_export
    
    end

  	private

    def permitted_pars
      params[:local_taric].permit(:kncode, :description, :additional_info)
    end

end
