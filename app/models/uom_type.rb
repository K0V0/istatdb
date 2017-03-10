class UomType < ActiveRecord::Base
	
	#belongs_to :uom

	has_many :uoms, inverse_of: :uom_type

	validates :uom_type, presence: true

end
