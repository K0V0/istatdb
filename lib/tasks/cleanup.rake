
namespace :cleanup do

  desc "TODO"
  task images: :environment do
  	ids = []
    root_dir = "public/uploads/good_image/image/"

  	Good.joins(:good_images).each do |good|
  		i = good.good_images.ids
  		ids.push *i	
  	end
  	ids.uniq!

  	Dir.chdir(root_dir)
  	dirs = Dir.glob("*/")
    dirs.each do |dir|
      dir_id = dir.sub("/", "").to_i
      if !ids.include?(dir_id)
        FileUtils.rm_rf("#{Dir.pwd}/#{dir_id.to_s}")
      end
    end

  end

  desc "TODO"
  task files: :environment do
    ids = []
    root_dir = "public/uploads/good_issue_file/file/"

    Issue.joins(:good_issue_files).each do |file|
      i = file.good_issue_files.ids
      ids.push *i 
    end
    ids.uniq!

    Dir.chdir(root_dir)
    dirs = Dir.glob("*/")
    dirs.each do |dir|
      dir_id = dir.sub("/", "").to_i
      if !ids.include?(dir_id)
        puts dir_id
        FileUtils.rm_rf("#{Dir.pwd}/#{dir_id.to_s}")
      end
    end

  end

end