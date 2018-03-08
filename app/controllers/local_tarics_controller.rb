class LocalTaricsController < ApplicationController

    private

    def _searcher_settings
    	{ paginate: true, autoshow: false }
    end

    def _allowed_params
      [ :id, :kncode, :description, :additional_info ]
    end

end
