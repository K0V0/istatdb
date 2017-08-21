class ImpexpcompanyManufacturer < ActiveRecord::Base

#include AssocValidator
#include Log

belongs_to :impexpcompany, inverse_of: :impexpcompany_manufacturers
belongs_to :manufacturer, inverse_of: :impexpcompany_manufacturers
#belongs_to :local_taric 

#validate :assoc_validation, on: [:update]
#validates :impexpcompany_id, uniqueness: { scope: :manufacturer_id }

#attr_writer :local_taric_kncode
#attr_writer :local_taric_description

#before_update :before_actions

#def local_taric_kncode
#	self.local_taric.try(:kncode)
#end

#def local_taric_description
#	self.local_taric.try(:description)
#end

#def impexpcompany_company_name
#	self.impexpcompany.company_name
#end

#def manufacturer_name
#	self.manufacturer.name
#end

#def incoterm_human
#	Incoterm.find(self.incoterm).try(:shortland)
#end

#def assoc_validation
#	assoc_validator(LocalTaric, :kncode, :description) if !@local_taric_kncode.blank?
#end

#def before_actions
#	(self.local_taric_id = @local_taric.id) if !@local_taric_kncode.blank?
#end

end
