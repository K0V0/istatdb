namespace :changelog do

  desc "TODO"
  task load: :environment do
    Change.connection
    Change.skip_callback(:save, :after, :write_changelog_file)
    Change.delete_all
    list = JSON.parse(File.read("db/changelog/changelog.json"))
    list.each do |item|
        #Change.first_or_create(item)
        Change.create(item)
        Rails.logger.info("---------")
        Rails.logger.info(item)
    end
    Change.set_callback(:save, :after, :write_changelog_file)
  end

end
