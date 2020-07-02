class LocalTaricsController < ApplicationController

	before_action :normalize_kncode_search_params, only: :new_select_search

    private

    ### override
    def show_action
        super
        @for_goodstable = @record
            .goods
            .includes(:issues, :good_images, :impexpcompanies, :manufacturers)
            .order('goods.ident ASC')
    end

    ### must be because of prelignting will not work when in create/edit action
    def normalize_kncode_search_params
    	params[:q][:kncode_start].gsub!(/\s+/, "")
    end

    def _searcher_settings
    	{ paginate: true, autoshow: false, intelligent_mode2: true }
    end

    def _allowed_params
      [ :id, :kncode, :description, :additional_info ]
    end

end
