namespace :cleanup_images do

  desc "TODO"
  task clean: :environment do
  	ids = []
  	Good.joins(:good_images).each do |good|
  		i = good.good_images.ids
  		ids.push *i	
  	end
  	ids.uniq!
  	root_dir = "/public/uploads/good_image/image/"
  	#dirs = Dir.entries(root_dir).select {|entry| File.directory? File.join(root_dir, entry) and !(entry =='.' || entry == '..') }
  	#Rails.logger.info "-----------------------------"
  	#Rails.logger.info ids
  	#puts dirs
  	Dir.chdir(root_dir)
  	#dirs = Dir.glob("*/")
  	#puts dirs
  end

end