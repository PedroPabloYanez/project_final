Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    sessions: 'users/sessions', omniauth_callbacks: 'users/omniauth_callbacks'
  }
  get 'users/:id', to: 'users#update_status', as: :update_status
  delete '/users/:id', to: 'users#destroy', as: :destroy_user

  
  get 'admin', to: 'home#admin'
  resources :tasks
  resources :teams do 
    get "team/:user_id", to:"teams#add_member", as: "add_member"
  end
  resources :projects
  


  root "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
