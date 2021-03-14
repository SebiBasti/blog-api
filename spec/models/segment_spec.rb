require 'rails_helper'

RSpec.describe Segment, type: :model do
  it { should belong_to(:post) }
  it { should validate_presence_of(:segment_type) }
  it { should validate_inclusion_of(:segment_type).in_array(%w[text_block code_block picture youtube_link]) }
end
