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



  ### hlavna stranka - databaza tovarov

  # index
  get "goodsdb",
    to: "goods#index",
    as: "goods"

  # pridat novy tovar
  get "goodsdb/new",
    to: "goods#new",
    as: "new_good"

  # vytvorit novy tovar
  post 'goodsdb',
    to: "goods#create"

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

  #patch "manufacturersdb/:id/edit",
   # to: "manufacturers#update",
   # as: "update_manufacturer"

  #patch "manufacturersdb/:id/edit_details",
   # to: "manufacturers#update_details",
   # as: "update_impexpcompany_manufacturer"

  delete "manufacturersdb/:id/delete",
    to: "manufacturers#delete",
    as: "delete_manufacturer"  

  # create action
  #post "manufacturersdb",
   # to: "manufacturers#create",
   # as: "create_manufacturer"
  
  # edit action
  #get "manufacturersdb/edit",
   # to: "manufacturers#administration"

  #get "manufacturersdb/leave_administrative",
   # to: "manufacturers#leave_administration"

  #ransack search action
  #get "manufacturersdb/search",
   # to: "manufacturers#search",
    #as: "search_manufacturers" 

  #get "manufacturersdb/export",
   # to: "manufacturers#csv_export"



### databaza klientov (objednavatelia sluzby intrastat) 
  ### dovozcovia a vyvozcovia

  # index
  get "clientsdb",
    to: "impexpcompanies#index",
    as: "impexpcompanies"

  # novy klient
  get "clientsdb/new",
    to: "impexpcompanies#new",
    as: "new_impexpcompany"

  #create
  post "clientsdb",
    to: "impexpcompanies#create",
    as: "create_impexpcompany"

  # administrative mode
  get "clientsdb/edit",
    to: "impexpcompanies#administration"

  get "clientsdb/leave_administrative",
    to: "impexpcompanies#leave_administration"

  # edit
  get "clientsdb/:id/edit",
    to: "impexpcompanies#edit",
    as: "edit_impexpcompany"

  patch "clientsdb/:id/update",
    to: "impexpcompanies#update",
    as: "update_impexpcompany"

  # delete
  delete "clientsdb/:id/delete",
    to: "impexpcompanies#delete",
    as: "delete_impexpcompany"

  get "clientsdb/export",
    to: "impexpcompanies#csv_export"



  ### lokalna taric databaza

  #index
  get "localtaricdb",
    to: "local_tarics#index",
    as: "local_tarics"

  #new
  get "localtaricdb/new",
    to: "local_tarics#new",
    as: "new_local_taric" 

  #show
  get "localtaricdb/:id/details",
    to: "local_tarics#show",
    as: "local_taric"

  #edit
  get "localtaricdb/:id/edit",
    to: "local_tarics#edit",
    as: "edit_local_taric"

  #update
  patch "localtaricdb/:id/update",
    to: "local_tarics#update",
    as: "update_local_taric"

  #create
  post "localtaricdb",
    to: "local_tarics#create",
    as: "create_local_taric"

  #administration
  get "localtaricdb/edit",
    to: "local_tarics#administration"

  get "localtaricdb/leave_administrative",
    to: "local_tarics#leave_administration"

  #delete
  delete "localtaricdb/:id/delete",
    to: "local_tarics#delete",
    as: "delete_local_taric"

  #index
  get "localtaricdb/search",
    to: "local_tarics#search",
    as: "search_local_taric"
  
  get "localtaricdb/export",
    to: "local_tarics#csv_export"



  ### Nastavenia

  #index
  get "settings",
    to: "settings#index",
    as: "settings" 



  ### API calls

  # new good creation form - for searching kncodes in LocalTaric
  # thats why in another controller
  #post "api/knnumber_search",
  #  to: "api#local_taric_search"

  # new good creation form - for searching client's company in Impexpcompany
 # post "api/client_search",
  #  to: "api#impexpcompany_search"

  # new good creation form - for searching manufacturer's company in Manufcturer
  #post "api/manufacturer_search",
  #  to: "api#manufacturer_search"

  #post "api/good_search_ident_exists",
  #  to: "api#good_search_ident_exists"

  #post "api/manufacturer_search_name_exists",
  #  to: "api#manufacturer_search_name_exists"

  
  ### settings section

  post "global_tarics/upload_xml",
    to: "global_tarics#upload_xml", 
    as: "upload_global_taric_xml"

  post "global_tarics/xml_from_url",
    to: "global_tarics#xml_from_url", 
    as: "global_taric_xml_from_url"

  get "uom_types",
    to: "uom_types#index", 
    as: "uom_types"

  get "uom_type/:id",
    to: "uom_types#show",
    as: "uom_type"

  post "uom_types",
    to: "uom_types#create" 

  patch  "uom_type/:id",
    to: "uom_types#update"

  get "uom_types/new_uom",
    to: "uom_types#new", 
    as: "new_uom_type"

  get "uom_types/edit_uom/:id",
    to: "uom_types#edit", 
    as: "edit_uom_type"

  delete "uom_types/delete_uom/:id",
    to: "uom_types#delete", 
    as: "delete_uom_type"


  ### hidden section for testing purposes

  get "test_scripts",
    to: "test_scripts#index",
    as: "test_scripts"

  get "test_scripts/add_fake_data",
    to: "test_scripts#add_fake_data",
    as: "test_add_fake_data"

  get "test_scripts/remove_everything",
    to: "test_scripts#remove_all",
    as: "test_remove_everything"

  get "test_scripts/impexpmanudb_fixture_fillup",
    to: "test_scripts#impexpcompany_manufacturer_fixture",
    as: "test_dbfixture1"

  get "test_scripts/uoms_fixture_fillup",
    to: "test_scripts#uoms_table_fixture",
    as: "test_dbfixture2"




  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
