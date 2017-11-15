class InitiateShowFooterSetting < ActiveRecord::Migration
  
	def self.up
		Setting.create({  
			k: "show_footer",
			v: "1"
		})
	end

	def self.down
		Setting.where(k: "show_footer").delete_all
	end

end
