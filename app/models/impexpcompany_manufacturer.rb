class ImpexpcompanyManufacturer < ActiveRecord::Base

belongs_to :impexpcompany, inverse_of: :impexpcompany_manufacturers
belongs_to :manufacturer, inverse_of: :impexpcompany_manufacturers
belongs_to :local_taric 

validates :impexpcompany_id, uniqueness: { scope: :manufacturer_id }

def self.with_local_taric
	self.joins(:local_taric).preload(:local_taric)
end

end
