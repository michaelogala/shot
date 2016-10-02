Rails.application.routes.draw do
  root 'links#index'

  scope controller: :users do
    get '/users/dashboard' => :show, as: :dashboard
    get 'users/sign_in' => :sign_in, as: :sign_in
    get 'users/login' => :sign_in
    get 'users/sign_out'=> :sign_out, as: :log_out
    post 'users/login' => :attempt_login, as: :login
    post 'users/create' => :create, as: :new_user
    get 'users/sign_up' => :new,  as: :sign_up
  end

  scope controller: :links do
    get     '/'                              => :index
    post    '/dashboard/link/new'            => :create
    post     '/dashboard/link/update/:id'     => :update
    delete  '/dashboard/link/:id'            => :destroy
    post    '/dashboard/link/activate/:id'   => :activate
    post     '/dashboard/link/deactivate/:id' => :deactivate
  end

  scope controller: :redirects do
    get '/:slug' => :show
    get '/link/inactive' => :inactive
    get '/link/deleted' => :deleted
  end
end
