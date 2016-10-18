require 'rails_helper'

RSpec.describe LinksController, type: :controller do

  describe 'GET #index' do
    before { get :index }

    it 'renders the index template' do
      expect(response).to render_template('index')
    end

    it 'has a valid presenter instance set' do
      expect(assigns(:index_presenter)).to_not be_nil
    end

    it 'has a new link instance' do
      expect(assigns(:new_link)).to be_a_new Link
    end
  end

  describe 'POST #create' do
    before { request.env['HTTP_REFERER'] = '/dashboard' }
    let!(:initial_link_count) { Link.count }

    context 'with valid parameters' do
      before { post :create, link: attributes_for(:link) }

      it 'creates a link and redirect to dashboard' do
        expect(Link.count).to eq initial_link_count + 1
        expect(response).to redirect_to dashboard_path
      end

      it 'has a flash containing the link created and a success message' do
        expect(flash[:notice]).to be_present
        expect(flash[:link]).to be_present
      end
    end

    context 'with invalid parameters' do
      before { post :create, link: attributes_for(:link, given_url: nil) }

      it 'fails to create a link and redirects to dashboard' do
        expect(Link.count).to eq initial_link_count
        expect(response).to redirect_to dashboard_path
      end

      it 'has a flash message indicating the error' do
        expect(flash[:error]).to be_present
      end
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }
    let(:link) { create(:link) }

    context 'when user is signed in' do
      before do
        user.links << link
        session[:id] = user.id
        get :show, link_id: link.id
      end

      it 'displays the dashboard' do
        expect(response).to render_template 'show'
      end

      it 'has an ActiveRecord instance containing my links' do
        expect(assigns(:links)).to be_an ActiveRecord::Relation
        expect(assigns(:links)).to include link
      end
    end

    context 'when user is not signed in' do
      before { get :show }
      it 'redirects to sign in page' do
        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe 'PATCH #update' do
    let(:link) { create(:link) }
    let(:user) { create(:user) }

    context 'when user has a valid session' do
      before do
        request.env['HTTP_REFERER'] = dashboard_path
        session[:id] = user.id
        patch :update, id: link.id, link: { slug: 'some' }
      end

      it 'updates link and goes back to dashboard' do
        expect(link.reload.slug).to eq 'some'
        expect(response).to redirect_to dashboard_path
      end

      it 'has a flash message indicating successful update' do
        expect(flash[:notice]).to be_present
      end
    end
  end

  describe 'PATCH #toggle_activate' do
    let(:link) { create(:link) }
    let(:user) { create(:user) }
    before do
      request.env['HTTP_REFERER'] = dashboard_path
      session[:id] = user.id
    end

    describe 'disabling a link' do

      context 'when user is signed in' do
        before { patch :toggle_activate, id: link, active: false }

        it 'sets the link status to inactive and goes to dashboard' do
          expect(link.reload.active).to eq false
          expect(response).to redirect_to dashboard_path
        end

        it 'has a flash message indicating deactivation' do
          expect(flash[:notice]).to be_present
        end
      end
    end

    describe 'activating a link' do
      before { link.active = false }

      context 'when user is signed in' do
        before { patch :toggle_activate, id: link.id, active: true }

        it 'sets the link status to active and goes to dashboard' do
          expect(link.reload.active).to eq true
          expect(response).to redirect_to dashboard_path
        end

        it 'has a flash message indicating reactivation' do
          expect(flash[:notice]).to be_present
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:link) { create(:link) }
    let(:user) { create(:user) }
    before do
      session[:id] = user.id
      delete :destroy, id: link.id
    end

    it 'removes the link from db and goes to dashboard with a flash notice' do
      expect(Link.all).to_not include link
      expect(response).to redirect_to dashboard_path
      expect(flash[:notice]).to be_present
    end
  end

  describe 'GET #inactive' do
    before { get :inactive }
    it { is_expected.to render_template 'inactive' }
  end

  describe 'GET #deleted' do
    before { get :deleted }
    it { is_expected.to render_template 'deleted' }
  end

  describe 'GET #redirect' do
    let(:link) { create(:link) }

    context 'with a valid slug' do
      before { get :redirect, slug: link.slug }

      it 'redirects to the original url' do
        expect(response).to redirect_to link.given_url
      end

      it 'persists the visit data to db' do
        expect(link.reload.visits.count).to eq 1
      end

      it 'increases the link\'s click count' do
        expect(link.reload.clicks).to eq 1
      end
    end

    context 'with an invalid slug' do
      before { get :redirect, slug: 'xxx' }
      it 'renders a page showing that the link doesn\'t exist' do
        expect(response).to render_template 'deleted'
      end
    end

    context 'when link is not active' do
      before do
        link.update_attributes(active: false)
        get :redirect, slug: link.slug
      end

      it 'renders a page showing that link is inactive' do
        expect(response).to render_template 'inactive'
      end
    end
  end
end
