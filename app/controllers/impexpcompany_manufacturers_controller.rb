class ImpexpcompanyManufacturersController < ApplicationController

	def edit_multiple
		@details = ImpexpcompanyManufacturer.where(manufacturer_id: params[:id])
		_load_vars
		#@details = ImpexpcompanyManufacturer.where(manufacturer_id: params[:id])
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
				if pars[:detach_local_taric] == "true"
					detail.local_taric = nil
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
			redirect_to get_path_back
		end
	end

	private

	def _load_vars
		@incoterms = Incoterm.includes(:translations).all.default_order
		#@local_tarics = LocalTaric.includes(:translations).all.default_order.page(1).per(20)
		will_paginate :local_taric, :referent
		if action_name == "edit_multiple"
			local_tarics_original = @local_tarics.ids
			local_taric_selected_ids = []
			@details.each do |detail|
				if !detail.local_taric.nil?
					local_taric_selected_ids.push(detail.local_taric.id)
				end
			end
			@local_tarics = LocalTaric
								.includes(:translations)
								.where(id: local_tarics_original + local_taric_selected_ids)
								.order(kncode: :asc)
		end
		@local_taric = LocalTaric.new
		@trade_types = TradeType.includes(:translations).all.default_order
		#@people = Person.all
	end

	def permitted_pars pars
		# other than permitted_params inherited from application_controller
		pars.permit(
			:id,
			:local_taric_id,
			:incoterm_id,
			:trade_type_id,
			:invoices_correct,
			:referent_id,
			:detach_local_taric,
			:detach_person,
			local_taric: [:kncode, :description, :id, :allow_search_as_new],
			referent: [:first_name, :last_name, :email, :phone, :allow_search_as_new]
		)
	end

end
