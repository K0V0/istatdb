class Intertable < ActiveRecord::Base

	belongs_to :good, inverse_of: :intertable
	belongs_to :manufacturer, inverse_of: :intertable
	belongs_to :impexpcompany, inverse_of: :intertable

end
