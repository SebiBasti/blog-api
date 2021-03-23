class TextBlock < ApplicationRecord
  belongs_to :segment
  validates :content, presence: true
end
