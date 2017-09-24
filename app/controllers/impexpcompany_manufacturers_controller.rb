class ImpexpcompanyManufacturersController < ApplicationController

	#skip_filter *_process_action_callbacks.map(&:filter)

	#def edit
	#	@manufacturer = Manufacturer.find(params[:manufacturer_id])
	#end

	def edit_details
		@details = ImpexpcompanyManufacturer.where(manufacturer_id: params[:id])
		@incoterms = Incoterm.all
		@local_tarics = LocalTaric.all
		@details.each do |im|
    		im.build_local_taric if im.local_taric.nil?
    	end
    	@details << ImpexpcompanyManufacturer.new
		#@local_taric = 
	end

	def update_details
		
	end

end