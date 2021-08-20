Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    sessions: 'users/sessions', omniauth_callbacks: 'users/omniauth_callbacks'
  }
  #Ruta para ver dashboard y resumen
  get 'users', to: 'users#index', as: :index_user
  
  get 'users/:id', to: 'users#update_status', as: :update_status
  delete '/users/:id', to: 'users#destroy', as: :destroy_user

  
  get 'admin', to: 'home#admin'
  resources :tasks

  resources :teams do 
    member do
      get "add_member/:user_id", to:"teams#add_member", as: "add_member"
      delete 'delete_member/:member_id', to: 'teams#delete_member', as: 'delete_member'
    end
  end


  resources :projects
  
  #resource :cart, only: [:show, :update] #do
    #get 'carts/:id/delete_item', to: 'carts#delete_item', as: 'delete_item'
  #end

  root "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
