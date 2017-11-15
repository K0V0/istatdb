class InitiatePerPageSetting < ActiveRecord::Migration
	def self.up
		Setting.create({  
			k: "per_page",
			v: "25"
		})
	end

	def self.down
		Setting.where(k: "per_page").delete_all
	end
end
