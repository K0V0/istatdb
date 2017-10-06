Rails.application.routes.draw do

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
  post "goodsdb",
    to: "goods#create",
    as: "create_good"
 
  # sekcia upravy - nacitanie polozky
  get "goodsdb/:id/edit",
    to: "goods#edit",
    as: "edit_good"

  # sekcia upravy - uprava
  patch "goodsdb/:id",
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
  get "manufacturer_details/:id/edit_multiple",
    to: "impexpcompany_manufacturers#edit_multiple",
    as: "edit_details_manufacturer"

  patch "manufacturer_details/:id/update_multiple",
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



  ### spravodajske jednotky

  #index
  get "clientsdb",
    to: "impexpcompanies#index",
    as: "impexpcompanies"

  #new
  get "clientsdb/new",
    to: "impexpcompanies#new",
    as: "new_impexpcompany"

  # administration
  get "clientsdb/administrative",
    to: "impexpcompanies#administrative"

  # end administration
  get "clientsdb/end_administrative",
    to: "impexpcompanies#end_administrative"

  #show
  get "clientsdb/:id",
    to: "impexpcompanies#show",
    as: "impexpcompany"

  #create
  post "clientsdb",
    to: "impexpcompanies#create",
    as: "create_impexpcompany"

  #edit
  get "clientsdb/:id/edit",
    to: "impexpcompanies#edit",
    as: "edit_impexpcompany"

  #update
  patch "clientsdb/:id",
    to: "impexpcompanies#update",
    as: "update_impexpcompany"

  #delete
  delete "clientsdb/:id",
    to: "impexpcompanies#delete",
    as: "delete_impexpcompany"



  ### Nastavenia

  #index
  get "settings",
    to: "settings#index",
    as: "settings" 

end
