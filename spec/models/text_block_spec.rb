require 'rails_helper'

describe TextBlock, type: :model do
  it { should belong_to(:segment) }
  it { should validate_presence_of(:content) }
end
