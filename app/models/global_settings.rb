# RailsSettings Model
class GlobalSettings < RailsSettings::Base
	self.table_name = "global_settings"
  source Rails.root.join("config/app.yml")
  namespace Rails.env
end
