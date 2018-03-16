class UomType < ActiveRecord::Base

	include Defaults

	translates :full_name, :description

	has_many :uoms, inverse_of: :uom_type

	validates :uom_type, presence: true

	scope :default_order, -> {
		order(uom_type: :asc)
	}

	def name_for_form_input
		prep = intrastat_code.blank? ? "---" : intrastat_code
		"#{self.full_name} [#{self.uom_type}] - {#{prep}}"
	end

end
