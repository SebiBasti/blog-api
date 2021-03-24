require 'rails_helper'

RSpec.describe CodeBlock, type: :model do
  it { should belong_to(:segment) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:code_type) }
end
