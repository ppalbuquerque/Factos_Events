Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  #devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :event, except: [:index, :create] do
    collection do
      post :search
      get '', action: 'order'
    end
    post :add, action: 'create', on: :collection
    get :publish
    get :reject
    resources :comment
  end
  resources :academic, controller: 'event', type: 'Academic', only: [:index, :show]
  resources :cultural, controller: 'event', type: 'Cultural', only: [:index, :show]
  resources :users, only: [:show]
end
