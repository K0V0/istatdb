class Intertable < ActiveRecord::Base

	#attr_accessible :good_id, :manufacturer_id, :impexpcompany_id

	belongs_to :good, inverse_of: :intertables
	belongs_to :manufacturer, inverse_of: :intertables
	belongs_to :impexpcompany, inverse_of: :intertables

end
