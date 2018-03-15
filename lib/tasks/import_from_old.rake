namespace :import_from_old do

  desc "OK"
  task :load, [:model] => [:environment] do |t, args|
    list = JSON.parse(File.read("db/import_from_oldapp/#{args[:model].to_s}.json"))
    list.each do |item|
        rec = args[:model].to_s.classify.constantize.new(item.to_h)
        rec.save(validate: false)
    end
  end

  desc "OK, oprava chybajucich colnych cisel"
  ### nutne zakomentovat v modeli Good.rb "nested_attrs_getter_for"
  task load_good_local_tarics: :environment do
      list = JSON.parse(File.read("db/import_from_oldapp/good.json"))
      list.each do |item|
          h = item.to_h
          g = Good.find(h['id'])
          g.local_taric_id = h['local_taric_id']
          g.save(validate: false)
      end
  end

  task all: :environment do
      tasks = [
            :local_taric,
            :manufacturer,
            :impexpcompany,
            :good,
            :intertable,
            :impexpcompany_manufacturer,
            :uom
        ]
        tasks.each do |tsk|
            Rake::Task['import_from_old:load'].reenable
            Rake::Task['import_from_old:load'].invoke(tsk.to_s)
        end
  end

  ## local_taric
  ## manufacturer
  ## impexpcompany
  ## good
  ## intertable
  ## impexpcompany_manufacturer
  ## uom

end
