class ApiController < ApplicationController

	before_action :strip_ransack_from_params, only: [:local_taric_search]

	def local_taric_search
		searcher_for object: LocalTaric
		render('/layouts/add_edit_searchtable')
	end

	private

	def strip_ransack_from_params
		@stripped_params = []
		params[:q].each do |k, v|
			@stripped_params << k.to_s.sub(/_[a-z]+$/, "").to_sym
		end
	end

end