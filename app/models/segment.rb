class Segment < ApplicationRecord
  belongs_to :post
  validates :segment_type, presence: true, inclusion: { in: %w[text_block code_block picture youtube_link] }
end
