class ImpexpController < ApplicationController

	def index
		@companies = Impexpcompany.all
	end

end
