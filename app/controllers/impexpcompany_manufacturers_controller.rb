class ImpexpcompanyManufacturersController < ApplicationController

	def edit_multiple
		@details = ImpexpcompanyManufacturer.where(manufacturer_id: params[:id])
		@details.each do |im|
    		im.build_local_taric if im.local_taric.nil?
    	end
	end

	def update_multiple
		@details = ImpexpcompanyManufacturer.find(params[:impexpcompany_manufacturers].keys)
		@details.each do |detail|
			if !(pars = params[:impexpcompany_manufacturers]["#{detail.id}"])[:local_taric_id].blank?
				# taric code selected from list
				detail.update(permitted_pars(pars.except(:local_taric)))
			else
				# new taric code also filled up
				detail.update(permitted_pars(pars))
			end
		end
	end

	private

	def load_vars
		@incoterms = Incoterm.all
		@local_tarics = LocalTaric.all
	end

	def permitted_pars pars
		# other than permitted_params inherited from application_controller
		pars.permit(
			:id,
			:local_taric_id,
			:incoterm_id,
			:invoices_correct,
			local_taric: [:kncode, :description, :id, :allow_search_as_new]
		)
	end

end