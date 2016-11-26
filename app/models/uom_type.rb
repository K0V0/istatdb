class UomType < ActiveRecord::Base
	
	belongs_to :uom

	validates :uom, presence: true

end
