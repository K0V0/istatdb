class OthersController < ApplicationController

    skip_filter *_process_action_callbacks.map(&:filter)
    before_action :inits

end
