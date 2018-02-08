class ImpexpcompanyManufacturersController < ApplicationController

	def edit_multiple
		@details = ImpexpcompanyManufacturer.where(manufacturer_id: params[:id])
		build_local_tarics
	end

	def update_multiple
		## TODO: handle errors - validation of kncode if entered new
		@details = ImpexpcompanyManufacturer.where(manufacturer_id: params[:id])
		# :id -> manufacturer_id - foreign key
		# fisrt - extended options should always be for one manufacturer
		details_saved = {}
		# holds for every associated options set if passed or not

		@details.each do |detail|
			dateil_saved = false
			local_taric_selected = !((pars = params[:impexpcompany_manufacturers]["#{detail.id}"])[:local_taric_id].blank?)
			adding_new_not_allowed = (pars[:local_taric][:allow_search_as_new] != "1")

			logger(local_taric_selected)
			logger(adding_new_not_allowed)
			
			if local_taric_selected&&adding_new_not_allowed
				# manual input of hscode ignored
				logger('manual input not alowed')
				detail_saved = detail.update(permitted_pars(pars.except(:local_taric)))
			else
				# select from list ignored in this case
				logger('else select from list not allowed')
				errors = false
				if !adding_new_not_allowed
					local_taric = LocalTaric.find_or_create_by(
						kncode: pars[:local_taric][:kncode],
						description: pars[:local_taric][:description]
					)
					errors = local_taric.errors.any?
					if !errors
						detail.local_taric = local_taric
					end
					# if hscode found or created, assign in to item
					detail.update_attributes(
						permitted_pars(pars.except(:local_taric_id, :local_taric))
					)
					# assign other items
				end
				detail_saved = (detail.save == true && errors == false)
			end
			
			details_saved[detail.id] = detail_saved
		end

		if details_saved.has_value? false
			render :edit_multiple
			# if at least one assoc does not pass validation, do not submit
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

	def build_local_tarics
		@details.each do |im|
    		im.build_local_taric if im.local_taric.nil?
    	end
	end

end