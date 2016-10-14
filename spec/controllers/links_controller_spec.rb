require 'rails_helper'

RSpec.describe LinksController, type: :controller do

  describe '#index' do
    before do
      get :index
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end
    it 'has all valid instance variables' do
      expect(assigns(:index_presenter)).to_not be_nil
      expect(assigns(:new_link)).to be_a_new Link
    end
  end

  describe '#create' do
    before do
      request.env['HTTP_REFERER'] = '/dashboard'
    end
    context 'with valid parameters' do
      it 'should succeed and redirect back' do
        expect do
          post :create, link: attributes_for(:link)
        end.to change(Link, :count).by 1
        expect(flash[:notice]).to be_present
        expect(flash[:link]).to be_present
        expect(response.status).to eq(302)
      end
    end

    context 'with invalid parameters' do
      it 'should fail' do
        expect do
          post :create, link: attributes_for(:link, given_url: nil)
        end.to_not change(Link, :count)
        expect(flash[:error]).to be_present
      end
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }
    let(:link) { create(:link) }

    context 'if user is signed in' do
      before do
        user.links << link
        session[:id] = user.id
        get :show, link_id: link.id
      end

      it 'should display the dashboard' do
        expect(response).to render_template 'show'
      end

      it 'should have an array containing my links' do
        expect(assigns(:links)).to_not be_nil
        expect(assigns(:link)).to_not be_nil
      end
    end

    context 'if user is not signed in' do
      before { get :show }
      it 'should redirect to sign in page' do
        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe '#update' do
    it 'updates link and redirects to HTTP_REFERER' do
      link = Link.create(given_url: Faker::Internet.url,
                         slug: Faker::Internet.slug)
      post :update, id: link.id,
                    slug: 'some',
                    given_url: link.given_url,
                    active: true
      expect(response.status).to eq 302
      expect(flash[:notice]).to be_present
    end
  end

  describe '#activate' do
    before do
      @link = FactoryGirl.create(:link, active: false)
    end
    it 'sets the link status to active' do
      post :toggle_activate, id: @link, active: true
      expect(response.status).to eq 302
      expect(flash[:notice]).to be_present
    end
  end

  describe '#deactivate' do
    it 'sets the link status to active' do
      link = Link.create(given_url: Faker::Internet.url,
                         slug: Faker::Internet.slug)
      post :toggle_activate, id: link.id, active: false
      expect(response.status).to eq 302
      expect(flash[:notice]).to be_present
    end
  end

  describe '#destroy' do
    it 'removes the link from db' do
      link = Link.create(given_url: Faker::Internet.url,
                         slug: Faker::Internet.slug)
      delete :destroy, id: link.id
      expect(response.status).to eq 302
      expect(flash[:notice]).to be_present
    end
  end
end
