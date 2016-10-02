require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe '#new' do
    before do
      get :new
    end
    context 'when signing up' do
      it { should render_template 'new' }
      it 'should have a valid instance variable' do
        expect(assigns(:user)).to be_a_new User
      end
    end
  end

  describe '#create' do

    context 'with valid params' do
      it 'should create a user' do
        expect {
          post :create, user: attributes_for(:user)
        }.to change(User, :count).by 1
        expect(flash[:notice]).to be_present
        expect(response.status).to eq 302
        expect(session[:id]).to_not be_nil
      end
    end

    context 'without password' do
      it 'should fail to create a user' do
        expect {
          post :create, user: attributes_for(:user, password: nil)
        }.to_not change(User, :count)
        expect(response.status).to eq 302
      end
    end

    context 'without email' do
      it 'should fail to create a user' do
        expect {
          post :create, user: attributes_for(:user, email: nil)
        }.to_not change(User, :count)
        expect(response.status).to eq 302
      end
    end
  end

  describe '#show' do
    before do
      user = FactoryGirl.create(:user)
      link = FactoryGirl.create(:link)
      user.links << link
      session[:id] = user.id
      get :show, link_id: link.id
    end

    context 'visit dashboard' do
      it 'should render template \'show\'' do
        expect(response).to render_template 'show'
      end
      it 'should have valid instance variables' do
        expect(assigns(:links)).to_not be_nil
        expect(assigns(:link)).to_not be_nil
      end
    end
  end

  describe '#sign_in' do
    before { get :sign_in }
    context 'when signing in' do
      it { should render_template 'sign_in' }
    end
  end

  describe '#attempt_login' do
    before {
      user = create(:user)
      post :attempt_login, user: attributes_for(:user)
    }
    context 'with valid params' do
      it { should set_flash }
      it { should redirect_to dashboard_path }
      it 'should have valid session' do
        expect(session[:id]).to_not be_nil
      end
    end
  end

  describe '#sign_in' do
    context 'with invalid params' do
      before{
        post :attempt_login, user: attributes_for(:user, email: nil)
      }
      it { should set_flash }
      it { should render_template 'sign_in' }
      it 'should not have a session' do
        expect(session[:id]).to be_nil
      end
    end
  end

  describe '#sign_out' do
    before { get :sign_out }
    context 'when signing out' do
      it { should redirect_to root_path }
      it { should set_flash }
      it 'should invalidate the session' do
        expect(session[:id]).to be_nil
      end
    end
  end
end
