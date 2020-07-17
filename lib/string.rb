
class String

	def is_singular?
		self.pluralize != self && self.singularize == self
	end

	def to_kncode
		self.gsub(/.{2}/).with_index {|x, i| i > 0 ? "#{x} " : "#{x}" } .strip
	end

    def suffix_lowcase
        regex = /\.(jpg|jpeg|gif|png)$/i
        suffix_patched = self[regex, 1]
        self.sub(regex, ".#{suffix_patched.downcase}")
    end

    def suffix_lowcase(suffix)
        regex = /\.(jpg|jpeg|gif|png)$/i
        self.sub(regex, ".#{suffix.downcase}")
    end

    def true?
        self.to_s.downcase == "true"
    end

end