Rails.application.routes.draw do
  devise_for :users  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  namespace :users do
    resources :information do
    end
  end

  resources :activities do 
    member do
      patch :favorite
      post :create_comment
    end
  end

end
