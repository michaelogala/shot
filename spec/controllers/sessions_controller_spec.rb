require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    before { get :new }
    it { is_expected.to render_template 'new' }
    it 'should have a new user instance' do
      expect(assigns(:user)).to be_a_new User
    end
  end

  describe 'POST #create' do
    let!(:user) { create(:user) }

    context 'with valid parameters' do
      before do
        post :create, session: { email: user.email, password: user.password }
      end

      it 'should set a valid session' do
        expect(session[:id]).to eq user.id
      end

      it 'should redirect to dashboard' do
        expect(response).to redirect_to dashboard_path
      end

      it 'should have a flash message welcoming the user' do
        expect(flash[:notice]).to eq 'Login Successful'
      end
    end

    context 'with invalid parameters' do
      before { post :create, session: { email: nil, password: nil } }

      it 'should not have a valid session' do
        expect(session[:id]).to be_nil
      end

      it 'should render the signin page again' do
        expect(response).to render_template 'new'
      end

      it 'should have a flash message indicating sign in failure' do
        expect(flash[:notice]).to eq 'Invalid username/password combination'
      end
    end
  end

  describe 'DELETE #destroy' do
    before { delete :destroy }

    it 'should set the session to nil' do
      expect(session[:id]).to be_nil
    end

    it 'should redirect to root path' do
      expect(response).to redirect_to root_path
    end

    it 'should have a flash message indicating sign out' do
      expect(flash[:notice]).to eq 'You have logged out'
    end
  end
end
