module SettingsHelper

	def get_options_from_options(valshash)
		output = ""
		valshash.each do |k, v|
			output += "<option 
				value=\"#{k.to_s}\"
				>
				#{v}
				</option>"
		end
		output.html_safe
	end

end