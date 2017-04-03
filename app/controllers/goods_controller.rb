class GoodsController < ApplicationController

	before_action(only: [:index, :search, :show, :administration]) {

		searcher_for(
			preload: :local_taric,
			paginate: true
		);
	}

	def index
		@impexpcompanies = Impexpcompany.all
		@manufacturers = Manufacturer.all
	end

	def search
		@impexpcompanies = Impexpcompany.all
		@manufacturers = Manufacturer.all
		super
	end

	def new
		@local_tarics = LocalTaric.all
		@impexpcompanies = Impexpcompany.all
		@manufacturers = Manufacturer.all

		@local_taric = @good.build_local_taric
		@impexpcompany = @good.impexpcompanies.build
		@manufacturer = @good.manufacturers.build
	end
		
	private 

	def permitted_params
		params.require(:good).permit(
			:ident, 
			:description,
			:local_taric_id,
			:impexpcompany,
			impexpcompany_ids: [],
			local_taric_attributes: [:kncode, :description]
		)
	end
end
