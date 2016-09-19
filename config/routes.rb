Rails.application.routes.draw do
  get 'users/index'

  devise_for :users
  resources :links
  root 'links#index'

  post 'links/create'

  post 'links/update'

  get ':slug' => 'redirects#show'

  get 'users/dashboard' => 'users#show'


end
