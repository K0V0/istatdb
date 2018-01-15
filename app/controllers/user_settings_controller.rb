class UserSettingsController < ApplicationController

	before_action do 
		is_subsection_of(parent_controller: :settings)
	end

	
end
