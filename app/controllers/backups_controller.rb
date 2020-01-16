require 'rake'
require 'net/ftp'
require 'open-uri'

Rake::Task.clear # necessary to avoid tasks being loaded several times in dev mode
Taric::Application.load_tasks # providing your application name is 'sample'

class BackupsController < ApplicationController

    skip_filter *_process_action_callbacks.map(&:filter)

    def do_backup
    	# mozno bude treba RAILS_ENV=#{Rails.env}
    	Rake::Task['db:data:dump'].reenable # in case you're going to invoke the same task second time.
    	Rake::Task['db:data:dump'].invoke
    	timestring = Time.now.strftime("%Y-%h-%d_%H.%M")
    	FileUtils.cp 'db/data.yml', "backup/#{timestring}-data.yml"
    	FileUtils.cp 'db/data.yml', "public/backups/#{timestring}-data.yml"
    	#flash.now[:backup_complete] = "Backup operations completed".html_safe
    	#redirect_to settings_path
    	send_file "public/backups/#{timestring}-data.yml"
        if GlobalSettings.backup_enabled == "1"
            #logger "ideeeeeeee"
            Net::FTP.open(
                GlobalSettings.backup_adress,
                GlobalSettings.backup_user,
                GlobalSettings.backup_pass) do |ftp|
                    ftp.passive = true
                    ftp.putbinaryfile("public/backups/#{timestring}-data.yml")
            end
        end
    end

    private



end

