require 'rails_helper'

describe "Pictures", type: :request do
  let(:user) { create(:user) }
  let!(:posting) { create(:post, user_id: user.id) }
  let!(:segment) { create(:segment, :is_picture, post_id: posting.id) }
  let!(:picture) { create(:picture, :is_external_link, segment_id: segment.id) }
  let(:post_id) { posting.id }
  let(:segment_id) { segment.id }
  let(:id) { picture.id }
  let(:headers) { valid_headers }

  describe 'GET /posts/:post_id/segments/:id/picture' do
    before { get "/posts/#{post_id}/segments/#{segment_id}/picture", params: {}, headers: headers }

    context 'when picture exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the picture' do
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

  describe 'POST /posts/:post_id/segments/:segment_id/picture' do
    let(:valid_attributes_external) { { external_link: 'https://de.wikipedia.org/wiki/Ruby_(Programmiersprache)#/media/Datei:Ruby_logo.svg' }.to_json }
    let(:valid_attributes_cloudinary) { { photo: Rack::Test::UploadedFile.new('spec/support/assets/test.jpg', 'image/jpg') }.to_json }

    context 'when request attributes are external link' do
      before { post "/posts/#{post_id}/segments/#{segment_id}/picture", params: valid_attributes_external, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request attributes are not valid' do
      before { post "/posts/#{post_id}/segments/#{segment_id}/picture", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body)
          .to match(/Validation failed: No photo attached or linked/)
      end
    end
  end

  describe 'PUT /posts/:post_id/segments/:segment_id/picture' do
    let(:valid_attributes_external) { { external_link: 'https://de.wikipedia.org/wiki/Ruby_on_Rails#/media/Datei:Ruby_on_Rails_logo.jpg' }.to_json }

    before { put "/posts/#{post_id}/segments/#{segment_id}/picture", params: valid_attributes_external, headers: headers }

    context 'when external picture exists' do

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the picture' do
        updated_picture = Picture.find(id)
        expect(updated_picture.external_link).to match(/#{Regexp.quote('https://de.wikipedia.org/wiki/Ruby_on_Rails#/media/Datei:Ruby_on_Rails_logo.jpg')}/)
      end
    end

    context 'when the segment/picture does not exist' do
      let(:segment_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Segment/)
      end
    end
  end

  describe 'DELETE /posts/:post_id/segments/:segment_id/picture' do
    before { delete "/posts/#{post_id}/segments/#{segment_id}/picture", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end

# TODO: - cloudinary tests
