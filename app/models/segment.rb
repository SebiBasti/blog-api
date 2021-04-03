class Segment < ApplicationRecord
  belongs_to :post
  has_one :text_block, dependent: :destroy
  has_one :code_block, dependent: :destroy
  has_one :youtube_link, dependent: :destroy
  has_one :picture, dependent: :destroy
  validates :segment_type, presence: true, inclusion: { in: %w[text_block code_block picture youtube_link] }
end
