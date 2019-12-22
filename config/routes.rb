Rails.application.routes.draw do

  ### nastavenie domovskej stranky

  root to: 'searchers#index'



  ### searchery

  post "local_tarics/new_select_search",
    to: "local_tarics#new_select_search"

  post "local_tarics/new_select_load_items",
    to: "local_tarics#new_select_load_items"

  post "impexpcompanies/new_select_search",
    to: "impexpcompanies#new_select_search"

  post "manufacturers/new_select_search",
    to: "manufacturers#new_select_search"

  post "manufacturers/new_select_load_items",
    to: "manufacturers#new_select_load_items"

  post "task_types/new_select_search",
    to: "task_types#new_select_search"

  post "issues/new_select_load_items",
    to: "issues#new_select_load_items"

  post "issues/new_select_search",
    to: "issues#new_select_search"

  ## check existence ajax call

  post "good/check_existence",
    to: "goods#check_existence"

  post "local_taric/check_existence",
    to: "local_tarics#check_existence"

  post "manufacturer/check_existence",
    to: "manufacturers#check_existence"

  post "impexpcompany/check_existence",
    to: "impexpcompanies#check_existence"

  post "uom_type/check_existence",
    to: "uom_types#check_existence"

  post "incoterm/check_existence",
    to: "incoterms#check_existence"

  post "trade_type/check_existence",
    to: "trade_types#check_existence"



  ### hlavna stranka - databaza tovarov

  # index
  get "goodsdb",
    to: "goods#index",
    as: "goods"

  # znovu pridat podla posledneho zaradenia
  #get "goodsdb/repeat_association",
    #to: "goods#apply_last_select",
    #as: "repeated_assoc_good"


  # pridat novy tovar
  get "goodsdb/new",
    to: "goods#new",
    as: "new_good"

  # ransack search
  get "goodsdb/search",
    to: "goods#search",
    as: "search_goods"

  # ransack search
  get "goodsdb/export",
    to: "goods#export",
    as: "export_goods"

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

  # vytvorit novu
  post "goodsdb/export",
    to: "goods#do_export",
    as: "do_export_goods"

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



  ### vyhladavac

  # index
  get "searcher",
    to: "searchers#index",
    as: "searcher"

  # ransack search
  get "searcher/search",
    to: "searchers#search",
    as: "search"



  ### databaza vyrobcov/odoberatelov tovarov

  # index
  get "manufacturersdb",
    to: "manufacturers#index",
    as: "manufacturers"

  get "manufacturersdb/search",
    to: "manufacturers#search",
    as: "search_manufacturers"

    # ransack search
  get "manufacturersdb/export",
    to: "manufacturers#export",
    as: "export_manufacturers"

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

  post "manufacturersdb/new",
    to: "manufacturers#create",
    as: "create_manufacturer"

  post "manufacturersdb/export",
    to: "manufacturers#do_export",
    as: "do_export_manufacturers"

  patch "manufacturersdb/:id/edit",
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
  post "localtaricdb/new",
    to: "local_tarics#create",
    as: "create_local_taric"

  #update
  patch "localtaricdb/:id/edit",
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
    to: "issues#index"#,
    #as: "others"

  ## ostatne - kalkulacka

  #index
  get "others/calculator",
    to: "calculators#index",
    as: "calculators"

  ## ostatne - zoznam zmien

  #index
  get "others/changelog",
    to: "changes#index",
    as: "changes"

  get "others/changelog/new",
    to: "changes#new",
    as: "new_change"

  post "others/changelog/new",
    to: "changes#create",
    as: "create_change"

  get "others/changelog/:id/edit",
    to: "changes#edit",
    as: "edit_change"

  patch "others/changelog/:id/edit",
    to: "changes#update",
    as: "update_change"

  delete "others/changelog/:id",
    to: "changes#delete",
    as: "delete_change"

  get "others/changelog/administrative",
    to: "changes#administrative"

  get "others/changelog/end_administrative",
    to: "changes#end_administrative"

  ## ostatne - ulohy

  #index
  get "others/tasks",
    to: "tasks#index",
    as: "tasks"

  get "others/tasks/search",
    to: "tasks#search",
    as: "search_tasks"

  get "others/tasks/administrative",
    to: "tasks#administrative"

  get "others/tasks/end_administrative",
    to: "tasks#end_administrative"

  get "others/tasks/new",
    to: "tasks#new",
    as: "new_task"

  get "others/tasks/:id",
    to: "tasks#show",
    as: "task"

  post "others/tasks/new",
    to: "tasks#create",
    as: "create_task"

  get "others/tasks/:id/edit",
    to: "tasks#edit",
    as: "edit_task"

  patch "others/tasks/:id/edit",
    to: "tasks#update",
    as: "update_task"

  delete "others/tasks/:id",
    to: "tasks#delete",
    as: "delete_task"

  put "others/tasks/:id",
    to: "tasks#change_status"#,
    #as: "task"

  ## ostatne - valuty

  get "others/valuts",
    to: "valuts#index",
    as: "valuts"

  ## ostatne - pripady

  #index
  get "others/issues",
    to: "issues#index",
    as: "issues"

  get "others/issues/search",
    to: "issues#search",
    as: "search_issues"

  get "others/issues/administrative",
    to: "issues#administrative"

  get "others/issues/end_administrative",
    to: "issues#end_administrative"

  get "others/issues/new",
    to: "issues#new",
    as: "new_issue"

  get "others/issues/:id",
    to: "issues#show",
    as: "issue"

  post "others/issues/new",
    to: "issues#create",
    as: "create_issue"

  get "others/issues/:id/edit",
    to: "issues#edit",
    as: "edit_issue"

  patch "others/issues/:id/edit",
    to: "issues#update",
    as: "update_issue"

  delete "others/issues/:id",
    to: "issues#delete",
    as: "delete_issue"

  #put "others/issues/:id",
    #to: "issues#change_status"#,
    #as: "issue"




  ### Nastavenia

  #index
  get "settings",
    to: "settings#index",
    as: "settings"

  #ulozenie nastaveni
  post "settings",
    to: "settings#update_settings"

  #urob zalohu
  post "db_backup",
    to: "backups#do_backup",
    as: "db_backup"

  ## Nastavenia - spravodajske jednotky

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
  post "settings/clientsdb/new",
    to: "impexpcompanies#create",
    as: "create_impexpcompany"

  #edit
  get "settings/clientsdb/:id/edit",
    to: "impexpcompanies#edit",
    as: "edit_impexpcompany"

  #update
  patch "settings/clientsdb/:id/edit",
    to: "impexpcompanies#update",
    as: "update_impexpcompany"

  #delete
  delete "settings/clientsdb/:id",
    to: "impexpcompanies#delete",
    as: "delete_impexpcompany"

  ## Nastavenia - uoms

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
  post "settings/uom_types/new",
    to: "uom_types#create",
    as: "create_uom_type"

  # edit
  get "settings/uom_types/:id/edit",
    to: "uom_types#edit",
    as: "edit_uom_type"

  # update
  patch "settings/uom_types/:id/edit",
    to: "uom_types#update",
    as: "update_uom_type"

  # delete
  delete "settings/uom_types/:id",
    to: "uom_types#delete",
    as: "delete_uom_type"

  ## Nastavenia - incoterms

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
  post "settings/incoterms/new",
    to: "incoterms#create",
    as: "create_incoterm"

  # edit
  get "settings/incoterms/:id/edit",
    to: "incoterms#edit",
    as: "edit_incoterm"

  # update
  patch "settings/incoterms/:id/edit",
    to: "incoterms#update",
    as: "update_incoterm"

  # delete
  delete "settings/incoterms/:id",
    to: "incoterms#delete",
    as: "delete_incoterm"

  ## Nastavenia - druhy obchodu

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
  post "settings/trade_types/new",
    to: "trade_types#create",
    as: "create_trade_type"

  # edit
  get "settings/trade_types/:id/edit",
    to: "trade_types#edit",
    as: "edit_trade_type"

  # update
  patch "settings/trade_types/:id/edit",
    to: "trade_types#update",
    as: "update_trade_type"

  # delete
  delete "settings/trade_types/:id",
    to: "trade_types#delete",
    as: "delete_trade_type"


  ## nastavenia - referenti

  # index
  get "settings/people",
    to: "people#index",
    as: "people"

  # new
  get "settings/people/new",
    to: "people#new",
    as: "new_person_type"

  # administration
  get "settings/people/administrative",
    to: "people#administrative"

  # end administration
  get "settings/people/end_administrative",
    to: "people#end_administrative"

  # show
  get "settings/people/:id",
    to: "people#show",
    as: "person_type"

  # create
  post "settings/people/new",
    to: "people#create",
    as: "create_person_type"

  # edit
  get "settings/people/:id/edit",
    to: "people#edit",
    as: "edit_person_type"

  # update
  patch "settings/people/:id/edit",
    to: "people#update",
    as: "update_person_type"

  # delete
  delete "settings/people/:id",
    to: "people#delete",
    as: "delete_person_type"

  ## Nastavenia - pouzivatelia

  # index
  get "settings/users/user",
    to: "user_settings#index",
    as: "user_settings"

  devise_for :users, skip: :all

  devise_scope :user do

    get "/login",
      to: "devise/sessions#new",
      as: "new_user_session"

    # nvm
    post "/login",
      to: "devise/sessions#create",
      as: "user_session"

    # odhlasenie
    delete "/logout",
      to: "devise/sessions#destroy",
      as: "destroy_user_session"

    # nvm
    post "/password",
      to: "devise/passwords#create",
      as: "user_password"

    get "/password/new",
      to: "devise/passwords#new",
      as: "new_user_password"

    get "/password/edit",
      to: "devise/passwords#edit",
      as: "edit_user_password"

    patch "/password",
      to: "devise/passwords#update"

    put "/password",
      to: "devise/passwords#update"

    get "/settings/users/user/cancel",
      to: "devise/registrations#cancel",
      as: "cancel_user_registration"

    post "/",
      to: "devise/registrations#create",
      as: "user_registration"

    get "/register",
      to: "devise/registrations#new",
      as: "new_user_registration"

    get "/settings/users/user/edit",
      to: "devise/registrations#edit",
      as: "edit_user_registration"

    patch "/",
      to: "devise/registrations#update"

    put "/settings/users/user/edit",
      to: "devise/registrations#update"

    delete "/",
      to: "devise/registrations#destroy"

  end

end
