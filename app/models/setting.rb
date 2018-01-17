class Setting < ActiveRecord::Base

	belongs_to :user, inverse_of: :settings

	scope :l, -> { 
		to_return = {}
		user_settings = OpenStruct.new(self.all.map { |x| [x.k, x.v] } .to_h)
		#Rails.logger.info user_settings
		self.defaults.each do |k, v|
			#Rails.logger.info "---------"
			#Rails.logger.info k
			#Rails.logger.info v
			#Rails.logger.info user_settings.try(k)
			if user_settings.try(k).blank?
				to_return[k] = v
				#Rails.logger.info "---------"
			else
				to_return[k] = user_settings[k]
				#Rails.logger.info "********"
			end
		end
		#Rails.logger.info to_return
		#@MEM.settings = OpenStruct.new(to_return)
		#return @MEM.settings
		return OpenStruct.new(to_return)
	}

	scope :u, -> (pars) {
		pars.each do |k, v|
			#Rails.logger.info k
			#Rails.logger.info v
			#if self.defaults[k.to_sym] != v
				#Rails.logger.info "********"
				#Rails.logger.info self.defaults
				#Rails.logger.info self.defaults[k.to_sym]
				#Rails.logger.info self.where(k: k).size
				setting = self.where(k: k)
				if setting.length == 0
					setting.create({k: k, v: v})
				else
					setting.first.update({v: v})
				end
				#Rails.logger.info self.defaults[k.to_sym]
			#end
		end
	}

	scope :d, -> {
		return OpenStruct.new(self.defaults)
	}

	def self.defaults
		{
			gui_per_page: 		"10",
			gui_show_footer: 	"1",
			gui_enable_3d: 		"1"
		}
	end

end
