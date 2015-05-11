Rails.application.routes.draw do
  get 'reagents/index'

InventoryManagerV2::Application.routes.draw do
  root 'welcome#login'

  get    'home'             => 'welcome#index'
  get    'login'            => 'sessions#new'
  post   'login'            => 'sessions#create'
  get    'logout'           => 'sessions#destroy'
  get    'settings'         => 'dashboard#settings'
  get    'download_report'  => 'reagents#dump_to_csv'
  post   'dashboard/create' => 'dashboard#create'
  get    'remove_setting'   => 'dashboard#remove'
  post   'requests_for_supplier' => 'orders#requests_for_supplier'
  post   'make_order'           => 'orders#create'
  get    'imports_index'        => 'imports#index'
  post   'file_import_path'     => 'imports#upload'
  post    'file_process_path'    => 'imports#process_file'



  namespace :admin do
    root 'admin#index'
  end

    resources :requests
    resources :orders
    resources :studies

    resources :reagents, :kit_items do
      resources :logs
    end

    resources :dashboard, :only => [:index]
    resources :reports

  end

end
