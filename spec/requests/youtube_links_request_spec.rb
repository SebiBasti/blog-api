require 'rails_helper'

RSpec.describe "YoutubeLinks", type: :request do
  let!(:posting) { create(:post) }
  let!(:segment) { create(:segment, :is_youtube_link, post_id: posting.id) }
  let!(:youtube_link) { create(:youtube_link, segment_id: segment.id) }
  let(:post_id) { posting.id }
  let(:segment_id) { segment.id }
  let(:id) { youtube_link.id }

  describe 'GET /posts/:post_id/segments/:id/youtube_link' do
    before { get "/posts/#{post_id}/segments/#{segment_id}/youtube_link" }

    context 'when youtube link exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the youtube link' do
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

  describe 'POST /posts/:post_id/segments/:segment_id/youtube_link' do
    let(:valid_attributes) { { link: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ' } }
    let(:invalid_attributes) { { link: 'https://www.youtube.com/watch?v=bad_link' } }

    context 'when request attributes are valid' do
      before { post "/posts/#{post_id}/segments/#{segment_id}/youtube_link", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request attributes are not valid' do
      before { post "/posts/#{post_id}/segments/#{segment_id}/youtube_link", params: invalid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        p response.body
        expect(response.body)
          .to match(/Validation failed: Link invalid/)
      end
    end
  end

  describe 'PUT /posts/:post_id/segments/:segment_id/youtube_link' do
    let(:valid_attributes) { { link: 'https://www.youtube.com/watch?v=WDiB4rtp1qw' } }

    before { put "/posts/#{post_id}/segments/#{segment_id}/youtube_link", params: valid_attributes }

    context 'when youtube link exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the youtube link' do
        updated_youtube_link = YoutubeLink.find(id)
        expect(updated_youtube_link.link).to match(/#{Regexp.quote('https://www.youtube.com/watch?v=WDiB4rtp1qw')}/)
      end
    end

    context 'when the segment/youtube link does not exist' do
      let(:segment_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Segment/)
      end
    end
  end

  describe 'DELETE /posts/:post_id/segments/:segment_id/youtube_link' do
    before { delete "/posts/#{post_id}/segments/#{segment_id}/youtube_link" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
