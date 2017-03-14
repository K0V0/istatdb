class UomType < ActiveRecord::Base
	
	has_many :uoms, inverse_of: :uom_type

	validates :uom_type, presence: true

	def description
		I18n.t("uom_types.#{super.to_s}", default: "#{super.to_s}")
	end

end
