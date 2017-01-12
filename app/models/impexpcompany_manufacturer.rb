class ImpexpcompanyManufacturer < ActiveRecord::Base

belongs_to :impexpcompany, inverse_of: :impexpcompany_manufacturers
belongs_to :manufacturer, inverse_of: :impexpcompany_manufacturers
belongs_to :local_taric 

validates :impexpcompany_id, uniqueness: { scope: :manufacturer_id }

attr_accessor :local_taric_kncode
attr_accessor :local_taric_description

end
