Rails.application.routes.draw do
  resources :provinces
  devise_for :users, controllers: { sessions: 'users/sessions' }
  root to: "dashboards#index"
  
  resources :roles
  resources :users
  resources :categories
  resources :unit_of_measurements
  resources :products do
    member do
      delete 'preview_images/:attachment_id', to: 'products#purge_preview_image', as: :purge_preview_image
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

end
