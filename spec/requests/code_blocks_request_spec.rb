require 'rails_helper'

describe 'CodeBlocks API', type: :request do
  let(:user) { create(:user) }
  let!(:posting) { create(:post, user_id: user.id) }
  let!(:segment) { create(:segment, :is_code_block, post_id: posting.id) }
  let!(:code_block) { create(:code_block, segment_id: segment.id) }
  let(:post_id) { posting.id }
  let(:segment_id) { segment.id }
  let(:id) { code_block.id }
  let(:headers) { valid_headers }

  describe 'GET /posts/:post_id/segments/:id/code_block' do
    before { get "/posts/#{post_id}/segments/#{segment_id}/code_block", params: {}, headers: headers }

    context 'when code block exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the code block' do
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

  describe 'POST /posts/:post_id/segments/:segment_id/code_block' do
    let(:valid_attributes) { { content: 'Test', code_type: 'ruby' }.to_json }

    context 'when request attributes are valid' do
      before { post "/posts/#{post_id}/segments/#{segment_id}/code_block", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request attributes are not valid' do
      before { post "/posts/#{post_id}/segments/#{segment_id}/code_block", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body)
          .to match(/Validation failed: Content can't be blank/)
      end
    end
  end

  describe 'PUT /posts/:post_id/segments/:segment_id/code_block' do
    let(:valid_attributes) { { content: 'Update', code_type: 'java' }.to_json }

    before { put "/posts/#{post_id}/segments/#{segment_id}/code_block", params: valid_attributes, headers: headers }

    context 'when code block exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the code block' do
        updated_code_block = CodeBlock.find(id)
        expect(updated_code_block.content).to match(/Update/)
        expect(updated_code_block.code_type).to match(/java/)
      end
    end

    context 'when the segment/code block does not exist' do
      let(:segment_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Segment/)
      end
    end
  end

  describe 'DELETE /posts/:post_id/segments/:segment_id/code_block' do
    before { delete "/posts/#{post_id}/segments/#{segment_id}/code_block", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
