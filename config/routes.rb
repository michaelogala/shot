Rails.application.routes.draw do
  root 'links#index'
  devise_for :users

  scope controller: :links do
    get '/'                               => :index
    post '/dashboard/link/new'            => :create
    post '/dashboard/link/update/:id'     => :update
    post '/dashboard/link/:id'            => :destroy
    post '/dashboard/link/activate/:id'   => :activate
    post '/dashboard/link/deactivate/:id' => :deactivate
  end

  scope controller: :users do
    get '/dashboard'  => :show
  end

  scope controller: :redirects do
    get '/:slug' => :show
  end
end
