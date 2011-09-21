Rails.application.routes.draw do

  namespace :api do
    namespace :admin do
      resources :taxons
      resources :products do
        resources :images, :only => [ :create, :update, :destroy ]
      end
    end
  end

end
