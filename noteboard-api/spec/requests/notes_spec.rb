require 'rails_helper'

RSpec.describe 'Notes API', type: :request do
  let(:note) { create(:note) }
  let!(:notes) { create_list(:note, 5) }
  let(:id) { notes.first.id }

  describe 'GET /api/v1/notes' do
    before { get '/api/v1/notes' }

    it 'returns notes' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /api/v1/notes' do
    let(:valid_attributes) { { note: { title: 'Test', content: 'From specs' } } }

    context 'when request attributes are valid' do
      before { post "/api/v1/notes", params: valid_attributes }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'PUT /api/v1/notes/:id' do
    let(:valid_attributes) { { note: { title: 'Test', content: 'From specs' } } }

    before { put "/api/v1/notes/#{id}", params: valid_attributes }

    context 'when note exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates the note' do
        expect(response.body).not_to be_empty
      end
    end
  end

  describe 'DELETE /api/v1/notes/:id' do
    before { delete "/api/v1/notes/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end