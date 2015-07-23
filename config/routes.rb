Rails.application.routes.draw do
  root 'pages#index'

  resources :gemfiles
end
