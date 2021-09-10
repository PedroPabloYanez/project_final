Rails.application.routes.draw do
  
  resources :payments
  devise_for :users, controllers: {
    sessions: 'users/sessions', omniauth_callbacks: 'users/omniauth_callbacks'
  }
  #Ruta para ver dashboard y resumen
  get 'users', to: 'users#index', as: :index_user
  get 'dashboard_user', to: 'users#dashboard_user', as: :dashboard_user
  
  get 'users/:id', to: 'users#update_status', as: :update_status
  delete 'users/:id', to: 'users#destroy', as: "destroy_user"

  #Admin
  get 'admin', to: 'home#admin'
  delete "home/:id", to: "home#destroy_user_admin", as: "destroy_user_admin"
  
  resources :tasks

  resources :teams do 
    member do
      get "add_member/:user_id", to:"teams#add_member", as: "add_member"
      delete 'delete_member/:member_id/', to: 'teams#delete_member', as: 'delete_member'
    end
  end


  resources :projects do
    member do
      patch "like", to: "projects#like"
    end
  end
  
  #Mercado Pago
  get 'mercado-pago', to: 'payments#mercado_pago', as: 'mercado-pago'
  get 'payments_success', to: 'payments#pago_exitoso', as: 'pago-exitoso'



  root "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
