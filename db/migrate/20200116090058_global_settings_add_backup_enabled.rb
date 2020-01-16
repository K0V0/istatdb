class GlobalSettingsAddBackupEnabled < ActiveRecord::Migration
  def change
  	GlobalSettings.create({ var: "backup_enabled", value: "0" })
  end
end
