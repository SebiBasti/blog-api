require 'rails_helper'

RSpec.describe Segment, type: :model do
  it { should belong_to(:post) }
  it { should validate_presence_of(:type) }
end
