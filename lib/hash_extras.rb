
module HashExtras

	def self.included(base)
	    Hash.instance_eval do
	      include HashHelperMethods
	    end
	end

	module HashHelperMethods

		def deep_has_key? *args
			return false if self.nil?
			return true if (deep_do_generation_fu(args, false) != false)
			return false
 		end

 		def access_deep *args
 			return nil if self.nil?
			return deep_do_generation_fu args, nil
 		end

 		def deep_add! val, *keys
 			deep_merge_fu keys.reverse, self, val
 		end

 		def largest_hash_pair
		  	self.max_by{|k,v| v}
		end

 		private

 		def deep_merge_fu keys, obj, val 
 			lk = keys.last
 			v = (keys.length > 1) ? {} : val
 			obj.merge!(lk => v)
 			keys.pop
 			deep_merge_fu(keys, obj[lk], val) if !keys.blank?
 			obj
 		end

 		def deep_do_generation_fu args, failval
 			tmp = self
 			args.each do |arg|
 				if !tmp.nil?
					if tmp.has_key? arg
						tmp2 = tmp[arg]
						tmp = tmp2
					else
						return failval
					end
				else
					return failval
				end
			end
			return tmp
 		end

	end

end
