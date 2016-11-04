require 'rails_helper'

RSpec.describe "Api::V1::Links", type: :request do
  let(:link) { create :link }

  describe "GET /api_v1_links" do
    before { get '/api/v1/links' }

    it 'returns all links' do
      expect(json_response[:links]).to be_present
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/v1/links/:id' do
    before { get "/api/v1/links/#{link.id}"}

    it 'returns json response containing link properties' do
      expect(json_response[:url]).to be_present
      expect(json_response[:slug]).to be_present
      expect(json_response[:active]).to be_present
    end
  end

  describe 'POST /api/v1/links' do
    let!(:link_count) { Link.count }

    context 'with valid params' do
      before { post '/api/v1/links', attributes_for(:link) }

      it 'saves and returns the link as json response' do
        expect(Link.count).to eq link_count + 1
        expect(json_response[:url]).to be_present
        expect(json_response[:slug]).to be_present
      end
    end

    context 'with invalid params' do
      before { post '/api/v1/links' }

      it 'returns a json message indicating failure' do
        expect(Link.count).to eq link_count
        expect(json_response[:error]).to be_present
      end
    end
  end

  describe 'PATCH /api/v1/links/:id' do
    context 'with valid params' do
      before { patch "/api/v1/links/#{link.id}", { slug: 'newslug' } }

      it 'updates the link data' do
        expect(json_response[:slug]).to eq 'newslug'
      end
    end
  end

  describe 'DELETE /api/v1/links/:id' do
    before { delete "/api/v1/links/#{link.id}" }

    it 'removes the link from the database' do
      expect(Link.find_by(id: link.id)).to be_nil
      expect(response.status).to eq 204
    end
  end
end
