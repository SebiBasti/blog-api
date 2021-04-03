require 'rails_helper'

describe Picture, type: :model do

  it { should belong_to(:segment) }

  let(:posting) { create(:post) }
  let(:segment) { create(:segment, :is_picture, post_id: posting.id) }

  it 'should raise an error when both picture sources are provided' do
    expect { create(:picture, :is_external_link, :is_cloudinary_link, segment_id: segment.id) }
      .to raise_error(ActiveRecord::RecordInvalid,
                      'Validation failed: Photo can either be uploaded or linked, not both')
  end

  it 'should raise an error if no photo and no link is provided' do
    expect { create(:picture, segment_id: segment.id) }
      .to raise_error(ActiveRecord::RecordInvalid,
                      'Validation failed: No photo attached or linked.')
  end

  context 'cloudinary upload test and cleanup' do
    let!(:picture) { create(:picture, :is_cloudinary_link, segment_id: segment.id) }
    before { @cloudinary_key = picture.photo.key }

    it 'should create a cloudinary id' do
      expect(@cloudinary_key).to be_truthy
    end

    after { Cloudinary::Uploader.destroy(@cloudinary_key) unless RSpec.current_example.exception }
  end
end
