class Segment < ApplicationRecord
  belongs_to :post
  validates :type, presence: true, inclusion: { in: %w[text_block code_block picture youtube_link] }
end
