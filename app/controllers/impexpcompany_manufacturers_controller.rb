class ImpexpcompanyManufacturersController < ApplicationController

	def edit_multiple
		_load_vars
		@details = ImpexpcompanyManufacturer.where(manufacturer_id: params[:id])
	end

	def update_multiple
		_load_vars
		details_saved = {}
		@details = ImpexpcompanyManufacturer.where(manufacturer_id: params[:id])

		@details.each do |detail|
			pars = params[:impexpcompany_manufacturers]["#{detail.id}"]
			add_new_localtaric = pars[:local_taric_attributes][:allow_search_as_new] == "1" ? true : false
			if add_new_localtaric
				# if kncode written to input fileds and allowed to add
				detail.local_taric = LocalTaric.find_or_create_by(
					kncode: pars[:local_taric_attributes][:kncode],
					description: pars[:local_taric_attributes][:description]
				)
			else
				if pars.has_key? :local_taric_id
					# if something selected
					detail.local_taric = LocalTaric.find(pars[:local_taric_id])
				end
			end
			# assign other attributes
			detail.assign_attributes(permitted_pars(pars).except!(:local_taric_id, :local_taric, :local_taric_attributes))
			details_saved[detail.id] = detail.save
		end

		if details_saved.has_value? false
			render :edit_multiple
			# if at least one assoc does not pass validation, do not submit
		else
			redirect_to manufacturers_path
		end
	end

	private

	def _load_vars
		@incoterms = Incoterm.includes(:translations).all.default_order
		@local_tarics = LocalTaric.includes(:translations).all.default_order
		@local_taric = LocalTaric.new
		@trade_types = TradeType.includes(:translations).all.default_order
	end

	def permitted_pars pars
		# other than permitted_params inherited from application_controller
		pars.permit(
			:id,
			:local_taric_id,
			:incoterm_id,
			:trade_type_id,
			:invoices_correct,
			local_taric: [:kncode, :description, :id, :allow_search_as_new]
		)
	end

end
