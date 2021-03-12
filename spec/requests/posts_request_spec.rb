require 'rails_helper'

RSpec.describe "Blog API", type: :request do
  let!(:posts) { create_list(:post, 10) }
  let(:post_id) { posts.first.id }

  describe 'GET /posts' do
    before { get '/posts' }

    it 'returns posts' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /posts/:id' do
    before { get "/posts/#{post_id}" }

    context 'when record exists' do
      it 'returns te post' do
        expect(json).not_to must_be_empty
        expect(json['id']).to eq(post_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:post_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Post/)
      end
    end
  end
end
