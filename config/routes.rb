Rails.application.routes.draw do
  root 'links#index'

  scope controller: :users do
    post 'users/create' => :create, as: :new_user
    get 'users/sign_up' => :new, as: :sign_up
  end

  scope controller: :links do
    get '/' => :index
    post '/dashboard/link/new' => :create
    get '/dashboard' => :show, as: :dashboard
    post '/dashboard/link/:id/update' => :update
    delete '/dashboard/:id/link' => :destroy
    patch '/dashboard/link/:id/activate' => :toggle_activate
  end

  scope controller: :redirects do
    get '/:slug' => :show
    get '/link/inactive' => :inactive
    get '/link/deleted' => :deleted
  end

  scope controller: :sessions do
    get '/users/sign_in' => :new, as: :sign_in
    get '/users/sign_out' => :destroy, as: :sign_out
    post '/users/sign_in' => :create, as: :log_in
  end
end
