Rails.application.routes.draw do

  namespace :api do
    namespace :admin do
      resources :taxons
      resources :products
    end
  end

end
