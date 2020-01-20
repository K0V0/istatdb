namespace :exchange_rates do

  desc "load"
  task load: :environment do
    tempfile = Down.download(GlobalSettings.valuts_adress_history, destination: Rails.root.join('public', 'valuts'))
    File.rename(Dir['public/valuts/down-*.xml'].first, 'public/valuts/valuts-hist.xml') 
  end

end