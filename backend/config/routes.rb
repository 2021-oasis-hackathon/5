Rails.application.routes.draw do
  resources :shops do
    resources :menus
  end

  resources :users

  post 'login', to: "authentication#authenticate"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
