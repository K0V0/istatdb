class LocalTaricsController < ApplicationController

    private

    def _searcher_settings
    	{ paginate: true, autoshow: false }
    end

    def permitted_params
      params[:local_taric].permit(:id, :kncode, :description, :additional_info)
    end

    def _around_create_after_save
        logger @record.errors.inspect

    end

end
