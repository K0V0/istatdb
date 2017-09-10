class Incoterm < ActiveRecord::Base

	has_many :impexpcompany_manufacturers, -> { distinct }, inverse_of: :incoterm

end
