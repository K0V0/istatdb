class CalculatorsController < ApplicationController

    before_action do
        is_subsection_of(parent_controller: :others)
    end

end
