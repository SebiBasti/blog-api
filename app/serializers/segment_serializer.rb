class SegmentSerializer
  include FastJsonapi::ObjectSerializer
  attribute :segment_type
  belongs_to :post
  has_one :text_block
  has_one :code_block
  has_one :youtube_link
  has_one :picture
end
