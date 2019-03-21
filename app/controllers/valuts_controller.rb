class ValutsController < ApplicationController

	skip_filter *_process_action_callbacks.map(&:filter)
    before_action :inits


	

    private

    def _parent_controller
        :others
    end
    
end
