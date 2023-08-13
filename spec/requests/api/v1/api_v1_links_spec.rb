require 'rails_helper'

RSpec.describe "Api::V1::Links", type: :request do
  let(:user) { create :user }
  let(:link) { create :link }
  before do
    user.links << link
    user.generate_token
  end

  describe 'GET /api/v1/links/:id' do
    before do
      get "/api/v1/links/#{link.id}", params: {}, headers: { Authorization: user.auth_token }
    end

    it 'returns json response containing link properties' do
      expect(json_response[:url]).to be_present
      expect(json_response[:slug]).to be_present
      expect(json_response[:active]).to be_present
    end
  end

  describe "GET /api_v1_links" do
    before do
      get '/api/v1/links', params: {}, headers: { Authorization: user.auth_token }
    end

    it 'returns all links' do
      expect(json_response[:links]).to be_present
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /api/v1/links' do
    let!(:link_count) { user.links.count }

    context 'with valid params' do
      before do
        post '/api/v1/links',
             params: attributes_for(:link),
             headers: { Authorization: user.auth_token }
      end

      it 'saves and returns the link as json response' do
        expect(user.reload.links.count).to eq link_count + 1
        expect(json_response[:url]).to be_present
        expect(json_response[:slug]).to be_present
      end
    end

    context 'with invalid params' do
      before { post '/api/v1/links', params: {}, headers: { Authorization: user.auth_token } }

      it 'returns a json message indicating failure' do
        expect(Link.count).to eq link_count
        expect(json_response[:error]).to be_present
      end
    end
  end

  describe 'PATCH /api/v1/links/:id' do
    context 'with valid params' do
      before do
        patch "/api/v1/links/#{link.id}",
              params: { slug: 'newslug' },
              headers: { Authorization: user.auth_token }
      end

      it 'updates the link data' do
        expect(json_response[:slug]).to eq 'newslug'
      end
    end
  end

  describe 'DELETE /api/v1/links/:id' do
    before do
      delete "/api/v1/links/#{link.id}", params: {}, headers: { Authorization: user.auth_token }
    end

    it 'removes the link from the database' do
      expect(Link.find_by(id: link.id)).to be_nil
      expect(response.status).to eq 204
    end
  end
end
