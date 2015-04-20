Rails.application.routes.draw do
  get 'reagents/index'

InventoryManagerV2::Application.routes.draw do
  root 'welcome#login'

  get    'home'     => 'welcome#index'
  get    'login'    => 'sessions#new'
  post   'login'    => 'sessions#create'
  get    'logout'   => 'sessions#destroy'
  get    'settings' => 'dashboard#settings'

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
