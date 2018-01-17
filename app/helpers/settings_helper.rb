module SettingsHelper

	# keys in input hash - actual value for option
	# values - option texts 
	def get_options_from_options(valshash: {}, setting_name: "")

		output = ""
		valshash.each do |k, v|
			
			is_selected = setting(setting_name) == k.to_s

			output += "<option 
				value=\"#{k.to_s}\"
				#{('selected=\"selected\"' if is_selected)}
				>
				#{v}
				</option>"
		end

		output.html_safe
	end

end