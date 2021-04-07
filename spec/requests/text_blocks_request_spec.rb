require 'rails_helper'

describe 'TextBlocks API', type: :request do
  let(:user) { create(:user) }
  let!(:posting) { create(:post, created_by: user.id) }
  let!(:segment) { create(:segment, :is_text_block, post_id: posting.id) }
  let!(:text_block) { create(:text_block, segment_id: segment.id) }
  let(:post_id) { posting.id }
  let(:segment_id) { segment.id }
  let(:id) { text_block.id }
  let(:headers) { valid_headers }

  describe 'GET /posts/:post_id/segments/:id/text_block' do
    before { get "/posts/#{post_id}/segments/#{segment_id}/text_block", params: {}, headers: headers }

    context 'when text block exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the text block' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when segment does not exist' do
      let(:segment_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Segment/)
      end
    end
  end

  describe 'POST /posts/:post_id/segments/:segment_id/text_block' do
    let(:valid_attributes) { { content: 'Test' }.to_json }

    context 'when request attributes are valid' do
      before { post "/posts/#{post_id}/segments/#{segment_id}/text_block", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request attributes are not valid' do
      before { post "/posts/#{post_id}/segments/#{segment_id}/text_block", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body)
          .to match(/Validation failed: Content can't be blank/)
      end
    end
  end

  describe 'PUT /posts/:post_id/segments/:segment_id/text_block' do
    let(:valid_attributes) { { content: 'Update' }.to_json }

    before { put "/posts/#{post_id}/segments/#{segment_id}/text_block", params: valid_attributes, headers: headers }

    context 'when text block exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the text block' do
        updated_text_block = TextBlock.find(id)
        expect(updated_text_block.content).to match(/Update/)
      end
    end

    context 'when the segment/text block does not exist' do
      let(:segment_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Segment/)
      end
    end
  end

  describe 'DELETE /posts/:post_id/segments/:segment_id/text_block' do
    before { delete "/posts/#{post_id}/segments/#{segment_id}/text_block", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
