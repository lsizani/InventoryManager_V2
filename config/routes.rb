Rails.application.routes.draw do
  get 'reagents/index'

InventoryManagerV2::Application.routes.draw do
  #get 'reagents/index'
  namespace :admin do
    root 'admin#index'
  end

    resources :requests
    resources :orders
    resources :studies

    resources :reagents, :kit_items do
      resources :logs
    end

    resources :dashboard
    root 'welcome#index'
  end

end
