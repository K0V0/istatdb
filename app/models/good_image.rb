class GoodImage < ActiveRecord::Base

	belongs_to :good, inverse_of: :good_images

	mount_uploader :image, GoodImageUploader

end
