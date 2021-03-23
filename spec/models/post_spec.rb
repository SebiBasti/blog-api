require 'rails_helper'

describe Post, type: :model do
  it { should have_many(:segments).dependent(:destroy) }
  it { should validate_presence_of(:title) }
end
