Rails.application.routes.draw do
  scope :v1, defaults: { format: :json } do
    devise_for :users, path_names: {
      sign_in: 'login',
      sign_out: 'logout'
    }
  end

  namespace :v1, defaults: { format: :json } do
    get '/dogs', to: 'dogs#dogs'
    resources :users do
      resources :dogs
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
