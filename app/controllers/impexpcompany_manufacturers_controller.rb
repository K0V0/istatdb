class ImpexpcompanyManufacturersController < ApplicationController

	def edit_multiple
		@details = ImpexpcompanyManufacturer.where(manufacturer_id: params[:id])
		@details.each do |im|
    		im.build_local_taric if im.local_taric.nil?
    	end
	end

	def update_multiple
		## TODO: handle errors - validation of kncode if entered new
		@details = ImpexpcompanyManufacturer.find(params[:impexpcompany_manufacturers].keys)
		details_saved = {}

		@details.each do |detail|
			dateil_saved = false
			local_taric_selected = !((pars = params[:impexpcompany_manufacturers]["#{detail.id}"])[:local_taric_id].blank?)
			adding_new_not_allowed = (pars[:local_taric][:allow_search_as_new] != "1")
			
			if local_taric_selected&&adding_new_not_allowed
				# taric code selected from list and not allowed to use input of searchfield
				# as data for new LocalTaric object
				detail_saved = detail.update(permitted_pars(pars.except(:local_taric)))
			else
				# new taric code also filled up
				if !adding_new_not_allowed
					detail.local_taric = LocalTaric.find_or_create_by(
						kncode: pars[:local_taric][:kncode],
						description: pars[:local_taric][:description]
					)
					detail.update_attributes(
						permitted_pars(pars.except(:local_taric_id, :local_taric))
					)
					detail_saved = detail.save
				end
			end
			
			details_saved[detail.id] = detail_saved
		end

		if details_saved.has_value? false
			render "edit_multiple"
		else
			redirect_to manufacturers_path
		end
	end

	private

	def load_vars
		@incoterms = Incoterm.all
		@local_tarics = LocalTaric.all
		@local_taric = LocalTaric.new
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