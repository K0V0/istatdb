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

			add_new_referent = pars[:referent_attributes][:allow_search_as_new] == "1" ? true : false
			if add_new_referent
				# if kncode written to input fileds and allowed to add
				detail.referent = Referent.find_or_create_by(
					first_name: pars[:referent_attributes][:first_name],
					last_name: pars[:referent_attributes][:last_name],
					email: pars[:referent_attributes][:email],
					phone: pars[:referent_attributes][:phone],
					impexpcompany_id: pars[:referent_attributes][:impexpcompany_id]
				)
			else
				if pars.has_key? :referent_id
					# if something selected
					detail.referent = Referent.find(pars[:referent_id])
				end
				if pars[:detach_referent] == "true"
					detail.referent = nil
				end
			end

			# assign other attributes
			detail.assign_attributes(
				permitted_pars(pars).except!(
					:local_taric_id, :local_taric, :local_taric_attributes,
					:referent_id, :referent, :referent_attributes
				)
			)
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

			referents_original = @referents.ids
			referent_selected_ids = []
			@details.each do |detail|
				if !detail.referent.nil?
					referent_selected_ids.push(detail.referent.id)
				end
			end
			@referents = Referent
							.where(id: referents_original + referent_selected_ids)
							.order(first_name: :asc)
		end
		@local_taric = LocalTaric.new
		@referent = Referent.new
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
			:detach_referent,
			local_taric: [:kncode, :description, :id, :allow_search_as_new],
			referent: [:first_name, :last_name, :email, :phone, :allow_search_as_new, :id, :impexpcompany_id]
		)
	end

end
