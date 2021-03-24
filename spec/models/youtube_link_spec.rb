require 'rails_helper'

describe YoutubeLink, type: :model do
  it { should belong_to(:segment) }
  it { should validate_presence_of(:link) }
  it { should allow_value('https://www.youtube.com/watch?v=dQw4w9WgXcQ').for(:link) }
  it { should_not allow_value('https://www.youtube.com/watch?v=bad_link').for(:link) }
end
