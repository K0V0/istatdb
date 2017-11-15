class Setting < ActiveRecord::Base

	scope :load, -> { 
		OpenStruct.new( self.all.map { |x|  [x.k, x.v] } .to_h )
	}

end
