class ImpexpcompanyManufacturersController < ApplicationController

	def dummy_create

	end

	def edit_multiple
		@details = ImpexpcompanyManufacturer.where(manufacturer_id: params[:id])
		#build_local_tarics
	end

	def update_multiple
		## TODO: handle errors - validation of kncode if entered new
		details_saved = {}
		@details = ImpexpcompanyManufacturer.where(manufacturer_id: params[:id])

		@details.each do |detail|
			logger detail.id, "detail id"
			pars = params[:impexpcompany_manufacturers]["#{detail.id}"]
			add_new_localtaric = pars[:local_taric_attributes][:allow_search_as_new] == "1" ? true :false

			if add_new_localtaric
				local_taric = LocalTaric.find_or_create_by(
					kncode: pars[:local_taric_attributes][:kncode],
					description: pars[:local_taric_attributes][:description]
				)
				logger local_taric.errors.keys
			else

			end
			#detail.update_attributes(permitted_pars(pars))
			details_saved[detail.id] = false
		end
		# :id -> manufacturer_id - foreign key
		# fisrt - extended options should always be for one manufacturer
		#details_saved = {}
		# holds for every associated options set if passed or not
=begin
		@details.each do |detail|
			dateil_saved = false
			local_taric_selected = !((pars = params[:impexpcompany_manufacturers]["#{detail.id}"])[:local_taric_id].blank?)
			adding_new_not_allowed = (pars[:local_taric][:allow_search_as_new] != "1")

			logger(local_taric_selected)
			logger(adding_new_not_allowed)
			errors = []
			if local_taric_selected&&adding_new_not_allowed
				# manual input of hscode ignored
				logger('manual input not alowed')
				detail_saved = detail.update(permitted_pars(pars.except(:local_taric)))
			else
				# select from list ignored in this case
				logger('else select from list not allowed')
				#errors = false
				if !adding_new_not_allowed
					local_taric = LocalTaric.find_or_create_by(
						kncode: pars[:local_taric][:kncode],
						description: pars[:local_taric][:description]
					)
					errors = local_taric.errors
					logger(local_taric.errors.keys, "lt errors")
					logger(local_taric.errors.any?, "lt errors any")
					logger(detail.errors.any?, "detail errors any")
					#logger(detail, "detail")
					if !errors.any?
						detail.local_taric = local_taric
					else
						#detail.errors.add(errors)
						#logger(detail.errors.keys)
						#logger(errors.keys)
						#detail.local_taric = local_taric
						#errors.keys.each do |key|
							#detail.local_taric.errors.add(:kncode, :blank)
							#detail.errors.add(:local_taric_attributes, :not_selected_or_created)
						#end
					end
					# if hscode found or created, assign in to item
					#detail.update_attributes(
					#	permitted_pars(pars.except(:local_taric_id, :local_taric))
					#)
					detail.update_attributes(
						permitted_pars(pars.except(:local_taric_id, :local_taric))
					)
					# assign other items
				end
				#logger(detail.errors, "details errors")
				#logger(errors, "errors")
				#logger "any errors"
				detail_saved = (detail.save == true && errors.any? == false)
			end

			#logger(detail.errors, "details errors")
			#logger(errors, "errors")

			#detail.errors.merge! errors
			#logger(detail_saved, "saved")
			details_saved[detail.id] = detail_saved
			#logger(@detail[0])
		end
=end
		#@details.second.errors.add(:local_taric, "je kokot")
		#logger(@details.second.local_taric.errors.keys, "det log kley err lotar")
		#logger(@details.second.local_taric.errors[:kncode], "det log kley err lotar")

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
    		#@local_taricsim.local_taric
    	end
	end

end
