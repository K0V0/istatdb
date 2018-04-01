namespace :deletions do

  desc "TODO"
  task delete_all: :environment do
    Good.delete_all
    Impexpcompany.delete_all
    ImpexpcompanyManufacturer.delete_all
    LocalTaric.delete_all
    Manufacturer.delete_all
    UomType.delete_all
    Uom.delete_all
    Incoterm.delete_all
    Intertable.delete_all
    Change.delete_all
    Setting.delete_all
    TradeType.delete_all
    User.delete_all
  end

  desc "TODO"
  task delete_userdata: :environment do
    Good.delete_all
    Impexpcompany.delete_all
    ImpexpcompanyManufacturer.delete_all
    LocalTaric.delete_all
    Manufacturer.delete_all
    Uom.delete_all
    Intertable.delete_all
  end

end
