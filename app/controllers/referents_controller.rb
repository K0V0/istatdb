class ReferentsController < ApplicationController

    ### OVERRIDE
    def apicall_search_action
        id = params[:window_id].sub(/\D+/, '').to_i
        obj = ImpexpcompanyManufacturer.find(id).impexpcompany.referents
        super(obj: obj)
    end

    private

    def _parent_controller
        :settings
    end

    def _searcher_settings
        {
            paginate: true
        }
    end

    def _allowed_params
         [
            :id,
            :first_name,
            :last_name,
            :email,
            :phone,
            :impexpcompany_id,
            impexpcompany_attributes: [
                :company_name,
                :allow_search_as_new
            ],
        ]
    end

    def _loads_for_search_panel
        @impexpcompanies = Impexpcompany.all
    end

    def _load_vars
        #will_paginate :impexpcompany
    end

    def _around_new
       # build_if_empty :impexpcompany
    end

    def _around_create_after_save_failed
       # build_if_empty :impexpcompany
    end

    def _around_edit
        #build_if_empty :impexpcompany
    end

    def _around_update_after_save
        #build_if_empty :impexpcompany
    end

    def _around_update_after_save_failed
       # build_if_empty :impexpcompany
    end

end