class ImpexpcompanyManufacturersController < ApplicationController

	def edit_multiple
		@details = ImpexpcompanyManufacturer.where(manufacturer_id: params[:id])
	end

	def update_multiple
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

	#def build_local_tarics
	#	@details.each do |im|
    #		im.build_local_taric if im.local_taric.nil?
    #	end
	#end

end
