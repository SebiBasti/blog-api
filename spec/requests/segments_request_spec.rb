require 'rails_helper'

describe 'Segments API', type: :request do
  let(:user) { create(:user) }
  let!(:posting) { create(:post, user_id: user.id) }
  let!(:segments) { create_list(:segment, 20, post_id: posting.id) }
  let(:post_id) { posting.id }
  let(:id) { segments.first.id }
  let(:headers) { valid_headers }

  describe 'GET /posts/:post_id/segments' do
    before { get "/posts/#{post_id}/segments", params: {}, headers: headers }

    context 'when post exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all post segments' do
        expect(json.size).to eq(20)
      end
    end

    context 'when post does not exist' do
      let(:post_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Post/)
      end
    end
  end

  describe 'GET /posts/:post_id/segments/:id' do
    before { get "/posts/#{post_id}/segments/#{id}", params: {}, headers: headers }

    context 'when post segment exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the segment' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when post segment does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Segment/)
      end
    end
  end

  describe 'POST /posts/:post_id/segments' do
    let(:valid_attributes) { { segment_type: 'text_block' }.to_json }

    context 'when request attributes are valid' do
      before { post "/posts/#{post_id}/segments", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request attributes are not valid' do
      before { post "/posts/#{post_id}/segments", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body)
          .to match(/Validation failed: Segment type can't be blank, Segment type is not included in the list/)
      end
    end
  end

  describe 'PUT /posts/:post_id/segments/:id' do
    let(:valid_attributes) { { segment_type: 'code_block' }.to_json }

    before { put "/posts/#{post_id}/segments/#{id}", params: valid_attributes, headers: headers }

    context 'when segment exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the segment' do
        updated_segment = Segment.find(id)
        expect(updated_segment.segment_type).to match(/code_block/)
      end
    end

    context 'when the segment does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Segment/)
      end
    end
  end

  describe 'DELETE /posts/:post_id/segments/:id' do
    before { delete "/posts/#{post_id}/segments/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
