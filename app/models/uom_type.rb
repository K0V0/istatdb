class UomType < ActiveRecord::Base

	extend OrderAsSpecified

	include Defaults

	translates :full_name, :description

	has_many :uoms, inverse_of: :uom_type

	validates :uom_type, presence: true

	scope :default_order, -> {
		customs = self.where(intrastat_code: nil).pluck(:id)
		order_as_specified(id: customs)
	}

	def name_for_form_input
		prep = intrastat_code.blank? ? "(#{description})" : "{#{intrastat_code}}"
		"#{self.full_name} [#{self.uom_type}] - #{prep}"
	end

end
