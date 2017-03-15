class UomsController < ApplicationController

	before_action(only: :create) { create_action permitted_pars }

    before_action(only: :update) { update_action permitted_pars }

	def index
		#redirect_to settings_path
	end

	def new
		@good = Good.find(params[:good_id])
		@uom = @good.uoms.new
		load_assocs
	end

	def edit
		@good = @uom.good
		load_assocs
		super
	end

	private

	def permitted_pars
		 params[:uom].permit(:uom_type_id, :uom, :uom_multiplier, :manufacturer_id, :impexpcompany_id)
	end

	def load_assocs
		@manufacturers = @good.manufacturers
		@impexpcompanies = @good.impexpcompanies
		@impexpcompany = @uom.impexpcompany
		@manufacturer = @uom.manufacturer
	end

end