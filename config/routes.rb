Rails.application.routes.draw do


  ### nastavenie domovskej stranky

  root to: 'goods#index'



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

  # zobrazit detaily o polozke
  get "goodsdb/:id/details",
    to: "goods#show",
    as: "good"

  # vytvorit novu
  post "goodsdb",
    to: "goods#create",
    as: "create_good"

  # administration - enter index page into administration mode
  get "goodsdb/edit",
    to: "goods#administration"

  get "goodsdb/leave_administrative",
    to: "goods#leave_administration"

  get "goodsdb/:id/edit",
    to: "goods#edit",
    as: "edit_good"

  patch "goodsdb/:id/edit",
    to: "goods#update",
    as: "update_good"

  post "goodsdb/new/edit_client_search",
    to: "impexpcompanies#edit_good_client_search"

  delete "goodsdb/:id/delete",
    to: "goods#delete",
    as: "delete_good"

  get "goodsdb/export",
    to: "goods#csv_export"



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



  ### databaza vyrobcov/odoberatelov tovarov

  # index
  get "manufacturersdb",
    to: "manufacturers#index",
    as: "manufacturers" 

  # novy vyrobca/odoberatel
  get "manufacturersdb/new",
    to: "manufacturers#new",
    as: "new_manufacturer" 

  # show details
  get "manufacturersdb/:id/details",
    to: "manufacturers#show",
    as: "manufacturer"

  # edit
  get "manufacturersdb/:id/edit",
    to: "manufacturers#edit",
    as: "edit_manufacturer"

  patch "manufacturersdb/:id/edit",
    to: "manufacturers#update",
    as: "update_manufacturer"

  patch "manufacturersdb/:id/edit_details",
    to: "manufacturers#update_details",
    as: "update_impexpcompany_manufacturer"

  delete "manufacturersdb/:id/delete",
    to: "manufacturers#delete",
    as: "delete_manufacturer"  

  # create action
  post "manufacturersdb",
    to: "manufacturers#create",
    as: "create_manufacturer"
  
  # edit action
  get "manufacturersdb/edit",
    to: "manufacturers#administration"

  get "manufacturersdb/leave_administrative",
    to: "manufactuers#leave_administration"

  #ransack search action
  get "manufacturersdb/search",
    to: "manufacturers#search",
    as: "search_manufacturers" 

  get "manufacturersdb/export",
    to: "manufacturers#csv_export"



  ### lokalna taric databaza

  #index
  get "localtaricdb",
    to: "local_taric#index",
    as: "local_tarics"

  #new
  get "localtaricdb/new",
    to: "local_taric#new",
    as: "new_local_taric" 

  #show
  get "localtaricdb/:id/details",
    to: "local_taric#show",
    as: "local_taric"

  #edit
  get "localtaricdb/:id/edit",
    to: "local_taric#edit",
    as: "edit_local_taric"

  #update
  patch "localtaricdb/:id/update",
    to: "local_taric#update",
    as: "update_local_taric"

  #create
  post "localtaricdb",
    to: "local_taric#create",
    as: "create_local_taric"

  #administration
  get "localtaricdb/edit",
    to: "local_taric#administration"

  get "localtaricdb/leave_administrative",
    to: "local_taric#leave_administration"

  #delete
  delete "localtaricdb/:id/delete",
    to: "local_taric#delete",
    as: "delete_local_taric"

  #index
  get "localtaricdb/search",
    to: "local_taric#search",
    as: "search_local_taric"
  
  get "localtaricdb/export",
    to: "local_taric#csv_export"



  ### Nastavenia

  #index
  get "settings",
    to: "settings#index",
    as: "settings" 



  ### API calls

  # new good creation form - for searching kncodes in LocalTaric
  # thats why in another controller
  post "api/knnumber_search",
    to: "api#local_taric_search"

  # new good creation form - for searching client's company in Impexpcompany
  post "api/client_search",
    to: "api#client_search"

  # new good creation form - for searching manufacturer's company in Manufcturer
  post "api/manufacturer_search",
    to: "api#manufacturer_search"

  post "api/good_search_ident_exists",
    to: "api#good_search_ident_exists"

  post "api/manufacturer_search_name_exists",
    to: "api#manufacturer_search_name_exists"

  post "api/add_to_uoms_calculator",
    to: "api#add_to_calculator_mem"



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
