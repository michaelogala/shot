require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET #new' do
    before { get :new }
    context 'when user tries to sign up' do
      it 'displays the sign up form' do
        expect(response).to render_template 'new'
      end

      it 'has the user instance variable set' do
        expect(assigns(:user)).to be_a_new User
      end
    end
  end

  describe 'POST #create' do
    let!(:initial_db_count) { User.count }

    context 'with valid params' do
      before { post :create, params: { user: attributes_for(:user) } }

      it 'persists the new user to database' do
        expect(User.count).to eq initial_db_count + 1
      end

      it 'has a flash notice' do
        expect(flash[:notice]).to be_present
      end

      it 'redirects the user to dashboard' do
        expect(response).to redirect_to dashboard_path
      end

      it 'sets a valid session' do
        expect(session[:id]).to_not be_nil
      end
    end

    context 'with invalid params' do
      before { post :create, params: { user: attributes_for(:user, password: nil) } }

      it 'does not persist to the database' do
        expect(User.count).to eq initial_db_count
      end

      it 'displays the sign up page again' do
        expect(response).to render_template 'new'
      end

      it 'has a flash message indicating the error' do
        expect(flash[:notice]).to_not be_nil
      end
    end
  end
end
