namespace :changelog do

  desc "TODO"
  task load: :environment do
    Change.connection
    list = JSON.parse(File.read("db/changelog/changelog.json"))
    list.each do |item|
        Change.first_or_create(item)
    end
  end

end
