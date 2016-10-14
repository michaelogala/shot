require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET #new' do
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

  describe 'POST #create' do

    context 'with valid params' do
      it 'should create a user' do
        expect do
          post :create, user: attributes_for(:user)
        end.to change(User, :count).by 1
        expect(flash[:notice]).to be_present
        expect(response.status).to eq 302
        expect(session[:id]).to_not be_nil
      end
    end

    context 'with invalid params' do
      before { post :create, user: attributes_for(:user, password: nil) }
      let!(:db_count) { User.count }

      it 'doesn\'t persist to the database' do
        expect(User.count).to eq db_count
      end

      it 'should display the sign up page again' do
        expect(response).to render_template 'new'
      end

      it 'should have a flash message indicating the error' do
        expect(flash[:notice]).to_not be_nil
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

end
