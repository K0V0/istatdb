class LocalTaric < ActiveRecord::Base

	has_many :goods, inverse_of: :local_taric

	validates :kncode, presence: true
	validates :kncode, numericality: { only_integer: true }
	validate :kncode_length_valid

	validates :description, presence: true
	validates_uniqueness_of :kncode, scope: :description#, on: :create

	def kncode_length_valid
		# shouldnt validation stop on presence validation ?
		if !kncode.nil?
			if !(kncode.length == 8 || kncode.length == 10)
				errors.add(:kncode, :exactly)
			end
		end
	end

=begin
	def save *args
	    if new_record? 
	      super         
	    else
	      r = LocalTaric.where(kncode: kncode, description: description)
	      if r.blank?
	      	r = LocalTaric.new
	      	r.assign_attributes(kncode: kncode, description: description)
	      	r.save
	      	#return true
	      	return r
	      else
	      	return true
	      end
	    end
	end
=end

end
