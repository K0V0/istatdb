class Setting < ActiveRecord::Base

	belongs_to :user, inverse_of: :settings

	scope :l, -> { 
		to_return = {}
		user_settings = OpenStruct.new(self.all.map { |x| [x.k, x.v] } .to_h)
		self.defaults.each do |k, v|
			if user_settings.try(k).blank?
				to_return[k] = v
			else
				to_return[k] = user_settings[k]
			end
		end
		return OpenStruct.new(to_return)
	}

	scope :u, -> (pars) {
		pars.each do |k, v|
			setting = self.where(k: k)
			if setting.length == 0
				setting.create({k: k, v: v})
			else
				setting.first.update({v: v})
			end
		end
	}

	scope :d, -> {
		return OpenStruct.new(self.defaults)
	}

	def self.defaults
		{
			gui_per_page: 		"10",
			gui_show_footer: 	"1",
			gui_enable_3d: 		"1",
			gui_pin_searchbar: 	"1"
		}
	end

end
