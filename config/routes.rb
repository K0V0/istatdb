Rails.application.routes.draw do

  devise_for :users
  ### nastavenie domovskej stranky

  root to: 'goods#index'



  ### searchery

  post "local_tarics/new_select_search",
    to: "local_tarics#new_select_search"

  post "impexpcompanies/new_select_search",
    to: "impexpcompanies#new_select_search"

  post "manufacturers/new_select_search",
    to: "manufacturers#new_select_search"

  #post "impexpcompany_manufacturers/new_select_search",
  #  to: "impexpcompany_manufacturers#new_select_search"

  ### check existence ajax call

  post "good/check_existence",
    to: "goods#check_existence"



  ### hlavna stranka - databaza tovarov

  # index
  get "goodsdb",
    to: "goods#index",
    as: "goods"

  # pridat novy tovar
  get "goodsdb/new",
    to: "goods#new",
    as: "new_good"

  # ransack search
  get "goodsdb/search",
    to: "goods#search",
    as: "search_goods"

  # administration - enter index page into administration mode
  get "goodsdb/administrative",
    to: "goods#administrative"

  # administration - return from
  get "goodsdb/end_administrative",
    to: "goods#end_administrative"

  # zobrazit detaily o polozke
  get "goodsdb/:id",
    to: "goods#show",
    as: "good"

  # vytvorit novu
  post "goodsdb/new",
    to: "goods#create",
    as: "create_good"

  # sekcia upravy - nacitanie polozky
  get "goodsdb/:id/edit",
    to: "goods#edit",
    as: "edit_good"

  # sekcia upravy - uprava
  patch "goodsdb/:id/edit",
    to: "goods#update",
    as: "update_good"

  # odstranit
  delete "goodsdb/:id/delete",
    to: "goods#delete",
    as: "delete_good"

  ## pamet kalkulacky

  # vlozit hodnotu
  post "goodsdb/add_to_uoms_calculator",
    to: "goods#add_to_calculator_mem"

  # vymaze vsetky
  post "goodsdb/clear_uoms_calculator",
    to: "goods#clear_calculator_mem"

  # vymazat jednu
  post "goodsdb/delete_from_uoms_calculator/:id",
    to: "goods#remove_from_calculator_mem",
    as: "calculator_remove"

  # upravit hodnotu
  post "goodsdb/edit_in_uoms_calculator/:id",
    to: "goods#edit_rec_in_calculator_mem",
    as: "calculator_edit"



  ### databaza vyrobcov/odoberatelov tovarov

  # index
  get "manufacturersdb",
    to: "manufacturers#index",
    as: "manufacturers"

  get "manufacturersdb/search",
    to: "manufacturers#search",
    as: "search_manufacturers"

  # administration - enter index page into administration mode
  get "manufacturersdb/administrative",
    to: "manufacturers#administrative"

  # administration - return from
  get "manufacturersdb/end_administrative",
    to: "manufacturers#end_administrative"

  # novy vyrobca/odoberatel
  get "manufacturersdb/new",
    to: "manufacturers#new",
    as: "new_manufacturer"

  # show details
  get "manufacturersdb/:id",
    to: "manufacturers#show",
    as: "manufacturer"

  #edit
  get "manufacturersdb/:id/edit",
    to: "manufacturers#edit",
    as: "edit_manufacturer"

  post "manufacturersdb",
    to: "manufacturers#create",
    as: "create_manufacturer"

  patch "manufacturersdb/:id",
    to: "manufacturers#update",
    as: "update_manufacturer"

  delete "manufacturersdb/:id/delete",
    to: "manufacturers#delete",
    as: "delete_manufacturer"

  #edit associated details on impexpcompany_manufacturers table
  get "manufacturersdb/:id/edit_details",
    to: "impexpcompany_manufacturers#edit_multiple",
    as: "edit_details_manufacturer"

  patch "manufacturersdb/:id/edit_details",
    to: "impexpcompany_manufacturers#update_multiple",
    as: "update_details_manufacturer"



  ### lokalna taric databaza

  #index
  get "localtaricdb",
    to: "local_tarics#index",
    as: "local_tarics"

  #search
  get "localtaricdb",
    to: "local_tarics#search",
    as: "search_local_tarics"

  # administration - enter index page into administration mode
  get "localtaricdb/administrative",
    to: "local_tarics#administrative"

  # administration - return from
  get "localtaricdb/end_administrative",
    to: "local_tarics#end_administrative"

  #new
  get "localtaricdb/new",
    to: "local_tarics#new",
    as: "new_local_taric"

  #show
  get "localtaricdb/:id",
    to: "local_tarics#show",
    as: "local_taric"

  #edit
  get "localtaricdb/:id/edit",
    to: "local_tarics#edit",
    as: "edit_local_taric"

  #create
  post "localtaricdb",
    to: "local_tarics#create",
    as: "create_local_taric"

  #update
  patch "localtaricdb/:id",
   to: "local_tarics#update",
    as: "update_local_taric"

  #delete
  delete "localtaricdb/:id",
    to: "local_tarics#delete",
    as: "delete_local_taric"



  ### globalny taric - taric SK

  #index
  get "taricsk",
    to: "global_tarics#index",
    as: "sk_tarics"



  ### ostatne

  #index
  get "others",
    to: "others#index",
    as: "others"



  ### Nastavenia

  #index
  get "settings",
    to: "settings#index",
    as: "settings"

  #ulozenie nastaveni
  post "settings",
    to: "settings#update_settings"


  ### Nastavenia - spravodajske jednotky

  #index
  get "settings/clientsdb",
    to: "impexpcompanies#index",
    as: "impexpcompanies"

  #new
  get "settings/clientsdb/new",
    to: "impexpcompanies#new",
    as: "new_impexpcompany"

  # administration
  get "settings/clientsdb/administrative",
    to: "impexpcompanies#administrative"

  # end administration
  get "settings/clientsdb/end_administrative",
    to: "impexpcompanies#end_administrative"

  #show
  get "settings/clientsdb/:id",
    to: "impexpcompanies#show",
    as: "impexpcompany"

  #create
  post "settings/clientsdb",
    to: "impexpcompanies#create",
    as: "create_impexpcompany"

  #edit
  get "settings/clientsdb/:id/edit",
    to: "impexpcompanies#edit",
    as: "edit_impexpcompany"

  #update
  patch "settings/clientsdb/:id",
    to: "impexpcompanies#update",
    as: "update_impexpcompany"

  #delete
  delete "settings/clientsdb/:id",
    to: "impexpcompanies#delete",
    as: "delete_impexpcompany"

  ### Nastavenia - uoms

  # index
  get "settings/uom_types",
    to: "uom_types#index",
    as: "uom_types"

  # new
  get "settings/uom_types/new",
    to: "uom_types#new",
    as: "new_uom_type"

  # administration
  get "settings/uom_types/administrative",
    to: "uom_types#administrative"

  # end administration
  get "settings/uom_types/end_administrative",
    to: "uom_types#end_administrative"

  # show
  get "settings/uom_types/:id",
    to: "uom_types#show",
    as: "uom_type"

  # create
  post "settings/uom_types",
    to: "uom_types#create",
    as: "create_uom_type"

  # edit
  get "settings/uom_types/:id/edit",
    to: "uom_types#edit",
    as: "edit_uom_type"

  # update
  patch "settings/uom_types/:id",
    to: "uom_types#update",
    as: "update_uom_type"

  # delete
  delete "settings/uom_types/:id",
    to: "uom_types#delete",
    as: "delete_uom_type"


  ### Nastavenia - incoterms

  # index
  get "settings/incoterms",
    to: "incoterms#index",
    as: "incoterms"

  # new
  get "settings/incoterms/new",
    to: "incoterms#new",
    as: "new_incoterm"

  # administration
  get "settings/incoterms/administrative",
    to: "incoterms#administrative"

  # end administration
  get "settings/incoterms/end_administrative",
    to: "incoterms#end_administrative"

  # show
  get "settings/incoterms/:id",
    to: "incoterms#show",
    as: "incoterm"

  # create
  post "settings/incoterms",
    to: "incoterms#create",
    as: "create_incoterm"

  # edit
  get "settings/incoterms/:id/edit",
    to: "incoterms#edit",
    as: "edit_incoterm"

  # update
  patch "settings/incoterms/:id",
    to: "incoterms#update",
    as: "update_incoterm"

  # delete
  delete "settings/incoterms/:id",
    to: "incoterms#delete",
    as: "delete_incoterm"


  ### Nastavenia - druhy obchodu

  # index
  get "settings/trade_types",
    to: "trade_types#index",
    as: "trade_types"

  # new
  get "settings/trade_types/new",
    to: "trade_types#new",
    as: "new_trade_type"

  # administration
  get "settings/trade_types/administrative",
    to: "trade_types#administrative"

  # end administration
  get "settings/trade_types/end_administrative",
    to: "trade_types#end_administrative"

  # show
  get "settings/trade_types/:id",
    to: "trade_types#show",
    as: "trade_type"

  # create
  post "settings/trade_types",
    to: "trade_types#create",
    as: "create_trade_type"

  # edit
  get "settings/trade_types/:id/edit",
    to: "trade_types#edit",
    as: "edit_trade_type"

  # update
  patch "settings/trade_types/:id",
    to: "trade_types#update",
    as: "update_trade_type"

  # delete
  delete "settings/trade_types/:id",
    to: "trade_types#delete",
    as: "delete_trade_type"


  ### Nastavenia - pouzivatelia

  # index
  get "settings/users",
    to: "user_settings#index",
    as: "user_settings"

end
