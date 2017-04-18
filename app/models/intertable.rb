class Intertable < ActiveRecord::Base

	belongs_to :good, inverse_of: :intertables
	belongs_to :manufacturer, inverse_of: :intertables
	belongs_to :impexpcompany, inverse_of: :intertables

end
