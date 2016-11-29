class UomType < ActiveRecord::Base
	
	#belongs_to :uom

	validates :uom_type, presence: true

end
