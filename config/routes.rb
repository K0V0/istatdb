Rails.application.routes.draw do


  ### nastavenie domovskej stranky

  root 'goods#index'



  ### hlavna stranka - databaza tovarov

  # index
  get "goodsdb",
    to: "goods#index",
    as: "goods"

  # pridat novy tovar
  get "goodsdb/new",
    to: "goods#new",
    as: "new_good"

  # zobrazit detaily o polozke
  get "goodsdb/:id/details",
    to: "goods#show",
    as: "good"

  post "goodsdb",
    to: "goods#create"



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
    to: "impexpcompanies#create"



  ### databaza vyrobcov/odoberatelov tovarov

  # index
  get "manufacturersdb",
    to: "manufacturers#index",
    as: "manufacturers" 

  # novy vyrobca/odoberatel
  get "manufacturersdb/new",
    to: "manufacturers#new",
    as: "new_manufacturer" 

  get "manufacturersdb/:id/details",
    to: "manufacturers#show",
    as: "manufacturer" 


  ### lokalna taric databaza

  #index
  get "localtaricdb",
    to: "local_taric#index",
    as: "local_tarics" 

  #new
  get "localtaricdb/new",
    to: "local_taric#new",
    as: "new_local_taric" 

  #create - ulozi novy zaznam
  post "localtaricdb",
    to: "local_taric#create"



  ### hidden section for testing purposes

  get "test_scripts",
    to: "test_scripts#index",
    as: "test_scripts"

  get "add_fake_data",
    to: "test_scripts#add_fake_data",
    as: "test_add_fake_data"




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
