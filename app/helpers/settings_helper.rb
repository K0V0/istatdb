module SettingsHelper

	# keys in input hash - actual value for option
	# values - option texts 
	def get_options_from_options(valshash)

		output = ""
		valshash.each do |k, v|
			stringified_key = k.to_s
			is_selected = @MEM.settings.send(stringified_key) == stringified_key

			output += "<option 
				value=\"#{stringified_key}\"
				selected=\"#{is_selected}\"
				>
				#{v}
				</option>"
		end

		output.html_safe
	end

end