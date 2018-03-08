class UomTypesController < ApplicationController

	private

    def _parent_controller
        :settings
    end

	def _allowed_params
		 [ :uom_type, :full_name, :description ]
	end

end
