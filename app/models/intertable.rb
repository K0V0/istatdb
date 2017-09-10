class Intertable < ActiveRecord::Base

	belongs_to :good, inverse_of: :intertables
	belongs_to :manufacturer, inverse_of: :intertables
	belongs_to :impexpcompany, inverse_of: :intertables

	def save *arg
		# hack to prevent unexcepted behaviour when on edit records with empty
		# keys are saved into table
		if !(self.impexpcompany_id.blank?&&self.manufacturer_id.blank?)
			super *arg
		end
		return true
	end

end
