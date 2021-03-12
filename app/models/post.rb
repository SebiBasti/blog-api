class Post < ApplicationRecord
  has_many :segments, dependent: :destroy
  validates :title, presence: true
end
