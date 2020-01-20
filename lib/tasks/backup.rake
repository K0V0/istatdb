require 'net/ftp'
require 'open-uri'

namespace :backup do

  desc "database"
  task database: :environment do
    Rake::Task['db:data:dump'].reenable # in case you're going to invoke the same task second time.
    Rake::Task['db:data:dump'].invoke
    timestring = Time.now.strftime("%Y-%h-%d_%H.%M")
    FileUtils.cp 'db/data.yml', "backup/#{timestring}-data.yml"
    FileUtils.cp 'db/data.yml', "public/backups/#{timestring}-data.yml"
    if GlobalSettings.backup_enabled == "1"
    #if true
        #logger "ideeeeeeee"
        Net::FTP.open(
            GlobalSettings.backup_adress,
            GlobalSettings.backup_user,
            GlobalSettings.backup_pass) do |ftp|
                rgx = Regexp.new("#{GlobalSettings.backup_root.sub('/', '')}$")
                ftp.mkdir(GlobalSettings.backup_root) if !ftp.list("/").any?{|dir| dir.match(rgx)}
                ftp.passive = true
                ftp.putbinaryfile("public/backups/#{timestring}-data.yml")
                ftp.rename("/#{timestring}-data.yml", "#{GlobalSettings.backup_root}/#{timestring}-data.yml")
        end
    end
  end

  desc "files"
  task files: :environment do
  	folders = ['good_image', 'good_issue_file']
    uploads_folder = Rails.root.to_s + "/public/uploads"
    backup_folder = Rails.root.to_s + "/public/backups"

    folders.each do |folder|
    	puts folder
    	zip_file = "#{backup_folder}/#{folder}.zip"
    	source_folder = "#{uploads_folder}/#{folder}"
    	%x{  zip -r  #{zip_file}  #{source_folder} }
    end

    folders.each do |folder|
    	if GlobalSettings.backup_enabled == "1"
    	#if true
    		zip_file = "#{backup_folder}/#{folder}.zip"
	        Net::FTP.open(
	            GlobalSettings.backup_adress,
	            GlobalSettings.backup_user,
	            GlobalSettings.backup_pass) do |ftp|
	                rgx = Regexp.new("#{GlobalSettings.backup_root.sub('/', '')}$")
	                ftp.mkdir(GlobalSettings.backup_root) if !ftp.list("/").any?{|dir| dir.match(rgx)}
	                ftp.passive = true
	                ftp.putbinaryfile("public/backups/#{folder}.zip")
	        end
	    end
    end

  end

end