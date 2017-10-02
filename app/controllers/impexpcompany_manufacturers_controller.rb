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
			local_taric_selected = !((pars = params[:impexpcompany_manufacturers]["#{detail.id}"])[:local_taric_id].blank?)
			adding_new_not_allowed = (pars[:local_taric][:allow_search_as_new] != "1")
			if local_taric_selected&&adding_new_not_allowed
				# taric code selected from list and not allowed to use input of searchfield
				# as data for new LocalTaric object
				detail.update(permitted_pars(pars.except(:local_taric)))
			else
				# new taric code also filled up
				if !adding_new_not_allowed
					#pars[:local_taric][:allow_search_as_new] == "1"
					Rails.logger.info "------------------------"
					#adding
					Rails.logger.info pars[:local_taric][:kncode]
					detail.local_taric = LocalTaric.find_or_create_by(
						kncode: pars[:local_taric][:kncode],
						description: pars[:local_taric][:description]
					)

					Rails.logger.info detail.local_taric
					Rails.logger.info detail.local_taric.id
					detail.update_attributes(
						permitted_pars(pars.except(:local_taric_id, :local_taric))
					)
					detail.save
				end
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