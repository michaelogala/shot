require 'rails_helper'

RSpec.describe RedirectsController, type: :controller do
  describe '#inactive' do
    before { get :inactive }
    it { should render_template 'inactive' }
  end

  describe '#deleted' do
    before { get :deleted }
    it { should render_template 'deleted' }
  end

  describe '#show' do
    context 'with a valid slug' do
      it 'redirects successfully' do
        link = Link.create(given_url: Faker::Internet.url,
                           slug: Faker::Internet.slug)
        get :show, slug: link.slug
        expect(response.status).to eq 302
        link.reload
        expect(link.visits.count).to eq 1
        expect(link.clicks).to eq 1
      end
    end

    context 'with an invalid slug' do
      it 'renders deleted' do
        get :show, slug: 'xxx'
        expect(response).to render_template 'deleted'
        expect(response.status).to eq 200
      end
    end

    context 'when link is not active' do
      link2 = Link.create(given_url: 'http://andela.com',
                          slug: Faker::Internet.slug, active: false)
      it 'renders inactive' do
        get :show, slug: link2.slug
        expect(response).to render_template 'inactive'
        expect(response.status).to eq 200
      end
    end
  end
end
