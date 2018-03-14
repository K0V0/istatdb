namespace :import_from_old do

  desc "OK"
  task :load, [:model] => [:environment] do |t, args|
    list = JSON.parse(File.read("db/import_from_oldapp/#{args[:model].to_s}.json"))
    list.each do |item|
        rec = args[:model].to_s.classify.constantize.new(item.to_h)
        rec.save(validate: false)
    end
  end

  desc "NOT OK, chybau cuolne cisla"
    task load_good_local_tarics: :environment do
        list = JSON.parse(File.read("db/import_from_oldapp/good.json"))
        list.each do |item|
            #rec = args[:model].to_s.classify.constantize.new(item.to_h)
            #rec.save(validate: false)
            #puts "kkt", (item.to_h)['local_taric_id']
            r = item.to_h
            LocalTaric.find(r["id"]).update(local_taric_id: r["local_taric_id"])
        end
    end

  # local_taric
  # manufacturer
  # impexpcompany
  # good

end
